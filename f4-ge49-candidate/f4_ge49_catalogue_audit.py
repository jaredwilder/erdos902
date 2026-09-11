#!/usr/bin/env python3
"""
Audit the finite certificate for the candidate improvement f(4) >= 49.

Input:
  - by default downloads Brendan McKay's complete DRT(23) catalogue:
    https://users.cecs.anu.edu.au/~bdm/data/drtourn23.txt
  - or pass a local catalogue path as argv[1].

Checks:
  1. 37 catalogue rows, each encoding a DRT(23,11,5).
  2. Exactly two rows have S_3 (1-indexed lines 35 and 36).
  3. Their numbers of internally undominated 4-sets are 2475 and 2530.
  4. For every feasible outside interaction mask W:
       |W| <= 12
       |W ∩ N_H^-(h)| <= 6 for all h in H
     compute the exact maximum number of bad 4-sets contained in W.
     The maxima are 65 and 66.
"""

import itertools
import sys
import urllib.request
import hashlib
import numpy as np

URL = "https://users.cecs.anu.edu.au/~bdm/data/drtourn23.txt"
N = 23

def load_catalogue():
    if len(sys.argv) > 1:
        raw = open(sys.argv[1], "rb").read()
    else:
        raw = urllib.request.urlopen(URL, timeout=30).read()
    print("sha256 =", hashlib.sha256(raw).hexdigest())
    lines = [x.strip().decode() for x in raw.splitlines() if x.strip()]
    assert len(lines) == 37, len(lines)
    assert all(len(x) == N*(N-1)//2 for x in lines)
    return lines

def parse(s):
    out = [0]*N
    p = 0
    for i in range(N):
        for j in range(i+1, N):
            if s[p] == "1":
                out[i] |= 1 << j
            else:
                out[j] |= 1 << i
            p += 1
    allmask = (1 << N) - 1
    inn = [((allmask ^ (1 << v)) & ~out[v]) for v in range(N)]
    return out, inn

def is_drt(out):
    if any(x.bit_count() != 11 for x in out):
        return False
    for u in range(N):
        for v in range(u+1, N):
            if (out[u] & out[v]).bit_count() != 5:
                return False
    return True

def has_dom(out, S):
    return any((o & S) == S for o in out)

def has_S3(out):
    for a,b,c in itertools.combinations(range(N), 3):
        S = (1<<a)|(1<<b)|(1<<c)
        if not has_dom(out, S):
            return False
    return True

def bad4(out):
    ans = []
    for A in itertools.combinations(range(N), 4):
        S = sum(1<<x for x in A)
        if not has_dom(out, S):
            ans.append(S)
    return ans

def zeta_bad_counts(bad):
    f = np.zeros(1<<N, dtype=np.uint16)
    f[np.array(bad, dtype=np.int64)] = 1
    for i in range(N):
        step = 1<<i
        block = step<<1
        a = f.reshape(-1, block)
        a[:, step:block] += a[:, :step]
    return f

def repair_capacity(out, inn, bad):
    f = zeta_bad_counts(bad)
    best = -1
    witness = None
    # Full 2^23 enumeration. Constraint first, then lookup f[W].
    for W in range(1<<N):
        if W.bit_count() > 12:
            continue
        ok = True
        for h in range(N):
            if (W & inn[h]).bit_count() > 6:
                ok = False
                break
        if ok and int(f[W]) > best:
            best = int(f[W])
            witness = W
    return best, witness

def verts(mask):
    return [i for i in range(N) if (mask>>i)&1]

def main():
    lines = load_catalogue()
    tours = [parse(s) for s in lines]

    assert all(is_drt(out) for out,_ in tours)
    surv = [i for i,(out,_) in enumerate(tours) if has_S3(out)]
    print("DRT23 entries =", len(lines))
    print("S3 survivors (1-indexed) =", [i+1 for i in surv])
    assert surv == [34,35]

    expected = [(2475,65),(2530,66)]
    for j,i in enumerate(surv):
        out,inn = tours[i]
        b = bad4(out)
        cap,W = repair_capacity(out,inn,b)
        print(f"line {i+1}: bad4={len(b)} cap={cap} witness={verts(W)}")
        assert (len(b),cap) == expected[j]

    print("24*65 =", 24*65, "< 2475")
    print("24*66 =", 24*66, "< 2530")
    print("ceil(2475/65) = 39")
    print("ceil(2530/66) = 39")
    print("FINITE CERTIFICATE: PASS")

if __name__ == "__main__":
    main()
