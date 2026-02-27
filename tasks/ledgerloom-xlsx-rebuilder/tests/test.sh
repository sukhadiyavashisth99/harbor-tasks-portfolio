#!/usr/bin/env bash
set -euo pipefail

mkdir -p /logs/verifier

echo 0 > /logs/verifier/reward.txt
trap 'echo 0 > /logs/verifier/reward.txt' ERR

mkdir -p /input
cp -f /solution/fixtures/ledger_dump.csv /input/ledger_dump.csv

uv venv /tmp/venv
source /tmp/venv/bin/activate

uv pip install -q \
  pytest==8.2.2 \
  openpyxl==3.1.5

bash /solution/solve.sh
pytest -q /tests

echo 1 > /logs/verifier/reward.txt
