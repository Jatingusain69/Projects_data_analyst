"""Invoice Verification & Discrepancy Analysis (Python / Pandas version)
Reads PO_Data and Invoice_Data from the Excel workbook, runs the same checks
as the Excel formulas, and saves exceptions to a CSV. Sample data only.
"""
import pandas as pd

FILE = "Invoice_Verification_Project.xlsx"

po = pd.read_excel(FILE, sheet_name="PO_Data")
inv = pd.read_excel(FILE, sheet_name="Invoice_Data")

# Join each invoice to its PO
df = inv.merge(po[["PO_No", "PO_Qty", "PO_Unit_Price"]], on="PO_No", how="left")
df["Expected"] = df["PO_Qty"] * df["PO_Unit_Price"]
df["Variance"] = (df["Billed_Amount"] - df["Expected"]).round(2)

# Checks
df["Missing_Field"] = inv[["Invoice_No", "Invoice_Date", "Vendor", "PO_No", "Item",
                           "Inv_Qty", "Inv_Unit_Price", "Billed_Amount"]].isna().any(axis=1)
df["Duplicate"] = df.duplicated(subset=["Invoice_No", "PO_No", "Billed_Amount"], keep=False)
df["PO_Not_Found"] = df["PO_No"].notna() & df["PO_Qty"].isna()
df["Qty_Mismatch"] = df["PO_Qty"].notna() & (df["Inv_Qty"] != df["PO_Qty"])
df["Price_Mismatch"] = df["PO_Unit_Price"].notna() & ((df["Inv_Unit_Price"] - df["PO_Unit_Price"]).round(2) != 0)
df["Total_Error"] = (df["Billed_Amount"] - df["Inv_Qty"] * df["Inv_Unit_Price"]).round(2) != 0

flags = ["Missing_Field", "Duplicate", "PO_Not_Found", "Qty_Mismatch", "Price_Mismatch", "Total_Error"]
df["Status"] = df[flags].any(axis=1).map({True: "Exception", False: "Clean"})
df["Exception_Type"] = df[flags].apply(lambda r: "; ".join(c.replace("_", " ") for c in flags if r[c]), axis=1)

# Summary
total, exc = len(df), (df["Status"] == "Exception").sum()
print(f"Invoices checked : {total}")
print(f"Clean            : {total - exc}")
print(f"Exceptions       : {exc} ({exc / total:.0%})")
print(f"Overbilled (Rs)  : {df.loc[df['Variance'] > 0, 'Variance'].sum():,.2f}")
print("\nException count by type:")
print(df[flags].sum().to_string())

df[df["Status"] == "Exception"].to_csv("invoice_exceptions.csv", index=False)
print("\nSaved: invoice_exceptions.csv")
