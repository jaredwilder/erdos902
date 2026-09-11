#!/usr/bin/env python3
"""Verify the S_3 filter on Brendan McKay's complete DRT(23) catalogue.

Input format: one 253-bit line per tournament, the upper triangle of the
23x23 adjacency matrix in row order.  For i<j, bit 1 is interpreted as i->j;
bit 0 as j->i.  The script also checks the global converse convention, since
the catalogue format description does not matter to the isomorphism-level
classification claim.

For each tournament it checks:
  * tournament order/encoding length;
  * regular outdegree 11;
  * doubly-regular common-out-neighbour count 5;
  * property S_3: every triple has an outside vertex beating all three;
  * number of undominated 4-sets.

The release target is that exactly two of the 37 catalogue objects satisfy
S_3, with bad-4 counts 2475 and 2530, matching the two cores already stored
and kernel-checked in Erdos902DRT23.lean.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import urllib.request
from pathlib import Path

N = 23
EXPECTED_LINES = 37
EXPECTED_BITS = N * (N - 1) // 2
URL = "https://users.cecs.anu.edu.au/~bdm/data/drtourn23.txt"


def parse_line(bits: str, converse: bool = False):
    if len(bits) != EXPECTED_BITS or set(bits) - {"0", "1"}:
        raise ValueError(f"bad catalogue line length/content: {len(bits)}")
    out = [0] * N
    k = 0
    for i in range(N):
        for j in range(i + 1, N):
            one = bits[k] == "1"
            if converse:
                one = not one
            if one:
                out[i] |= 1 << j
            else:
                out[j] |= 1 << i
            k += 1
    return out


def pop(x: int) -> int:
    return x.bit_count()


def check_drt(out):
    assert all(pop(out[v]) == 11 for v in range(N))
    assert all(pop(out[i] & out[j]) == 5 for i in range(N) for j in range(i + 1, N))


def in_masks(out):
    full = (1 << N) - 1
    return [full ^ (1 << v) ^ out[v] for v in range(N)]


def has_s3(out):
    ins = in_masks(out)
    for a, b, c in itertools.combinations(range(N), 3):
        if ins[a] & ins[b] & ins[c] == 0:
            return False
    return True


def bad4_count(out):
    ins = in_masks(out)
    return sum(
        1 for a,b,c,d in itertools.combinations(range(N), 4)
        if ins[a] & ins[b] & ins[c] & ins[d] == 0
    )


def analyse(lines, converse=False):
    survivors = []
    for idx, bits in enumerate(lines, start=1):
        out = parse_line(bits, converse=converse)
        check_drt(out)
        if has_s3(out):
            survivors.append({"catalogue_row": idx, "bad4": bad4_count(out), "bits_sha256": hashlib.sha256(bits.encode()).hexdigest()})
    return survivors


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input", type=Path, default=None, help="optional frozen catalogue file")
    ap.add_argument("--out", type=Path, default=Path("drt23_s3_receipt.json"))
    args = ap.parse_args()

    if args.input:
        raw = args.input.read_bytes()
        source = str(args.input)
    else:
        raw = urllib.request.urlopen(URL, timeout=60).read()
        source = URL
    text = raw.decode("ascii")
    lines = [ln.strip() for ln in text.splitlines() if ln.strip()]
    assert len(lines) == EXPECTED_LINES, (len(lines), EXPECTED_LINES)
    assert all(len(ln) == EXPECTED_BITS for ln in lines)

    forward = analyse(lines, False)
    converse = analyse(lines, True)
    result = {
        "source": source,
        "catalogue_sha256": hashlib.sha256(raw).hexdigest(),
        "objects": len(lines),
        "bits_per_object": EXPECTED_BITS,
        "forward_s3_survivors": forward,
        "converse_s3_survivors": converse,
        "expected_stored_bad4_multiset": [2475, 2530],
    }
    print(json.dumps(result, indent=2))
    args.out.write_text(json.dumps(result, indent=2) + "\n")

    # Fail closed on the classification bridge we need.
    assert len(forward) == 2, forward
    assert sorted(x["bad4"] for x in forward) == [2475, 2530], forward
    # Reversal may permute catalogue representatives, but should give the same
    # isomorphism-level S3 count and invariant multiset if the catalogue is closed
    # under converse up to isomorphism.
    assert len(converse) == 2, converse
    assert sorted(x["bad4"] for x in converse) == [2475, 2530], converse


if __name__ == "__main__":
    main()
