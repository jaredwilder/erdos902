#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

git fetch origin compute/global-s4-cloud
git reset --hard origin/compute/global-s4-cloud
source .venv/bin/activate

OUT="cloud_runs/f4_universal_meta_sat"
mkdir -p "$OUT"

run_case() {
  local c="$1"
  echo "=== UNIVERSAL META-SAT CASE: $c ==="
  /usr/bin/time -v -o "$OUT/${c}.time.txt" \
    python tools/f4_universal_meta_sat.py \
      --case "$c" \
      --cnf "$OUT/${c}.cnf" \
      --receipt "$OUT/${c}.json" \
      --matrix "$OUT/${c}.adjacency.txt" \
      --solver cadical195 \
      | tee "$OUT/${c}.stdout.txt"
  sha256sum "$OUT/${c}.cnf" "$OUT/${c}.json" > "$OUT/${c}.sha256"

  local status
  status=$(python3 -c "import json; print(json.load(open('$OUT/${c}.json'))['status'])")
  echo "=== $c STATUS: $status ==="
  if [[ "$status" == "SAT_COUNTEREXAMPLE" ]]; then
    echo "COUNTEREXAMPLE FOUND IN $c. ROUTE KILLED; STOPPING FURTHER COURTS."
    return 42
  fi
}

set +e
run_case size11
rc=$?
set -e
if [[ $rc -eq 42 ]]; then exit 42; elif [[ $rc -ne 0 ]]; then exit $rc; fi

set +e
run_case size12
rc=$?
set -e
if [[ $rc -eq 42 ]]; then exit 42; elif [[ $rc -ne 0 ]]; then exit $rc; fi

set +e
run_case defects
rc=$?
set -e
if [[ $rc -eq 42 ]]; then exit 42; elif [[ $rc -ne 0 ]]; then exit $rc; fi

python3 - <<'PY'
import json
from pathlib import Path
root=Path('cloud_runs/f4_universal_meta_sat')
for c in ('size11','size12','defects'):
    d=json.loads((root/f'{c}.json').read_text())
    print(f"{c}: status={d['status']} vars={d['variables']} clauses={d['clauses']} solve_seconds={d.get('solve_seconds')}")
print('ALL THREE UNIVERSAL COURTS RETURNED UNSAT_DISCOVERY.')
print('NEXT REQUIRED GATE: external static-CNF CaDiCaL proof + independent DRAT/LRAT verification; do not publish yet.')
PY
