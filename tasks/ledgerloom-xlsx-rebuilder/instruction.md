You’re given a Harbor task environment with a CLI toolchain already set up. Your goal is to produce a valid Excel report at:

/output/final_report.xlsx

The report must contain two sheets:

1) Transactions
- Header row must be exactly:
  txn_id, date, description, category, amount
- Dates must be normalized to ISO format YYYY-MM-DD
- Categories must be normalized using this mapping:
  Groc. -> Groceries
  Transport -> Transport
  Utilities -> Utilities
  Food -> Food
  Rent -> Rent
  Health -> Health
  Income -> Income
  Other -> Other

2) Summary
- Two columns: Category, Total
- One row per category that appears in Transactions (sum of amount)
- Final row labeled "Grand Total" with the sum of all category totals

Notes:
- Amounts can be negative (spend) or positive (income/refunds).
- Totals must be numeric (not stored as text).
- Output must be a real .xlsx file that can be opened in Excel.
