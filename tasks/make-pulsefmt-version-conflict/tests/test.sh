#!/usr/bin/env bash
set -euo pipefail

mkdir -p /logs/verifier

if [ -d /project ]; then
  cd /project
else
  cd "$(dirname "$0")/.."
fi

if pytest -q tests/test_outputs.py; then
  echo "1.0" > /logs/verifier/reward.txt
else
  echo "0.0" > /logs/verifier/reward.txt
  exit 1
fi
