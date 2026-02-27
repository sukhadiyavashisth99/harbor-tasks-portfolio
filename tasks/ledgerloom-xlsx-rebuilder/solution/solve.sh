#!/usr/bin/env bash
set -euo pipefail

python3 - << 'PY'
import csv
import os
import re
from datetime import datetime
from openpyxl import Workbook
from openpyxl.styles import Alignment, Font

IN_PATH = "/solution/fixtures/ledger_dump.csv"
OUT_PATH = "/output/final_report.xlsx"

CATEGORY_MAP = {
    "Groc.": "Groceries",
    "Transport": "Transport",
    "Utilities": "Utilities",
    "Food": "Food",
    "Rent": "Rent",
    "Health": "Health",
    "Income": "Income",
    "Other": "Other",
}

def parse_date(s: str) -> str:
    s = s.strip()
    fmts = ["%Y-%m-%d", "%m/%d/%Y", "%Y/%m/%d", "%m-%d-%Y", "%d-%m-%Y"]
    for f in fmts:
        try:
            return datetime.strptime(s, f).strftime("%Y-%m-%d")
        except ValueError:
            pass
    # fallback: try to extract digits
    m = re.findall(r"\d+", s)
    if len(m) >= 3:
        a,b,c = m[0], m[1], m[2]
        # guess mm dd yyyy
        if len(c) == 4:
            mm, dd, yyyy = int(a), int(b), int(c)
            return f"{yyyy:04d}-{mm:02d}-{dd:02d}"
    raise ValueError(f"Unparseable date: {s}")

os.makedirs("/output", exist_ok=True)

rows = []
with open(IN_PATH, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for r in reader:
        txn_id = r["txn_id"].strip()
        date = parse_date(r["date"])
        desc = r["description"].strip()
        cat_raw = r["category"].strip()
        cat = CATEGORY_MAP.get(cat_raw, "Other")
        amt = float(r["amount"])
        rows.append((txn_id, date, desc, cat, amt))

wb = Workbook()

# Transactions sheet
ws = wb.active
ws.title = "Transactions"
headers = ["txn_id", "date", "description", "category", "amount"]
ws.append(headers)
for row in rows:
    ws.append(list(row))

# basic formatting
for cell in ws[1]:
    cell.font = Font(bold=True)
    cell.alignment = Alignment(horizontal="center")

# Summary sheet
ws2 = wb.create_sheet("Summary")
ws2.append(["Category", "Total"])
totals = {}
for _, _, _, cat, amt in rows:
    totals[cat] = totals.get(cat, 0.0) + amt

for cat in sorted(totals.keys()):
    ws2.append([cat, float(round(totals[cat], 2))])

grand = sum(totals.values())
ws2.append(["Grand Total", float(round(grand, 2))])

for cell in ws2[1]:
    cell.font = Font(bold=True)
    cell.alignment = Alignment(horizontal="center")

wb.save(OUT_PATH)
print(f"Wrote {OUT_PATH}")
PY
