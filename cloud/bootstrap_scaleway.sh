#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/jaredwilder/erdos902.git"
BRANCH="${ERDOS902_BRANCH:-compute/global-s4-cloud}"
WORKDIR="${ERDOS902_WORKDIR:-$HOME/erdos902-cloud}"

if [[ "${EUID}" -eq 0 ]]; then SUDO=""; else SUDO="sudo"; fi

$SUDO apt-get update
DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y \
  git python3 python3-venv python3-pip build-essential tmux jq time procps util-linux

if [[ -d "$WORKDIR/.git" ]]; then
  git -C "$WORKDIR" fetch --prune origin
else
  git clone "$REPO_URL" "$WORKDIR"
fi

git -C "$WORKDIR" checkout "$BRANCH"
git -C "$WORKDIR" reset --hard "origin/$BRANCH"
cd "$WORKDIR"

python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip wheel
python -m pip install python-sat

mkdir -p cloud_receipts cloud_runs
{
  echo "utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "git_commit=$(git rev-parse HEAD)"
  echo "git_branch=$(git branch --show-current)"
  echo "python=$(python --version 2>&1)"
  echo "pysat=$(python -c 'import pysat; print(pysat.__version__)')"
  echo "nproc=$(nproc)"
  echo "memory_bytes=$(awk '/MemTotal/ {print $2*1024}' /proc/meminfo)"
  echo "hostname=$(hostname)"
} | tee cloud_receipts/bootstrap_host.txt
lscpu > cloud_receipts/lscpu.txt
free -h > cloud_receipts/free.txt
python -m pip freeze > cloud_receipts/pip_freeze.txt

# Known exact controls. f(2)=7, so arbitrary n=6 must be UNSAT and n=7 must be SAT.
python tools/global_s4_cegar.py --n 6 --k 2 --fix-arc --batch 64 \
  --receipt cloud_receipts/smoke_n6_k2.json --matrix cloud_receipts/smoke_n6_k2.adj || true
python tools/global_s4_cegar.py --n 7 --k 2 --fix-arc --batch 64 \
  --receipt cloud_receipts/smoke_n7_k2.json --matrix cloud_receipts/smoke_n7_k2.adj || true
python - <<'PY'
import json
from pathlib import Path
checks = [
    (Path('cloud_receipts/smoke_n6_k2.json'), 'UNSAT_UNDER_STRUCTURAL_CONSTRAINTS'),
    (Path('cloud_receipts/smoke_n7_k2.json'), 'SAT_CONSTRUCTION'),
]
for p, expected in checks:
    data = json.loads(p.read_text())
    got = data['status']
    if got != expected:
        raise SystemExit(f'SMOKE FAIL {p}: expected {expected}, got {got}')
print('SMOKE PASS: global CEGAR reproduces f(2)=7 boundary (n=6 UNSAT, n=7 SAT).')
PY

echo
echo "BOOTSTRAP PASS"
echo "workdir=$WORKDIR"
echo "commit=$(git rev-parse HEAD)"
echo "Next: bash cloud/calibrate_global48.sh"
