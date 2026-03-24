-- ============================================================
-- EXPORT BUSINESS MANAGEMENT SYSTEM
-- FILE 2: INSERT SAMPLE DATA
-- Database: Export
-- ============================================================

USE Export;
GO

-- ============================================================
-- INSERT: COUNTRIES
-- ============================================================

INSERT INTO Countries (CountryName, CountryCode, CurrencyCode, CurrencySymbol, Region, IsActive) VALUES
('India', 'IN', 'INR', '₹', 'Asia', 1),
('United States', 'US', 'USD', '$', 'North America', 1),
('United Kingdom', 'GB', 'GBP', '£', 'Europe', 1),
('Germany', 'DE', 'EUR', '€', 'Europe', 1),
('United Arab Emirates', 'AE', 'AED', 'د.إ', 'Middle East', 1),
('Saudi Arabia', 'SA', 'SAR', 'ر.س', 'Middle East', 1),
('Singapore', 'SG', 'SGD', 'S$', 'Asia', 1),
('Australia', 'AU', 'AUD', 'A$', 'Oceania', 1),
('Canada', 'CA', 'CAD', 'C$', 'North America', 1),
('Brazil', 'BR', 'BRL', 'R$', 'South America', 1);

PRINT 'Inserted 10 Countries';

-- ============================================================
-- INSERT: SUPPLIERS
-- ============================================================

INSERT INTO Suppliers (SupplierName, CompanyRegistration, ContactPerson, Email, Phone, Address, CountryID, PaymentTerms, Rating, IsActive) VALUES
('Krishna Rice Mills', 'CRN001', 'Rajesh Kumar', 'rajesh@krishnarice.com', '+91-9999888877', '123 Mill Road, Haryana', 1, 'Net 30', 4.8, 1),
('Sundaram Textiles Ltd', 'CRN002', 'Meera Singh', 'meera@sundaramtex.com', '+91-9876543210', '456 Textile Park, Tamil Nadu', 1, 'Net 45', 4.6, 1),
('Spice Valley Exports', 'CRN003', 'Vikram Patel', 'vikram@spicevalley.com', '+91-8765432109', '789 Spice Street, Kerala', 1, 'Net 30', 4.7, 1),
('Leather Craft Industries', 'CRN004', 'Arjun Sharma', 'arjun@leathercraft.com', '+91-7654321098', '321 Leather Zone, Uttar Pradesh', 1, 'Net 60', 4.5, 1),
('Precision Engineering Co.', 'CRN005', 'Priya Gupta', 'priya@precisioneng.com', '+91-6543210987', '654 Tech Park, Karnataka', 1, 'Net 30', 4.9, 1);

PRINT 'Inserted 5 Suppliers';

-- ============================================================
-- INSERT: CUSTOMERS
-- ============================================================

INSERT INTO Customers (CompanyName, BusinessType, ContactPerson, Email, Phone, Website, Address, CountryID, PortOfDischarge, CreditLimit, PaymentTerms, IsActive) VALUES
('Al Manar Trading LLC', 'Distributor', 'Ahmed Al-Mazrouei', 'ahmed@almanar.ae', '+971-4-234-5678', 'www.almanar.ae', 'Dubai Trade Center', 5, 'Port of Jebel Ali', 500000, 'Net 30', 1),
('Global Foods Importers', 'Wholesaler', 'Hans Mueller', 'hans@globalfoods.de', '+49-40-123-4567', 'www.globalfoods.de', 'Hamburg, Germany', 4, 'Port of Hamburg', 300000, 'Net 45', 1),
('Pacific Wholesale Co.', 'Retailer', 'John Smith', 'john@pacificwholesale.com', '+1-213-456-7890', 'www.pacificwholesale.com', 'Los Angeles, CA', 2, 'Port of Los Angeles', 250000, 'Net 30', 1),
('Singapore Trade Hub', 'Distributor', 'Tan Wei Ming', 'tan@singtradeHub.sg', '+65-6789-0123', 'www.singtradehub.sg', 'Singapore', 7, 'Port of Singapore', 400000, 'LC', 1),
('UK Import Solutions', 'Wholesaler', 'Elizabeth Brown', 'elizabeth@ukimports.co.uk', '+44-20-7946-0958', 'www.ukimports.co.uk', 'London, UK', 3, 'Port of Rotterdam', 350000, 'Net 45', 1),
('Riyadh Business Group', 'Distributor', 'Mohammad Al-Saud', 'mohammad@riyadhbg.sa', '+966-11-465-7890', 'www.riyadhbg.sa', 'Riyadh', 6, 'Port of Jeddah', 600000, 'Net 60', 1),
('Melbourne Imports Pty', 'Retailer', 'Sarah Johnson', 'sarah@melbimports.com.au', '+61-3-9654-0000', 'www.melbimports.com.au', 'Melbourne', 8, 'Port of Melbourne', 280000, 'Net 30', 1),
('Toronto Trading Corp', 'Distributor', 'Robert Taylor', 'robert@torontotrading.ca', '+1-416-789-0123', 'www.torontotrading.ca', 'Toronto, Canada', 9, 'Port of Toronto', 320000, 'Net 45', 1);

PRINT 'Inserted 8 Customers';

-- ============================================================
-- INSERT: PRODUCTS
-- ============================================================

INSERT INTO Products (ProductName, Description, Category, HSNCode, UnitOfMeasure, PackingSize, PackingUnit, SupplierID, QualityCertification, MinimumOrderQuantity, LeadTimeDays, IsActive) VALUES
('Basmati Rice Premium Grade', '1121 Basmati Rice, Long grain, 25-30% broken', 'Agri-Commodity', '1006', 'MT', 50, 'Bags', 1, 'ISO 9001, FSSAI', 5, 14, 1),
('Cotton T-Shirts', '100% Organic Cotton, various sizes', 'Textiles', '6109', 'Pieces', 100, 'Boxes', 2, 'GOTS, ISO 9001', 500, 21, 1),
('Black Pepper', 'Premium grade, 50 mesh', 'Spices', '0904', 'MT', 25, 'Jute Bags', 3, 'ISO 22000, FSSAI', 1, 10, 1),
('Leather Wallets', 'Genuine leather, handcrafted', 'Leather Goods', '4205', 'Pieces', 50, 'Cartons', 4, 'ISO 9001', 200, 21, 1),
('CNC Machine Parts', 'Precision engineered components', 'Engineering', '8483', 'Pieces', 20, 'Wooden Boxes', 5, 'ISO 9001, ISO 8601', 100, 28, 1),
('Cashew Nuts', 'Raw cashew kernels, W-320', 'Agri-Commodity', '0801', 'MT', 50, 'Bags', 1, 'FSSAI, ISO 22000', 2, 14, 1),
('Denim Jeans', 'Premium denim, various sizes', 'Textiles', '6202', 'Pieces', 100, 'Boxes', 2, 'ISO 9001', 300, 21, 1),
('Turmeric Powder', 'Pure turmeric, high curcumin content', 'Spices', '0906', 'MT', 25, 'Drums', 3, 'FSSAI, ISO 22000', 1, 10, 1);

PRINT 'Inserted 8 Products';

-- ============================================================
-- INSERT: PRODUCT PRICING
-- ============================================================

INSERT INTO ProductPricing (ProductID, SupplierID, CostPrice, MarkupPercentage, ExportPrice, CurrencyCode, MinimumQuantity, MaximumQuantity, EffectiveDate, ExpiryDate) VALUES
(1, 1, 400, 20, 480, 'USD', 5, 500, '2026-01-01', NULL),
(2, 2, 2.50, 40, 3.50, 'USD', 500, 50000, '2026-01-01', NULL),
(3, 3, 3500, 25, 4375, 'USD', 1, 100, '2026-01-01', NULL),
(4, 4, 8, 35, 10.80, 'USD', 200, 10000, '2026-01-01', NULL),
(5, 5, 45, 30, 58.50, 'USD', 100, 5000, '2026-01-01', NULL),
(6, 1, 2500, 22, 3050, 'USD', 2, 50, '2026-01-01', NULL),
(7, 2, 3, 38, 4.14, 'USD', 300, 30000, '2026-01-01', NULL),
(8, 3, 5000, 20, 6000, 'USD', 1, 50, '2026-01-01', NULL);

PRINT 'Inserted 8 Product Pricing Records';

-- ============================================================
-- INSERT: INVENTORY
-- ============================================================

INSERT INTO Inventory (ProductID, WarehouseLocation, QuantityInStock, ReorderLevel, ReorderQuantity, LastRestockDate, ManufactureDate, ExpiryDate, BatchNumber) VALUES
(1, 'Warehouse A', 250, 50, 100, '2026-03-01', '2026-02-15', NULL, 'BATCH-001'),
(2, 'Warehouse B', 15000, 1000, 5000, '2026-03-10', '2026-02-20', NULL, 'BATCH-002'),
(3, 'Warehouse A', 45, 10, 30, '2026-03-05', '2026-02-01', NULL, 'BATCH-003'),
(4, 'Warehouse C', 5000, 500, 1000, '2026-03-08', '2026-01-15', NULL, 'BATCH-004'),
(5, 'Warehouse B', 2500, 200, 500, '2026-03-12', '2026-02-10', NULL, 'BATCH-005'),
(6, 'Warehouse A', 120, 20, 50, '2026-02-28', '2026-02-01', NULL, 'BATCH-006'),
(7, 'Warehouse C', 8000, 500, 2000, '2026-03-10', '2026-02-25', NULL, 'BATCH-007'),
(8, 'Warehouse A', 35, 8, 20, '2026-03-07', '2026-01-20', NULL, 'BATCH-008');

PRINT 'Inserted 8 Inventory Records';

-- ============================================================
-- INSERT: ORDERS
-- ============================================================

INSERT INTO Orders (OrderNumber, CustomerID, OrderDate, RequiredDeliveryDate, ConfirmedDeliveryDate, OrderStatus, IncoTerms, PortOfOrigin, PortOfDischarge, CurrencyCode, TotalQuantity, SubTotal, Tax, Discount, ShippingCost, Insurance, TotalAmount, PaymentTerms) VALUES
('ORD-2026-001', 1, '2026-02-15', '2026-03-30', '2026-03-28', 'Shipped', 'FOB', 'Port of Mundra', 'Port of Jebel Ali', 'USD', 50, 24000, 1920, 1000, 2000, 500, 27420, 'Net 30'),
('ORD-2026-002', 2, '2026-02-20', '2026-04-10', '2026-04-08', 'Processing', 'CIF', 'Port of Nhava Sheva', 'Port of Hamburg', 'EUR', 10000, 35000, 2800, 1500, 3500, 800, 40600, 'Net 45'),
('ORD-2026-003', 3, '2026-02-25', '2026-03-25', '2026-03-23', 'Delivered', 'FOB', 'Port of Mundra', 'Port of Los Angeles', 'USD', 1000, 4375000, 350000, 100000, 25000, 15000, 4665000, 'Net 30'),
('ORD-2026-004', 4, '2026-03-01', '2026-04-15', NULL, 'Confirmed', 'LC', 'Port of Nhava Sheva', 'Port of Singapore', 'SGD', 2000, 117000, 9360, 5000, 8000, 2000, 131360, 'LC'),
('ORD-2026-005', 5, '2026-03-05', '2026-04-20', NULL, 'Processing', 'CIF', 'Port of Mundra', 'Port of Rotterdam', 'GBP', 5000, 27000, 2160, 1500, 4500, 1200, 33360, 'Net 45'),
('ORD-2026-006', 1, '2026-03-08', '2026-04-05', NULL, 'Confirmed', 'FOB', 'Port of Mundra', 'Port of Jebel Ali', 'USD', 75, 35850, 2868, 1500, 2500, 700, 40418, 'Net 30'),
('ORD-2026-007', 6, '2026-03-10', '2026-05-01', NULL, 'Confirmed', 'Net 60', 'Port of Nhava Sheva', 'Port of Jeddah', 'SAR', 100, 585000, 46800, 0, 12000, 3500, 647300, 'Net 60'),
('ORD-2026-008', 7, '2026-03-12', '2026-04-30', NULL, 'Processing', 'CIF', 'Port of Mundra', 'Port of Melbourne', 'AUD', 500, 2070000, 165600, 75000, 15000, 8000, 2183600, 'Net 30');

PRINT 'Inserted 8 Orders';

-- ============================================================
-- INSERT: ORDER DETAILS
-- ============================================================

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, LineTotal, SupplierID, DeliveryStatus) VALUES
(1, 1, 50, 480, 24000, 1, 'Complete'),
(2, 2, 10000, 3.50, 35000, 2, 'Complete'),
(3, 3, 1000, 4375, 4375000, 3, 'Complete'),
(4, 4, 2000, 58.50, 117000, 5, 'Pending'),
(5, 2, 5000, 3.50, 17500, 2, 'Partial'),
(5, 7, 2500, 4.14, 10350, 2, 'Pending'),
(6, 6, 75, 3050, 228750, 1, 'Pending'),
(6, 1, 30, 480, 14400, 1, 'Pending'),
(7, 8, 100, 6000, 600000, 3, 'Pending'),
(8, 4, 500, 58.50, 29250, 4, 'Pending'),
(8, 2, 3000, 3.50, 10500, 2, 'Pending');

PRINT 'Inserted 11 Order Details';

-- ============================================================
-- INSERT: INVOICES
-- ============================================================

INSERT INTO Invoices (InvoiceNumber, OrderID, InvoiceDate, DueDate, Amount, TaxAmount, TotalInvoiceAmount, CurrencyCode, InvoiceStatus, Description) VALUES
('INV-2026-001', 1, '2026-02-15', '2026-03-17', 24000, 1920, 27420, 'USD', 'Fully_Paid', 'Export Order Invoice'),
('INV-2026-002', 2, '2026-02-20', '2026-04-06', 35000, 2800, 40600, 'EUR', 'Partially_Paid', 'Export Order Invoice'),
('INV-2026-003', 3, '2026-02-25', '2026-03-27', 4375000, 350000, 4665000, 'USD', 'Fully_Paid', 'Large Export Order'),
('INV-2026-004', 4, '2026-03-01', '2026-04-30', 117000, 9360, 131360, 'SGD', 'Issued', 'Export Order Invoice'),
('INV-2026-005', 5, '2026-03-05', '2026-04-19', 27850, 2228, 33360, 'GBP', 'Partially_Paid', 'Export Order Invoice'),
('INV-2026-006', 6, '2026-03-08', '2026-04-07', 243150, 19452, 262602, 'USD', 'Issued', 'Export Order Invoice'),
('INV-2026-007', 7, '2026-03-10', '2026-05-09', 600000, 48000, 648000, 'SAR', 'Issued', 'Export Order Invoice'),
('INV-2026-008', 8, '2026-03-12', '2026-04-11', 39750, 3180, 42930, 'AUD', 'Issued', 'Export Order Invoice');

PRINT 'Inserted 8 Invoices';

-- ============================================================
-- INSERT: PAYMENTS
-- ============================================================

INSERT INTO Payments (InvoiceID, PaymentDate, AmountPaid, PaymentMethod, ReferenceNumber, BankName, CurrencyCode, ExchangeRate, PaymentStatus) VALUES
(1, '2026-03-05', 27420, 'Bank Transfer', 'BT-2026-001', 'Emirates NBD', 'USD', 3.67, 'Completed'),
(2, '2026-03-25', 20300, 'Bank Transfer', 'BT-2026-002', 'Commerzbank', 'EUR', 1, 'Completed'),
(3, '2026-03-10', 4665000, 'LC', 'LC-2026-001', 'HSBC', 'USD', 1, 'Completed'),
(5, '2026-04-01', 16680, 'Wire Transfer', 'WT-2026-001', 'Barclays', 'GBP', 1, 'Completed'),
(2, '2026-04-20', 20300, 'Bank Transfer', 'BT-2026-003', 'Deutsche Bank', 'EUR', 1, 'Completed');

PRINT 'Inserted 5 Payments';

-- ============================================================
-- INSERT: SHIPMENTS
-- ============================================================

INSERT INTO Shipments (OrderID, ShipmentNumber, ShipmentDate, EstimatedArrivalDate, ActualArrivalDate, ShippingAgent, FreightForwarder, CarrierName, VesselName, ContainerNumber, ContainerType, NumberOfContainers, BillOfLadingNumber, ShipmentStatus, Weight, Volume) VALUES
(1, 'SHIP-2026-001', '2026-02-28', '2026-03-28', '2026-03-27', 'Al Manar Logistics', 'GTI Freight', 'MSC', 'MSC Gulsun', 'MSCU123456789', '20ft', 1, 'BL-2026-001', 'Delivered', 50000, 85),
(2, 'SHIP-2026-002', '2026-03-05', '2026-04-10', NULL, 'HAPAG-Lloyd', 'KUHNE+NAGEL', 'HAPAG', 'Seatrade Reefer', 'HLCU987654321', '40ft', 2, 'BL-2026-002', 'In_Transit', 350000, 65),
(3, 'SHIP-2026-003', '2026-03-10', '2026-03-25', '2026-03-23', 'ONE', 'DHL Supply Chain', 'ONE', 'ONE Innovation', 'ONEU456789012', '40ft', 5, 'BL-2026-003', 'Delivered', 45000, 125),
(4, 'SHIP-2026-004', '2026-03-20', '2026-04-15', NULL, 'Evergreen', 'Sinotrans', 'Evergreen', 'Ever Ace', 'EGLV123456789', '40ft', 2, 'BL-2026-004', 'Pending', 120000, 95),
(5, 'SHIP-2026-005', '2026-03-22', '2026-04-20', NULL, 'Maersk', 'Geodis', 'Maersk', 'Maersk Seatrade', 'MAEU987654321', '40ft', 3, 'BL-2026-005', 'Loaded', 180000, 115);

PRINT 'Inserted 5 Shipments';

-- ============================================================
-- INSERT: SHIPPING DOCUMENTS
-- ============================================================

INSERT INTO ShippingDocuments (ShipmentID, DocumentType, DocumentFileName, DocumentDate, DocumentStatus) VALUES
(1, 'Commercial Invoice', 'INV-2026-001.pdf', '2026-02-15', 'Approved'),
(1, 'Packing List', 'PL-SHIP-2026-001.pdf', '2026-02-28', 'Approved'),
(1, 'Certificate of Origin', 'COO-SHIP-2026-001.pdf', '2026-02-28', 'Approved'),
(1, 'Bill of Lading', 'BL-2026-001.pdf', '2026-02-28', 'Approved'),
(1, 'Insurance Certificate', 'INS-SHIP-2026-001.pdf', '2026-02-28', 'Approved'),
(2, 'Commercial Invoice', 'INV-2026-002.pdf', '2026-02-20', 'Approved'),
(2, 'Packing List', 'PL-SHIP-2026-002.pdf', '2026-03-05', 'Approved'),
(2, 'Certificate of Origin', 'COO-SHIP-2026-002.pdf', '2026-03-05', 'Approved'),
(2, 'Bill of Lading', 'BL-2026-002.pdf', '2026-03-05', 'Approved'),
(2, 'Customs Declaration', 'CD-SHIP-2026-002.pdf', '2026-03-05', 'Approved'),
(3, 'Commercial Invoice', 'INV-2026-003.pdf', '2026-02-25', 'Approved'),
(3, 'Packing List', 'PL-SHIP-2026-003.pdf', '2026-03-10', 'Approved'),
(3, 'Certificate of Origin', 'COO-SHIP-2026-003.pdf', '2026-03-10', 'Approved'),
(3, 'Bill of Lading', 'BL-2026-003.pdf', '2026-03-10', 'Approved'),
(3, 'Insurance Certificate', 'INS-SHIP-2026-003.pdf', '2026-03-10', 'Approved'),
(3, 'Inspection Certificate', 'INSP-SHIP-2026-003.pdf', '2026-03-10', 'Approved'),
(4, 'Commercial Invoice', 'INV-2026-004.pdf', '2026-03-01', 'Pending'),
(4, 'Packing List', 'PL-SHIP-2026-004.pdf', '2026-03-20', 'Pending'),
(4, 'Certificate of Origin', 'COO-SHIP-2026-004.pdf', '2026-03-20', 'Pending'),
(4, 'Bill of Lading', 'BL-2026-004.pdf', '2026-03-20', 'In Progress'),
(5, 'Commercial Invoice', 'INV-2026-005.pdf', '2026-03-05', 'Pending'),
(5, 'Packing List', 'PL-SHIP-2026-005.pdf', '2026-03-22', 'Pending'),
(5, 'Certificate of Origin', 'COO-SHIP-2026-005.pdf', '2026-03-22', 'In Progress'),
(5, 'Bill of Lading', 'BL-2026-005.pdf', '2026-03-22', 'In Progress');

PRINT 'Inserted 24 Shipping Documents';

-- ============================================================
-- INSERT: EMPLOYEES
-- ============================================================

INSERT INTO Employees (EmployeeName, Position, Department, Email, Phone, HireDate, Salary, CommissionPercentage, IsActive) VALUES
('Vikram Sharma', 'Export Manager', 'Sales', 'vikram@exportbiz.com', '+91-9876543210', '2024-01-15', 500000, 2.5, 1),
('Priya Desai', 'Sales Executive', 'Sales', 'priya@exportbiz.com', '+91-8765432109', '2024-06-20', 300000, 1.5, 1),
('Rajesh Kumar', 'Operations Manager', 'Operations', 'rajesh@exportbiz.com', '+91-7654321098', '2023-03-10', 450000, 0, 1),
('Anjali Gupta', 'Finance Manager', 'Finance', 'anjali@exportbiz.com', '+91-6543210987', '2023-08-15', 400000, 0, 1),
('Hassan Al-Mansouri', 'Export Consultant', 'Sales', 'hassan@exportbiz.com', '+971-50-1234567', '2024-10-01', 350000, 2, 1);

PRINT 'Inserted 5 Employees';

-- ============================================================
-- INSERT: QUOTATIONS
-- ============================================================

INSERT INTO Quotations (QuotationNumber, CustomerID, QuotationDate, ValidUntil, CreatedByEmployeeID, Status, SubTotal, Tax, Discount, TotalAmount) VALUES
('QT-2026-001', 1, '2026-02-01', '2026-02-28', 1, 'Accepted', 50000.00, 4000.00, 2000.00, 52000.00),
('QT-2026-002', 2, '2026-02-05', '2026-03-05', 2, 'Accepted', 75000.00, 6000.00, 3000.00, 78000.00),
('QT-2026-003', 3, '2026-02-10', '2026-03-10', 1, 'Accepted', 500000.00, 40000.00, 20000.00, 520000.00),
('QT-2026-004', 4, '2026-02-15', '2026-03-15', 2, 'Sent', 150000.00, 12000.00, 5000.00, 157000.00),
('QT-2026-005', 5, '2026-02-18', '2026-03-18', 1, 'Sent', 100000.00, 8000.00, 4000.00, 104000.00),
('QT-2026-006', 6, '2026-02-20', '2026-03-20', 3, 'Sent', 200000.00, 16000.00, 8000.00, 208000.00),
('QT-2026-007', 7, '2026-02-22', '2026-03-22', 2, 'Draft', 120000.00, 9600.00, 5000.00, 124600.00),
('QT-2026-008', 8, '2026-02-25', '2026-03-25', 1, 'Draft', 180000.00, 14400.00, 7000.00, 187400.00),
('QT-2026-001-REV', 1, '2026-03-01', '2026-03-31', 1, 'Accepted', 60000.00, 4800.00, 2400.00, 62400.00),
('QT-2026-009', 2, '2026-03-05', '2026-04-05', 2, 'Sent', 90000.00, 7200.00, 3600.00, 93600.00),
('QT-2026-010', 3, '2026-03-08', '2026-04-08', 1, 'Sent', 250000.00, 20000.00, 10000.00, 260000.00),
('QT-2026-011', 4, '2026-03-10', '2026-04-10', 2, 'Draft', 175000.00, 14000.00, 7000.00, 182000.00),
('QT-2026-012', 5, '2026-03-12', '2026-04-12', 1, 'Rejected', 85000.00, 6800.00, 3400.00, 88400.00),
('QT-2026-013', 6, '2026-03-15', '2026-04-15', 3, 'Sent', 220000.00, 17600.00, 8800.00, 228800.00),
('QT-2026-014', 7, '2026-03-18', '2026-04-18', 2, 'Draft', 140000.00, 11200.00, 5600.00, 145600.00);

PRINT 'Inserted 15 Quotations';

-- ============================================================
-- INSERT: EXCHANGE RATES
-- ============================================================

INSERT INTO ExchangeRates (FromCurrency, ToCurrency, Rate, RateDate, Source) VALUES
('USD', 'INR', 83.45, '2026-03-23', 'RBI'),
('USD', 'EUR', 0.92, '2026-03-23', 'ECB'),
('USD', 'AED', 3.67, '2026-03-23', 'CBR'),
('USD', 'SGD', 1.35, '2026-03-23', 'MAS'),
('USD', 'GBP', 0.79, '2026-03-23', 'BOE'),
('USD', 'SAR', 3.75, '2026-03-23', 'SAMA'),
('USD', 'AUD', 1.54, '2026-03-23', 'RBA'),
('USD', 'CAD', 1.36, '2026-03-23', 'BOC');

PRINT 'Inserted 8 Exchange Rates';