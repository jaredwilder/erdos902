#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

# Pull latest weapon from the compute branch.
git fetch origin compute/global-s4-cloud
git reset --hard origin/compute/global-s4-cloud

mkdir -p cloud_runs/f4_local_universe

CXX="${CXX:-g++}"
THREADS="${THREADS:-$(nproc)}"
export OMP_NUM_THREADS="$THREADS"

echo "=== BUILDING LOCAL-UNIVERSE AUDITOR ==="
$CXX -O3 -march=native -fopenmp -std=c++20 \
  tools/f4_local_universe.cpp -o cloud_runs/f4_local_universe/f4_local_universe
echo "=== BUILD PASS / threads=$OMP_NUM_THREADS ==="

run_row() {
  local row="$1"
  local out="cloud_runs/f4_local_universe/row${row}.json"
  local tim="cloud_runs/f4_local_universe/row${row}.time.txt"
  echo "=== ROW $row / EXHAUSTIVE 2^23 MASK AUDIT / OMP_NUM_THREADS=$OMP_NUM_THREADS ==="

  # Keep stdout pristine JSON while giving the terminal a visible heartbeat.
  /usr/bin/time -v -o "$tim" \
    cloud_runs/f4_local_universe/f4_local_universe --row "$row" \
    > "$out" &
  local pid=$!
  while kill -0 "$pid" 2>/dev/null; do
    sleep 5
    if kill -0 "$pid" 2>/dev/null; then
      echo "row $row still running... pid=$pid utc=$(date -u +%H:%M:%S) cpu_threads=$OMP_NUM_THREADS"
    fi
  done
  wait "$pid"

  cat "$out"
  sha256sum "$out" > "cloud_runs/f4_local_universe/row${row}.sha256"
  echo "=== ROW $row COMPLETE ==="
}

run_row 35
run_row 36

python3 - <<'PY'
import json
from pathlib import Path
root=Path('cloud_runs/f4_local_universe')
rows=[]
for r in (35,36):
    d=json.loads((root/f'row{r}.json').read_text())
    rows.append(d)
    print(f"row {r}: admissible={sum(d['admissible_count_by_size_0_to_12'])} "
          f"maximal={sum(d['maximal_admissible_count_by_size_0_to_12'])} "
          f"envelope_violations={d['envelope_violations']} "
          f"elapsed={d['elapsed_seconds']}s")
    if not d['bad4_control_pass']:
        raise SystemExit(f'ROW {r} BAD4 CONTROL FAIL')
    if not d['size12_rigidity_control_pass']:
        raise SystemExit(f'ROW {r} RIGIDITY CONTROL FAIL')
    if not d['closed_out_capacity_control_pass']:
        raise SystemExit(f'ROW {r} CAPACITY CONTROL FAIL')
    if not d['exceptional_size11_exact_control_pass']:
        raise SystemExit(f'ROW {r} SIZE11 CONTROL FAIL')

if all(d['envelope_pass'] for d in rows):
    print('ENVELOPE AUDIT PASS ON ALL 2^23 MASKS FOR BOTH ROWS.')
    print('IMPORTANT: this is finite computational evidence. Do not publish f(4)>=49 yet; next step is independent verifier + theorem-chain audit + kernel packaging.')
else:
    for d in rows:
        if not d['envelope_pass']:
            print(f"ROW {d['row']} ENVELOPE FAIL: {d['envelope_violations']} violations; "
                  f"worst mask={d['worst_excess_mask']} size={d['worst_excess_size']} "
                  f"repair={d['worst_excess_repair']} excess={d['worst_excess_over_envelope']}")
    print('ENVELOPE CONJECTURE KILLED. Mine the violating masks; do not claim the 2448 argument.')
PY

echo "receipts=$(realpath cloud_runs/f4_local_universe)"
