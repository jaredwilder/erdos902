#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
source .venv/bin/activate

CUBE_DEPTH="${CUBE_DEPTH:-4}"
JOBS="${JOBS:-8}"
TIME_LIMIT="${TIME_LIMIT:-21600}"
OUT="${OUT:-cloud_runs/global48_d${CUBE_DEPTH}}"
TOTAL=$((1 << CUBE_DEPTH))
mkdir -p "$OUT"

run_cube() {
  local idx="$1"
  local tag
  tag=$(printf '%03d' "$idx")
  mkdir -p "$OUT/cube_$tag"
  /usr/bin/time -v -o "$OUT/cube_$tag/time.txt" \
    python tools/global_s4_cegar.py \
      --n 48 --k 4 --f4step48 \
      --cube-depth "$CUBE_DEPTH" --cube-index "$idx" \
      --batch 512 --time-limit "$TIME_LIMIT" --progress 20 \
      --cutlog "$OUT/cube_$tag/cuts.jsonl" \
      --receipt "$OUT/cube_$tag/receipt.json" \
      --matrix "$OUT/cube_$tag/adjacency.txt" \
      > "$OUT/cube_$tag/stdout.log" 2>&1 || true
}
export -f run_cube
export OUT CUBE_DEPTH TIME_LIMIT

seq 0 $((TOTAL - 1)) | xargs -n1 -P "$JOBS" bash -c 'run_cube "$0"'
python cloud/summarize_global48.py "$OUT"
