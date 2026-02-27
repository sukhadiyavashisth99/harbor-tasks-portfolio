#!/usr/bin/env bash
set -euo pipefail

mkdir -p /logs/verifier

# Default to failure
echo 0 > /logs/verifier/reward.txt
trap 'echo 0 > /logs/verifier/reward.txt' ERR

# Use uv for isolation (CI requirement)
uv venv /tmp/venv
source /tmp/venv/bin/activate

uv pip install -q pytest openpyxl

# Generate output and run tests
bash /solution/solve.sh
pytest -q /tests

# Success
echo 1 > /logs/verifier/reward.txt
