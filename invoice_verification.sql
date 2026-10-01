-- Invoice Verification & Discrepancy Analysis (SQL part)
-- Works in MySQL and SQLite. Sample data only.

DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS purchase_orders;

CREATE TABLE purchase_orders (
    po_no        VARCHAR(10) PRIMARY KEY,
    vendor       VARCHAR(60),
    item         VARCHAR(60),
    po_qty       INT,
    po_unit_price DECIMAL(10,2)
);

CREATE TABLE invoices (
    row_id       INT PRIMARY KEY,
    invoice_no   VARCHAR(12),
    invoice_date DATE,
    vendor       VARCHAR(60),
    po_no        VARCHAR(10),
    item         VARCHAR(60),
    inv_qty      INT,
    inv_unit_price DECIMAL(10,2),
    billed_amount DECIMAL(12,2)
);

INSERT INTO purchase_orders VALUES ('PO-5001', 'Sharma Office Supplies', 'A4 Paper Ream', 12, 285);
INSERT INTO purchase_orders VALUES ('PO-5002', 'TechNova Traders', 'Toner Cartridge', 10, 3450);
INSERT INTO purchase_orders VALUES ('PO-5003', 'Delhi Stationers', 'USB-C Cable', 20, 420);
INSERT INTO purchase_orders VALUES ('PO-5004', 'Metro IT Solutions', 'Office Chair', 40, 6800);
INSERT INTO purchase_orders VALUES ('PO-5005', 'Apex Furnishings', 'Network Switch 8-Port', 5, 2950);
INSERT INTO purchase_orders VALUES ('PO-5006', 'Sharma Office Supplies', 'Monitor 24 inch', 5, 9800);
INSERT INTO purchase_orders VALUES ('PO-5007', 'TechNova Traders', 'Whiteboard Marker Box', 25, 360);
INSERT INTO purchase_orders VALUES ('PO-5008', 'Delhi Stationers', 'Laptop Stand', 5, 1250);
INSERT INTO purchase_orders VALUES ('PO-5009', 'Metro IT Solutions', 'Wireless Mouse', 12, 780);
INSERT INTO purchase_orders VALUES ('PO-5010', 'Apex Furnishings', 'Keyboard', 25, 1150);
INSERT INTO purchase_orders VALUES ('PO-5011', 'Sharma Office Supplies', 'A4 Paper Ream', 5, 285);
INSERT INTO purchase_orders VALUES ('PO-5012', 'TechNova Traders', 'Toner Cartridge', 25, 3450);
INSERT INTO purchase_orders VALUES ('PO-5013', 'Delhi Stationers', 'USB-C Cable', 10, 420);
INSERT INTO purchase_orders VALUES ('PO-5014', 'Metro IT Solutions', 'Office Chair', 5, 6800);
INSERT INTO purchase_orders VALUES ('PO-5015', 'Apex Furnishings', 'Network Switch 8-Port', 5, 2950);
INSERT INTO purchase_orders VALUES ('PO-5016', 'Sharma Office Supplies', 'Monitor 24 inch', 20, 9800);
INSERT INTO purchase_orders VALUES ('PO-5017', 'TechNova Traders', 'Whiteboard Marker Box', 20, 360);
INSERT INTO purchase_orders VALUES ('PO-5018', 'Delhi Stationers', 'Laptop Stand', 5, 1250);
INSERT INTO purchase_orders VALUES ('PO-5019', 'Metro IT Solutions', 'Wireless Mouse', 10, 780);
INSERT INTO purchase_orders VALUES ('PO-5020', 'Apex Furnishings', 'Keyboard', 5, 1150);
INSERT INTO purchase_orders VALUES ('PO-5021', 'Sharma Office Supplies', 'A4 Paper Ream', 25, 285);
INSERT INTO purchase_orders VALUES ('PO-5022', 'TechNova Traders', 'Toner Cartridge', 20, 3450);
INSERT INTO purchase_orders VALUES ('PO-5023', 'Delhi Stationers', 'USB-C Cable', 5, 420);
INSERT INTO purchase_orders VALUES ('PO-5024', 'Metro IT Solutions', 'Office Chair', 25, 6800);
INSERT INTO purchase_orders VALUES ('PO-5025', 'Apex Furnishings', 'Network Switch 8-Port', 5, 2950);

INSERT INTO invoices VALUES (1, 'INV-1001', '2026-07-22', 'Sharma Office Supplies', 'PO-5001', 'A4 Paper Ream', 12, 285, 3420);
INSERT INTO invoices VALUES (2, 'INV-1002', '2026-07-23', 'TechNova Traders', 'PO-5002', 'Toner Cartridge', 10, 3450, 34500);
INSERT INTO invoices VALUES (3, 'INV-1003', '2026-07-24', 'Delhi Stationers', 'PO-5003', 'USB-C Cable', 20, 420, 8400);
INSERT INTO invoices VALUES (4, 'INV-1004', '2026-07-25', 'Metro IT Solutions', 'PO-5004', 'Office Chair', 40, 6800, 272000);
INSERT INTO invoices VALUES (5, 'INV-1005', '2026-07-26', 'Apex Furnishings', 'PO-5005', 'Network Switch 8-Port', 5, 2950, 14750);
INSERT INTO invoices VALUES (6, 'INV-1006', '2026-07-27', 'Sharma Office Supplies', 'PO-5006', 'Monitor 24 inch', 5, 9800, 49000);
INSERT INTO invoices VALUES (7, 'INV-1007', '2026-07-28', 'TechNova Traders', 'PO-5007', 'Whiteboard Marker Box', 25, 360, 9000);
INSERT INTO invoices VALUES (8, 'INV-1008', '2026-07-01', 'Delhi Stationers', 'PO-5008', 'Laptop Stand', 5, 1250, 6250);
INSERT INTO invoices VALUES (9, 'INV-1009', '2026-07-02', 'Metro IT Solutions', 'PO-5009', 'Wireless Mouse', 12, 780, 9360);
INSERT INTO invoices VALUES (10, 'INV-1010', '2026-07-03', 'Apex Furnishings', 'PO-5010', 'Keyboard', 25, 1150, 28750);
INSERT INTO invoices VALUES (11, 'INV-1011', '2026-07-04', 'Sharma Office Supplies', 'PO-5011', 'A4 Paper Ream', 5, 285, 1425);
INSERT INTO invoices VALUES (12, 'INV-1012', '2026-07-05', 'TechNova Traders', 'PO-5012', 'Toner Cartridge', 25, 3450, 86250);
INSERT INTO invoices VALUES (13, 'INV-1013', '2026-07-06', 'Delhi Stationers', 'PO-5013', 'USB-C Cable', 10, 420, 4200);
INSERT INTO invoices VALUES (14, 'INV-1014', '2026-07-07', 'Metro IT Solutions', 'PO-5014', 'Office Chair', 5, 6800, 34000);
INSERT INTO invoices VALUES (15, 'INV-1015', '2026-07-08', 'Apex Furnishings', 'PO-5015', 'Network Switch 8-Port', 5, 2950, 14750);
INSERT INTO invoices VALUES (16, 'INV-1016', '2026-07-09', 'Sharma Office Supplies', 'PO-5016', 'Monitor 24 inch', 20, 9800, 196000);
INSERT INTO invoices VALUES (17, 'INV-1017', '2026-07-10', 'TechNova Traders', 'PO-5017', 'Whiteboard Marker Box', 20, 360, 7200);
INSERT INTO invoices VALUES (18, 'INV-1018', '2026-07-11', 'Delhi Stationers', 'PO-5018', 'Laptop Stand', 5, 1400, 7000);
INSERT INTO invoices VALUES (19, 'INV-1019', '2026-07-12', 'Metro IT Solutions', 'PO-5019', 'Wireless Mouse', 15, 780, 11700);
INSERT INTO invoices VALUES (20, 'INV-1020', '2026-07-13', 'Apex Furnishings', 'PO-5020', 'Keyboard', 5, 1150, 7550);
INSERT INTO invoices VALUES (21, 'INV-1005', '2026-07-26', 'Apex Furnishings', 'PO-5005', 'Network Switch 8-Port', 5, 2950, 14750);
INSERT INTO invoices VALUES (22, 'INV-1022', '2026-07-15', 'Sharma Office Supplies', NULL, 'A4 Paper Ream', 25, 285, 7125);
INSERT INTO invoices VALUES (23, 'INV-1023', '2026-07-16', NULL, 'PO-5021', 'A4 Paper Ream', 25, 285, 7125);
INSERT INTO invoices VALUES (24, 'INV-1024', '2026-07-17', 'TechNova Traders', 'PO-9999', 'Toner Cartridge', 20, 3450, 69000);

-- 1) Master check: every invoice with its PO and all flags
SELECT i.invoice_no, i.po_no, i.vendor,
       i.inv_qty, p.po_qty, i.inv_unit_price, p.po_unit_price, i.billed_amount,
       p.po_qty * p.po_unit_price                         AS expected_amount,
       i.billed_amount - p.po_qty * p.po_unit_price       AS variance,
       CASE WHEN p.po_no IS NULL THEN 'PO not found'
            WHEN i.inv_qty <> p.po_qty THEN 'Qty mismatch'
            WHEN i.inv_unit_price <> p.po_unit_price THEN 'Price mismatch'
            WHEN ROUND(i.billed_amount - i.inv_qty * i.inv_unit_price, 2) <> 0 THEN 'Total error'
            ELSE 'OK' END                                  AS check_result
FROM invoices i
LEFT JOIN purchase_orders p ON p.po_no = i.po_no
ORDER BY i.row_id;

-- 2) Duplicate invoices (same invoice no + PO + amount)
SELECT invoice_no, po_no, billed_amount, COUNT(*) AS times_billed
FROM invoices
GROUP BY invoice_no, po_no, billed_amount
HAVING COUNT(*) > 1;

-- 3) Missing fields
SELECT row_id, invoice_no,
       CASE WHEN vendor IS NULL THEN 'MISSING' ELSE 'ok' END AS vendor_check,
       CASE WHEN po_no  IS NULL THEN 'MISSING' ELSE 'ok' END AS po_check
FROM invoices
WHERE vendor IS NULL OR po_no IS NULL OR invoice_no IS NULL
   OR inv_qty IS NULL OR inv_unit_price IS NULL OR billed_amount IS NULL;

-- 4) Invoices whose PO does not exist
SELECT i.invoice_no, i.po_no
FROM invoices i
LEFT JOIN purchase_orders p ON p.po_no = i.po_no
WHERE i.po_no IS NOT NULL AND p.po_no IS NULL;

-- 5) Vendor-wise exception summary (overbilled amount)
SELECT i.vendor,
       COUNT(*) AS invoices,
       SUM(CASE WHEN i.billed_amount > p.po_qty * p.po_unit_price THEN 1 ELSE 0 END) AS overbilled_count,
       SUM(CASE WHEN i.billed_amount > p.po_qty * p.po_unit_price
                THEN i.billed_amount - p.po_qty * p.po_unit_price ELSE 0 END) AS overbilled_amount
FROM invoices i
JOIN purchase_orders p ON p.po_no = i.po_no
GROUP BY i.vendor
ORDER BY overbilled_amount DESC;

-- 6) POs not yet invoiced
SELECT p.po_no, p.vendor, p.item
FROM purchase_orders p
LEFT JOIN invoices i ON i.po_no = p.po_no
WHERE i.po_no IS NULL;
