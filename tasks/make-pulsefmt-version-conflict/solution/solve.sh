#!/usr/bin/env bash
set -euo pipefail

if [ -d /project ]; then
  cd /project
else
  cd "$(dirname "$0")/.."
fi

python3 - <<'PY'
from pathlib import Path

makefile = Path("Makefile")
text = makefile.read_text()
old = "PULSEFMT_VERSION := 1.0"
new = "PULSEFMT_VERSION := 2.0"

if old not in text:
    raise SystemExit("expected Makefile to contain the broken dependency pin")

makefile.write_text(text.replace(old, new, 1))
PY

make clean
make
./build/bin/cache_audit
