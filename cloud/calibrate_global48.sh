#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
source .venv/bin/activate

SECONDS_PER_CUBE="${SECONDS_PER_CUBE:-300}"
CUBE_DEPTH="${CUBE_DEPTH:-4}"
JOBS="${JOBS:-4}"
OUT="${OUT:-cloud_runs/global48_calibration_d${CUBE_DEPTH}}"
mkdir -p "$OUT"

run_cube() {
  local idx="$1"
  local tag
  tag=$(printf '%02d' "$idx")
  mkdir -p "$OUT/cube_$tag"
  /usr/bin/time -v -o "$OUT/cube_$tag/time.txt" \
    python tools/global_s4_cegar.py \
      --n 48 --k 4 --f4step48 \
      --cube-depth "$CUBE_DEPTH" --cube-index "$idx" \
      --batch 512 --time-limit "$SECONDS_PER_CUBE" --progress 20 \
      --cutlog "$OUT/cube_$tag/cuts.jsonl" \
      --receipt "$OUT/cube_$tag/receipt.json" \
      --matrix "$OUT/cube_$tag/adjacency.txt" \
      > "$OUT/cube_$tag/stdout.log" 2>&1 || true
}
export -f run_cube
export OUT CUBE_DEPTH SECONDS_PER_CUBE

# Calibration samples disjoint cubes. It is performance measurement, not a completeness claim.
seq 0 $((JOBS - 1)) | xargs -n1 -P "$JOBS" bash -c 'run_cube "$0"'
python cloud/summarize_global48.py "$OUT"
