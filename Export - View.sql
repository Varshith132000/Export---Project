USE Export;
GO

DROP VIEW IF EXISTS vw_ExecutiveSummary;
GO

CREATE VIEW vw_ExecutiveSummary AS
SELECT 
    COUNT(DISTINCT o.OrderID) as TotalOrders,
    COUNT(DISTINCT o.CustomerID) as UniqueCustomers,
    SUM(o.TotalAmount) as TotalRevenue,
    AVG(o.TotalAmount) as AvgOrderValue,
    COUNT(DISTINCT s.ShipmentID) as TotalShipments,
    SUM(CASE WHEN s.ActualArrivalDate <= s.EstimatedArrivalDate THEN 1 ELSE 0 END) as OnTimeShipments,
    COUNT(DISTINCT p.ProductID) as UniqueProducts,
    SUM(inv.QuantityInStock) as TotalInventory
FROM Orders o
LEFT JOIN Shipments s ON o.OrderID = s.OrderID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
LEFT JOIN Products p ON od.ProductID = p.ProductID
LEFT JOIN Inventory inv ON p.ProductID = inv.ProductID
WHERE o.OrderStatus NOT IN ('Cancelled');

----

USE Export;
GO

DROP VIEW IF EXISTS vw_DailyRevenueTrend;
GO

CREATE VIEW vw_DailyRevenueTrend AS
SELECT 
    CAST(o.OrderDate as DATE) as OrderDate,
    YEAR(o.OrderDate) as Year,
    MONTH(o.OrderDate) as Month,
    DAY(o.OrderDate) as Day,
    DATENAME(WEEKDAY, o.OrderDate) as DayOfWeek,
    COUNT(o.OrderID) as OrderCount,
    SUM(o.TotalAmount) as DailyRevenue,
    AVG(o.TotalAmount) as AvgOrderValue,
    MIN(o.TotalAmount) as MinOrder,
    MAX(o.TotalAmount) as MaxOrder
FROM Orders o
WHERE o.OrderStatus NOT IN ('Cancelled')
GROUP BY CAST(o.OrderDate as DATE), YEAR(o.OrderDate), MONTH(o.OrderDate), DAY(o.OrderDate), DATENAME(WEEKDAY, o.OrderDate);

PRINT 'View: vw_DailyRevenueTrend Created';
GO

-----------------------

USE Export;
GO

DROP VIEW IF EXISTS vw_CustomerPerformance;
GO

CREATE VIEW vw_CustomerPerformance AS
SELECT 
    c.CustomerID,
    c.CompanyName,
    c.BusinessType,
    co.CountryName,
    c.CountryID,
    c.CreditLimit,
    c.Email,
    c.Phone,
    COUNT(DISTINCT o.OrderID) as TotalOrders,
    SUM(o.TotalAmount) as TotalRevenue,
    AVG(o.TotalAmount) as AvgOrderValue,
    MIN(o.OrderDate) as FirstOrderDate,
    MAX(o.OrderDate) as LastOrderDate,
    DATEDIFF(DAY, MAX(o.OrderDate), GETDATE()) as DaysSinceLastOrder,
    CASE 
        WHEN SUM(o.TotalAmount) > 500000 THEN 'Premium'
        WHEN SUM(o.TotalAmount) > 100000 THEN 'Gold'
        WHEN SUM(o.TotalAmount) > 50000 THEN 'Silver'
        ELSE 'Bronze'
    END as CustomerSegment,
    COALESCE(SUM(i.TotalInvoiceAmount - COALESCE((SELECT SUM(AmountPaid) FROM Payments WHERE InvoiceID = i.InvoiceID), 0)), 0) as OutstandingAmount,
    c.IsActive
FROM Customers c
LEFT JOIN Countries co ON c.CountryID = co.CountryID
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID AND o.OrderStatus NOT IN ('Cancelled')
LEFT JOIN Invoices i ON o.OrderID = i.OrderID
GROUP BY c.CustomerID, c.CompanyName, c.BusinessType, co.CountryName, c.CountryID, c.CreditLimit, c.Email, c.Phone, c.IsActive;

PRINT 'View: vw_CustomerPerformance Created';
GO

----------------

USE Export;
GO

DROP VIEW IF EXISTS vw_ProductSalesPerformance;
GO

CREATE VIEW vw_ProductSalesPerformance AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.HSNCode,
    p.UnitOfMeasure,
    s.SupplierName,
    SUM(od.Quantity) as TotalQuantitySold,
    SUM(od.LineTotal) as TotalRevenue,
    COUNT(DISTINCT od.OrderID) as OrderCount,
    AVG(od.UnitPrice) as AvgPrice,
    AVG(od.Quantity) as AvgQuantityPerOrder,
    pp.CostPrice,
    pp.ExportPrice,
    ROUND(((pp.ExportPrice - pp.CostPrice) / pp.CostPrice * 100), 2) as ProfitMarginPercent,
    inv.QuantityInStock,
    inv.ReorderLevel,
    CASE 
        WHEN inv.QuantityInStock <= inv.ReorderLevel THEN 'URGENT'
        WHEN inv.QuantityInStock <= inv.ReorderLevel * 1.5 THEN 'WARNING'
        ELSE 'OK'
    END as InventoryStatus,
    p.IsActive
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID
LEFT JOIN ProductPricing pp ON p.ProductID = pp.ProductID
LEFT JOIN Inventory inv ON p.ProductID = inv.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category, p.HSNCode, p.UnitOfMeasure, s.SupplierName, pp.CostPrice, pp.ExportPrice, inv.QuantityInStock, inv.ReorderLevel, p.IsActive;

PRINT 'View: vw_ProductSalesPerformance Created';
GO

-----------------------

USE Export;
GO

DROP VIEW IF EXISTS vw_ShipmentPerformance;
GO

CREATE VIEW vw_ShipmentPerformance AS
SELECT 
    s.ShipmentID,
    s.ShipmentNumber,
    o.OrderNumber,
    c.CompanyName,
    co.CountryName,
    s.ShipmentDate,
    s.EstimatedArrivalDate,
    s.ActualArrivalDate,
    DATEDIFF(DAY, s.ShipmentDate, ISNULL(s.ActualArrivalDate, GETDATE())) as TransitDays,
    DATEDIFF(DAY, s.EstimatedArrivalDate, s.ActualArrivalDate) as DaysVariance,
    CASE 
        WHEN s.ActualArrivalDate IS NULL THEN 'In Transit'
        WHEN s.ActualArrivalDate <= s.EstimatedArrivalDate THEN 'On Time'
        ELSE 'Late'
    END as DeliveryStatus,
    s.ShipmentStatus,
    s.VesselName,
    s.ContainerNumber,
    s.ContainerType,
    s.NumberOfContainers,
    s.Weight,
    s.Volume,
    s.ShippingAgent,
    s.FreightForwarder,
    s.CarrierName,
    o.TotalAmount as OrderValue
FROM Shipments s
LEFT JOIN Orders o ON s.OrderID = o.OrderID
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN Countries co ON c.CountryID = co.CountryID;

PRINT 'View: vw_ShipmentPerformance Created';
GO

-------------------------

USE Export;
GO

DROP VIEW IF EXISTS vw_FinancialAnalysis;
GO

CREATE VIEW vw_FinancialAnalysis AS
SELECT 
    i.InvoiceID,
    i.InvoiceNumber,
    o.OrderNumber,
    c.CompanyName,
    c.CountryID,
    co.CountryName,
    i.InvoiceDate,
    i.DueDate,
    CAST(i.InvoiceDate as DATE) as InvoiceDateOnly,
    YEAR(i.InvoiceDate) as Year,
    MONTH(i.InvoiceDate) as Month,
    QUARTER(i.InvoiceDate) as Quarter,
    i.TotalInvoiceAmount,
    i.CurrencyCode,
    COALESCE(SUM(p.AmountPaid), 0) as TotalPaid,
    i.TotalInvoiceAmount - COALESCE(SUM(p.AmountPaid), 0) as OutstandingAmount,
    DATEDIFF(DAY, i.DueDate, GETDATE()) as DaysOverdue,
    CASE 
        WHEN i.TotalInvoiceAmount - COALESCE(SUM(p.AmountPaid), 0) <= 0 THEN 'Fully Paid'
        WHEN COALESCE(SUM(p.AmountPaid), 0) > 0 THEN 'Partially Paid'
        ELSE 'Unpaid'
    END as PaymentStatus,
    CASE 
        WHEN DATEDIFF(DAY, i.DueDate, GETDATE()) > 60 THEN 'Critical'
        WHEN DATEDIFF(DAY, i.DueDate, GETDATE()) > 30 THEN 'High Risk'
        WHEN DATEDIFF(DAY, i.DueDate, GETDATE()) > 0 THEN 'Overdue'
        ELSE 'On Track'
    END as CollectionRisk,
    COUNT(DISTINCT p.PaymentID) as PaymentCount,
    MAX(p.PaymentDate) as LastPaymentDate,
    i.InvoiceStatus,
    o.TotalAmount as OrderAmount
FROM Invoices i
LEFT JOIN Orders o ON i.OrderID = o.OrderID
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN Countries co ON c.CountryID = co.CountryID
LEFT JOIN Payments p ON i.InvoiceID = p.InvoiceID
GROUP BY i.InvoiceID, i.InvoiceNumber, o.OrderNumber, c.CompanyName, c.CountryID, co.CountryName, 
         i.InvoiceDate, i.DueDate, i.TotalInvoiceAmount, i.CurrencyCode, i.InvoiceStatus, o.TotalAmount;

PRINT 'View: vw_FinancialAnalysis Created';
GO

---------------------------

USE Export;
GO

DROP VIEW IF EXISTS vw_QuotationPipeline;
GO

CREATE VIEW vw_QuotationPipeline AS
SELECT 
    q.QuotationID,
    q.QuotationNumber,
    c.CompanyName,
    c.CountryID,
    co.CountryName,
    e.EmployeeName,
    q.QuotationDate,
    q.ValidUntil,
    q.TotalAmount,
    q.Status,
    DATEDIFF(DAY, q.QuotationDate, GETDATE()) as DaysOpen,
    CASE WHEN q.Status = 'Accepted' THEN 1 ELSE 0 END as Won,
    CASE WHEN q.Status = 'Rejected' THEN 1 ELSE 0 END as Lost,
    CASE WHEN q.Status = 'Sent' THEN 1 ELSE 0 END as Pending,
    (SELECT COUNT(*) FROM Orders WHERE CustomerID = c.CustomerID AND 
     OrderDate >= q.QuotationDate AND OrderDate <= DATEADD(DAY, 30, q.QuotationDate)) as ConvertedOrders,
    c.IsActive
FROM Quotations q
LEFT JOIN Customers c ON q.CustomerID = c.CustomerID
LEFT JOIN Countries co ON c.CountryID = co.CountryID
LEFT JOIN Employees e ON q.CreatedByEmployeeID = e.EmployeeID;

PRINT 'View: vw_QuotationPipeline Created';
GO

--------------------------------

USE Export;
GO

DROP VIEW IF EXISTS vw_OrderStatusSummary;
GO

CREATE VIEW vw_OrderStatusSummary AS
SELECT 
    o.OrderID,
    o.OrderNumber,
    c.CompanyName,
    c.CountryID,
    co.CountryName,
    o.OrderDate,
    o.OrderStatus,
    COUNT(DISTINCT od.OrderDetailID) as LineItemCount,
    SUM(od.Quantity) as TotalQuantity,
    o.TotalAmount,
    o.CurrencyCode,
    o.IncoTerms,
    CASE WHEN s.ShipmentID IS NOT NULL THEN 'Shipped' ELSE 'Not Shipped' END as ShipmentStatus,
    CASE 
        WHEN i.InvoiceID IS NULL THEN 'No Invoice'
        WHEN i.InvoiceStatus = 'Fully_Paid' THEN 'Paid'
        WHEN i.InvoiceStatus = 'Partially_Paid' THEN 'Partially Paid'
        ELSE i.InvoiceStatus
    END as PaymentStatus,
    DATEDIFF(DAY, o.OrderDate, GETDATE()) as DaysSinceOrder,
    DATEDIFF(DAY, o.OrderDate, o.ConfirmedDeliveryDate) as FulfillmentDays,
    o.PaymentTerms,
    c.CreditLimit,
    c.IsActive
FROM Orders o
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN Countries co ON c.CountryID = co.CountryID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
LEFT JOIN Shipments s ON o.OrderID = s.OrderID
LEFT JOIN Invoices i ON o.OrderID = i.OrderID
GROUP BY o.OrderID, o.OrderNumber, c.CompanyName, c.CountryID, co.CountryName, o.OrderDate, 
         o.OrderStatus, o.TotalAmount, o.CurrencyCode, o.IncoTerms, s.ShipmentID, i.InvoiceID, 
         i.InvoiceStatus, o.ConfirmedDeliveryDate, o.PaymentTerms, c.CreditLimit, c.IsActive;

PRINT 'View: vw_OrderStatusSummary Created';
GO

---------------------

USE Export;
GO

DROP VIEW IF EXISTS vw_CountryAnalysis;
GO

CREATE VIEW vw_CountryAnalysis AS
SELECT 
    co.CountryID,
    co.CountryName,
    co.Region,
    co.CurrencyCode,
    COUNT(DISTINCT c.CustomerID) as TotalCustomers,
    COUNT(DISTINCT o.OrderID) as TotalOrders,
    SUM(o.TotalAmount) as TotalRevenue,
    AVG(o.TotalAmount) as AvgOrderValue,
    SUM(od.Quantity) as TotalQuantity,
    COUNT(DISTINCT s.ShipmentID) as TotalShipments,
    COUNT(DISTINCT CASE WHEN s.ActualArrivalDate <= s.EstimatedArrivalDate THEN s.ShipmentID END) as OnTimeShipments
FROM Countries co
LEFT JOIN Customers c ON co.CountryID = c.CountryID
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID AND o.OrderStatus NOT IN ('Cancelled')
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
LEFT JOIN Shipments s ON o.OrderID = s.OrderID
GROUP BY co.CountryID, co.CountryName, co.Region, co.CurrencyCode;

PRINT 'View: vw_CountryAnalysis Created';
GO

USE Export;
GO

DROP VIEW IF EXISTS vw_RevenueByCategory;
GO

---------------------
CREATE VIEW vw_RevenueByCategory AS
SELECT 
    p.Category,
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) as QuantitySold,
    SUM(od.LineTotal) as CategoryRevenue,
    COUNT(DISTINCT od.OrderID) as OrderCount,
    AVG(od.UnitPrice) as AvgPrice,
    ROUND(SUM(od.LineTotal) * 100.0 / (SELECT SUM(LineTotal) FROM OrderDetails), 2) as RevenuePercentage
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.Category, p.ProductID, p.ProductName;

PRINT 'View: vw_RevenueByCategory Created';
GO

---------------------------

USE Export;
GO

-- Check all views
SELECT OBJECT_NAME(id) as ViewName
FROM SYSOBJECTS
WHERE XTYPE = 'V' AND name LIKE 'vw_%'
ORDER BY name;

-----------------------------

USE Export;
GO

DROP VIEW IF EXISTS vw_CustomerPerformance;
GO


----------------------------

Msg 195, Level 15, State 10, Procedure vw_FinancialAnalysis, Line 14 [Batch Start Line 427]
'QUARTER' is not a recognized built-in function name.

-- Test each view
PRINT '=== Testing Views ===';  

PRINT '1. Executive Summary:';
SELECT TOP 1 * FROM vw_ExecutiveSummary;

PRINT '2. Daily Revenue Trend:';
SELECT TOP 5 * FROM vw_DailyRevenueTrend;

PRINT '3. Customer Performance:';
SELECT TOP 5 * FROM vw_CustomerPerformance;

PRINT '4. Product Sales Performance:';
SELECT TOP 5 * FROM vw_ProductSalesPerformance;

PRINT '5. Shipment Performance:';
SELECT TOP 5 * FROM vw_ShipmentPerformance;

PRINT '6. Financial Analysis:';
SELECT TOP 5 * FROM vw_FinancialAnalysis;

PRINT '7. Quotation Pipeline:';
SELECT TOP 5 * FROM vw_QuotationPipeline;

PRINT '8. Order Status Summary:';
SELECT TOP 5 * FROM vw_OrderStatusSummary;

PRINT '9. Country Analysis:';
SELECT TOP 5 * FROM vw_CountryAnalysis;

PRINT '10. Revenue by Category:';
SELECT TOP 5 * FROM vw_RevenueByCategory;

PRINT '=== All Views Created Successfully ===';
GO

-----------------