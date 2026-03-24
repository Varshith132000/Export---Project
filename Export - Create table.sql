-- ============================================================
-- EXPORT BUSINESS MANAGEMENT SYSTEM
-- FILE 1: CREATE ALL TABLES
-- Database: Export
-- ============================================================

USE Export;
GO

-- Drop existing tables if they exist (in correct order)
IF OBJECT_ID('ShippingDocuments', 'U') IS NOT NULL DROP TABLE ShippingDocuments;
IF OBJECT_ID('ShippingDocuments', 'U') IS NOT NULL DROP TABLE ShippingDocuments;
IF OBJECT_ID('Quotations', 'U') IS NOT NULL DROP TABLE Quotations;
IF OBJECT_ID('ExchangeRates', 'U') IS NOT NULL DROP TABLE ExchangeRates;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Shipments', 'U') IS NOT NULL DROP TABLE Shipments;
IF OBJECT_ID('Payments', 'U') IS NOT NULL DROP TABLE Payments;
IF OBJECT_ID('Invoices', 'U') IS NOT NULL DROP TABLE Invoices;
IF OBJECT_ID('OrderDetails', 'U') IS NOT NULL DROP TABLE OrderDetails;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Inventory', 'U') IS NOT NULL DROP TABLE Inventory;
IF OBJECT_ID('ProductPricing', 'U') IS NOT NULL DROP TABLE ProductPricing;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Suppliers', 'U') IS NOT NULL DROP TABLE Suppliers;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Countries', 'U') IS NOT NULL DROP TABLE Countries;

GO

-- ============================================================
-- 1. COUNTRIES TABLE
-- ============================================================
CREATE TABLE Countries (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName VARCHAR(100) NOT NULL,
    CountryCode VARCHAR(5) UNIQUE,
    CurrencyCode VARCHAR(5),
    CurrencySymbol VARCHAR(5),
    Region VARCHAR(50),
    IsActive BIT DEFAULT 1
);

PRINT 'Created: Countries';

-- ============================================================
-- 2. SUPPLIERS TABLE
-- ============================================================
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName VARCHAR(100) NOT NULL,
    CompanyRegistration VARCHAR(50),
    ContactPerson VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT,
    CountryID INT NOT NULL,
    PaymentTerms VARCHAR(50),
    Rating DECIMAL(3,2),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

PRINT 'Created: Suppliers';

-- ============================================================
-- 3. CUSTOMERS TABLE
-- ============================================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CompanyName VARCHAR(100) NOT NULL,
    BusinessType VARCHAR(50),
    ContactPerson VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Website VARCHAR(100),
    Address TEXT,
    CountryID INT NOT NULL,
    PortOfDischarge VARCHAR(100),
    CreditLimit DECIMAL(15,2) DEFAULT 0,
    PaymentTerms VARCHAR(50),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

PRINT 'Created: Customers';

-- ============================================================
-- 4. PRODUCTS TABLE
-- ============================================================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Category VARCHAR(50),
    HSNCode VARCHAR(10),
    UnitOfMeasure VARCHAR(20),
    PackingSize INT,
    PackingUnit VARCHAR(20),
    SupplierID INT,
    QualityCertification VARCHAR(100),
    MinimumOrderQuantity DECIMAL(10,2),
    LeadTimeDays INT,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

PRINT 'Created: Products';

-- ============================================================
-- 5. PRODUCT PRICING TABLE
-- ============================================================
CREATE TABLE ProductPricing (
    PricingID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    SupplierID INT NOT NULL,
    CostPrice DECIMAL(12,2),
    MarkupPercentage DECIMAL(5,2),
    ExportPrice DECIMAL(12,2),
    CurrencyCode VARCHAR(5),
    MinimumQuantity DECIMAL(10,2),
    MaximumQuantity DECIMAL(10,2),
    EffectiveDate DATE,
    ExpiryDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

PRINT 'Created: ProductPricing';

-- ============================================================
-- 6. INVENTORY TABLE
-- ============================================================
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    WarehouseLocation VARCHAR(100),
    QuantityInStock DECIMAL(10,2),
    ReorderLevel DECIMAL(10,2),
    ReorderQuantity DECIMAL(10,2),
    LastRestockDate DATE,
    ManufactureDate DATE,
    ExpiryDate DATE,
    BatchNumber VARCHAR(50),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    UNIQUE (ProductID, WarehouseLocation)
);

PRINT 'Created: Inventory';

-- ============================================================
-- 7. ORDERS TABLE
-- ============================================================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderNumber VARCHAR(50) UNIQUE,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    RequiredDeliveryDate DATE,
    ConfirmedDeliveryDate DATE,
    OrderStatus VARCHAR(20) DEFAULT 'Confirmed',
    IncoTerms VARCHAR(20),
    PortOfOrigin VARCHAR(100),
    PortOfDischarge VARCHAR(100),
    CurrencyCode VARCHAR(5),
    TotalQuantity DECIMAL(10,2),
    SubTotal DECIMAL(15,2),
    Tax DECIMAL(10,2),
    Discount DECIMAL(10,2),
    ShippingCost DECIMAL(10,2),
    Insurance DECIMAL(10,2),
    TotalAmount DECIMAL(15,2),
    PaymentTerms VARCHAR(50),
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

PRINT 'Created: Orders';

-- ============================================================
-- 8. ORDER DETAILS TABLE
-- ============================================================
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity DECIMAL(10,2),
    UnitPrice DECIMAL(12,2),
    LineTotal DECIMAL(15,2),
    SupplierID INT,
    DeliveryStatus VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

PRINT 'Created: OrderDetails';

-- ============================================================
-- 9. INVOICES TABLE
-- ============================================================
CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceNumber VARCHAR(50) UNIQUE,
    OrderID INT NOT NULL,
    InvoiceDate DATE,
    DueDate DATE,
    Amount DECIMAL(15,2),
    TaxAmount DECIMAL(10,2),
    TotalInvoiceAmount DECIMAL(15,2),
    CurrencyCode VARCHAR(5),
    InvoiceStatus VARCHAR(20) DEFAULT 'Issued',
    Description TEXT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

PRINT 'Created: Invoices';

-- ============================================================
-- 10. PAYMENTS TABLE
-- ============================================================
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceID INT NOT NULL,
    PaymentDate DATE,
    AmountPaid DECIMAL(15,2),
    PaymentMethod VARCHAR(30) DEFAULT 'Bank Transfer',
    ReferenceNumber VARCHAR(100),
    BankName VARCHAR(100),
    CurrencyCode VARCHAR(5),
    ExchangeRate DECIMAL(10,4),
    PaymentStatus VARCHAR(20) DEFAULT 'Completed',
    PaymentDate_Recorded DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID)
);

PRINT 'Created: Payments';

-- ============================================================
-- 11. SHIPMENTS TABLE
-- ============================================================
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ShipmentNumber VARCHAR(50) UNIQUE,
    ShipmentDate DATE,
    EstimatedArrivalDate DATE,
    ActualArrivalDate DATE,
    ShippingAgent VARCHAR(100),
    FreightForwarder VARCHAR(100),
    CarrierName VARCHAR(100),
    VesselName VARCHAR(100),
    ContainerNumber VARCHAR(50),
    ContainerType VARCHAR(20),
    NumberOfContainers INT,
    BillOfLadingNumber VARCHAR(50),
    ShipmentStatus VARCHAR(30) DEFAULT 'Pending',
    Weight DECIMAL(10,2),
    Volume DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

PRINT 'Created: Shipments';

-- ============================================================
-- 12. SHIPPING DOCUMENTS TABLE
-- ============================================================
CREATE TABLE ShippingDocuments (
    DocumentID INT PRIMARY KEY IDENTITY(1,1),
    ShipmentID INT NOT NULL,
    DocumentType VARCHAR(50),
    DocumentFileName VARCHAR(200),
    DocumentDate DATE,
    UploadedDate DATETIME DEFAULT GETDATE(),
    DocumentStatus VARCHAR(50),
    FOREIGN KEY (ShipmentID) REFERENCES Shipments(ShipmentID)
);

PRINT 'Created: ShippingDocuments';

-- ============================================================
-- 13. EMPLOYEES TABLE
-- ============================================================
CR-- ============================================================
-- EXPORT BUSINESS MANAGEMENT SYSTEM
-- FILE 1: CREATE ALL TABLES
-- Database: Export
-- ============================================================

USE Export;
GO

-- Drop existing tables if they exist (in correct order)
IF OBJECT_ID('ShippingDocuments', 'U') IS NOT NULL DROP TABLE ShippingDocuments;
IF OBJECT_ID('ShippingDocuments', 'U') IS NOT NULL DROP TABLE ShippingDocuments;
IF OBJECT_ID('Quotations', 'U') IS NOT NULL DROP TABLE Quotations;
IF OBJECT_ID('ExchangeRates', 'U') IS NOT NULL DROP TABLE ExchangeRates;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Shipments', 'U') IS NOT NULL DROP TABLE Shipments;
IF OBJECT_ID('Payments', 'U') IS NOT NULL DROP TABLE Payments;
IF OBJECT_ID('Invoices', 'U') IS NOT NULL DROP TABLE Invoices;
IF OBJECT_ID('OrderDetails', 'U') IS NOT NULL DROP TABLE OrderDetails;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Inventory', 'U') IS NOT NULL DROP TABLE Inventory;
IF OBJECT_ID('ProductPricing', 'U') IS NOT NULL DROP TABLE ProductPricing;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Suppliers', 'U') IS NOT NULL DROP TABLE Suppliers;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Countries', 'U') IS NOT NULL DROP TABLE Countries;

GO

-- ============================================================
-- 1. COUNTRIES TABLE
-- ============================================================
CREATE TABLE Countries (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName VARCHAR(100) NOT NULL,
    CountryCode VARCHAR(5) UNIQUE,
    CurrencyCode VARCHAR(5),
    CurrencySymbol VARCHAR(5),
    Region VARCHAR(50),
    IsActive BIT DEFAULT 1
);

PRINT 'Created: Countries';

-- ============================================================
-- 2. SUPPLIERS TABLE
-- ============================================================
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName VARCHAR(100) NOT NULL,
    CompanyRegistration VARCHAR(50),
    ContactPerson VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT,
    CountryID INT NOT NULL,
    PaymentTerms VARCHAR(50),
    Rating DECIMAL(3,2),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

PRINT 'Created: Suppliers';

-- ============================================================
-- 3. CUSTOMERS TABLE
-- ============================================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CompanyName VARCHAR(100) NOT NULL,
    BusinessType VARCHAR(50),
    ContactPerson VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Website VARCHAR(100),
    Address TEXT,
    CountryID INT NOT NULL,
    PortOfDischarge VARCHAR(100),
    CreditLimit DECIMAL(15,2) DEFAULT 0,
    PaymentTerms VARCHAR(50),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

PRINT 'Created: Customers';

-- ============================================================
-- 4. PRODUCTS TABLE
-- ============================================================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Category VARCHAR(50),
    HSNCode VARCHAR(10),
    UnitOfMeasure VARCHAR(20),
    PackingSize INT,
    PackingUnit VARCHAR(20),
    SupplierID INT,
    QualityCertification VARCHAR(100),
    MinimumOrderQuantity DECIMAL(10,2),
    LeadTimeDays INT,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

PRINT 'Created: Products';

-- ============================================================
-- 5. PRODUCT PRICING TABLE
-- ============================================================
CREATE TABLE ProductPricing (
    PricingID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    SupplierID INT NOT NULL,
    CostPrice DECIMAL(12,2),
    MarkupPercentage DECIMAL(5,2),
    ExportPrice DECIMAL(12,2),
    CurrencyCode VARCHAR(5),
    MinimumQuantity DECIMAL(10,2),
    MaximumQuantity DECIMAL(10,2),
    EffectiveDate DATE,
    ExpiryDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

PRINT 'Created: ProductPricing';

-- ============================================================
-- 6. INVENTORY TABLE
-- ============================================================
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    WarehouseLocation VARCHAR(100),
    QuantityInStock DECIMAL(10,2),
    ReorderLevel DECIMAL(10,2),
    ReorderQuantity DECIMAL(10,2),
    LastRestockDate DATE,
    ManufactureDate DATE,
    ExpiryDate DATE,
    BatchNumber VARCHAR(50),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    UNIQUE (ProductID, WarehouseLocation)
);

PRINT 'Created: Inventory';

-- ============================================================
-- 7. ORDERS TABLE
-- ============================================================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderNumber VARCHAR(50) UNIQUE,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    RequiredDeliveryDate DATE,
    ConfirmedDeliveryDate DATE,
    OrderStatus VARCHAR(20) DEFAULT 'Confirmed',
    IncoTerms VARCHAR(20),
    PortOfOrigin VARCHAR(100),
    PortOfDischarge VARCHAR(100),
    CurrencyCode VARCHAR(5),
    TotalQuantity DECIMAL(10,2),
    SubTotal DECIMAL(15,2),
    Tax DECIMAL(10,2),
    Discount DECIMAL(10,2),
    ShippingCost DECIMAL(10,2),
    Insurance DECIMAL(10,2),
    TotalAmount DECIMAL(15,2),
    PaymentTerms VARCHAR(50),
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

PRINT 'Created: Orders';

-- ============================================================
-- 8. ORDER DETAILS TABLE
-- ============================================================
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity DECIMAL(10,2),
    UnitPrice DECIMAL(12,2),
    LineTotal DECIMAL(15,2),
    SupplierID INT,
    DeliveryStatus VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

PRINT 'Created: OrderDetails';

-- ============================================================
-- 9. INVOICES TABLE
-- ============================================================
CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceNumber VARCHAR(50) UNIQUE,
    OrderID INT NOT NULL,
    InvoiceDate DATE,
    DueDate DATE,
    Amount DECIMAL(15,2),
    TaxAmount DECIMAL(10,2),
    TotalInvoiceAmount DECIMAL(15,2),
    CurrencyCode VARCHAR(5),
    InvoiceStatus VARCHAR(20) DEFAULT 'Issued',
    Description TEXT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

PRINT 'Created: Invoices';

-- ============================================================
-- 10. PAYMENTS TABLE
-- ============================================================
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceID INT NOT NULL,
    PaymentDate DATE,
    AmountPaid DECIMAL(15,2),
    PaymentMethod VARCHAR(30) DEFAULT 'Bank Transfer',
    ReferenceNumber VARCHAR(100),
    BankName VARCHAR(100),
    CurrencyCode VARCHAR(5),
    ExchangeRate DECIMAL(10,4),
    PaymentStatus VARCHAR(20) DEFAULT 'Completed',
    PaymentDate_Recorded DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID)
);

PRINT 'Created: Payments';

-- ============================================================
-- 11. SHIPMENTS TABLE
-- ============================================================
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ShipmentNumber VARCHAR(50) UNIQUE,
    ShipmentDate DATE,
    EstimatedArrivalDate DATE,
    ActualArrivalDate DATE,
    ShippingAgent VARCHAR(100),
    FreightForwarder VARCHAR(100),
    CarrierName VARCHAR(100),
    VesselName VARCHAR(100),
    ContainerNumber VARCHAR(50),
    ContainerType VARCHAR(20),
    NumberOfContainers INT,
    BillOfLadingNumber VARCHAR(50),
    ShipmentStatus VARCHAR(30) DEFAULT 'Pending',
    Weight DECIMAL(10,2),
    Volume DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

PRINT 'Created: Shipments';

-- ============================================================
-- 12. SHIPPING DOCUMENTS TABLE
-- ============================================================
CREATE TABLE ShippingDocuments (
    DocumentID INT PRIMARY KEY IDENTITY(1,1),
    ShipmentID INT NOT NULL,
    DocumentType VARCHAR(50),
    DocumentFileName VARCHAR(200),
    DocumentDate DATE,
    UploadedDate DATETIME DEFAULT GETDATE(),
    DocumentStatus VARCHAR(50),
    FOREIGN KEY (ShipmentID) REFERENCES Shipments(ShipmentID)
);

PRINT 'Created: ShippingDocuments';

-- ============================================================
-- 13. EMPLOYEES TABLE
-- ============================================================
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Position VARCHAR(50),
    Department VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    HireDate DATE,
    Salary DECIMAL(12,2),
    CommissionPercentage DECIMAL(5,2) DEFAULT 0,
    IsActive BIT DEFAULT 1
);

PRINT 'Created: Employees';

-- ============================================================
-- 14. QUOTATIONS TABLE
-- ============================================================
CREATE TABLE Quotations (
    QuotationID INT PRIMARY KEY IDENTITY(1,1),
    QuotationNumber VARCHAR(50) UNIQUE,
    CustomerID INT NOT NULL,
    QuotationDate DATE,
    ValidUntil DATE,
    CreatedByEmployeeID INT,
    Status VARCHAR(20) DEFAULT 'Draft',
    SubTotal DECIMAL(15,2),
    Tax DECIMAL(10,2),
    Discount DECIMAL(10,2),
    TotalAmount DECIMAL(15,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CreatedByEmployeeID) REFERENCES Employees(EmployeeID)
);

