#!/usr/bin/env bash
set -euo pipefail

mkdir -p /logs/verifier
echo 0 > /logs/verifier/reward.txt
trap 'echo 0 > /logs/verifier/reward.txt' ERR

# env isolation required by CI
uv venv /tmp/venv
source /tmp/venv/bin/activate
uv pip install -q pytest openpyxl

# produce output first
bash /solution/solve.sh

# then run tests
pytest -q /tests

echo 1 > /logs/verifier/reward.txt
