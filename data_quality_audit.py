"""Data Quality Audit (Python / Pandas template)
Point FILE at your own dataset (CSV) and set KEY_COLS / RULES for your columns.
Prints a summary of issues and saves them to audit_issues.csv.
"""
import pandas as pd

FILE = "records.csv"            # your dataset
KEY_COLS = ["employee_id"]      # columns that should be unique
REQUIRED = ["employee_id", "name", "department"]   # must not be blank
RULES = {                       # column: allowed condition (function -> True if valid)
    "salary": lambda s: s > 0,
    "email": lambda s: s.astype(str).str.contains(r"^[^@\s]+@[^@\s]+\.[^@\s]+$", regex=True),
}

df = pd.read_csv(FILE)
issues = []

def add(mask, issue):
    for idx in df.index[mask]:
        issues.append({"row": idx + 2, "issue": issue})   # +2 = Excel row number (header + 1-based)

for col in REQUIRED:
    add(df[col].isna() | (df[col].astype(str).str.strip() == ""), f"Missing {col}")
add(df.duplicated(subset=KEY_COLS, keep=False), "Duplicate " + "/".join(KEY_COLS))
for col, ok in RULES.items():
    add(df[col].notna() & ~ok(df[col]), f"Invalid {col}")
for col in df.select_dtypes(include=["object", "string"]):
    add(df[col].notna() & (df[col].astype(str) != df[col].astype(str).str.strip()), f"Extra spaces in {col}")

out = pd.DataFrame(issues)
print(f"Records reviewed: {len(df)}")
print(f"Issues found    : {len(out)}")
if len(out):
    print(out["issue"].value_counts().to_string())
    out.to_csv("audit_issues.csv", index=False)
    print("Saved: audit_issues.csv")
