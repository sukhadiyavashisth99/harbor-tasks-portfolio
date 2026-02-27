#!/usr/bin/env bash
set -euo pipefail

# 1) Produce the required output file
bash /solution/solve.sh

# 2) Run tests
pytest -q /tests

# 3) Write reward
mkdir -p /logs/verifier
echo "1" > /logs/verifier/reward.txt
