FROM python:3.12-slim

WORKDIR /app

# Only system tools + uv (no pytest/openpyxl here)
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install uv in the image (ok to bake the toolchain)
RUN pip install --no-cache-dir uv==0.10.6
