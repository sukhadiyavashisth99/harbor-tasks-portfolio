You are working in a Harbor task environment with a Python toolchain available.

Inside the environment, you are provided with a CSV file located at:

    /solution/fixtures/ledger_dump.csv

This file contains transaction data with the following columns:

    txn_id, date, description, amount, category

Your job is to generate an Excel report at:

    /output/final_report.xlsx

The Excel file must contain exactly two sheets:

1) "Transactions"
   - Columns: txn_id, date, description, category, amount
   - Dates must be normalized to ISO format: YYYY-MM-DD
   - Categories must be mapped using the provided mapping logic
   - Preserve numeric precision for amounts

2) "Summary"
   - Two columns: Category, Total
   - One row per category (sorted alphabetically)
   - A final row labeled "Grand Total"
   - Totals must be rounded to 2 decimal places

The output file must be written to /output/final_report.xlsx.

Assume the input file exists and contains valid CSV data.
