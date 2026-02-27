FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir pytest openpyxl

# Harbor copies task files into /app; keep it simple.
RUN pip install --no-cache-dir uv
