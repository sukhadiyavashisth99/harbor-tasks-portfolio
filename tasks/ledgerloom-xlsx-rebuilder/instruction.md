We have a ledger export that needs to be turned into a client-ready Excel report.

The raw data is available inside the environment at:

    /solution/fixtures/ledger_dump.csv

The CSV contains:

    txn_id, date, description, amount, category

However, the export is inconsistent and requires normalization before reporting.

Requirements:

1. Normalize all dates to ISO format (YYYY-MM-DD).

   The input may contain any of the following formats:
   - YYYY-MM-DD
   - YYYY/MM/DD
   - MM/DD/YYYY
   - MM-DD-YYYY
   - DD-MM-YYYY

2. Normalize categories using the following mapping:

   Groc.      -> Groceries
   Transport  -> Transport
   Utilities  -> Utilities
   Food       -> Food
   Rent       -> Rent
   Health     -> Health
   Income     -> Income
   Other      -> Other

   Any category not listed above should default to "Other".

3. Generate an Excel file at:

       /output/final_report.xlsx

   The workbook must contain exactly two sheets:

   Sheet 1: "Transactions"
   Columns (in this order):
       txn_id, date, description, category, amount

   Sheet 2: "Summary"
   Columns:
       Category, Total

   - Totals must be grouped by normalized category
   - Categories must appear in alphabetical order
   - Values must be rounded to two decimal places
   - A final row labeled "Grand Total" must be included

The goal is to produce a clean financial summary suitable for external reporting.
