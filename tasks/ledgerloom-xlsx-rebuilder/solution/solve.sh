#!/usr/bin/env bash
set -euo pipefail

python3 - << 'PY'
import csv
import io
from datetime import datetime
from decimal import Decimal, ROUND_HALF_UP
from openpyxl import Workbook
from openpyxl.styles import Font, Alignment
import os

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

CSV_TEXT = """txn_id,date,description,category,amount
T001,01/05/2025,"H-Mart groceries",Groc.,-42.37
T002,2025-01-06,"Uber ride to office",Transport,-18.50
T003,01-07-2025,"Salary payment",Income,2500.00
T004,2025/01/07,"Electricity bill",Utilities,-96.13
T005,1/08/2025,"Coffee, downtown",Food,-4.75
T006,2025-01-08,"Refund: Coffee, downtown",Food,4.75
T007,2025-01-09,"Rent January",Rent,-1200
T008,2025-01-10,"Pharmacy",Health,-23.99
T009,01/10/2025,"Gas station",Transport,-35.21
T010,2025-01-11,"Book store",Other,-12.49
T011,2025-01-12,"Freelance payout",Income,350.00
T012,2025-01-12,"Gym membership",Health,-39.99
"""

def parse_date(s: str) -> str:
    s = s.strip()
    fmts = ["%Y-%m-%d", "%Y/%m/%d", "%m/%d/%Y", "%m-%d-%Y", "%m/%d/%y", "%m-%d-%y"]
    for fmt in fmts:
        try:
            return datetime.strptime(s, fmt).strftime("%Y-%m-%d")
        except ValueError:
            pass
    raise ValueError(f"Unrecognized date format: {s}")

def q2(x: Decimal) -> Decimal:
    return x.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)

wb = Workbook()
ws_txn = wb.active
ws_txn.title = "Transactions"
ws_sum = wb.create_sheet("Summary")

headers = ["txn_id", "date", "description", "category", "amount"]
ws_txn.append(headers)
for cell in ws_txn[1]:
    cell.font = Font(bold=True)
    cell.alignment = Alignment(horizontal="center")

totals = {}
reader = csv.DictReader(io.StringIO(CSV_TEXT))
for row in reader:
    txn_id = row["txn_id"].strip()
    date_iso = parse_date(row["date"])
    desc = row["description"].strip()
    cat_raw = row["category"].strip()
    cat = CATEGORY_MAP.get(cat_raw, cat_raw)
    amt = q2(Decimal(row["amount"].strip()))

    ws_txn.append([txn_id, date_iso, desc, cat, float(amt)])
    totals[cat] = totals.get(cat, Decimal("0.00")) + amt

ws_sum.append(["Category", "Total"])
for cell in ws_sum[1]:
    cell.font = Font(bold=True)
    cell.alignment = Alignment(horizontal="center")

grand = Decimal("0.00")
for cat in sorted(totals.keys()):
    t = q2(totals[cat])
    grand += t
    ws_sum.append([cat, float(t)])

ws_sum.append(["Grand Total", float(q2(grand))])

os.makedirs("/output", exist_ok=True)
wb.save(OUT_PATH)
print(f"Wrote {OUT_PATH}")
PY
