#!/usr/bin/env python3
from __future__ import annotations
import json
import re
import sys
from pathlib import Path

root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path('cloud_runs/global48_d4')
rows = []
for d in sorted(root.glob('cube_*')):
    rp = d / 'receipt.json'
    if not rp.exists():
        rows.append((d.name, 'NO_RECEIPT', 0, 0.0, None))
        continue
    r = json.loads(rp.read_text())
    rss = None
    tp = d / 'time.txt'
    if tp.exists():
        m = re.search(r'Maximum resident set size \(kbytes\):\s*(\d+)', tp.read_text())
        if m:
            rss = int(m.group(1)) / (1024 * 1024)
    rows.append((d.name, r['status'], r['exact_target_blocks'], r['elapsed_seconds'], rss))

print(f'GLOBAL48 SUMMARY: {root}')
print('cube\tstatus\tcuts\tseconds\tmax_RSS_GiB')
for cube, status, cuts, secs, rss in rows:
    print(f'{cube}\t{status}\t{cuts}\t{secs:.1f}\t{rss if rss is not None else "?"}')
counts = {}
for _, status, *_ in rows:
    counts[status] = counts.get(status, 0) + 1
print('status_counts=' + json.dumps(counts, sort_keys=True))
if rows:
    rss_values = [r[-1] for r in rows if r[-1] is not None]
    if rss_values:
        print(f'peak_observed_RSS_GiB={max(rss_values):.3f}')

sat = [r for r in rows if r[1] == 'SAT_CONSTRUCTION']
if sat:
    print('*** SAT CONSTRUCTION FOUND. STOP AND INDEPENDENTLY VERIFY BEFORE ANY PUBLIC CLAIM. ***')
unsat = [r for r in rows if r[1] == 'UNSAT_UNDER_STRUCTURAL_CONSTRAINTS']
if rows and len(unsat) == len(rows):
    print('All represented cubes returned incremental UNSAT.')
    print('DO NOT publish nonexistence yet: freeze/replay as static CNF and verify DRAT/LRAT first.')
