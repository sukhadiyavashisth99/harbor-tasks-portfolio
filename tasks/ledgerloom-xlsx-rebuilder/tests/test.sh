#!/usr/bin/env bash
set -euo pipefail

mkdir -p /logs/verifier

# Default fail unless everything succeeds
echo 0 > /logs/verifier/reward.txt
trap 'echo 0 > /logs/verifier/reward.txt' ERR

# Create input folder and copy fixture
mkdir -p /input
cp -f /solution/fixtures/ledger_dump.csv /input/ledger_dump.csv

# Use uv for isolated env (required by CI sanity)
uv venv /tmp/venv
# shellcheck disable=SC1091
source /tmp/venv/bin/activate

# Install pinned deps (exact versions)
uv pip install -q \
  pytest==8.2.2 \
  openpyxl==3.1.5

# Run solver + tests
bash /solution/solve.sh
pytest -q /tests

# If we got here, success
echo 1 > /logs/verifier/reward.txt
