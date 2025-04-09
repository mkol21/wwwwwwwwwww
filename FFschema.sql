-- GAP Retail Database Schema (Optimized Combined Version)
DROP DATABASE IF EXISTS gap_retail_db;
CREATE DATABASE IF NOT EXISTS gap_retail_db;
USE gap_retail_db;

-- Drop tables in reverse order of dependencies
SET FOREIGN_KEY_CHECKS = 0;

-- Drop analytics tables
DROP TABLE IF EXISTS order_tracking;
DROP TABLE IF EXISTS sales_analytics;

-- Drop relational/junction tables
DROP TABLE IF EXISTS gap_cash;
DROP TABLE IF EXISTS order_promotions;
DROP TABLE IF EXISTS promotion_application;
DROP TABLE IF EXISTS supplier_order_items;
DROP TABLE IF EXISTS supplier_orders;
DROP TABLE IF EXISTS return_items;
DROP TABLE IF EXISTS shipment_items;
DROP TABLE IF EXISTS returns;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS store_inventory_replenishment;
DROP TABLE IF EXISTS warehouse_stock_transfer;
DROP TABLE IF EXISTS inventory_levels;
DROP TABLE IF EXISTS shopping_cart_items;
DROP TABLE IF EXISTS product_categories;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS product_variants;
DROP TABLE IF EXISTS shopping_cart;
DROP TABLE IF EXISTS promotions;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS loyalty_accounts;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS warehouses;
DROP TABLE IF EXISTS payment_status;
DROP TABLE IF EXISTS payment_methods;
DROP TABLE IF EXISTS categories;

SET FOREIGN_KEY_CHECKS = 1;

-- Create base tables
CREATE TABLE categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE,
    CategoryDescription TEXT,
    ParentCategoryID INT NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (ParentCategoryID) REFERENCES categories(CategoryID) ON DELETE SET NULL,
    INDEX idx_category_name (CategoryName),
    INDEX idx_parent_category (ParentCategoryID)
) ENGINE=InnoDB;

CREATE TABLE payment_methods (
    PaymentMethodID INT AUTO_INCREMENT PRIMARY KEY,
    MethodName VARCHAR(50) NOT NULL UNIQUE,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    ProcessingFee DECIMAL(4,2) NOT NULL,
    PaymentGateway VARCHAR(50) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    INDEX idx_method_name (MethodName),
    INDEX idx_payment_active (IsActive),
    CONSTRAINT chk_processing_fee CHECK (ProcessingFee >= 0)
) ENGINE=InnoDB;

CREATE TABLE payment_status (
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(50) NOT NULL UNIQUE,
    StatusDescription TEXT,
    IsSystemStatus BOOLEAN DEFAULT TRUE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    INDEX idx_status_name (StatusName)
) ENGINE=InnoDB;

CREATE TABLE warehouses (
    WarehouseID INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL,
    WarehouseLocation VARCHAR(255) NOT NULL,
    WarehouseCapacity INT NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    ContactPhone VARCHAR(20) NOT NULL,
    ContactEmail VARCHAR(100) NOT NULL,
    OperatingHours VARCHAR(100) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    INDEX idx_warehouse_location (WarehouseLocation),
    INDEX idx_warehouse_name (WarehouseName),
    INDEX idx_warehouse_active (IsActive),
    CONSTRAINT chk_warehouse_capacity CHECK (WarehouseCapacity > 0)
) ENGINE=InnoDB;

CREATE TABLE stores (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    StorePhone VARCHAR(20) NOT NULL,
    StoreEmail VARCHAR(100) NOT NULL,
    ManagerName VARCHAR(100) NOT NULL,
    OperatingHours VARCHAR(100) NOT NULL,
    StoreSize INT NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    SupportsPickup BOOLEAN DEFAULT TRUE NOT NULL,
    RegionID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    INDEX idx_store_location (Location),
    INDEX idx_store_region (RegionID),
    INDEX idx_store_name (StoreName),
    INDEX idx_store_active (IsActive),
    CONSTRAINT chk_store_size CHECK (StoreSize > 0)
) ENGINE=InnoDB;

CREATE TABLE customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    PasswordHash VARCHAR(255) NOT NULL COMMENT 'Hashed password for customer authentication',
    DateJoined DATE NOT NULL DEFAULT (CURRENT_DATE),
    DateOfBirth DATE,
    Gender VARCHAR(20),
    PreferredLanguage VARCHAR(10) DEFAULT 'en' NOT NULL,
    MarketingPreferences JSON,
    StoredPaymentMethods JSON DEFAULT NULL COMMENT 'Array of stored payment methods for express checkout',
    LastLoginDate TIMESTAMP NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    IsFirstTimeBuyer BOOLEAN DEFAULT TRUE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    INDEX idx_customer_email (Email),
    INDEX idx_customer_name (LastName, FirstName),
    INDEX idx_customer_phone (Phone),
    INDEX idx_first_time_buyer (IsFirstTimeBuyer),
    INDEX idx_customer_active (IsActive)
) ENGINE=InnoDB;

-- Add triggers for date validation
DELIMITER $$

CREATE TRIGGER before_customer_insert
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF NEW.DateOfBirth > CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Date of Birth cannot be in the future';
    END IF;
    
    IF NEW.DateJoined > CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Join Date cannot be in the future';
    END IF;
END $$

CREATE TRIGGER before_customer_update
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    IF NEW.DateOfBirth > CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Date of Birth cannot be in the future';
    END IF;
    
    IF NEW.DateJoined > CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Join Date cannot be in the future';
    END IF;
END $$

DELIMITER ;

CREATE TABLE suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100) NOT NULL UNIQUE,
    ContactPhone VARCHAR(20) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    TaxID VARCHAR(50),
    PaymentTerms VARCHAR(100) NOT NULL,
    LeadTimeDays INT NOT NULL,
    MinimumOrderQuantity INT NOT NULL,
    PreferredCurrency CHAR(3) DEFAULT 'USD' NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    SupplierRating DECIMAL(3,2),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    UNIQUE INDEX idx_supplier_email (ContactEmail),
    INDEX idx_supplier_name (SupplierName),
    INDEX idx_supplier_active (IsActive),
    CONSTRAINT chk_supplier_rating CHECK (SupplierRating >= 0 AND SupplierRating <= 5),
    CONSTRAINT chk_supplier_lead_time CHECK (LeadTimeDays > 0),
    CONSTRAINT chk_supplier_moq CHECK (MinimumOrderQuantity > 0)
) ENGINE=InnoDB;

CREATE TABLE addresses (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AddressLine1 VARCHAR(100) NOT NULL,
    AddressLine2 VARCHAR(100),
    City VARCHAR(100) NOT NULL,
    StateProvince VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(20) NOT NULL,
    Country VARCHAR(50) NOT NULL DEFAULT 'USA',
    IsDefaultShipping BOOLEAN DEFAULT FALSE NOT NULL,
    IsDefaultBilling BOOLEAN DEFAULT FALSE NOT NULL,
    AddressType ENUM('HOME', 'BUSINESS', 'SHIPPING', 'BILLING') NOT NULL,
    IsVerified BOOLEAN DEFAULT FALSE NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    VerificationDate TIMESTAMP NULL,
    VerificationMethod VARCHAR(50),
    VerificationNotes TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID) ON DELETE CASCADE,
    INDEX idx_customer_address (CustomerID),
    INDEX idx_address_type (AddressType),
    INDEX idx_postal_code (PostalCode),
    INDEX idx_address_verified (IsVerified),
    INDEX idx_address_active (IsActive),
    INDEX idx_default_shipping (IsDefaultShipping),
    INDEX idx_default_billing (IsDefaultBilling),
    CONSTRAINT chk_verification_date CHECK (
        (IsVerified = FALSE AND VerificationDate IS NULL) OR
        (IsVerified = TRUE AND VerificationDate IS NOT NULL)
    )
) ENGINE=InnoDB;

CREATE TABLE loyalty_accounts (
    LoyaltyAccountID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL UNIQUE,
    PointsBalance INT DEFAULT 0 NOT NULL,
    TierLevel ENUM('Core', 'Enthusiast', 'Icon') DEFAULT 'Core' NOT NULL,
    TierStartDate DATE NOT NULL COMMENT 'Start date of the current annual tier qualification period',
    TierEndDate DATE NOT NULL COMMENT 'End date of the current annual tier qualification period',
    LifetimePoints INT DEFAULT 0 NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID) ON DELETE CASCADE,
    INDEX idx_tier_level (TierLevel),
    INDEX idx_tier_dates (TierStartDate, TierEndDate),
    CONSTRAINT chk_points_balance CHECK (PointsBalance >= 0),
    CONSTRAINT chk_lifetime_points CHECK (LifetimePoints >= 0),
    CONSTRAINT chk_tier_dates CHECK (TierEndDate > TierStartDate)
) ENGINE=InnoDB;

DELIMITER $$

CREATE TRIGGER before_loyalty_insert
BEFORE INSERT ON loyalty_accounts
FOR EACH ROW
BEGIN
    IF NEW.TierStartDate > CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tier start date cannot be in the future';
    END IF;
END $$

DELIMITER ;

CREATE TABLE products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    ProductDescription TEXT NOT NULL,
    Brand VARCHAR(50) NOT NULL DEFAULT 'GAP',
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    ProductLifecycleStatus ENUM('Draft', 'Active', 'Discontinued', 'Seasonal') DEFAULT 'Active' NOT NULL,
    MSRP DECIMAL(10,2) NOT NULL,
    StandardCost DECIMAL(10,2) NOT NULL,
    Weight DECIMAL(6,2) NOT NULL,
    Dimensions VARCHAR(50) NOT NULL,
    SeasonYear INT NOT NULL,
    SeasonName VARCHAR(20) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES categories(CategoryID) ON DELETE RESTRICT,
    FOREIGN KEY (SupplierID) REFERENCES suppliers(SupplierID) ON DELETE RESTRICT,
    INDEX idx_product_lifecycle (ProductLifecycleStatus),
    INDEX idx_product_name (ProductName),
    INDEX idx_product_brand (Brand),
    INDEX idx_product_category (CategoryID),
    INDEX idx_product_supplier (SupplierID),
    INDEX idx_product_season (SeasonYear, SeasonName),
    CONSTRAINT chk_product_prices CHECK (
        MSRP >= 0 AND 
        StandardCost >= 0 AND 
        MSRP >= StandardCost
    ),
    CONSTRAINT chk_season_year CHECK (
        SeasonYear >= 2000 AND SeasonYear <= 2100
    ),
    CONSTRAINT chk_weight CHECK (Weight > 0)
) ENGINE=InnoDB;

CREATE TABLE promotions (
    PromotionID INT AUTO_INCREMENT PRIMARY KEY,
    PromotionName VARCHAR(100) NOT NULL,
    PromotionCode VARCHAR(20) NOT NULL UNIQUE,
    Description TEXT NOT NULL,
    StartDate TIMESTAMP NOT NULL,
    EndDate TIMESTAMP NOT NULL,
    DiscountType ENUM('PERCENTAGE', 'FIXED_AMOUNT', 'BUY_X_GET_Y', 'BUNDLE') NOT NULL,
    DiscountValue DECIMAL(10,2) NOT NULL,
    MinimumPurchase DECIMAL(10,2) DEFAULT 0 NOT NULL,
    MaximumDiscount DECIMAL(10,2),
    UsageLimit INT,
    UsageCount INT DEFAULT 0 NOT NULL,
    IsStackable BOOLEAN DEFAULT FALSE NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    IsFirstTimePurchaseOnly BOOLEAN DEFAULT FALSE NOT NULL,
    ApplicableProducts JSON,
    ExcludedProducts JSON,
    TargetCustomerSegment VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_promotion_dates CHECK (EndDate > StartDate),
    CONSTRAINT chk_promotion_values CHECK (
        DiscountValue > 0 AND
        (MinimumPurchase IS NULL OR MinimumPurchase > 0) AND
        (MaximumDiscount IS NULL OR MaximumDiscount >= DiscountValue) AND
        (DiscountType != 'PERCENTAGE' OR DiscountValue <= 100)
    ),
    CONSTRAINT chk_usage CHECK (
        (UsageLimit IS NULL OR UsageLimit > 0) AND
        UsageCount >= 0 AND
        (UsageLimit IS NULL OR UsageCount <= UsageLimit)
    ),
    INDEX idx_promotion_dates (StartDate, EndDate),
    INDEX idx_promotion_code (PromotionCode),
    INDEX idx_promotion_active (IsActive),
    INDEX idx_first_time_purchase (IsFirstTimePurchaseOnly)
) ENGINE=InnoDB;

CREATE TABLE shopping_cart (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    SessionID VARCHAR(255) NULL,
    LastActiveTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    AppliedPromotions JSON DEFAULT NULL COMMENT 'Array of {promotionId, code, discountAmount}',
    ItemDiscounts JSON DEFAULT NULL COMMENT 'Object mapping cartItemId to discounts',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID) ON DELETE CASCADE,
    INDEX idx_customer_cart (CustomerID),
    INDEX idx_session_cart (SessionID),
    INDEX idx_cart_active_time (LastActiveTime),
    CONSTRAINT chk_cart_owner CHECK (
        (CustomerID IS NULL AND SessionID IS NOT NULL) OR 
        (CustomerID IS NOT NULL AND SessionID IS NULL)
    )
) ENGINE=InnoDB;

CREATE TABLE product_variants (
    VariantID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    SKU VARCHAR(50) NOT NULL UNIQUE,
    Color VARCHAR(50) NOT NULL,
    Size VARCHAR(20) NOT NULL,
    VariantPrice DECIMAL(10,2) NOT NULL,
    VariantImageURI VARCHAR(255) NOT NULL,
    StockLevel INT DEFAULT 0 NOT NULL COMMENT 'Aggregate stock level. Kept in sync via triggers from inventory_levels.',
    LowStockThreshold INT DEFAULT 10 NOT NULL,
    Weight DECIMAL(6,2) NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES products(ProductID) ON DELETE CASCADE,
    INDEX idx_variant_sku (SKU),
    INDEX idx_variant_details (Color, Size),
    INDEX idx_variant_product (ProductID),
    INDEX idx_variant_active (IsActive),
    INDEX idx_variant_stock (StockLevel),
    CONSTRAINT chk_variant_price CHECK (VariantPrice >= 0),
    CONSTRAINT chk_stock_levels CHECK (
        StockLevel >= 0 AND 
        LowStockThreshold > 0
    ),
    CONSTRAINT chk_variant_weight CHECK (Weight > 0)
) ENGINE=InnoDB;

CREATE TABLE orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NULL,
    OrderDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    OrderStatus ENUM('Pending', 'Processing', 'Ready for Pickup', 'Picked Up', 'Shipped', 'Delivered', 'Cancelled', 'Returned') NOT NULL DEFAULT 'Pending',
    ShippingAddressID INT NOT NULL,
    BillingAddressID INT NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    TaxAmount DECIMAL(10,2) NOT NULL,
    ShippingAmount DECIMAL(10,2) NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    IsFirstTimePurchase BOOLEAN DEFAULT FALSE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID) ON DELETE SET NULL,
    FOREIGN KEY (ShippingAddressID) REFERENCES addresses(AddressID) ON DELETE RESTRICT,
    FOREIGN KEY (BillingAddressID) REFERENCES addresses(AddressID) ON DELETE RESTRICT,
    INDEX idx_customer_order (CustomerID),
    INDEX idx_order_status (OrderStatus),
    INDEX idx_order_date (OrderDate),
    INDEX idx_first_purchase (IsFirstTimePurchase),
    INDEX idx_shipping_address (ShippingAddressID),
    INDEX idx_billing_address (BillingAddressID),
    CONSTRAINT chk_order_amounts CHECK (
        SubTotal >= 0 AND 
        TaxAmount >= 0 AND 
        ShippingAmount >= 0 AND 
        TotalAmount >= 0 AND
        TotalAmount = SubTotal + TaxAmount + ShippingAmount
    )
) ENGINE=InnoDB;

DELIMITER $$

CREATE TRIGGER before_order_status_update
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.OrderStatus = 'Cancelled' AND NEW.OrderStatus != 'Cancelled' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot change status of cancelled order';
    END IF;
    
    IF OLD.OrderStatus = 'Returned' AND NEW.OrderStatus != 'Returned' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot change status of returned order';
    END IF;
END $$

CREATE TRIGGER after_order_complete
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.OrderStatus = 'Delivered' AND OLD.OrderStatus != 'Delivered' AND NEW.CustomerID IS NOT NULL THEN
        UPDATE loyalty_accounts
        SET PointsBalance = PointsBalance + FLOOR(NEW.TotalAmount),
            LifetimePoints = LifetimePoints + FLOOR(NEW.TotalAmount)
        WHERE CustomerID = NEW.CustomerID;
    END IF;
END $$

DELIMITER ;

CREATE TABLE product_categories (
    ProductCategoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    CategoryID INT NOT NULL,
    IsPrimary BOOLEAN DEFAULT FALSE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES categories(CategoryID) ON DELETE CASCADE,
    UNIQUE KEY uk_product_category (ProductID, CategoryID),
    INDEX idx_product_categories (ProductID),
    INDEX idx_category_products (CategoryID),
    INDEX idx_primary_category (IsPrimary)
) ENGINE=InnoDB;

DELIMITER $$

CREATE TRIGGER before_insert_product_category
BEFORE INSERT ON product_categories
FOR EACH ROW
BEGIN
    IF NEW.IsPrimary = TRUE THEN
        IF EXISTS (
            SELECT 1 
            FROM product_categories 
            WHERE ProductID = NEW.ProductID 
            AND IsPrimary = TRUE
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product can only have one primary category';
        END IF;
    END IF;
END $$

CREATE TRIGGER before_update_product_category
BEFORE UPDATE ON product_categories
FOR EACH ROW
BEGIN
    IF NEW.IsPrimary = TRUE AND OLD.IsPrimary = FALSE THEN
        IF EXISTS (
            SELECT 1 
            FROM product_categories 
            WHERE ProductID = NEW.ProductID 
            AND IsPrimary = TRUE
            AND ProductCategoryID != NEW.ProductCategoryID
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product can only have one primary category';
        END IF;
    END IF;
END $$

DELIMITER ;

CREATE TABLE shopping_cart_items (
    CartItemID INT AUTO_INCREMENT PRIMARY KEY,
    CartID INT NOT NULL,
    ProductVariantID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (CartID) REFERENCES shopping_cart(CartID) ON DELETE CASCADE,
    FOREIGN KEY (ProductVariantID) REFERENCES product_variants(VariantID) ON DELETE CASCADE,
    INDEX idx_cart_items (CartID),
    INDEX idx_cart_variant (ProductVariantID),
    CONSTRAINT chk_cart_quantity CHECK (Quantity > 0)
) ENGINE=InnoDB;

CREATE TABLE inventory_levels (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    VariantID INT NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    WarehouseID INT NULL,
    StoreID INT NULL,
    LocationType ENUM('Store', 'Warehouse') NOT NULL,
    QuantityOnHand INT NOT NULL DEFAULT 0,
    ReservedForPickup INT DEFAULT 0 NOT NULL,
    PickupReservationExpiry TIMESTAMP NULL,
    ReservedQuantity INT DEFAULT 0 NOT NULL,
    ReservationExpiry TIMESTAMP NULL,
    ReorderPoint INT NOT NULL DEFAULT 10,
    LowStockThreshold INT DEFAULT 10 NOT NULL,
    LastStockCheckDate TIMESTAMP NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (VariantID) REFERENCES product_variants(VariantID) ON DELETE CASCADE,
    FOREIGN KEY (SKU) REFERENCES product_variants(SKU) ON DELETE CASCADE,
    FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID) ON DELETE CASCADE,
    FOREIGN KEY (StoreID) REFERENCES stores(StoreID) ON DELETE CASCADE,
    INDEX idx_inventory_variant (VariantID),
    INDEX idx_inventory_sku (SKU),
    INDEX idx_inventory_location (LocationType, WarehouseID, StoreID),
    INDEX idx_inventory_quantity (QuantityOnHand),
    INDEX idx_inventory_warehouse (WarehouseID),
    INDEX idx_inventory_store (StoreID),
    INDEX idx_inventory_reserved (ReservedQuantity),
    INDEX idx_inventory_pickup (ReservedForPickup),
    CONSTRAINT chk_location CHECK (
        (WarehouseID IS NULL AND StoreID IS NOT NULL AND LocationType = 'Store') OR
        (WarehouseID IS NOT NULL AND StoreID IS NULL AND LocationType = 'Warehouse')
    ),
    CONSTRAINT chk_quantity CHECK (
        QuantityOnHand >= 0 AND 
        ReservedForPickup >= 0 AND 
        ReservedQuantity >= 0 AND
        QuantityOnHand >= (ReservedForPickup + ReservedQuantity)
    ),
    CONSTRAINT chk_reorder_point CHECK (ReorderPoint > 0)
) ENGINE=InnoDB;

DELIMITER $$

CREATE TRIGGER before_inventory_insert
BEFORE INSERT ON inventory_levels
FOR EACH ROW
BEGIN
    IF NEW.ReservedForPickup > 0 AND (NEW.PickupReservationExpiry IS NULL OR NEW.PickupReservationExpiry <= CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid pickup reservation expiry time';
    END IF;
    IF NEW.ReservedQuantity > 0 AND (NEW.ReservationExpiry IS NULL OR NEW.ReservationExpiry <= CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid reservation expiry time';
    END IF;
END $$

CREATE TRIGGER before_inventory_update
BEFORE UPDATE ON inventory_levels
FOR EACH ROW
BEGIN
    IF NEW.ReservedForPickup > 0 AND (NEW.PickupReservationExpiry IS NULL OR NEW.PickupReservationExpiry <= CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid pickup reservation expiry time';
    END IF;
    IF NEW.ReservedQuantity > 0 AND (NEW.ReservationExpiry IS NULL OR NEW.ReservationExpiry <= CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid reservation expiry time';
    END IF;
END $$

CREATE TRIGGER after_inventory_update_store
AFTER UPDATE ON inventory_levels
FOR EACH ROW
BEGIN
    IF NEW.QuantityOnHand <= NEW.LowStockThreshold 
    AND OLD.QuantityOnHand > OLD.LowStockThreshold 
    AND NEW.LocationType = 'Store' THEN
        SIGNAL SQLSTATE '01000'
        SET MESSAGE_TEXT = 'Low stock alert triggered for store inventory';
    END IF;
END $$

CREATE TRIGGER after_inventory_update_warehouse
AFTER UPDATE ON inventory_levels
FOR EACH ROW
BEGIN
    IF NEW.QuantityOnHand <= NEW.LowStockThreshold 
    AND OLD.QuantityOnHand > OLD.LowStockThreshold 
    AND NEW.LocationType = 'Warehouse' THEN
        SIGNAL SQLSTATE '01000'
        SET MESSAGE_TEXT = 'Low stock alert triggered for warehouse inventory';
    END IF;
END $$

DELIMITER ;

-- Sync product_variants.StockLevel triggers
DELIMITER $$

CREATE TRIGGER after_inventory_insert_sync
AFTER INSERT ON inventory_levels
FOR EACH ROW
BEGIN
    UPDATE product_variants
    SET StockLevel = (
        SELECT SUM(QuantityOnHand - ReservedQuantity - ReservedForPickup)
        FROM inventory_levels
        WHERE VariantID = NEW.VariantID
    )
    WHERE VariantID = NEW.VariantID;
END $$

CREATE TRIGGER after_inventory_update_sync
AFTER UPDATE ON inventory_levels
FOR EACH ROW
BEGIN
    UPDATE product_variants
    SET StockLevel = (
        SELECT SUM(QuantityOnHand - ReservedQuantity - ReservedForPickup)
        FROM inventory_levels
        WHERE VariantID = NEW.VariantID
    )
    WHERE VariantID = NEW.VariantID;
END $$

CREATE TRIGGER after_inventory_delete_sync
AFTER DELETE ON inventory_levels
FOR EACH ROW
BEGIN
    UPDATE product_variants
    SET StockLevel = (
        SELECT COALESCE(SUM(QuantityOnHand - ReservedQuantity - ReservedForPickup), 0)
        FROM inventory_levels
        WHERE VariantID = OLD.VariantID
    )
    WHERE VariantID = OLD.VariantID;
END $$

DELIMITER ;

CREATE TABLE warehouse_stock_transfer (
    TransferID INT AUTO_INCREMENT PRIMARY KEY,
    FromWarehouseID INT NOT NULL,
    ToWarehouseID INT NOT NULL,
    VariantID INT NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    TransferStatus ENUM('Pending', 'In Transit', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
    RequestedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CompletedDate TIMESTAMP NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (FromWarehouseID) REFERENCES warehouses(WarehouseID) ON DELETE RESTRICT,
    FOREIGN KEY (ToWarehouseID) REFERENCES warehouses(WarehouseID) ON DELETE RESTRICT,
    FOREIGN KEY (VariantID) REFERENCES product_variants(VariantID) ON DELETE RESTRICT,
    FOREIGN KEY (SKU) REFERENCES product_variants(SKU) ON DELETE RESTRICT,
    INDEX idx_transfer_status (TransferStatus),
    INDEX idx_transfer_variant (VariantID),
    INDEX idx_transfer_sku (SKU),
    INDEX idx_transfer_from (FromWarehouseID),
    INDEX idx_transfer_to (ToWarehouseID),
    INDEX idx_transfer_dates (RequestedDate, CompletedDate),
    CONSTRAINT chk_transfer_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_different_warehouses CHECK (FromWarehouseID != ToWarehouseID),
    CONSTRAINT chk_completion_date CHECK (
        CompletedDate IS NULL OR 
        (CompletedDate >= RequestedDate AND TransferStatus IN ('Completed', 'Cancelled'))
    )
) ENGINE=InnoDB;

CREATE TABLE store_inventory_replenishment (
    ReplenishmentID INT AUTO_INCREMENT PRIMARY KEY,
    StoreID INT NOT NULL,
    WarehouseID INT NOT NULL,
    VariantID INT NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    RequestedQuantity INT NOT NULL,
    IsForPickupReserve BOOLEAN DEFAULT FALSE NOT NULL,
    ReplenishmentStatus ENUM('Requested', 'Processing', 'Shipped', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Requested',
    RequestedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CompletedDate TIMESTAMP NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES stores(StoreID) ON DELETE RESTRICT,
    FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID) ON DELETE RESTRICT,
    FOREIGN KEY (VariantID) REFERENCES product_variants(VariantID) ON DELETE RESTRICT,
    FOREIGN KEY (SKU) REFERENCES product_variants(SKU) ON DELETE RESTRICT,
    INDEX idx_replenishment_status (ReplenishmentStatus),
    INDEX idx_replenishment_sku (SKU),
    INDEX idx_replenishment_variant (VariantID),
    INDEX idx_replenishment_store (StoreID),
    INDEX idx_replenishment_warehouse (WarehouseID),
    INDEX idx_replenishment_dates (RequestedDate, CompletedDate),
    INDEX idx_replenishment_pickup (IsForPickupReserve),
    CONSTRAINT chk_replenishment_quantity CHECK (RequestedQuantity > 0),
    CONSTRAINT chk_replenishment_completion CHECK (
        CompletedDate IS NULL OR 
        (CompletedDate >= RequestedDate AND ReplenishmentStatus IN ('Completed', 'Cancelled'))
    )
) ENGINE=InnoDB;

CREATE TABLE order_items (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductVariantID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductVariantID) REFERENCES product_variants(VariantID) ON DELETE RESTRICT,
    INDEX idx_order_items (OrderID, ProductVariantID),
    INDEX idx_orderitem_order (OrderID),
    INDEX idx_orderitem_variant (ProductVariantID),
    CONSTRAINT chk_orderitem_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_orderitem_price CHECK (
        UnitPrice >= 0 AND 
        SubTotal >= 0 AND 
        SubTotal = Quantity * UnitPrice
    )
) ENGINE=InnoDB;

DELIMITER $

CREATE TRIGGER before_order_item_insert
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE variant_price DECIMAL(10,2);
    
    SELECT VariantPrice INTO variant_price
    FROM product_variants
    WHERE VariantID = NEW.ProductVariantID;
    
    IF NEW.UnitPrice < variant_price THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order item price cannot be less than variant price';
    END IF;
END $

CREATE TRIGGER after_order_item_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory_levels
    SET QuantityOnHand = QuantityOnHand - NEW.Quantity
    WHERE VariantID = NEW.ProductVariantID
    AND LocationType = 'Warehouse'
    AND QuantityOnHand >= NEW.Quantity;
    
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient inventory for order';
    END IF;
END $

CREATE TRIGGER after_order_item_delete
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory_levels
    SET QuantityOnHand = QuantityOnHand + OLD.Quantity
    WHERE VariantID = OLD.ProductVariantID
    AND LocationType = 'Warehouse';
END $

DELIMITER ;

CREATE TABLE payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    PaymentStatusID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    TransactionDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TransactionReference VARCHAR(100) NOT NULL,
    PaymentAttempts INT DEFAULT 1 NOT NULL,
    LastPaymentAttemptDate TIMESTAMP NULL,
    FailureReason VARCHAR(255),
    IsInStore BOOLEAN DEFAULT FALSE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (PaymentMethodID) REFERENCES payment_methods(PaymentMethodID) ON DELETE RESTRICT,
    FOREIGN KEY (PaymentStatusID) REFERENCES payment_status(StatusID) ON DELETE RESTRICT,
    INDEX idx_payment_order (OrderID),
    INDEX idx_payment_transaction (TransactionReference),
    INDEX idx_payment_attempts (PaymentAttempts),
    INDEX idx_payment_method (PaymentMethodID),
    INDEX idx_payment_status (PaymentStatusID),
    INDEX idx_payment_date (TransactionDate),
    INDEX idx_payment_instore (IsInStore),
    CONSTRAINT chk_payment_amount CHECK (Amount > 0),
    CONSTRAINT chk_payment_attempts CHECK (PaymentAttempts > 0),
    CONSTRAINT chk_payment_dates CHECK (
        LastPaymentAttemptDate IS NULL OR 
        LastPaymentAttemptDate >= TransactionDate
    )
) ENGINE=InnoDB;

CREATE TABLE shipments (
    ShipmentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ShipmentType ENUM('Standard Shipping', 'Express Shipping', 'Store Pickup') NOT NULL DEFAULT 'Standard Shipping',
    ShipmentStatus ENUM('Processing', 'Shipped', 'In Transit', 'Delivered', 'Ready for Pickup', 'Picked Up', 'Failed', 'Address Issue') NOT NULL DEFAULT 'Processing',
    TrackingNumber VARCHAR(100),
    ShippingCarrier VARCHAR(50),
    ShippedDate TIMESTAMP NULL,
    EstimatedDeliveryDate TIMESTAMP NULL,
    ActualDeliveryDate TIMESTAMP NULL,
    PickupDate TIMESTAMP NULL,
    PickupStoreID INT NULL,
    ShippingAddressVerified BOOLEAN DEFAULT FALSE NOT NULL,
    DeliveryAttempts INT DEFAULT 0 NOT NULL,
    DeliveryNotes TEXT,
    LastAttemptDate TIMESTAMP NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (PickupStoreID) REFERENCES stores(StoreID) ON DELETE RESTRICT,
    INDEX idx_shipment_order (OrderID),
    INDEX idx_shipment_tracking (TrackingNumber),
    INDEX idx_shipment_pickup (ShipmentType, PickupStoreID),
    INDEX idx_shipment_verified (ShippingAddressVerified),
    INDEX idx_delivery_attempts (DeliveryAttempts),
    INDEX idx_shipment_status (ShipmentStatus),
    INDEX idx_shipment_dates (ShippedDate, EstimatedDeliveryDate, ActualDeliveryDate, PickupDate),
    INDEX idx_shipment_store (PickupStoreID),
    CONSTRAINT chk_pickup_store CHECK (
        (ShipmentType = 'Store Pickup' AND PickupStoreID IS NOT NULL) OR
        (ShipmentType != 'Store Pickup' AND PickupStoreID IS NULL)
    ),
    CONSTRAINT chk_delivery_dates CHECK (
        (ActualDeliveryDate IS NULL OR ActualDeliveryDate >= ShippedDate) AND
        (ShippedDate IS NULL OR ShippedDate <= EstimatedDeliveryDate) AND
        (PickupDate IS NULL OR (ShipmentType = 'Store Pickup' AND PickupDate >= ShippedDate))
    ),
    CONSTRAINT chk_delivery_attempts CHECK (DeliveryAttempts >= 0)
) ENGINE=InnoDB;

CREATE TABLE returns (
    ReturnID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ReturnStatus ENUM('Requested', 'Approved', 'Received', 'Processed', 'Refunded', 'Rejected') NOT NULL DEFAULT 'Requested',
    ReturnReason TEXT NOT NULL,
    ReturnDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    RefundAmount DECIMAL(10,2),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    INDEX idx_return_order (OrderID),
    INDEX idx_return_status (ReturnStatus),
    INDEX idx_return_date (ReturnDate),
    CONSTRAINT chk_refund_amount CHECK (RefundAmount IS NULL OR RefundAmount >= 0)
) ENGINE=InnoDB;

DELIMITER $

CREATE TRIGGER before_return_insert
BEFORE INSERT ON returns
FOR EACH ROW
BEGIN
    DECLARE order_date TIMESTAMP;
    
    SELECT OrderDate INTO order_date
    FROM orders
    WHERE OrderID = NEW.OrderID;
    
    IF NEW.ReturnDate < order_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return date cannot be earlier than order date';
    END IF;
END $

CREATE TRIGGER before_return_update
BEFORE UPDATE ON returns
FOR EACH ROW
BEGIN
    DECLARE order_date TIMESTAMP;
    
    SELECT OrderDate INTO order_date
    FROM orders
    WHERE OrderID = NEW.OrderID;
    
    IF NEW.ReturnDate < order_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return date cannot be earlier than order date';
    END IF;
END $

DELIMITER ;

CREATE TABLE shipment_items (
    ShipmentItemID INT AUTO_INCREMENT PRIMARY KEY,
    ShipmentID INT NOT NULL,
    OrderItemID INT NOT NULL,
    Quantity INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (ShipmentID) REFERENCES shipments(ShipmentID) ON DELETE CASCADE,
    FOREIGN KEY (OrderItemID) REFERENCES order_items(OrderItemID) ON DELETE RESTRICT,
    INDEX idx_shipitem_shipment (ShipmentID),
    INDEX idx_shipitem_orderitem (OrderItemID),
    CONSTRAINT chk_shipitem_quantity CHECK (Quantity > 0)
) ENGINE=InnoDB;

DELIMITER $

CREATE TRIGGER before_shipment_item_insert
BEFORE INSERT ON shipment_items
FOR EACH ROW
BEGIN
    DECLARE order_item_quantity INT;
    DECLARE total_shipped INT;
    
    SELECT Quantity INTO order_item_quantity
    FROM order_items
    WHERE OrderItemID = NEW.OrderItemID;
    
    SELECT COALESCE(SUM(Quantity), 0) INTO total_shipped
    FROM shipment_items
    WHERE OrderItemID = NEW.OrderItemID;
    
    IF (total_shipped + NEW.Quantity) > order_item_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shipment quantity cannot exceed order item quantity';
    END IF;
END $

CREATE TRIGGER before_shipment_item_update
BEFORE UPDATE ON shipment_items
FOR EACH ROW
BEGIN
    DECLARE order_item_quantity INT;
    DECLARE total_shipped INT;
    
    SELECT Quantity INTO order_item_quantity
    FROM order_items
    WHERE OrderItemID = NEW.OrderItemID;
    
    SELECT COALESCE(SUM(Quantity), 0) INTO total_shipped
    FROM shipment_items
    WHERE OrderItemID = NEW.OrderItemID
    AND ShipmentItemID != NEW.ShipmentItemID;
    
    IF (total_shipped + NEW.Quantity) > order_item_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shipment quantity cannot exceed order item quantity';
    END IF;
END $

DELIMITER ;

CREATE TABLE return_items (
    ReturnItemID INT AUTO_INCREMENT PRIMARY KEY,
    ReturnID INT NOT NULL,
    OrderItemID INT NOT NULL,
    Quantity INT NOT NULL,
    ReturnReason TEXT NOT NULL,
    IsDamaged BOOLEAN DEFAULT FALSE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (ReturnID) REFERENCES returns(ReturnID) ON DELETE CASCADE,
    FOREIGN KEY (OrderItemID) REFERENCES order_items(OrderItemID) ON DELETE RESTRICT,
    INDEX idx_returnitem_return (ReturnID),
    INDEX idx_returnitem_orderitem (OrderItemID),
    INDEX idx_returnitem_damaged (IsDamaged),
    CONSTRAINT chk_returnitem_quantity CHECK (Quantity > 0)
) ENGINE=InnoDB;

DELIMITER $

CREATE TRIGGER before_return_item_insert
BEFORE INSERT ON return_items
FOR EACH ROW
BEGIN
    DECLARE order_item_quantity INT;
    DECLARE total_returned INT;
    
    SELECT Quantity INTO order_item_quantity
    FROM order_items
    WHERE OrderItemID = NEW.OrderItemID;
    
    SELECT COALESCE(SUM(Quantity), 0) INTO total_returned
    FROM return_items
    WHERE OrderItemID = NEW.OrderItemID;
    
    IF (total_returned + NEW.Quantity) > order_item_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return quantity cannot exceed order item quantity';
    END IF;
END $

CREATE TRIGGER before_return_item_update
BEFORE UPDATE ON return_items
FOR EACH ROW
BEGIN
    DECLARE order_item_quantity INT;
    DECLARE total_returned INT;
    
    SELECT Quantity INTO order_item_quantity
    FROM order_items
    WHERE OrderItemID = NEW.OrderItemID;
    
    SELECT COALESCE(SUM(Quantity), 0) INTO total_returned
    FROM return_items
    WHERE OrderItemID = NEW.OrderItemID
    AND ReturnItemID != NEW.ReturnItemID;
    
    IF (total_returned + NEW.Quantity) > order_item_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return quantity cannot exceed order item quantity';
    END IF;
END $

DELIMITER ;

CREATE TABLE supplier_orders (
    SupplierOrderID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierID INT NOT NULL,
    OrderDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ExpectedDeliveryDate TIMESTAMP NULL,
    OrderStatus ENUM('Draft', 'Submitted', 'Confirmed', 'Shipped', 'Received', 'Cancelled') NOT NULL DEFAULT 'Draft',
    TotalAmount DECIMAL(10,2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES suppliers(SupplierID) ON DELETE RESTRICT,
    INDEX idx_supplierorder_status (OrderStatus),
    INDEX idx_supplierorder_supplier (SupplierID),
    INDEX idx_supplierorder_dates (OrderDate, ExpectedDeliveryDate),
    CONSTRAINT chk_supplierorder_amount CHECK (TotalAmount >= 0),
    CONSTRAINT chk_supplier_dates CHECK (
        ExpectedDeliveryDate IS NULL OR 
        ExpectedDeliveryDate > OrderDate
    )
) ENGINE=InnoDB;

CREATE TABLE supplier_order_items (
    SupplierOrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitCost DECIMAL(10,2) NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (SupplierOrderID) REFERENCES supplier_orders(SupplierOrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES products(ProductID) ON DELETE RESTRICT,
    INDEX idx_supplieritem_order (SupplierOrderID),
    INDEX idx_supplieritem_product (ProductID),
    CONSTRAINT chk_supplieritem_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_supplieritem_cost CHECK (
        UnitCost >= 0 AND 
        TotalCost >= 0 AND 
        TotalCost = Quantity * UnitCost
    )
) ENGINE=InnoDB;

CREATE TABLE promotion_application (
    ApplicationID INT AUTO_INCREMENT PRIMARY KEY,
    PromotionID INT NOT NULL,
    OrderID INT NOT NULL,
    DiscountAmount DECIMAL(10,2) NOT NULL,
    IsEligible BOOLEAN DEFAULT TRUE NOT NULL,
    AppliedReason VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (PromotionID) REFERENCES promotions(PromotionID) ON DELETE RESTRICT,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    INDEX idx_promo_app_promotion (PromotionID),
    INDEX idx_promo_app_order (OrderID),
    INDEX idx_promo_app_eligible (IsEligible),
    CONSTRAINT chk_promo_discount CHECK (DiscountAmount >= 0)
) ENGINE=InnoDB;

DELIMITER $

CREATE TRIGGER after_promotion_application_insert
AFTER INSERT ON promotion_application
FOR EACH ROW
BEGIN
    UPDATE promotions
    SET UsageCount = UsageCount + 1
    WHERE PromotionID = NEW.PromotionID;
END $

CREATE TRIGGER after_promotion_application_delete
AFTER DELETE ON promotion_application
FOR EACH ROW
BEGIN
    UPDATE promotions
    SET UsageCount = UsageCount - 1
    WHERE PromotionID = OLD.PromotionID;
END $

DELIMITER ;

CREATE TABLE order_promotions (
    OrderPromotionID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    PromotionID INT NOT NULL,
    DiscountAmount DECIMAL(10,2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (PromotionID) REFERENCES promotions(PromotionID) ON DELETE RESTRICT,
    INDEX idx_orderpromo_order (OrderID),
    INDEX idx_orderpromo_promotion (PromotionID),
    CONSTRAINT chk_orderpromo_discount CHECK (DiscountAmount >= 0)
) ENGINE=InnoDB;

CREATE TABLE gap_cash (
    GapCashID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    GapCashCode VARCHAR(20) NOT NULL UNIQUE,
    GapCashAmount DECIMAL(10,2) NOT NULL,
    EarningOrderID INT NOT NULL,
    RedemptionOrderID INT NULL,
    EarningStartDate TIMESTAMP NOT NULL,
    EarningEndDate TIMESTAMP NOT NULL,
    RedemptionStartDate TIMESTAMP NOT NULL,
    RedemptionEndDate TIMESTAMP NOT NULL,
    IsRedeemed BOOLEAN DEFAULT FALSE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (EarningOrderID) REFERENCES orders(OrderID) ON DELETE RESTRICT,
    FOREIGN KEY (RedemptionOrderID) REFERENCES orders(OrderID) ON DELETE SET NULL,
    INDEX idx_gap_cash_customer (CustomerID),
    INDEX idx_gap_cash_redemption (RedemptionStartDate, RedemptionEndDate),
    INDEX idx_gap_cash_code (GapCashCode),
    INDEX idx_gap_cash_redeemed (IsRedeemed),
    INDEX idx_gap_cash_earning_order (EarningOrderID),
    INDEX idx_gap_cash_redemption_order (RedemptionOrderID),
    CONSTRAINT chk_gap_cash_amount CHECK (GapCashAmount > 0),
    CONSTRAINT chk_gap_cash_dates CHECK (
        EarningEndDate > EarningStartDate AND
        RedemptionEndDate > RedemptionStartDate AND
        RedemptionStartDate >= EarningEndDate
    )
) ENGINE=InnoDB;

DELIMITER $

CREATE TRIGGER before_gap_cash_insert
BEFORE INSERT ON gap_cash
FOR EACH ROW
BEGIN
    IF NEW.IsRedeemed = TRUE AND NEW.RedemptionOrderID IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Redeemed Gap Cash must have a redemption order';
    END IF;
    
    IF NEW.IsRedeemed = FALSE AND NEW.RedemptionOrderID IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unredeemed Gap Cash cannot have a redemption order';
    END IF;
END $

CREATE TRIGGER before_gap_cash_update
BEFORE UPDATE ON gap_cash
FOR EACH ROW
BEGIN
    IF NEW.IsRedeemed = TRUE AND NEW.RedemptionOrderID IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Redeemed Gap Cash must have a redemption order';
    END IF;
    
    IF NEW.IsRedeemed = FALSE AND NEW.RedemptionOrderID IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unredeemed Gap Cash cannot have a redemption order';
    END IF;
END $

DELIMITER ;

CREATE TABLE sales_analytics (
    AnalyticsID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    CustomerID INT NULL,
    OrderTotal DECIMAL(10,2) NOT NULL,
    ShipmentType ENUM('Standard Shipping', 'Express Shipping', 'Store Pickup'),
    OrderDate TIMESTAMP NOT NULL,
    ProductCategories JSON,
    PromotionsApplied JSON,
    PaymentMethod VARCHAR(50),
    IsFirstTimePurchase BOOLEAN DEFAULT FALSE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID) ON DELETE SET NULL,
    INDEX idx_analytics_date (OrderDate),
    INDEX idx_analytics_customer (CustomerID),
    INDEX idx_analytics_shipment (ShipmentType),
    INDEX idx_analytics_first_purchase (IsFirstTimePurchase),
    INDEX idx_analytics_order (OrderID),
    CONSTRAINT chk_analytics_total CHECK (OrderTotal >= 0)
) ENGINE=InnoDB;

CREATE TABLE order_tracking (
    TrackingID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    Status ENUM('Pending', 'Processing', 'Ready for Pickup', 'Picked Up', 'Shipped', 'Delivered', 'Cancelled', 'Returned') NOT NULL,
    StatusTimestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Notes TEXT,
    ShipmentID INT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ShipmentID) REFERENCES shipments(ShipmentID) ON DELETE SET NULL,
    INDEX idx_tracking_order (OrderID),
    INDEX idx_tracking_status (Status),
    INDEX idx_tracking_timestamp (StatusTimestamp),
    INDEX idx_tracking_shipment (ShipmentID)
) ENGINE=InnoDB;

DELIMITER $

CREATE TRIGGER before_tracking_insert
BEFORE INSERT ON order_tracking
FOR EACH ROW
BEGIN
    IF NEW.StatusTimestamp > CURRENT_TIMESTAMP() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Status timestamp cannot be in the future';
    END IF;
END $

DELIMITER ;