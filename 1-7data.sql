-- 01_base_tables.sql
-- Populate base tables for GAP Retail Database

USE gap_retail_db;

-- Disable foreign key checks for batch inserts
SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;

-- Reset auto-increment values
ALTER TABLE categories AUTO_INCREMENT = 1;
ALTER TABLE payment_methods AUTO_INCREMENT = 1;
ALTER TABLE payment_status AUTO_INCREMENT = 1;

-- Populate Categories table
-- First create parent categories
INSERT INTO categories (CategoryName, CategoryDescription, ParentCategoryID, IsActive) VALUES
('Men', 'All men\'s apparel and accessories', NULL, TRUE),
('Women', 'All women\'s apparel and accessories', NULL, TRUE),
('Kids', 'Children\'s clothing and accessories', NULL, TRUE),
('Baby', 'Infant and toddler clothing and accessories', NULL, TRUE),
('Teen', 'Teen fashion collections', NULL, TRUE),
('Home', 'Home decor and essentials', NULL, TRUE),
('Accessories', 'Fashion accessories for all', NULL, TRUE),
('Sale', 'Discounted and clearance items', NULL, TRUE),
('New Arrivals', 'Latest additions to our collections', NULL, TRUE),
('Collections', 'Special and limited edition collections', NULL, TRUE);

-- Now add subcategories with parent references
INSERT INTO categories (CategoryName, CategoryDescription, ParentCategoryID, IsActive) VALUES
-- Men's subcategories
('Men\'s Tops', 'T-shirts, shirts, and sweaters for men', 1, TRUE),
('Men\'s Bottoms', 'Pants, shorts, and jeans for men', 1, TRUE),
('Men\'s Outerwear', 'Jackets, coats, and outerwear for men', 1, TRUE),
('Men\'s Activewear', 'Athletic and workout wear for men', 1, TRUE),
('Men\'s Swimwear', 'Swim trunks and beachwear for men', 1, TRUE),

-- Women's subcategories
('Women\'s Tops', 'T-shirts, blouses, and sweaters for women', 2, TRUE),
('Women\'s Bottoms', 'Pants, shorts, skirts, and jeans for women', 2, TRUE),
('Women\'s Dresses', 'Dresses and jumpsuits for women', 2, TRUE),
('Women\'s Outerwear', 'Jackets, coats, and outerwear for women', 2, TRUE),
('Women\'s Activewear', 'Athletic and workout wear for women', 2, TRUE),
('Women\'s Swimwear', 'Swimsuits and beachwear for women', 2, TRUE),

-- Kids' subcategories
('Boys', 'Clothing for boys', 3, TRUE),
('Girls', 'Clothing for girls', 3, TRUE),
('Kids\' Accessories', 'Accessories for children', 3, TRUE),
('Kids\' Activewear', 'Athletic and workout wear for kids', 3, TRUE),
('Kids\' Outerwear', 'Jackets, coats, and outerwear for kids', 3, TRUE),

-- Baby subcategories
('Baby Boys', 'Clothing for baby boys', 4, TRUE),
('Baby Girls', 'Clothing for baby girls', 4, TRUE),
('Baby Essentials', 'Essential items for babies', 4, TRUE),
('Baby Accessories', 'Accessories for babies', 4, TRUE),

-- Teen subcategories
('Teen Boys', 'Fashion for teen boys', 5, TRUE),
('Teen Girls', 'Fashion for teen girls', 5, TRUE),

-- Home subcategories
('Bedding', 'Bed sheets, pillowcases, and comforters', 6, TRUE),
('Bath', 'Towels, shower curtains, and bath accessories', 6, TRUE),
('Decor', 'Decorative items for the home', 6, TRUE),

-- Accessories subcategories
('Hats', 'Hats for all ages', 7, TRUE),
('Belts', 'Belts for all ages', 7, TRUE),
('Bags', 'Bags and backpacks', 7, TRUE),
('Jewelry', 'Necklaces, bracelets, and earrings', 7, TRUE),
('Scarves', 'Scarves and wraps', 7, TRUE),
('Sunglasses', 'Sunglasses for all ages', 7, TRUE),

-- Collections subcategories
('GAP Logo', 'Classic GAP logo wear', 10, TRUE),
('Vintage', 'Vintage inspired styles', 10, TRUE),
('Holiday', 'Holiday themed apparel and gifts', 10, TRUE),
('Denim', 'Classic and contemporary denim styles', 10, TRUE),
('Organic Cotton', 'Sustainable organic cotton collection', 10, TRUE),
('Recycled', 'Products made from recycled materials', 10, TRUE);

-- Add some third-level categories
INSERT INTO categories (CategoryName, CategoryDescription, ParentCategoryID, IsActive) VALUES
-- Men's Tops subcategories
('Men\'s T-Shirts', 'Short-sleeved t-shirts for men', 11, TRUE),
('Men\'s Shirts', 'Button-down and dress shirts for men', 11, TRUE),
('Men\'s Sweaters', 'Sweaters and pullovers for men', 11, TRUE),
('Men\'s Hoodies', 'Hooded sweatshirts for men', 11, TRUE),

-- Add a few inactive categories for testing
('Discontinued Line', 'Products no longer in production', NULL, FALSE),
('Seasonal Holiday 2023', 'Holiday 2023 special items', 10, FALSE);

-- Populate Payment Methods table
INSERT INTO payment_methods (MethodName, IsActive, ProcessingFee, PaymentGateway) VALUES
('Credit Card', TRUE, 2.90, 'Stripe'),
('Debit Card', TRUE, 1.50, 'Stripe'),
('PayPal', TRUE, 3.20, 'PayPal'),
('Apple Pay', TRUE, 2.00, 'Apple'),
('Google Pay', TRUE, 2.00, 'Google'),
('Samsung Pay', TRUE, 2.00, 'Samsung'),
('Shop Pay', TRUE, 2.50, 'Shopify'),
('Afterpay', TRUE, 4.00, 'Afterpay'),
('Klarna', TRUE, 4.00, 'Klarna'),
('Gift Card', TRUE, 0.00, 'Internal'),
('Store Credit', TRUE, 0.00, 'Internal'),
('Gap Credit Card', TRUE, 0.00, 'Synchrony'),
('Venmo', TRUE, 3.00, 'PayPal'),
('Bank Transfer', TRUE, 1.00, 'Plaid'),
('Cash', TRUE, 0.00, 'In-Store');

-- Populate Payment Status table
INSERT INTO payment_status (StatusName, StatusDescription, IsSystemStatus) VALUES
('Pending', 'Payment is being processed', TRUE),
('Completed', 'Payment has been successfully processed', TRUE),
('Failed', 'Payment processing has failed', TRUE),
('Refunded', 'Payment has been refunded to the customer', TRUE),
('Partially Refunded', 'Payment has been partially refunded to the customer', TRUE),
('Authorized', 'Payment has been authorized but not yet captured', TRUE),
('Voided', 'Payment has been voided before processing', TRUE),
('Declined', 'Payment was declined by the payment processor', TRUE),
('Chargeback', 'Payment has been disputed by the customer', TRUE),
('Chargeback Resolved', 'Chargeback has been resolved', TRUE);

COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- Verify data
SELECT 'Categories', COUNT(*) FROM categories
UNION ALL
SELECT 'Payment Methods', COUNT(*) FROM payment_methods
UNION ALL
SELECT 'Payment Status', COUNT(*) FROM payment_status;
-- 02_locations.sql
-- Populate warehouse and store locations for GAP Retail Database

USE gap_retail_db;

-- Disable foreign key checks for batch inserts
SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;

-- Reset auto-increment values
ALTER TABLE warehouses AUTO_INCREMENT = 1;
ALTER TABLE stores AUTO_INCREMENT = 1;

-- Populate Warehouses table
INSERT INTO warehouses (WarehouseName, WarehouseLocation, WarehouseCapacity, IsActive, ContactPhone, ContactEmail, OperatingHours) VALUES
('Northeast Distribution Center', '100 Distribution Way, Fishkill, NY 12524', 150000, TRUE, '845-555-1000', 'nedc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 8:00-16:00'),
('Mid-Atlantic Fulfillment Center', '200 Logistics Pkwy, Gallatin, TN 37066', 200000, TRUE, '615-555-2000', 'mafc@gap-distribution.com', 'Mon-Sat 6:00-23:00'),
('Southeast Regional Hub', '300 Commerce Dr, Atlanta, GA 30354', 180000, TRUE, '404-555-3000', 'serh@gap-distribution.com', 'Mon-Sun 7:00-23:00'),
('Midwest Distribution Facility', '400 Industrial Ave, Columbus, OH 43219', 175000, TRUE, '614-555-4000', 'mwdf@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Southwest Fulfillment Center', '500 Warehouse Blvd, Fort Worth, TX 76177', 210000, TRUE, '817-555-5000', 'swfc@gap-distribution.com', 'Mon-Sun 24 hours'),
('Northwest Distribution Hub', '600 Shipping Ln, Reno, NV 89502', 160000, TRUE, '775-555-6000', 'nwdh@gap-distribution.com', 'Mon-Sat 6:00-22:00'),
('West Coast Primary Center', '700 Logistics Way, Ontario, CA 91761', 250000, TRUE, '909-555-7000', 'wcpc@gap-distribution.com', 'Mon-Sun 24 hours'),
('Pacific Northwest Facility', '800 Distribution Rd, Sumner, WA 98390', 140000, TRUE, '253-555-8000', 'pnwf@gap-distribution.com', 'Mon-Fri 7:00-23:00, Sat 8:00-16:00'),
('Rocky Mountain Distribution', '900 Supply Chain Dr, Aurora, CO 80011', 130000, TRUE, '303-555-9000', 'rmdc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Central US Fulfillment', '1000 Logistics Park, Groveport, OH 43125', 185000, TRUE, '614-555-1100', 'cusf@gap-distribution.com', 'Mon-Sun 6:00-22:00'),
('East Coast E-Commerce Center', '1100 Fulfillment Way, Florence, NJ 08518', 220000, TRUE, '609-555-1200', 'ecec@gap-distribution.com', 'Mon-Sun 24 hours'),
('Gulf Coast Distribution', '1200 Port Blvd, Houston, TX 77029', 170000, TRUE, '713-555-1300', 'gcdc@gap-distribution.com', 'Mon-Sat 7:00-23:00'),
('Great Lakes Fulfillment', '1300 Inventory Ave, Romeoville, IL 60446', 190000, TRUE, '815-555-1400', 'glfc@gap-distribution.com', 'Mon-Sat 6:00-22:00'),
('Mid-South Distribution', '1400 Logistics Rd, Memphis, TN 38116', 160000, TRUE, '901-555-1500', 'msdc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 8:00-16:00'),
('California South Hub', '1500 Commerce Center, San Bernardino, CA 92408', 230000, TRUE, '909-555-1600', 'cash@gap-distribution.com', 'Mon-Sun 24 hours'),
('Toronto Distribution Center', '1600 Steeles Ave E, Brampton, ON L6T 4L4, Canada', 145000, TRUE, '905-555-1700', 'todc@gap-distribution.ca', 'Mon-Fri 7:00-23:00, Sat 8:00-16:00'),
('Montreal Fulfillment Center', '1700 Rue Sherbrooke, Montreal, QC H1L 1E3, Canada', 125000, TRUE, '514-555-1800', 'mtfc@gap-distribution.ca', 'Mon-Fri 7:00-23:00'),
('Vancouver Regional Warehouse', '1800 Marine Way, Delta, BC V4K 5G6, Canada', 115000, TRUE, '604-555-1900', 'vrwh@gap-distribution.ca', 'Mon-Fri 7:00-22:00, Sat 8:00-15:00'),
('California Central Valley Hub', '1900 Distribution Ln, Tracy, CA 95304', 210000, TRUE, '209-555-2000', 'ccvh@gap-distribution.com', 'Mon-Sun 6:00-22:00'),
('New England Distribution', '2000 Commerce Way, Mansfield, MA 02048', 140000, TRUE, '508-555-2100', 'nedc-ma@gap-distribution.com', 'Mon-Fri 7:00-23:00, Sat 8:00-16:00'),
('Appalachian Regional Center', '2100 Logistics Blvd, Martinsburg, WV 25401', 130000, TRUE, '304-555-2200', 'aprc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Florida Primary Hub', '2200 Distribution Dr, Jacksonville, FL 32218', 175000, TRUE, '904-555-2300', 'flph@gap-distribution.com', 'Mon-Sat 6:00-22:00'),
('Arizona Fulfillment Center', '2300 Logistics Pkwy, Phoenix, AZ 85043', 160000, TRUE, '602-555-2400', 'azfc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Albuquerque Distribution', '2400 Commerce Loop, Albuquerque, NM 87106', 110000, TRUE, '505-555-2500', 'abqd@gap-distribution.com', 'Mon-Fri 7:00-20:00'),
('Las Vegas Facility', '2500 Supply Chain Ave, North Las Vegas, NV 89030', 140000, TRUE, '702-555-2600', 'lvfc@gap-distribution.com', 'Mon-Sat 6:00-22:00'),
('Indianapolis Distribution', '2600 Fulfillment Rd, Indianapolis, IN 46241', 165000, TRUE, '317-555-2700', 'indc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Kansas City Hub', '2700 Logistics Way, Edwardsville, KS 66111', 150000, TRUE, '913-555-2800', 'kchb@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 8:00-16:00'),
('Minneapolis Facility', '2800 Commerce Dr, Rogers, MN 55374', 145000, TRUE, '763-555-2900', 'mnfc@gap-distribution.com', 'Mon-Fri 7:00-23:00, Sat 8:00-16:00'),
('Detroit Area Distribution', '2900 Logistics Pkwy, Romulus, MI 48174', 155000, TRUE, '734-555-3000', 'dtdc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Salt Lake Regional Center', '3000 Distribution Ave, Salt Lake City, UT 84116', 140000, TRUE, '801-555-3100', 'slrc@gap-distribution.com', 'Mon-Fri 7:00-23:00, Sat 8:00-16:00'),
('Portland Distribution', '3100 Logistics Blvd, Portland, OR 97218', 130000, TRUE, '503-555-3200', 'ptld@gap-distribution.com', 'Mon-Fri 7:00-22:00, Sat 8:00-15:00'),
('Sacramento Valley Center', '3200 Supply Chain Dr, West Sacramento, CA 95691', 145000, TRUE, '916-555-3300', 'svdc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Oklahoma City Facility', '3300 Distribution Way, Oklahoma City, OK 73179', 120000, TRUE, '405-555-3400', 'okcd@gap-distribution.com', 'Mon-Fri 7:00-22:00'),
('Louisville Distribution', '3400 Logistics Ave, Shepherdsville, KY 40165', 150000, TRUE, '502-555-3500', 'kydc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Charlotte Regional Hub', '3500 Commerce Park, Charlotte, NC 28273', 165000, TRUE, '704-555-3600', 'chrh@gap-distribution.com', 'Mon-Sat 6:00-22:00'),
('UK Primary Center', '3600 Logistics Way, Milton Keynes MK17 8EF, UK', 120000, TRUE, '+44-1908-555-3700', 'ukpc@gap-distribution.co.uk', 'Mon-Fri 7:00-22:00'),
('European Central Hub', '3700 Distribution Str, Venlo, 5928 Netherlands', 160000, TRUE, '+31-77-555-3800', 'euhub@gap-distribution.eu', 'Mon-Fri 7:00-23:00'),
('Tokyo Distribution', '3800 Logistics Building, Narita, Chiba 286-0021, Japan', 90000, TRUE, '+81-476-555-3900', 'tokyo@gap-distribution.jp', 'Mon-Fri 8:00-22:00'),
('Shanghai Fulfillment Center', '3900 Logistics Park, Pudong, Shanghai 201306, China', 130000, TRUE, '+86-21-555-4000', 'shanghai@gap-distribution.cn', 'Mon-Sat 7:00-23:00'),
('Sydney Distribution', '4000 Commerce Dr, Eastern Creek, NSW 2766, Australia', 100000, TRUE, '+61-2-555-4100', 'sydney@gap-distribution.com.au', 'Mon-Fri 7:00-22:00'),
('Mexico City Hub', '4100 Logistics Ave, Cuautitlán Izcalli, 54740, Mexico', 110000, TRUE, '+52-55-555-4200', 'mexicocity@gap-distribution.mx', 'Mon-Fri 7:00-22:00, Sat 8:00-15:00'),
('South Florida Center', '4200 Distribution Blvd, Miami, FL 33178', 140000, TRUE, '305-555-4300', 'sflc@gap-distribution.com', 'Mon-Sat 7:00-23:00'),
('St. Louis Distribution', '4300 Logistics Way, Edwardsville, IL 62025', 135000, TRUE, '618-555-4400', 'stldc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 7:00-15:00'),
('Baltimore Area Hub', '4400 Distribution Dr, Hagerstown, MD 21740', 150000, TRUE, '301-555-4500', 'bltdc@gap-distribution.com', 'Mon-Fri 6:00-22:00, Sat 8:00-16:00'),
('Iowa Distribution Center', '4500 Commerce Park, Grimes, IA 50111', 125000, TRUE, '515-555-4600', 'iadc@gap-distribution.com', 'Mon-Fri 7:00-22:00'),
('Omaha Facility', '4600 Logistics Rd, Omaha, NE 68137', 120000, TRUE, '402-555-4700', 'nedc-ne@gap-distribution.com', 'Mon-Fri 7:00-22:00'),
('San Juan Center', '4700 Distribution Ave, Carolina, PR 00987', 85000, TRUE, '787-555-4800', 'prdc@gap-distribution.com', 'Mon-Fri 7:00-20:00'),
('Hawaii Distribution', '4800 Logistics Blvd, Honolulu, HI 96819', 70000, TRUE, '808-555-4900', 'hidc@gap-distribution.com', 'Mon-Fri 7:00-20:00'),
('Alaska Facility', '4900 Supply Chain Rd, Anchorage, AK 99518', 60000, TRUE, '907-555-5000', 'akfc@gap-distribution.com', 'Mon-Fri 7:00-19:00');

-- Populate Stores table
INSERT INTO stores (StoreName, Location, StorePhone, StoreEmail, ManagerName, OperatingHours, StoreSize, IsActive, SupportsPickup, RegionID) VALUES
('GAP 5th Avenue Flagship', '680 5th Ave, New York, NY 10019', '212-555-0001', 'gap-5thave@gap.com', 'Emma Rodriguez', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 15000, TRUE, TRUE, 1),
('GAP Times Square', '1466 Broadway, New York, NY 10036', '212-555-0002', 'gap-timessquare@gap.com', 'Michael Chen', 'Mon-Sun 9:00-22:00', 12000, TRUE, TRUE, 1),
('GAP SoHo', '513 Broadway, New York, NY 10012', '212-555-0003', 'gap-soho@gap.com', 'Sarah Johnson', 'Mon-Sat 10:00-20:00, Sun 11:00-19:00', 8500, TRUE, TRUE, 1),
('GAP Beverly Center', '8500 Beverly Blvd, Los Angeles, CA 90048', '323-555-0004', 'gap-beverly@gap.com', 'David Kim', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 9500, TRUE, TRUE, 2),
('GAP Grove', '189 The Grove Dr, Los Angeles, CA 90036', '323-555-0005', 'gap-grove@gap.com', 'Jessica Martinez', 'Mon-Thu 10:00-21:00, Fri-Sat 10:00-22:00, Sun 10:00-20:00', 10000, TRUE, TRUE, 2),
('GAP Santa Monica', '1355 3rd Street Promenade, Santa Monica, CA 90401', '310-555-0006', 'gap-santamonica@gap.com', 'Robert Taylor', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 8000, TRUE, TRUE, 2),
('GAP Michigan Avenue', '555 N Michigan Ave, Chicago, IL 60611', '312-555-0007', 'gap-michigan@gap.com', 'Amanda Wilson', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 11000, TRUE, TRUE, 3),
('GAP State Street', '35 N State St, Chicago, IL 60602', '312-555-0008', 'gap-state@gap.com', 'Brandon Lee', 'Mon-Sat 10:00-20:00, Sun 11:00-18:00', 9000, TRUE, TRUE, 3),
('GAP Market Street', '890 Market St, San Francisco, CA 94102', '415-555-0009', 'gap-market@gap.com', 'Michelle Garcia', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 12500, TRUE, TRUE, 2),
('GAP Union Square', '170 O\'Farrell St, San Francisco, CA 94102', '415-555-0010', 'gap-union@gap.com', 'William Brown', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 14000, TRUE, TRUE, 2),
('GAP Newbury', '140 Newbury St, Boston, MA 02116', '617-555-0011', 'gap-newbury@gap.com', 'Elizabeth White', 'Mon-Sat 10:00-20:00, Sun 11:00-19:00', 8000, TRUE, TRUE, 1),
('GAP Copley Place', '100 Huntington Ave, Boston, MA 02116', '617-555-0012', 'gap-copley@gap.com', 'Thomas Anderson', 'Mon-Sat 10:00-21:00, Sun 12:00-18:00', 7500, TRUE, TRUE, 1),
('GAP Georgetown', '1258 Wisconsin Ave NW, Washington, DC 20007', '202-555-0013', 'gap-georgetown@gap.com', 'Jennifer Davis', 'Mon-Sat 10:00-20:00, Sun 11:00-19:00', 9000, TRUE, TRUE, 1),
('GAP Pentagon City', '1100 S Hayes St, Arlington, VA 22202', '703-555-0014', 'gap-pentagon@gap.com', 'Christopher Wilson', '10:00-21:00, Sun 11:00-18:00', 8500, TRUE, TRUE, 1),
('GAP Lincoln Road', '737 Lincoln Rd, Miami Beach, FL 33139', '305-555-0015', 'gap-lincoln@gap.com', 'Nicole Garcia', 'Mon-Thu 10:00-22:00, Fri-Sat 10:00-23:00, Sun 11:00-20:00', 9000, TRUE, TRUE, 4),
('GAP Aventura Mall', '19501 Biscayne Blvd, Aventura, FL 33180', '305-555-0016', 'gap-aventura@gap.com', 'Andrew Smith', 'Mon-Sat 10:00-21:00, Sun 12:00-20:00', 10000, TRUE, TRUE, 4),
('GAP Lenox Square', '3393 Peachtree Rd NE, Atlanta, GA 30326', '404-555-0017', 'gap-lenox@gap.com', 'Stephanie Johnson', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 9500, TRUE, TRUE, 4),
('GAP Atlantic Station', '264 19th St NW, Atlanta, GA 30363', '404-555-0018', 'gap-atlantic@gap.com', 'James Williams', 'Mon-Thu 10:00-21:00, Fri-Sat 10:00-22:00, Sun 11:00-20:00', 8000, TRUE, TRUE, 4),
('GAP Galleria Dallas', '13350 Dallas Pkwy, Dallas, TX 75240', '214-555-0019', 'gap-galleria@gap.com', 'Ashley Martinez', 'Mon-Sat 10:00-21:00, Sun 12:00-18:00', 9000, TRUE, TRUE, 5),
('GAP NorthPark Center', '8687 N Central Expy, Dallas, TX 75225', '214-555-0020', 'gap-northpark@gap.com', 'Brian Jackson', 'Mon-Sat 10:00-20:00, Sun 12:00-18:00', 10500, TRUE, TRUE, 5),
('GAP Houston Galleria', '5085 Westheimer Rd, Houston, TX 77056', '713-555-0021', 'gap-houstongalleria@gap.com', 'Rachel Thompson', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 11000, TRUE, TRUE, 5),
('GAP Memorial City', '303 Memorial City Way, Houston, TX 77024', '713-555-0022', 'gap-memorial@gap.com', 'Kevin Harris', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 9000, TRUE, TRUE, 5),
('GAP Mall of America', '60 E Broadway, Bloomington, MN 55425', '952-555-0023', 'gap-moa@gap.com', 'Danielle Miller', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 12000, TRUE, TRUE, 3),
('GAP Denver Pavilions', '500 16th St, Denver, CO 80202', '303-555-0024', 'gap-denver@gap.com', 'Jonathan Clark', 'Mon-Sat 10:00-21:00, Sun 11:00-18:00', 8500, TRUE, TRUE, 5),
('GAP Cherry Creek', '3000 E 1st Ave, Denver, CO 80206', '303-555-0025', 'gap-cherry@gap.com', 'Melissa Lewis', 'Mon-Sat 10:00-20:00, Sun 11:00-18:00', 7500, TRUE, TRUE, 5),
('GAP Scottsdale Fashion Square', '7014 E Camelback Rd, Scottsdale, AZ 85251', '480-555-0026', 'gap-scottsdale@gap.com', 'Joshua Walker', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 8000, TRUE, TRUE, 6),
('GAP Ala Moana Center', '1450 Ala Moana Blvd, Honolulu, HI 96814', '808-555-0027', 'gap-alamoana@gap.com', 'Kaitlyn Young', 'Mon-Sat 9:30-21:00, Sun 10:00-19:00', 9000, TRUE, TRUE, 2),
('GAP Bellevue Square', '575 Bellevue Square, Bellevue, WA 98004', '425-555-0028', 'gap-bellevue@gap.com', 'Matthew Allen', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 8000, TRUE, TRUE, 6),
('GAP Westlake Center', '400 Pine St, Seattle, WA 98101', '206-555-0029', 'gap-westlake@gap.com', 'Olivia Scott', 'Mon-Sat 10:00-20:00, Sun 11:00-18:00', 7500, TRUE, TRUE, 6),
('GAP Pioneer Place', '700 SW 5th Ave, Portland, OR 97204', '503-555-0030', 'gap-pioneer@gap.com', 'Daniel Green', 'Mon-Sat 10:00-20:00, Sun 11:00-18:00', 7000, TRUE, TRUE, 6),
('GAP King of Prussia', '160 N Gulph Rd, King of Prussia, PA 19406', '610-555-0031', 'gap-kop@gap.com', 'Samantha Baker', 'Mon-Sat 10:00-21:00, Sun 11:00-18:00', 11000, TRUE, TRUE, 1),
('GAP Walnut Street', '1504 Walnut St, Philadelphia, PA 19102', '215-555-0032', 'gap-walnut@gap.com', 'Eric Nelson', 'Mon-Sat 10:00-20:00, Sun 11:00-18:00', 6500, TRUE, TRUE, 1),
('GAP Easton Town Center', '4030 The Strand E, Columbus, OH 43219', '614-555-0033', 'gap-easton@gap.com', 'Andrea Hill', 'Mon-Sat 10:00-21:00, Sun 12:00-18:00', 8500, TRUE, TRUE, 3),
('GAP Las Vegas Strip', '3200 Las Vegas Blvd S, Las Vegas, NV 89109', '702-555-0034', 'gap-strip@gap.com', 'Steven Carter', 'Sun-Thu 10:00-23:00, Fri-Sat 10:00-00:00', 13000, TRUE, TRUE, 6),
('GAP Fashion Show', '3200 Las Vegas Blvd S, Las Vegas, NV 89109', '702-555-0035', 'gap-fashionshow@gap.com', 'Laura Evans', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 10000, TRUE, TRUE, 6),
('GAP Eaton Centre', '220 Yonge St, Toronto, ON M5B 2H1, Canada', '416-555-0036', 'gap-eaton@gap.com', 'Ryan Morgan', 'Mon-Fri 10:00-21:30, Sat 9:30-21:00, Sun 10:00-19:00', 11500, TRUE, TRUE, 7),
('GAP Yorkdale', '3401 Dufferin St, Toronto, ON M6A 2T9, Canada', '416-555-0037', 'gap-yorkdale@gap.com', 'Natalie Parker', 'Mon-Fri 10:00-21:00, Sat 9:30-21:00, Sun 11:00-19:00', 9500, TRUE, TRUE, 7),
('GAP Robson Street', '1125 Robson St, Vancouver, BC V6E 1B5, Canada', '604-555-0038', 'gap-robson@gap.com', 'Jason Wright', 'Mon-Sat 10:00-21:00, Sun 11:00-19:00', 8000, TRUE, TRUE, 7),
('GAP Pacific Centre', '701 W Georgia St, Vancouver, BC V7Y 1G5, Canada', '604-555-0039', 'gap-pacific@gap.com', 'Megan Ross', 'Mon-Wed 10:00-19:00, Thu-Fri 10:00-21:00, Sat 10:00-19:00, Sun 11:00-18:00', 7500, TRUE, TRUE, 7),
('GAP Regent Street', '258-260, Regent St, London W1B 3AF, UK', '+44-20-555-0040', 'gap-regent@gap.com', 'Victoria Turner', 'Mon-Sat 10:00-20:00, Sun 12:00-18:00', 12000, TRUE, TRUE, 8),
('GAP Oxford Street', '376-384 Oxford St, London W1C 1JY, UK', '+44-20-555-0041', 'gap-oxford@gap.com', 'Alexander Hughes', 'Mon-Sat 9:00-21:00, Sun 11:30-18:00', 15000, TRUE, TRUE, 8),
('GAP Champs-Élysées', '36 Avenue des Champs-Élysées, 75008 Paris, France', '+33-1-555-0042', 'gap-champs@gap.com', 'Sophie Martin', 'Mon-Sat 10:00-20:00, Sun 11:00-19:00', 13000, TRUE, TRUE, 8),
('GAP Ginza', '4 Chome-3-2 Ginza, Chuo City, Tokyo 104-0061, Japan', '+81-3-555-0043', 'gap-ginza@gap.com', 'Takashi Tanaka', 'Mon-Sun 10:00-21:00', 11000, TRUE, TRUE, 9),
('GAP Shibuya', 'Shibuya Scramble Square, Tokyo, Japan', '+81-3-555-0044', 'gap-shibuya@gap.com', 'Yuki Nakamura', 'Mon-Sun 10:00-21:00', 9500, TRUE, TRUE, 9),
('GAP Hong Kong Central', 'IFC Mall, 8 Finance St, Central, Hong Kong', '+852-555-0045', 'gap-hongkong@gap.com', 'Wei Chen', 'Mon-Sun 10:00-22:00', 10000, TRUE, TRUE, 9),
('GAP Sydney CBD', 'Pitt Street Mall, Sydney NSW 2000, Australia', '+61-2-555-0046', 'gap-sydney@gap.com', 'Chloe Wilson', 'Mon-Wed 9:00-19:00, Thu 9:00-21:00, Fri-Sat 9:00-19:00, Sun 10:00-19:00', 8000, TRUE, TRUE, 10),
('GAP Mall of Dubai', 'The Dubai Mall, Dubai, United Arab Emirates', '+971-4-555-0047', 'gap-dubai@gap.com', 'Hassan Ahmed', 'Sat-Wed 10:00-22:00, Thu-Fri 10:00-00:00', 14000, TRUE, TRUE, 11),
('GAP Polanco', 'Av. Presidente Masaryk 407, Polanco, Mexico City, Mexico', '+52-55-555-0048', 'gap-polanco@gap.com', 'Carlos Rodriguez', 'Mon-Sat 11:00-21:00, Sun 11:00-19:00', 7500, TRUE, TRUE, 12),
('GAP Antara Fashion Hall', 'Av. Ejército Nacional 843, Granada, Mexico City, Mexico', '+52-55-555-0049', 'gap-antara@gap.com', 'Isabella Lopez', 'Mon-Sun 11:00-21:00', 8000, TRUE, TRUE, 12),
('GAP São Paulo', 'Shopping Iguatemi, Av. Brigadeiro Faria Lima, São Paulo, Brazil', '+55-11-555-0050', 'gap-saopaulo@gap.com', 'Mateo Silva', 'Mon-Sat 10:00-22:00, Sun 14:00-20:00', 9000, TRUE, TRUE, 13);

COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- Verify data
SELECT 'Warehouses', COUNT(*) FROM warehouses
UNION ALL
SELECT 'Stores', COUNT(*) FROM stores;

-- 03_suppliers_and_customers.sql
-- Populate supplier and customer data for GAP Retail Database

USE gap_retail_db;

-- Disable foreign key checks for batch inserts
SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;

-- Reset auto-increment values
ALTER TABLE suppliers AUTO_INCREMENT = 1;
ALTER TABLE customers AUTO_INCREMENT = 1;
ALTER TABLE addresses AUTO_INCREMENT = 1;
ALTER TABLE loyalty_accounts AUTO_INCREMENT = 1;

-- Populate Suppliers table
INSERT INTO suppliers (SupplierName, ContactName, ContactEmail, ContactPhone, Address, TaxID, PaymentTerms, LeadTimeDays, MinimumOrderQuantity, PreferredCurrency, IsActive, SupplierRating) VALUES
('Organic Cotton Collective', 'Maria Gonzalez', 'maria@ocollective.com', '415-555-2000', '123 Sustainable Way, San Francisco, CA 94110', 'OCC-123456', 'Net 30', 14, 500, 'USD', TRUE, 4.8),
('Denim Innovations Inc.', 'James Wilson', 'james@deniminnov.com', '213-555-2001', '456 Fashion Blvd, Los Angeles, CA 90012', 'DII-789123', 'Net 45', 21, 1000, 'USD', TRUE, 4.5),
('EcoFabrics Global', 'Sophia Chen', 'sophia@ecofabrics.com', '604-555-2002', '789 Green Street, Vancouver, BC V6B 2M1, Canada', 'EFG-456789', 'Net 30', 10, 250, 'CAD', TRUE, 4.7),
('Premium Textiles Ltd.', 'Richard Thompson', 'richard@premiumtex.com', '212-555-2003', '101 Luxury Lane, New York, NY 10001', 'PTL-234567', 'Net 30', 7, 300, 'USD', TRUE, 4.3),
('Fast Fashion Supply Co.', 'Jennifer Lopez', 'jennifer@fastfashionsupply.com', '305-555-2004', '202 Quick Delivery Dr, Miami, FL 33101', 'FFS-345678', 'Net 15', 5, 1000, 'USD', TRUE, 3.9),
('Sustainable Buttons & Trims', 'Michael Green', 'michael@sustainablebt.com', '503-555-2005', '303 Eco Way, Portland, OR 97201', 'SBT-456789', 'Net 30', 14, 100, 'USD', TRUE, 4.6),
('Global Textile Group', 'Sarah Johnson', 'sarah@globaltextile.com', '+44-20-555-2006', '404 International Blvd, London EC1A 1BB, UK', 'GTG-567890', 'Net 60', 28, 2000, 'GBP', TRUE, 4.2),
('Pacific Rim Fabrics', 'David Kim', 'david@pacificrimfabrics.com', '+852-555-2007', '505 Harbor Road, Hong Kong', 'PRF-678901', 'Net 45', 21, 1500, 'HKD', TRUE, 4.0),
('American Cotton Growers', 'Emily Davis', 'emily@americancotton.com', '901-555-2008', '606 Cotton Field Ln, Memphis, TN 38101', 'ACG-789012', 'Net 30', 14, 1000, 'USD', TRUE, 4.4),
('European Textile Imports', 'Hans Mueller', 'hans@eurotextile.com', '+49-30-555-2009', '707 Fashion Strasse, Berlin 10115, Germany', 'ETI-890123', 'Net 45', 30, 1000, 'EUR', TRUE, 4.1),
('Silk Road Suppliers', 'Li Wei', 'liwei@silkroadsuppliers.com', '+86-10-555-2010', '808 Ancient Trade St, Beijing 100000, China', 'SRS-901234', 'Net 60', 35, 2000, 'CNY', TRUE, 3.8),
('Modern Synthetics Inc.', 'Robert Johnson', 'robert@modernsynthetics.com', '770-555-2011', '909 Innovation Pkwy, Atlanta, GA 30301', 'MSI-012345', 'Net 30', 10, 500, 'USD', TRUE, 4.2),
('Quality Zippers & Fasteners', 'Nancy Parker', 'nancy@qualityzippers.com', '312-555-2012', '111 Component Ave, Chicago, IL 60601', 'QZF-123456', 'Net 15', 7, 200, 'USD', TRUE, 4.5),
('Southeast Asian Textiles', 'Arun Patel', 'arun@southeastasiantex.com', '+66-2-555-2013', '222 Market Road, Bangkok 10200, Thailand', 'SAT-234567', 'Net 45', 25, 1000, 'THB', TRUE, 3.9),
('Organic Wool Collective', 'Emma Watson', 'emma@organicwool.com', '+64-4-555-2014', '333 Pasture Lane, Wellington 6011, New Zealand', 'OWC-345678', 'Net 30', 30, 300, 'NZD', TRUE, 4.7),
('Premium Leather Works', 'Carlos Rodriguez', 'carlos@premiumleather.com', '+34-91-555-2015', '444 Tannery Street, Madrid 28001, Spain', 'PLW-456789', 'Net 45', 21, 100, 'EUR', TRUE, 4.6),
('Fast Buttons Inc.', 'Grace Lee', 'grace@fastbuttons.com', '212-555-2016', '555 Garment District, New York, NY 10018', 'FBI-567890', 'Net 15', 5, 1000, 'USD', TRUE, 4.0),
('Eco Packaging Solutions', 'Daniel Smith', 'daniel@ecopackaging.com', '206-555-2017', '666 Green Box Way, Seattle, WA 98101', 'EPS-678901', 'Net 30', 10, 500, 'USD', TRUE, 4.3),
('Indian Cotton Exports', 'Priya Sharma', 'priya@indiancotton.com', '+91-22-555-2018', '777 Mumbai Textile Park, Mumbai 400001, India', 'ICE-789012', 'Net 60', 28, 2000, 'INR', TRUE, 3.8),
('Brazilian Sustainable Fabrics', 'Mateo Santos', 'mateo@brazilianfabrics.com', '+55-11-555-2019', '888 Eco Avenue, São Paulo 01000-000, Brazil', 'BSF-890123', 'Net 45', 35, 1000, 'BRL', TRUE, 4.1),
('North American Thread Co.', 'Jessica Brown', 'jessica@nathread.com', '416-555-2020', '999 Spool Street, Toronto, ON M5V 2H1, Canada', 'NAT-901234', 'Net 30', 14, 500, 'CAD', TRUE, 4.4),
('Japanese Precision Textiles', 'Kenji Tanaka', 'kenji@jprecisiontex.com', '+81-3-555-2021', '123 Meticulous St, Tokyo 100-0001, Japan', 'JPT-012345', 'Net 30', 21, 500, 'JPY', TRUE, 4.9),
('Mediterranean Dye Works', 'Elena Rossi', 'elena@meddyeworks.com', '+39-06-555-2022', '234 Colorful Blvd, Rome 00100, Italy', 'MDW-123456', 'Net 45', 21, 300, 'EUR', TRUE, 4.2),
('Green Energy Textiles', 'Thomas Green', 'thomas@greenenergytex.com', '512-555-2023', '345 Solar Panel Road, Austin, TX 78701', 'GET-234567', 'Net 30', 14, 1000, 'USD', TRUE, 4.5),
('African Cotton Cooperative', 'Amara Diallo', 'amara@africancotton.com', '+20-2-555-2024', '456 Nile Way, Cairo, Egypt', 'ACC-345678', 'Net 60', 30, 1500, 'USD', TRUE, 3.7),
('Australian Wool Suppliers', 'Olivia Nelson', 'olivia@aussiewool.com', '+61-2-555-2025', '567 Merino Road, Sydney NSW 2000, Australia', 'AWS-456789', 'Net 45', 35, 500, 'AUD', TRUE, 4.3),
('Scandinavian Design Textiles', 'Lars Andersen', 'lars@scandtex.com', '+45-33-555-2026', '678 Minimal Street, Copenhagen 1050, Denmark', 'SDT-567890', 'Net 30', 21, 300, 'DKK', TRUE, 4.8),
('Mexican Artisan Fabrics', 'Isabella Martinez', 'isabella@mexicanartisanfabrics.com', '+52-55-555-2027', '789 Craft Blvd, Mexico City 06000, Mexico', 'MAF-678901', 'Net 45', 28, 500, 'MXN', TRUE, 4.0),
('Ethical Labor Textiles', 'William Chang', 'william@ethicallabor.com', '415-555-2028', '890 Fair Trade Way, San Francisco, CA 94105', 'ELT-789012', 'Net 30', 14, 1000, 'USD', TRUE, 4.7),
('Tech Fabric Innovations', 'Alicia Roberts', 'alicia@techfabric.com', '650-555-2029', '901 Smart Material Dr, Palo Alto, CA 94301', 'TFI-890123', 'Net 30', 10, 200, 'USD', TRUE, 4.5);

-- Generate hashed passwords (using SHA-256 for demo purposes - in production use stronger hashing algorithms)
SET @password_hash = SHA2('demo_password', 256);

-- Populate Customers table
INSERT INTO customers (FirstName, LastName, Email, Phone, PasswordHash, DateJoined, DateOfBirth, Gender, PreferredLanguage, MarketingPreferences, StoredPaymentMethods, LastLoginDate, IsActive, IsFirstTimeBuyer) VALUES
('John', 'Smith', 'john.smith@example.com', '212-555-1001', @password_hash, '2020-01-15', '1985-06-12', 'Male', 'en', '{"email":true,"sms":false,"mail":true}', NULL, '2023-05-10 14:30:00', TRUE, FALSE),
('Emma', 'Johnson', 'emma.johnson@example.com', '415-555-1002', @password_hash, '2020-02-20', '1990-08-24', 'Female', 'en', '{"email":true,"sms":true,"mail":false}', '{"cards":[{"last4":"1234","type":"visa","expire":"2025-04"}]}', '2023-05-11 09:15:00', TRUE, FALSE),
('Michael', 'Davis', 'michael.davis@example.com', '312-555-1003', @password_hash, '2020-03-10', '1978-11-30', 'Male', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"5678","type":"mastercard","expire":"2024-09"}]}', '2023-05-12 17:45:00', TRUE, FALSE),
('Sophia', 'Wilson', 'sophia.wilson@example.com', '305-555-1004', @password_hash, '2020-04-05', '1995-03-18', 'Female', 'en', '{"email":true,"sms":false,"mail":false}', NULL, '2023-05-09 10:30:00', TRUE, FALSE),
('James', 'Taylor', 'james.taylor@example.com', '617-555-1005', @password_hash, '2020-05-22', '1982-09-07', 'Male', 'en', '{"email":true,"sms":true,"mail":false}', NULL, '2023-05-08 16:20:00', TRUE, FALSE),
('Olivia', 'Thomas', 'olivia.thomas@example.com', '213-555-1006', @password_hash, '2020-06-18', '1989-12-15', 'Female', 'en', '{"email":false,"sms":true,"mail":true}', '{"cards":[{"last4":"9012","type":"amex","expire":"2026-01"}]}', '2023-05-11 12:45:00', TRUE, FALSE),
('Ethan', 'Brown', 'ethan.brown@example.com', '312-555-1007', @password_hash, '2020-07-30', '1992-05-28', 'Male', 'en', '{"email":true,"sms":false,"mail":false}', NULL, '2023-05-10 08:30:00', TRUE, FALSE),
('Isabella', 'Martinez', 'isabella.martinez@example.com', '214-555-1008', @password_hash, '2020-08-14', '1987-07-11', 'Female', 'es', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"3456","type":"visa","expire":"2025-11"}]}', '2023-05-09 19:15:00', TRUE, FALSE),
('Alexander', 'Garcia', 'alexander.garcia@example.com', '408-555-1009', @password_hash, '2020-09-05', '1980-02-23', 'Male', 'en', '{"email":true,"sms":true,"mail":false}', NULL, '2023-05-11 11:30:00', TRUE, FALSE),
('Mia', 'Lopez', 'mia.lopez@example.com', '305-555-1010', @password_hash, '2020-10-12', '1993-10-09', 'Female', 'es', '{"email":true,"sms":false,"mail":true}', '{"cards":[{"last4":"7890","type":"mastercard","expire":"2024-12"}]}', '2023-05-10 20:45:00', TRUE, FALSE),
('Benjamin', 'Lee', 'benjamin.lee@example.com', '917-555-1011', @password_hash, '2020-11-08', '1984-04-17', 'Male', 'en', '{"email":false,"sms":false,"mail":true}', NULL, '2023-05-09 15:30:00', TRUE, FALSE),
('Charlotte', 'Walker', 'charlotte.walker@example.com', '415-555-1012', @password_hash, '2020-12-19', '1991-08-06', 'Female', 'en', '{"email":true,"sms":true,"mail":false}', '{"cards":[{"last4":"1357","type":"discover","expire":"2025-07"}]}', '2023-05-08 14:15:00', TRUE, FALSE),
('Daniel', 'Hall', 'daniel.hall@example.com', '404-555-1013', @password_hash, '2021-01-24', '1979-11-22', 'Male', 'en', '{"email":true,"sms":false,"mail":false}', NULL, '2023-05-11 18:00:00', TRUE, FALSE),
('Amelia', 'Allen', 'amelia.allen@example.com', '713-555-1014', @password_hash, '2021-02-07', '1994-06-13', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"2468","type":"visa","expire":"2026-03"}]}', '2023-05-10 10:45:00', TRUE, FALSE),
('Henry', 'Young', 'henry.young@example.com', '215-555-1015', @password_hash, '2021-03-11', '1986-09-30', 'Male', 'en', '{"email":false,"sms":true,"mail":false}', NULL, '2023-05-09 13:30:00', TRUE, FALSE),
('Victoria', 'Hernandez', 'victoria.hernandez@example.com', '310-555-1016', @password_hash, '2021-04-03', '1996-01-25', 'Female', 'es', '{"email":true,"sms":false,"mail":true}', '{"cards":[{"last4":"3690","type":"amex","expire":"2025-09"}]}', '2023-05-11 16:15:00', TRUE, FALSE),
('Joseph', 'King', 'joseph.king@example.com', '312-555-1017', @password_hash, '2021-05-15', '1983-05-08', 'Male', 'en', '{"email":true,"sms":true,"mail":false}', NULL, '2023-05-12 09:00:00', TRUE, FALSE),
('Elizabeth', 'Wright', 'elizabeth.wright@example.com', '617-555-1018', @password_hash, '2021-06-22', '1990-12-19', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"4812","type":"mastercard","expire":"2024-11"}]}', '2023-05-10 13:45:00', TRUE, FALSE),
('Samuel', 'Lopez', 'samuel.lopez@example.com', '415-555-1019', @password_hash, '2021-07-09', '1981-07-14', 'Male', 'es', '{"email":false,"sms":false,"mail":true}', NULL, '2023-05-09 17:30:00', TRUE, FALSE),
('Sofia', 'Scott', 'sofia.scott@example.com', '305-555-1020', @password_hash, '2021-08-17', '1997-04-02', 'Female', 'en', '{"email":true,"sms":true,"mail":false}', '{"cards":[{"last4":"5913","type":"visa","expire":"2026-05"}]}', '2023-05-12 15:15:00', TRUE, FALSE),
('David', 'Green', 'david.green@example.com', '214-555-1021', @password_hash, '2021-09-25', '1984-11-16', 'Male', 'en', '{"email":true,"sms":false,"mail":false}', NULL, '2023-05-12 12:00:00', TRUE, FALSE),
('Audrey', 'Adams', 'audrey.adams@example.com', '213-555-1022', @password_hash, '2021-10-13', '1993-08-05', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"6024","type":"discover","expire":"2025-12"}]}', '2023-05-11 14:45:00', TRUE, FALSE),
('Christopher', 'Baker', 'christopher.baker@example.com', '212-555-1023', @password_hash, '2021-11-08', '1980-01-29', 'Male', 'en', '{"email":false,"sms":true,"mail":false}', NULL, '2023-05-09 09:30:00', TRUE, FALSE),
('Zoe', 'Carter', 'zoe.carter@example.com', '404-555-1024', @password_hash, '2021-12-17', '1995-06-24', 'Female', 'en', '{"email":true,"sms":false,"mail":true}', '{"cards":[{"last4":"7135","type":"visa","expire":"2026-08"}]}', '2023-05-12 11:15:00', TRUE, FALSE),
('Ryan', 'Perez', 'ryan.perez@example.com', '408-555-1025', @password_hash, '2022-01-21', '1986-12-31', 'Male', 'es', '{"email":true,"sms":true,"mail":false}', NULL, '2023-05-10 18:00:00', TRUE, FALSE),
('Natalie', 'Roberts', 'natalie.roberts@example.com', '917-555-1026', @password_hash, '2022-02-09', '1991-04-17', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"8246","type":"mastercard","expire":"2025-06"}]}', '2023-05-09 12:45:00', TRUE, FALSE),
('Luke', 'Phillips', 'luke.phillips@example.com', '312-555-1027', @password_hash, '2022-03-14', '1982-09-22', 'Male', 'en', '{"email":false,"sms":false,"mail":true}', NULL, '2023-05-12 16:30:00', TRUE, TRUE),
('Grace', 'Evans', 'grace.evans@example.com', '415-555-1028', @password_hash, '2022-04-28', '1994-11-09', 'Female', 'en', '{"email":true,"sms":true,"mail":false}', '{"cards":[{"last4":"9357","type":"amex","expire":"2026-02"}]}', '2023-05-11 10:15:00', TRUE, TRUE),
('Owen', 'Turner', 'owen.turner@example.com', '214-555-1029', @password_hash, '2022-05-16', '1989-03-26', 'Male', 'en', '{"email":true,"sms":false,"mail":false}', NULL, '2023-05-10 14:00:00', TRUE, TRUE),
('Lily', 'Torres', 'lily.torres@example.com', '305-555-1030', @password_hash, '2022-06-07', '1996-07-13', 'Female', 'es', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"0468","type":"visa","expire":"2025-10"}]}', '2023-05-09 19:45:00', TRUE, TRUE),
('Nathan', 'Campbell', 'nathan.campbell@example.com', '713-555-1031', @password_hash, '2022-07-19', '1983-10-05', 'Male', 'en', '{"email":false,"sms":true,"mail":false}', NULL, '2023-05-12 13:30:00', TRUE, TRUE),
('Hannah', 'Mitchell', 'hannah.mitchell@example.com', '213-555-1032', @password_hash, '2022-08-22', '1992-02-28', 'Female', 'en', '{"email":true,"sms":false,"mail":true}', '{"cards":[{"last4":"1579","type":"mastercard","expire":"2026-04"}]}', '2023-05-10 09:15:00', TRUE, TRUE),
('Caleb', 'Roberts', 'caleb.roberts@example.com', '617-555-1033', @password_hash, '2022-09-09', '1981-06-17', 'Male', 'en', '{"email":true,"sms":true,"mail":false}', NULL, '2023-05-11 17:00:00', TRUE, TRUE),
('Chloe', 'Sanchez', 'chloe.sanchez@example.com', '404-555-1034', @password_hash, '2022-10-15', '1997-09-03', 'Female', 'es', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"2680","type":"discover","expire":"2025-03"}]}', '2023-05-12 10:45:00', TRUE, TRUE),
('Eli', 'Rivera', 'eli.rivera@example.com', '212-555-1035', @password_hash, '2022-11-30', '1984-12-21', 'Male', 'es', '{"email":false,"sms":false,"mail":true}', NULL, '2023-05-10 19:30:00', TRUE, TRUE),
('Leah', 'Cooper', 'leah.cooper@example.com', '312-555-1036', @password_hash, '2022-12-12', '1993-04-07', 'Female', 'en', '{"email":true,"sms":true,"mail":false}', '{"cards":[{"last4":"3791","type":"visa","expire":"2026-07"}]}', '2023-05-09 14:15:00', TRUE, TRUE),
('Connor', 'Reed', 'connor.reed@example.com', '415-555-1037', @password_hash, '2023-01-08', '1987-08-19', 'Male', 'en', '{"email":true,"sms":false,"mail":false}', NULL, '2023-05-12 17:00:00', TRUE, TRUE),
('Stella', 'Bailey', 'stella.bailey@example.com', '214-555-1038', @password_hash, '2023-02-14', '1990-01-13', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"4802","type":"amex","expire":"2025-08"}]}', '2023-05-11 13:45:00', TRUE, TRUE),
('Miles', 'Kelly', 'miles.kelly@example.com', '305-555-1039', @password_hash, '2023-03-22', '1985-05-26', 'Male', 'en', '{"email":false,"sms":true,"mail":false}', NULL, '2023-05-10 08:30:00', TRUE, TRUE),
('Ruby', 'Howard', 'ruby.howard@example.com', '917-555-1040', @password_hash, '2023-04-09', '1998-08-11', 'Female', 'en', '{"email":true,"sms":false,"mail":true}', '{"cards":[{"last4":"5913","type":"mastercard","expire":"2026-11"}]}', '2023-05-09 16:15:00', TRUE, TRUE),
('Jonah', 'Cox', 'jonah.cox@example.com', '213-555-1041', @password_hash, '2023-05-01', '1988-11-29', 'Male', 'en', '{"email":true,"sms":true,"mail":false}', NULL, '2023-05-12 15:00:00', TRUE, TRUE),
('Sierra', 'Ward', 'sierra.ward@example.com', '617-555-1042', @password_hash, '2023-05-17', '1994-03-15', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"6024","type":"visa","expire":"2025-05"}]}', '2023-05-12 09:45:00', TRUE, TRUE),
('Xavier', 'Brooks', 'xavier.brooks@example.com', '408-555-1043', @password_hash, '2023-05-30', '1986-06-04', 'Male', 'en', '{"email":false,"sms":false,"mail":true}', NULL, '2023-05-11 18:30:00', TRUE, TRUE),
('Autumn', 'Gray', 'autumn.gray@example.com', '312-555-1044', @password_hash, '2023-06-15', '1991-10-23', 'Female', 'en', '{"email":true,"sms":true,"mail":false}', '{"cards":[{"last4":"7135","type":"discover","expire":"2026-06"}]}', '2023-05-10 11:15:00', TRUE, TRUE),
('Tyler', 'James', 'tyler.james@example.com', '713-555-1045', @password_hash, '2023-06-29', '1983-02-08', 'Male', 'en', '{"email":true,"sms":false,"mail":false}', NULL, '2023-05-09 15:00:00', TRUE, TRUE),
('Paisley', 'Bennett', 'paisley.bennett@example.com', '214-555-1046', @password_hash, '2023-07-14', '1995-05-31', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"8246","type":"mastercard","expire":"2025-01"}]}', '2023-05-12 13:45:00', TRUE, TRUE),
('Elias', 'Reyes', 'elias.reyes@example.com', '305-555-1047', @password_hash, '2023-07-31', '1989-09-17', 'Male', 'es', '{"email":false,"sms":true,"mail":false}', NULL, '2023-05-10 17:30:00', TRUE, TRUE),
('Willow', 'Fisher', 'willow.fisher@example.com', '212-555-1048', @password_hash, '2023-08-22', '1996-12-04', 'Female', 'en', '{"email":true,"sms":false,"mail":true}', '{"cards":[{"last4":"9357","type":"visa","expire":"2026-09"}]}', '2023-05-11 15:15:00', TRUE, TRUE),
('Asher', 'Watson', 'asher.watson@example.com', '404-555-1049', @password_hash, '2023-09-05', '1984-04-11', 'Male', 'en', '{"email":true,"sms":true,"mail":false}', NULL, '2023-05-12 12:00:00', TRUE, TRUE),
('Scarlett', 'Russell', 'scarlett.russell@example.com', '415-555-1050', @password_hash, '2023-09-19', '1990-07-29', 'Female', 'en', '{"email":true,"sms":true,"mail":true}', '{"cards":[{"last4":"0468","type":"amex","expire":"2025-02"}]}', '2023-05-10 14:45:00', TRUE, TRUE);

-- Populate Addresses table
INSERT INTO addresses (CustomerID, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Country, IsDefaultShipping, IsDefaultBilling, AddressType, IsVerified, IsActive, VerificationDate, VerificationMethod) VALUES
-- John Smith addresses
(1, '123 Main St', 'Apt 4B', 'New York', 'NY', '10001', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-01-15 14:30:00', 'Address Verification Service'),
(1, '456 Work Plaza', 'Suite 200', 'New York', 'NY', '10018', 'USA', FALSE, FALSE, 'BUSINESS', TRUE, TRUE, '2020-01-15 14:35:00', 'Address Verification Service'),

-- Emma Johnson addresses
(2, '789 Oak Drive', NULL, 'San Francisco', 'CA', '94107', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-02-20 10:15:00', 'Address Verification Service'),

-- Michael Davis addresses
(3, '101 Pine Avenue', 'Unit 3C', 'Chicago', 'IL', '60611', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-03-10 09:45:00', 'Address Verification Service'),
(3, '202 Office Park', 'Building 5', 'Chicago', 'IL', '60607', 'USA', FALSE, FALSE, 'BUSINESS', TRUE, TRUE, '2020-03-12 11:20:00', 'Address Verification Service'),

-- Sophia Wilson addresses
(4, '303 Beach Boulevard', NULL, 'Miami', 'FL', '33139', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-04-05 15:30:00', 'Address Verification Service'),

-- James Taylor addresses
(5, '404 Beacon Street', 'Apt 7D', 'Boston', 'MA', '02116', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-05-22 16:45:00', 'Address Verification Service'),

-- Olivia Thomas addresses
(6, '505 Sunset Boulevard', NULL, 'Los Angeles', 'CA', '90069', 'USA', TRUE, FALSE, 'HOME', TRUE, TRUE, '2020-06-18 13:20:00', 'Address Verification Service'),
(6, '606 Billing Lane', 'Suite 12', 'Los Angeles', 'CA', '90025', 'USA', FALSE, TRUE, 'BILLING', TRUE, TRUE, '2020-06-19 14:10:00', 'Address Verification Service'),

-- Ethan Brown addresses
(7, '707 Lakeview Drive', 'Apt 12B', 'Chicago', 'IL', '60614', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-07-30 11:55:00', 'Address Verification Service'),

-- Isabella Martinez addresses
(8, '808 Meadow Lane', NULL, 'Dallas', 'TX', '75201', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-08-14 10:30:00', 'Address Verification Service'),

-- Alexander Garcia addresses
(9, '909 Technology Drive', 'Suite 500', 'San Jose', 'CA', '95110', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2020-09-05 09:15:00', 'Address Verification Service'),

-- Mia Lopez addresses
(10, '1010 Ocean Drive', 'Apt 25F', 'Miami', 'FL', '33139', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-10-12 14:40:00', 'Address Verification Service'),

-- Benjamin Lee addresses
(11, '1111 Park Avenue', 'Apt 15C', 'New York', 'NY', '10028', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-11-08 12:25:00', 'Address Verification Service'),

-- Charlotte Walker addresses
(12, '1212 Golden Gate Ave', NULL, 'San Francisco', 'CA', '94115', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2020-12-19 15:50:00', 'Address Verification Service'),

-- Daniel Hall addresses
(13, '1313 Peachtree Street', 'Suite 100', 'Atlanta', 'GA', '30309', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2021-01-24 11:10:00', 'Address Verification Service'),

-- Amelia Allen addresses
(14, '1414 Westheimer Road', 'Apt 220', 'Houston', 'TX', '77006', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-02-07 13:45:00', 'Address Verification Service'),

-- Henry Young addresses
(15, '1515 Market Street', NULL, 'Philadelphia', 'PA', '19102', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-03-11 10:20:00', 'Address Verification Service'),

-- Victoria Hernandez addresses
(16, '1616 Wilshire Blvd', 'Apt 30B', 'Los Angeles', 'CA', '90024', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-04-03 16:15:00', 'Address Verification Service'),

-- Joseph King addresses
(17, '1717 Michigan Avenue', NULL, 'Chicago', 'IL', '60611', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-05-15 14:30:00', 'Address Verification Service'),

-- Elizabeth Wright addresses
(18, '1818 Commonwealth Ave', 'Apt 5A', 'Boston', 'MA', '02135', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-06-22 09:45:00', 'Address Verification Service'),

-- Samuel Lopez addresses
(19, '1919 Divisadero Street', NULL, 'San Francisco', 'CA', '94115', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-07-09 11:30:00', 'Address Verification Service'),

-- Sofia Scott addresses
(20, '2020 Collins Avenue', 'Apt 1800', 'Miami Beach', 'FL', '33139', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-08-17 15:20:00', 'Address Verification Service'),

-- Additional addresses for next 30 customers (21-50)
(21, '2121 McKinney Avenue', 'Suite 300', 'Dallas', 'TX', '75201', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2021-09-25 13:15:00', 'Address Verification Service'),
(22, '2222 Melrose Avenue', NULL, 'Los Angeles', 'CA', '90046', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-10-13 14:50:00', 'Address Verification Service'),
(23, '2323 Broadway', 'Apt 17D', 'New York', 'NY', '10024', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2021-11-08 16:30:00', 'Address Verification Service'),
(24, '2424 Peachtree Road', 'Suite 400', 'Atlanta', 'GA', '30305', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2021-12-17 11:45:00', 'Address Verification Service'),
(25, '2525 Santana Row', NULL, 'San Jose', 'CA', '95128', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-01-21 10:10:00', 'Address Verification Service'),
(26, '2626 Fifth Avenue', 'Apt 12B', 'New York', 'NY', '10065', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-02-09 09:30:00', 'Address Verification Service'),
(27, '2727 Canal Street', NULL, 'Chicago', 'IL', '60604', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-03-14 14:25:00', 'Address Verification Service'),
(28, '2828 Union Street', NULL, 'San Francisco', 'CA', '94123', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-04-28 16:40:00', 'Address Verification Service'),
(29, '2929 Lower Greenville', 'Apt 3', 'Dallas', 'TX', '75206', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-05-16 13:05:00', 'Address Verification Service'),
(30, '3030 Brickell Avenue', 'Apt 2500', 'Miami', 'FL', '33129', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-06-07 11:20:00', 'Address Verification Service'),
(31, '3131 Kirby Drive', 'Suite 200', 'Houston', 'TX', '77098', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2022-07-19 15:35:00', 'Address Verification Service'),
(32, '3232 Sunset Boulevard', NULL, 'Los Angeles', 'CA', '90026', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-08-22 14:15:00', 'Address Verification Service'),
(33, '3333 Newbury Street', NULL, 'Boston', 'MA', '02115', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-09-09 10:50:00', 'Address Verification Service'),
(34, '3434 Piedmont Road', 'Suite 150', 'Atlanta', 'GA', '30305', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2022-10-15 13:30:00', 'Address Verification Service'),
(35, '3535 Madison Avenue', 'Apt 20C', 'New York', 'NY', '10022', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-11-30 16:20:00', 'Address Verification Service'),
(36, '3636 Michigan Avenue', 'Apt 1500', 'Chicago', 'IL', '60604', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2022-12-12 15:15:00', 'Address Verification Service'),
(37, '3737 California Street', NULL, 'San Francisco', 'CA', '94118', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-01-08 11:45:00', 'Address Verification Service'),
(38, '3838 Knox Street', 'Suite 100', 'Dallas', 'TX', '75205', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2023-02-14 14:10:00', 'Address Verification Service'),
(39, '3939 Coconut Grove', NULL, 'Miami', 'FL', '33133', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-03-22 09:55:00', 'Address Verification Service'),
(40, '4040 Park Avenue', 'Apt 55B', 'New York', 'NY', '10022', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-04-09 16:40:00', 'Address Verification Service'),
(41, '4141 Venice Boulevard', NULL, 'Los Angeles', 'CA', '90019', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-05-01 13:25:00', 'Address Verification Service'),
(42, '4242 Boylston Street', 'Apt 7D', 'Boston', 'MA', '02116', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-05-17 15:50:00', 'Address Verification Service'),
(43, '4343 Stevens Creek Blvd', 'Suite 300', 'San Jose', 'CA', '95129', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2023-05-30 14:30:00', 'Address Verification Service'),
(44, '4444 Wabash Avenue', NULL, 'Chicago', 'IL', '60605', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-06-15 11:15:00', 'Address Verification Service'),
(45, '4545 Richmond Avenue', 'Suite 200', 'Houston', 'TX', '77027', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2023-06-29 10:05:00', 'Address Verification Service'),
(46, '4646 Mockingbird Lane', 'Apt 210', 'Dallas', 'TX', '75205', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-07-14 16:35:00', 'Address Verification Service'),
(47, '4747 Espanola Way', NULL, 'Miami Beach', 'FL', '33139', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-07-31 14:20:00', 'Address Verification Service'),
(48, '4848 Columbus Avenue', 'Apt 3F', 'New York', 'NY', '10025', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-08-22 13:10:00', 'Address Verification Service'),
(49, '4949 Roswell Road', 'Suite 100', 'Atlanta', 'GA', '30342', 'USA', TRUE, TRUE, 'BUSINESS', TRUE, TRUE, '2023-09-05 15:45:00', 'Address Verification Service'),
(50, '5050 Van Ness Avenue', NULL, 'San Francisco', 'CA', '94109', 'USA', TRUE, TRUE, 'HOME', TRUE, TRUE, '2023-09-19 10:30:00', 'Address Verification Service');

-- Add some additional addresses for variety
INSERT INTO addresses (CustomerID, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Country, IsDefaultShipping, IsDefaultBilling, AddressType, IsVerified, IsActive, VerificationDate, VerificationMethod) VALUES
-- International addresses
(5, '10 Regent Street', 'Flat 15', 'London', 'England', 'SW1Y 4LR', 'UK', FALSE, FALSE, 'HOME', TRUE, TRUE, '2020-06-10 09:30:00', 'International Address Verification'),
(12, '25 Rue du Faubourg', 'Apt 8', 'Paris', 'Île-de-France', '75008', 'France', FALSE, FALSE, 'HOME', TRUE, TRUE, '2021-01-15 10:45:00', 'International Address Verification'),
(18, '30 Queen Street', 'Suite 500', 'Toronto', 'Ontario', 'M5H 3R3', 'Canada', FALSE, FALSE, 'BUSINESS', TRUE, TRUE, '2021-07-20 14:15:00', 'International Address Verification'),
(24, '15 Orchard Road', '#08-01', 'Singapore', '', '238826', 'Singapore', FALSE, FALSE, 'HOME', TRUE, TRUE, '2022-02-18 16:30:00', 'International Address Verification'),
(30, '42 Bondi Road', 'Unit 7', 'Sydney', 'NSW', '2026', 'Australia', FALSE, FALSE, 'HOME', TRUE, TRUE, '2022-08-05 11:20:00', 'International Address Verification'),

-- Some non-verified addresses
(35, '555 Unverified Street', 'Apt 101', 'Detroit', 'MI', '48201', 'USA', FALSE, FALSE, 'HOME', FALSE, TRUE, NULL, NULL),
(40, '777 Pending Way', NULL, 'Phoenix', 'AZ', '85001', 'USA', FALSE, FALSE, 'HOME', FALSE, TRUE, NULL, NULL),
(45, '999 Review Lane', 'Suite 30', 'Portland', 'OR', '97201', 'USA', FALSE, FALSE, 'BUSINESS', FALSE, TRUE, NULL, NULL);

-- Populate Loyalty Accounts table (one for each customer)
INSERT INTO loyalty_accounts (CustomerID, PointsBalance, TierLevel, TierStartDate, TierEndDate, LifetimePoints) VALUES
-- Longer-term customers with higher points and tiers
(1, 5200, 'Icon', '2023-01-01', '2023-12-31', 12500),
(2, 4800, 'Icon', '2023-01-01', '2023-12-31', 11200),
(3, 6500, 'Icon', '2023-01-01', '2023-12-31', 15000),
(4, 3200, 'Enthusiast', '2023-01-01', '2023-12-31', 7800),
(5, 4100, 'Enthusiast', '2023-01-01', '2023-12-31', 9600),
(6, 5600, 'Icon', '2023-01-01', '2023-12-31', 13200),
(7, 2800, 'Enthusiast', '2023-01-01', '2023-12-31', 6500),
(8, 3700, 'Enthusiast', '2023-01-01', '2023-12-31', 8900),
(9, 2500, 'Enthusiast', '2023-01-01', '2023-12-31', 5800),
(10, 4300, 'Enthusiast', '2023-01-01', '2023-12-31', 9100),
(11, 1800, 'Core', '2023-01-01', '2023-12-31', 4200),
(12, 2200, 'Enthusiast', '2023-01-01', '2023-12-31', 5500),
(13, 1500, 'Core', '2023-01-01', '2023-12-31', 3800),
(14, 2900, 'Enthusiast', '2023-01-01', '2023-12-31', 6300),
(15, 1300, 'Core', '2023-01-01', '2023-12-31', 3100),
(16, 3400, 'Enthusiast', '2023-01-01', '2023-12-31', 7200),
(17, 1100, 'Core', '2023-01-01', '2023-12-31', 2700),
(18, 2700, 'Enthusiast', '2023-01-01', '2023-12-31', 5900),
(19, 900, 'Core', '2023-01-01', '2023-12-31', 2200),
(20, 3100, 'Enthusiast', '2023-01-01', '2023-12-31', 6800),
-- Newer customers with lower points, mostly Core tier
(21, 800, 'Core', '2023-01-01', '2023-12-31', 1800),
(22, 1200, 'Core', '2023-01-01', '2023-12-31', 2600),
(23, 600, 'Core', '2023-01-01', '2023-12-31', 1400),
(24, 1500, 'Core', '2023-01-01', '2023-12-31', 3200),
(25, 700, 'Core', '2023-01-01', '2023-12-31', 1600),
(26, 1800, 'Core', '2023-01-01', '2023-12-31', 3800),
(27, 500, 'Core', '2023-01-01', '2023-12-31', 1200),
(28, 1100, 'Core', '2023-01-01', '2023-12-31', 2500),
(29, 400, 'Core', '2023-01-01', '2023-12-31', 900),
(30, 1300, 'Core', '2023-01-01', '2023-12-31', 2800),
-- Very new customers with minimal points
(31, 300, 'Core', '2023-01-01', '2023-12-31', 700),
(32, 600, 'Core', '2023-01-01', '2023-12-31', 1300),
(33, 200, 'Core', '2023-01-01', '2023-12-31', 450),
(34, 400, 'Core', '2023-01-01', '2023-12-31', 900),
(35, 150, 'Core', '2023-01-01', '2023-12-31', 350),
(36, 350, 'Core', '2023-01-01', '2023-12-31', 800),
(37, 100, 'Core', '2023-01-01', '2023-12-31', 250),
(38, 300, 'Core', '2023-01-01', '2023-12-31', 650),
(39, 75, 'Core', '2023-01-01', '2023-12-31', 150),
(40, 250, 'Core', '2023-01-01', '2023-12-31', 500),
-- Newest customers with minimal/no points
(41, 50, 'Core', '2023-01-01', '2023-12-31', 100),
(42, 120, 'Core', '2023-01-01', '2023-12-31', 250),
(43, 30, 'Core', '2023-01-01', '2023-12-31', 80),
(44, 90, 'Core', '2023-01-01', '2023-12-31', 200),
(45, 20, 'Core', '2023-01-01', '2023-12-31', 50),
(46, 60, 'Core', '2023-01-01', '2023-12-31', 150),
(47, 10, 'Core', '2023-01-01', '2023-12-31', 40),
(48, 40, 'Core', '2023-01-01', '2023-12-31', 120),
(49, 5, 'Core', '2023-01-01', '2023-12-31', 30),
(50, 25, 'Core', '2023-01-01', '2023-12-31', 100);

COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- Verify data
SELECT 'Suppliers', COUNT(*) FROM suppliers
UNION ALL
SELECT 'Customers', COUNT(*) FROM customers
UNION ALL
SELECT 'Addresses', COUNT(*) FROM addresses
UNION ALL
SELECT 'Loyalty Accounts', COUNT(*) FROM loyalty_accounts;

-- 04_products_main.sql
-- Populate products and product categories for GAP Retail Database

USE gap_retail_db;

-- Disable foreign key checks for batch inserts
SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;

-- Reset auto-increment values
ALTER TABLE products AUTO_INCREMENT = 1;
ALTER TABLE product_categories AUTO_INCREMENT = 1;

-- Populate Products table
INSERT INTO products (ProductName, ProductDescription, Brand, CategoryID, SupplierID, ProductLifecycleStatus, MSRP, StandardCost, Weight, Dimensions, SeasonYear, SeasonName) VALUES
('Classic Logo T-Shirt', 'Soft cotton t-shirt with iconic GAP logo on the chest', 'GAP', 11, 1, 'Active', 24.95, 8.50, 0.3, '12x8x1 in', 2023, 'Spring'),
('Vintage Wash Jeans', 'Relaxed fit jeans with authentic vintage wash and distressing', 'GAP', 12, 2, 'Active', 69.95, 22.50, 0.8, '16x12x2 in', 2023, 'Spring'),
('Lightweight Puffer Jacket', 'Water-resistant lightweight puffer jacket with PrimaLoft® insulation', 'GAP', 13, 3, 'Active', 89.95, 32.00, 1.2, '20x15x4 in', 2023, 'Winter'),
('Performance Stretch Shorts', 'Quick-dry performance shorts with 4-way stretch for maximum comfort', 'GAP', 12, 1, 'Active', 39.95, 12.00, 0.4, '14x10x1 in', 2023, 'Summer'),
('Organic Cotton Hoodie', 'Cozy hoodie made from 100% organic cotton with front pouch pocket', 'GAP', 11, 5, 'Active', 59.95, 18.50, 0.9, '18x13x2 in', 2023, 'Fall'),
('Slim Fit Chinos', 'Modern slim fit chinos with stretch for comfort and mobility', 'GAP', 12, 4, 'Active', 49.95, 15.00, 0.6, '16x12x1 in', 2023, 'Spring'),
('Recycled Polyester Fleece', 'Eco-friendly fleece made from recycled polyester with zip front', 'GAP', 13, 6, 'Active', 64.95, 21.00, 0.7, '18x14x3 in', 2023, 'Winter'),
('Classic Oxford Shirt', 'Timeless button-down oxford shirt in premium cotton', 'GAP', 11, 7, 'Active', 54.95, 16.50, 0.4, '14x10x1 in', 2023, 'Spring'),
('Straight Leg Khakis', 'Versatile straight-leg khakis perfect for work or weekend', 'GAP', 12, 9, 'Active', 44.95, 14.00, 0.6, '16x12x1 in', 2023, 'Fall'),
('Quilted Vest', 'Lightweight quilted vest offering warmth without bulk', 'GAP', 13, 8, 'Active', 49.95, 17.50, 0.6, '18x14x2 in', 2023, 'Fall'),
('Ribbed Tank Top', 'Stretchy ribbed tank top with modern slim fit', 'GAP', 11, 1, 'Active', 19.95, 6.50, 0.2, '12x8x0.5 in', 2023, 'Summer'),
('Slim Fit Jeans', 'Modern slim fit jeans with slight stretch for comfort', 'GAP', 12, 2, 'Active', 59.95, 19.50, 0.7, '16x12x2 in', 2023, 'Spring'),
('Windbreaker Jacket', 'Lightweight water-resistant windbreaker with packable design', 'GAP', 13, 10, 'Active', 79.95, 26.00, 0.6, '18x14x2 in', 2023, 'Spring'),
('Athletic Fit Joggers', 'Performance joggers with tapered fit and moisture-wicking fabric', 'GAP', 14, 12, 'Active', 54.95, 18.00, 0.5, '16x12x1 in', 2023, 'Fall'),
('Essential V-Neck Tee', 'Soft cotton blend v-neck tee with superior comfort', 'GAP', 11, 1, 'Active', 22.95, 7.50, 0.3, '12x8x1 in', 2023, 'Summer'),

('Relaxed Fit Cargo Pants', 'Durable cargo pants with relaxed fit and multiple pockets', 'GAP', 12, 13, 'Active', 64.95, 22.00, 0.7, '16x12x2 in', 2023, 'Fall'),
('Wool Blend Peacoat', 'Classic peacoat made from warm wool blend with satin lining', 'GAP', 13, 14, 'Active', 149.95, 58.00, 1.8, '24x18x4 in', 2023, 'Winter'),
('Long Sleeve Henley', 'Comfortable henley with three-button placket and soft jersey knit', 'GAP', 11, 11, 'Active', 34.95, 11.50, 0.4, '14x10x1 in', 2023, 'Fall'),
('Slim Fit Dress Pants', 'Refined dress pants with modern slim fit and stretch comfort', 'GAP', 12, 9, 'Active', 69.95, 24.00, 0.6, '16x12x1 in', 2023, 'Spring'),
('Denim Trucker Jacket', 'Iconic denim trucker jacket with authentic wash and details', 'GAP', 13, 2, 'Active', 79.95, 28.00, 0.9, '20x15x2 in', 2023, 'Fall'),

('Floral Print Blouse', 'Lightweight blouse with vibrant floral print and flutter sleeves', 'GAP', 16, 15, 'Active', 49.95, 16.50, 0.3, '14x10x1 in', 2023, 'Spring'),
('High Rise Skinny Jeans', 'Flattering high-rise skinny jeans with shaping technology', 'GAP', 17, 2, 'Active', 69.95, 24.00, 0.7, '16x12x2 in', 2023, 'Spring'),
('Puff Sleeve Midi Dress', 'Feminine midi dress with trendy puff sleeves and flowy silhouette', 'GAP', 18, 16, 'Active', 79.95, 28.00, 0.5, '16x12x1 in', 2023, 'Summer'),
('Oversized Denim Jacket', 'Trendy oversized denim jacket with distressed details', 'GAP', 19, 2, 'Active', 74.95, 26.00, 0.8, '20x15x2 in', 2023, 'Spring'),
('High Impact Sports Bra', 'Supportive sports bra designed for high-impact activities', 'GAP', 20, 12, 'Active', 44.95, 15.00, 0.2, '12x8x1 in', 2023, 'Summer'),

('Wide Leg Linen Pants', 'Breezy wide-leg pants made from 100% linen for summer comfort', 'GAP', 17, 3, 'Active', 59.95, 19.50, 0.4, '16x12x1 in', 2023, 'Summer'),
('Cropped Cardigan', 'Versatile cropped cardigan with button front in soft knit fabric', 'GAP', 16, 11, 'Active', 44.95, 15.00, 0.5, '14x10x1 in', 2023, 'Spring'),
('Wrap Midi Skirt', 'Elegant wrap midi skirt with adjustable tie waist', 'GAP', 17, 16, 'Active', 54.95, 18.00, 0.4, '14x10x1 in', 2023, 'Summer'),
('Quilted Puffer Vest', 'Lightweight quilted puffer vest with stand collar', 'GAP', 19, 8, 'Active', 59.95, 20.00, 0.5, '18x14x2 in', 2023, 'Fall'),
('Seamless Leggings', 'Performance leggings with seamless construction for maximum comfort', 'GAP', 20, 12, 'Active', 64.95, 21.00, 0.3, '14x10x1 in', 2023, 'Spring'),

('Kids Graphic T-Shirt', 'Fun graphic tee made from soft cotton for all-day comfort', 'GAP Kids', 23, 1, 'Active', 19.95, 6.50, 0.2, '10x8x0.5 in', 2023, 'Summer'),
('Girls Denim Overalls', 'Adorable denim overalls with adjustable straps and multiple pockets', 'GAP Kids', 24, 2, 'Active', 39.95, 14.00, 0.4, '12x10x1 in', 2023, 'Spring'),
('Boys Cargo Shorts', 'Durable cargo shorts with elastic waist and multiple pockets', 'GAP Kids', 23, 13, 'Active', 29.95, 10.50, 0.3, '10x8x1 in', 2023, 'Summer'),
('Kids Hooded Sweatshirt', 'Cozy hooded sweatshirt with front kangaroo pocket', 'GAP Kids', 23, 5, 'Active', 34.95, 12.00, 0.4, '12x10x1 in', 2023, 'Fall'),
('Girls Tulle Skirt', 'Playful tulle skirt with elastic waistband and glitter details', 'GAP Kids', 24, 16, 'Active', 29.95, 10.00, 0.2, '10x8x1 in', 2023, 'Spring'),

('Baby Organic Onesie Set', 'Soft organic cotton onesie set, perfect for baby\'s sensitive skin', 'GAP Baby', 28, 1, 'Active', 24.95, 8.00, 0.2, '8x6x1 in', 2023, 'Spring'),
('Baby Pull-On Pants', 'Comfortable pull-on pants with elastic waistband for easy dressing', 'GAP Baby', 28, 5, 'Active', 19.95, 7.00, 0.2, '8x6x1 in', 2023, 'Fall'),
('Baby Knit Hat', 'Cozy knit hat to keep baby warm in colder weather', 'GAP Baby', 30, 11, 'Active', 14.95, 5.00, 0.1, '6x4x1 in', 2023, 'Winter'),
('Baby Fleece Vest', 'Soft fleece vest for layering and added warmth', 'GAP Baby', 28, 6, 'Active', 24.95, 8.50, 0.2, '10x8x1 in', 2023, 'Fall'),
('Baby Sock Set', 'Adorable set of 3 pairs of baby socks in fun patterns', 'GAP Baby', 30, 27, 'Active', 12.95, 4.00, 0.1, '4x3x1 in', 2023, 'Spring'),

('Soft Jersey Bedding Set', 'Ultra-soft jersey cotton bedding set in contemporary designs', 'GAP Home', 33, 29, 'Active', 99.95, 35.00, 2.0, '24x18x6 in', 2023, 'Spring'),
('Organic Cotton Bath Towels', 'Plush bath towels made from 100% organic cotton, set of 2', 'GAP Home', 34, 1, 'Active', 49.95, 18.00, 1.5, '20x14x4 in', 2023, 'Spring'),
('Decorative Throw Pillows', 'Stylish throw pillows to accent any living space, set of 2', 'GAP Home', 35, 29, 'Active', 39.95, 14.00, 1.0, '18x18x5 in', 2023, 'Fall'),
('Recycled Cotton Throw Blanket', 'Cozy throw blanket made from recycled cotton in classic patterns', 'GAP Home', 35, 6, 'Active', 69.95, 24.00, 1.2, '20x14x3 in', 2023, 'Winter'),
('Organic Bath Mat', 'Soft and absorbent bath mat made from organic cotton', 'GAP Home', 34, 1, 'Active', 29.95, 10.50, 0.8, '18x12x2 in', 2023, 'Spring'),

('Structured Baseball Cap', 'Classic 6-panel structured baseball cap with embroidered logo', 'GAP', 36, 18, 'Active', 24.95, 8.50, 0.2, '10x8x4 in', 2023, 'Summer'),
('Leather Belt', 'Premium leather belt with classic buckle in versatile brown', 'GAP', 37, 16, 'Active', 39.95, 14.00, 0.3, '10x4x1 in', 2023, 'Spring'),
('Canvas Tote Bag', 'Durable canvas tote bag with internal pockets and reinforced handles', 'GAP', 38, 21, 'Active', 34.95, 12.00, 0.5, '18x14x4 in', 2023, 'Summer'),
('Statement Necklace', 'Bold statement necklace with mixed materials and adjustable length', 'GAP', 39, 25, 'Active', 29.95, 10.50, 0.2, '8x6x2 in', 2023, 'Spring'),
('Wool Blend Scarf', 'Soft wool blend scarf in versatile solid colors', 'GAP', 40, 14, 'Active', 34.95, 12.00, 0.3, '12x8x1 in', 2023, 'Winter'),

('Classic Logo Sweatshirt', 'Iconic GAP logo sweatshirt in heavyweight cotton blend', 'GAP', 41, 5, 'Active', 54.95, 18.50, 0.8, '16x12x2 in', 2023, 'Fall'),
('Vintage Straight Jeans', 'Vintage-inspired straight leg jeans with authentic detailing', 'GAP', 44, 2, 'Seasonal', 69.95, 24.00, 0.7, '16x12x2 in', 2023, 'Fall'),
('Holiday Flannel Pajama Set', 'Festive flannel pajama set for cozy holiday lounging', 'GAP', 43, 11, 'Seasonal', 59.95, 20.00, 0.6, '14x10x2 in', 2023, 'Winter'),
('Organic Cotton Henley', 'Sustainable henley made from 100% organic cotton', 'GAP', 45, 1, 'Active', 39.95, 13.50, 0.4, '14x10x1 in', 2023, 'Spring'),
('Recycled Polyester Puffer', 'Eco-friendly puffer jacket made from recycled materials', 'GAP', 46, 6, 'Active', 99.95, 35.00, 1.0, '20x15x3 in', 2023, 'Winter');

-- Populate Product Categories table
-- Primary categories for each product
INSERT INTO product_categories (ProductID, CategoryID, IsPrimary) VALUES
-- Men's products primary categories
(1, 11, TRUE),   -- Classic Logo T-Shirt - Men's Tops
(2, 12, TRUE),   -- Vintage Wash Jeans - Men's Bottoms
(3, 13, TRUE),   -- Lightweight Puffer Jacket - Men's Outerwear
(4, 12, TRUE),   -- Performance Stretch Shorts - Men's Bottoms
(5, 11, TRUE),   -- Organic Cotton Hoodie - Men's Tops
(6, 12, TRUE),   -- Slim Fit Chinos - Men's Bottoms
(7, 13, TRUE),   -- Recycled Polyester Fleece - Men's Outerwear
(8, 11, TRUE),   -- Classic Oxford Shirt - Men's Tops
(9, 12, TRUE),   -- Straight Leg Khakis - Men's Bottoms
(10, 13, TRUE),  -- Quilted Vest - Men's Outerwear
(11, 11, TRUE),  -- Ribbed Tank Top - Men's Tops
(12, 12, TRUE),  -- Slim Fit Jeans - Men's Bottoms
(13, 13, TRUE),  -- Windbreaker Jacket - Men's Outerwear
(14, 14, TRUE),  -- Athletic Fit Joggers - Men's Activewear
(15, 11, TRUE),  -- Essential V-Neck Tee - Men's Tops
(16, 12, TRUE),  -- Relaxed Fit Cargo Pants - Men's Bottoms
(17, 13, TRUE),  -- Wool Blend Peacoat - Men's Outerwear
(18, 11, TRUE),  -- Long Sleeve Henley - Men's Tops
(19, 12, TRUE),  -- Slim Fit Dress Pants - Men's Bottoms
(20, 13, TRUE),  -- Denim Trucker Jacket - Men's Outerwear

-- Women's products primary categories
(21, 16, TRUE),  -- Floral Print Blouse - Women's Tops
(22, 17, TRUE),  -- High Rise Skinny Jeans - Women's Bottoms
(23, 18, TRUE),  -- Puff Sleeve Midi Dress - Women's Dresses
(24, 19, TRUE),  -- Oversized Denim Jacket - Women's Outerwear
(25, 20, TRUE),  -- High Impact Sports Bra - Women's Activewear
(26, 17, TRUE),  -- Wide Leg Linen Pants - Women's Bottoms
(27, 16, TRUE),  -- Cropped Cardigan - Women's Tops
(28, 17, TRUE),  -- Wrap Midi Skirt - Women's Bottoms
(29, 19, TRUE),  -- Quilted Puffer Vest - Women's Outerwear
(30, 20, TRUE),  -- Seamless Leggings - Women's Activewear

-- Kids products primary categories
(31, 23, TRUE),  -- Kids Graphic T-Shirt - Boys
(32, 24, TRUE),  -- Girls Denim Overalls - Girls
(33, 23, TRUE),  -- Boys Cargo Shorts - Boys
(34, 23, TRUE),  -- Kids Hooded Sweatshirt - Boys (could be unisex)
(35, 24, TRUE),  -- Girls Tulle Skirt - Girls

-- Baby products primary categories
(36, 28, TRUE),  -- Baby Organic Onesie Set - Baby Essentials
(37, 28, TRUE),  -- Baby Pull-On Pants - Baby Essentials
(38, 30, TRUE),  -- Baby Knit Hat - Baby Accessories
(39, 28, TRUE),  -- Baby Fleece Vest - Baby Essentials
(40, 30, TRUE),  -- Baby Sock Set - Baby Accessories

-- Home products primary categories
(41, 33, TRUE),  -- Soft Jersey Bedding Set - Bedding
(42, 34, TRUE),  -- Organic Cotton Bath Towels - Bath
(43, 35, TRUE),  -- Decorative Throw Pillows - Decor
(44, 35, TRUE),  -- Recycled Cotton Throw Blanket - Decor
(45, 34, TRUE),  -- Organic Bath Mat - Bath

-- Accessories primary categories
(46, 36, TRUE),  -- Structured Baseball Cap - Hats
(47, 37, TRUE),  -- Leather Belt - Belts
(48, 38, TRUE),  -- Canvas Tote Bag - Bags
(49, 39, TRUE),  -- Statement Necklace - Jewelry
(50, 40, TRUE),  -- Wool Blend Scarf - Scarves

-- Secondary categories for products (for cross-referencing)
-- Men's products secondary categories
(1, 1, FALSE),   -- Classic Logo T-Shirt - Men
(1, 41, FALSE),  -- Classic Logo T-Shirt - GAP Logo
(2, 1, FALSE),   -- Vintage Wash Jeans - Men
(2, 44, FALSE),  -- Vintage Wash Jeans - Denim
(3, 1, FALSE),   -- Lightweight Puffer Jacket - Men
(4, 1, FALSE),   -- Performance Stretch Shorts - Men
(4, 14, FALSE),  -- Performance Stretch Shorts - Men's Activewear
(5, 1, FALSE),   -- Organic Cotton Hoodie - Men
(5, 45, FALSE),  -- Organic Cotton Hoodie - Organic Cotton
(6, 1, FALSE),   -- Slim Fit Chinos - Men
(7, 1, FALSE),   -- Recycled Polyester Fleece - Men
(7, 46, FALSE),  -- Recycled Polyester Fleece - Recycled
(8, 1, FALSE),   -- Classic Oxford Shirt - Men
(9, 1, FALSE),   -- Straight Leg Khakis - Men
(10, 1, FALSE),  -- Quilted Vest - Men
(11, 1, FALSE),  -- Ribbed Tank Top - Men
(12, 1, FALSE),  -- Slim Fit Jeans - Men
(12, 44, FALSE), -- Slim Fit Jeans - Denim
(13, 1, FALSE),  -- Windbreaker Jacket - Men
(14, 1, FALSE),  -- Athletic Fit Joggers - Men
(15, 1, FALSE),  -- Essential V-Neck Tee - Men
(16, 1, FALSE),  -- Relaxed Fit Cargo Pants - Men
(17, 1, FALSE),  -- Wool Blend Peacoat - Men
(18, 1, FALSE),  -- Long Sleeve Henley - Men
(19, 1, FALSE),  -- Slim Fit Dress Pants - Men
(20, 1, FALSE),  -- Denim Trucker Jacket - Men
(20, 44, FALSE), -- Denim Trucker Jacket - Denim

-- Women's products secondary categories
(21, 2, FALSE),  -- Floral Print Blouse - Women
(22, 2, FALSE),  -- High Rise Skinny Jeans - Women
(22, 44, FALSE), -- High Rise Skinny Jeans - Denim
(23, 2, FALSE),  -- Puff Sleeve Midi Dress - Women
(24, 2, FALSE),  -- Oversized Denim Jacket - Women
(24, 44, FALSE), -- Oversized Denim Jacket - Denim
(25, 2, FALSE),  -- High Impact Sports Bra - Women
(26, 2, FALSE),  -- Wide Leg Linen Pants - Women
(27, 2, FALSE),  -- Cropped Cardigan - Women
(28, 2, FALSE),  -- Wrap Midi Skirt - Women
(29, 2, FALSE),  -- Quilted Puffer Vest - Women
(30, 2, FALSE),  -- Seamless Leggings - Women

-- Kids products secondary categories
(31, 3, FALSE),  -- Kids Graphic T-Shirt - Kids
(31, 41, FALSE), -- Kids Graphic T-Shirt - GAP Logo
(32, 3, FALSE),  -- Girls Denim Overalls - Kids
(32, 44, FALSE), -- Girls Denim Overalls - Denim
(33, 3, FALSE),  -- Boys Cargo Shorts - Kids
(34, 3, FALSE),  -- Kids Hooded Sweatshirt - Kids
(35, 3, FALSE),  -- Girls Tulle Skirt - Kids

-- Baby products secondary categories
(36, 4, FALSE),  -- Baby Organic Onesie Set - Baby
(36, 45, FALSE), -- Baby Organic Onesie Set - Organic Cotton
(37, 4, FALSE),  -- Baby Pull-On Pants - Baby
(38, 4, FALSE),  -- Baby Knit Hat - Baby
(39, 4, FALSE),  -- Baby Fleece Vest - Baby
(40, 4, FALSE),  -- Baby Sock Set - Baby

-- Home products secondary categories
(41, 6, FALSE),  -- Soft Jersey Bedding Set - Home
(42, 6, FALSE),  -- Organic Cotton Bath Towels - Home
(42, 45, FALSE), -- Organic Cotton Bath Towels - Organic Cotton
(43, 6, FALSE),  -- Decorative Throw Pillows - Home
(44, 6, FALSE),  -- Recycled Cotton Throw Blanket - Home
(44, 46, FALSE), -- Recycled Cotton Throw Blanket - Recycled
(45, 6, FALSE),  -- Organic Bath Mat - Home
(45, 45, FALSE), -- Organic Bath Mat - Organic Cotton

-- Accessories secondary categories
(46, 7, FALSE),  -- Structured Baseball Cap - Accessories
(46, 41, FALSE), -- Structured Baseball Cap - GAP Logo
(47, 7, FALSE),  -- Leather Belt - Accessories
(48, 7, FALSE),  -- Canvas Tote Bag - Accessories
(49, 7, FALSE),  -- Statement Necklace - Accessories
(50, 7, FALSE),  -- Wool Blend Scarf - Accessories

-- Seasonal category assignments
(17, 8, FALSE),  -- Wool Blend Peacoat - Sale
(20, 9, FALSE),  -- Denim Trucker Jacket - New Arrivals
(23, 9, FALSE),  -- Puff Sleeve Midi Dress - New Arrivals
(31, 8, FALSE),  -- Kids Graphic T-Shirt - Sale
(36, 9, FALSE),  -- Baby Organic Onesie Set - New Arrivals
(43, 43, FALSE); -- Decorative Throw Pillows - Holiday

COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- Verify data
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Product Categories', COUNT(*) FROM product_categories;

-- 05_product_variants.sql
-- Populate product variants for GAP Retail Database

USE gap_retail_db;

-- Disable foreign key checks for batch inserts
SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;

-- Reset auto-increment values
ALTER TABLE product_variants AUTO_INCREMENT = 1;

-- Populate Product Variants table
INSERT INTO product_variants (ProductID, SKU, Color, Size, VariantPrice, VariantImageURI, StockLevel, LowStockThreshold, Weight, IsActive) VALUES
-- Classic Logo T-Shirt (Product ID: 1) - 6 variants
(1, 'GAP-TS-LG-WHT-S', 'White', 'S', 24.95, '/images/products/classic-logo-tshirt-white-s.jpg', 120, 15, 0.25, TRUE),
(1, 'GAP-TS-LG-WHT-M', 'White', 'M', 24.95, '/images/products/classic-logo-tshirt-white-m.jpg', 150, 15, 0.27, TRUE),
(1, 'GAP-TS-LG-WHT-L', 'White', 'L', 24.95, '/images/products/classic-logo-tshirt-white-l.jpg', 140, 15, 0.29, TRUE),
(1, 'GAP-TS-LG-NVY-S', 'Navy', 'S', 24.95, '/images/products/classic-logo-tshirt-navy-s.jpg', 90, 15, 0.25, TRUE),
(1, 'GAP-TS-LG-NVY-M', 'Navy', 'M', 24.95, '/images/products/classic-logo-tshirt-navy-m.jpg', 120, 15, 0.27, TRUE),
(1, 'GAP-TS-LG-NVY-L', 'Navy', 'L', 24.95, '/images/products/classic-logo-tshirt-navy-l.jpg', 110, 15, 0.29, TRUE),

-- Vintage Wash Jeans (Product ID: 2) - 6 variants
(2, 'GAP-JN-VW-LTBLU-30', 'Light Blue', '30x32', 69.95, '/images/products/vintage-wash-jeans-ltblue-30.jpg', 80, 10, 0.75, TRUE),
(2, 'GAP-JN-VW-LTBLU-32', 'Light Blue', '32x32', 69.95, '/images/products/vintage-wash-jeans-ltblue-32.jpg', 95, 10, 0.78, TRUE),
(2, 'GAP-JN-VW-LTBLU-34', 'Light Blue', '34x32', 69.95, '/images/products/vintage-wash-jeans-ltblue-34.jpg', 90, 10, 0.81, TRUE),
(2, 'GAP-JN-VW-MDMBLU-30', 'Medium Blue', '30x32', 69.95, '/images/products/vintage-wash-jeans-mdblue-30.jpg', 75, 10, 0.75, TRUE),
(2, 'GAP-JN-VW-MDMBLU-32', 'Medium Blue', '32x32', 69.95, '/images/products/vintage-wash-jeans-mdblue-32.jpg', 85, 10, 0.78, TRUE),
(2, 'GAP-JN-VW-MDMBLU-34', 'Medium Blue', '34x32', 69.95, '/images/products/vintage-wash-jeans-mdblue-34.jpg', 80, 10, 0.81, TRUE),

-- Lightweight Puffer Jacket (Product ID: 3) - 4 variants
(3, 'GAP-JK-PF-BLK-S', 'Black', 'S', 89.95, '/images/products/lightweight-puffer-black-s.jpg', 60, 8, 1.1, TRUE),
(3, 'GAP-JK-PF-BLK-M', 'Black', 'M', 89.95, '/images/products/lightweight-puffer-black-m.jpg', 70, 8, 1.2, TRUE),
(3, 'GAP-JK-PF-NVY-S', 'Navy', 'S', 89.95, '/images/products/lightweight-puffer-navy-s.jpg', 55, 8, 1.1, TRUE),
(3, 'GAP-JK-PF-NVY-M', 'Navy', 'M', 89.95, '/images/products/lightweight-puffer-navy-m.jpg', 65, 8, 1.2, TRUE),

-- Performance Stretch Shorts (Product ID: 4) - 4 variants
(4, 'GAP-SH-PS-GRY-S', 'Gray', 'S', 39.95, '/images/products/performance-shorts-gray-s.jpg', 75, 10, 0.35, TRUE),
(4, 'GAP-SH-PS-GRY-M', 'Gray', 'M', 39.95, '/images/products/performance-shorts-gray-m.jpg', 90, 10, 0.38, TRUE),
(4, 'GAP-SH-PS-BLK-S', 'Black', 'S', 39.95, '/images/products/performance-shorts-black-s.jpg', 80, 10, 0.35, TRUE),
(4, 'GAP-SH-PS-BLK-M', 'Black', 'M', 39.95, '/images/products/performance-shorts-black-m.jpg', 95, 10, 0.38, TRUE),

-- Organic Cotton Hoodie (Product ID: 5) - 6 variants
(5, 'GAP-HD-OC-GRY-S', 'Gray', 'S', 59.95, '/images/products/organic-hoodie-gray-s.jpg', 65, 8, 0.85, TRUE),
(5, 'GAP-HD-OC-GRY-M', 'Gray', 'M', 59.95, '/images/products/organic-hoodie-gray-m.jpg', 75, 8, 0.9, TRUE),
(5, 'GAP-HD-OC-GRY-L', 'Gray', 'L', 59.95, '/images/products/organic-hoodie-gray-l.jpg', 70, 8, 0.95, TRUE),
(5, 'GAP-HD-OC-BLK-S', 'Black', 'S', 59.95, '/images/products/organic-hoodie-black-s.jpg', 60, 8, 0.85, TRUE),
(5, 'GAP-HD-OC-BLK-M', 'Black', 'M', 59.95, '/images/products/organic-hoodie-black-m.jpg', 70, 8, 0.9, TRUE),
(5, 'GAP-HD-OC-BLK-L', 'Black', 'L', 59.95, '/images/products/organic-hoodie-black-l.jpg', 65, 8, 0.95, TRUE),

-- Slim Fit Chinos (Product ID: 6) - 6 variants
(6, 'GAP-CH-SF-KHK-30', 'Khaki', '30x32', 49.95, '/images/products/slim-chinos-khaki-30.jpg', 70, 10, 0.55, TRUE),
(6, 'GAP-CH-SF-KHK-32', 'Khaki', '32x32', 49.95, '/images/products/slim-chinos-khaki-32.jpg', 80, 10, 0.58, TRUE),
(6, 'GAP-CH-SF-KHK-34', 'Khaki', '34x32', 49.95, '/images/products/slim-chinos-khaki-34.jpg', 75, 10, 0.61, TRUE),
(6, 'GAP-CH-SF-NVY-30', 'Navy', '30x32', 49.95, '/images/products/slim-chinos-navy-30.jpg', 65, 10, 0.55, TRUE),
(6, 'GAP-CH-SF-NVY-32', 'Navy', '32x32', 49.95, '/images/products/slim-chinos-navy-32.jpg', 75, 10, 0.58, TRUE),
(6, 'GAP-CH-SF-NVY-34', 'Navy', '34x32', 49.95, '/images/products/slim-chinos-navy-34.jpg', 70, 10, 0.61, TRUE),

-- Recycled Polyester Fleece (Product ID: 7) - 4 variants
(7, 'GAP-FL-RP-GRN-S', 'Green', 'S', 64.95, '/images/products/recycled-fleece-green-s.jpg', 55, 8, 0.65, TRUE),
(7, 'GAP-FL-RP-GRN-M', 'Green', 'M', 64.95, '/images/products/recycled-fleece-green-m.jpg', 65, 8, 0.7, TRUE),
(7, 'GAP-FL-RP-GRY-S', 'Gray', 'S', 64.95, '/images/products/recycled-fleece-gray-s.jpg', 50, 8, 0.65, TRUE),
(7, 'GAP-FL-RP-GRY-M', 'Gray', 'M', 64.95, '/images/products/recycled-fleece-gray-m.jpg', 60, 8, 0.7, TRUE),

-- Classic Oxford Shirt (Product ID: 8) - 6 variants
(8, 'GAP-SH-OX-WHT-S', 'White', 'S', 54.95, '/images/products/oxford-shirt-white-s.jpg', 85, 12, 0.35, TRUE),
(8, 'GAP-SH-OX-WHT-M', 'White', 'M', 54.95, '/images/products/oxford-shirt-white-m.jpg', 95, 12, 0.38, TRUE),
(8, 'GAP-SH-OX-WHT-L', 'White', 'L', 54.95, '/images/products/oxford-shirt-white-l.jpg', 90, 12, 0.41, TRUE),
(8, 'GAP-SH-OX-LBL-S', 'Light Blue', 'S', 54.95, '/images/products/oxford-shirt-lblue-s.jpg', 80, 12, 0.35, TRUE),
(8, 'GAP-SH-OX-LBL-M', 'Light Blue', 'M', 54.95, '/images/products/oxford-shirt-lblue-m.jpg', 90, 12, 0.38, TRUE),
(8, 'GAP-SH-OX-LBL-L', 'Light Blue', 'L', 54.95, '/images/products/oxford-shirt-lblue-l.jpg', 85, 12, 0.41, TRUE),

-- Straight Leg Khakis (Product ID: 9) - 4 variants
(9, 'GAP-KH-SL-KHK-32', 'Khaki', '32x32', 44.95, '/images/products/straight-khakis-khaki-32.jpg', 70, 10, 0.55, TRUE),
(9, 'GAP-KH-SL-KHK-34', 'Khaki', '34x32', 44.95, '/images/products/straight-khakis-khaki-34.jpg', 75, 10, 0.58, TRUE),
(9, 'GAP-KH-SL-OLV-32', 'Olive', '32x32', 44.95, '/images/products/straight-khakis-olive-32.jpg', 65, 10, 0.55, TRUE),
(9, 'GAP-KH-SL-OLV-34', 'Olive', '34x32', 44.95, '/images/products/straight-khakis-olive-34.jpg', 70, 10, 0.58, TRUE),

-- Quilted Vest (Product ID: 10) - 4 variants
(10, 'GAP-VS-QT-NVY-S', 'Navy', 'S', 49.95, '/images/products/quilted-vest-navy-s.jpg', 50, 8, 0.55, TRUE),
(10, 'GAP-VS-QT-NVY-M', 'Navy', 'M', 49.95, '/images/products/quilted-vest-navy-m.jpg', 60, 8, 0.6, TRUE),
(10, 'GAP-VS-QT-OLV-S', 'Olive', 'S', 49.95, '/images/products/quilted-vest-olive-s.jpg', 45, 8, 0.55, TRUE),
(10, 'GAP-VS-QT-OLV-M', 'Olive', 'M', 49.95, '/images/products/quilted-vest-olive-m.jpg', 55, 8, 0.6, TRUE),

-- Ribbed Tank Top (Product ID: 11) - 6 variants
(11, 'GAP-TK-RB-WHT-XS', 'White', 'XS', 19.95, '/images/products/ribbed-tank-white-xs.jpg', 80, 15, 0.18, TRUE),
(11, 'GAP-TK-RB-WHT-S', 'White', 'S', 19.95, '/images/products/ribbed-tank-white-s.jpg', 90, 15, 0.2, TRUE),
(11, 'GAP-TK-RB-WHT-M', 'White', 'M', 19.95, '/images/products/ribbed-tank-white-m.jpg', 85, 15, 0.22, TRUE),
(11, 'GAP-TK-RB-BLK-XS', 'Black', 'XS', 19.95, '/images/products/ribbed-tank-black-xs.jpg', 75, 15, 0.18, TRUE),
(11, 'GAP-TK-RB-BLK-S', 'Black', 'S', 19.95, '/images/products/ribbed-tank-black-s.jpg', 85, 15, 0.2, TRUE),
(11, 'GAP-TK-RB-BLK-M', 'Black', 'M', 19.95, '/images/products/ribbed-tank-black-m.jpg', 80, 15, 0.22, TRUE),

-- Slim Fit Jeans (Product ID: 12) - 6 variants
(12, 'GAP-JN-SF-DKBLU-30', 'Dark Blue', '30x32', 59.95, '/images/products/slim-jeans-dkblue-30.jpg', 70, 10, 0.65, TRUE),
(12, 'GAP-JN-SF-DKBLU-32', 'Dark Blue', '32x32', 59.95, '/images/products/slim-jeans-dkblue-32.jpg', 80, 10, 0.68, TRUE),
(12, 'GAP-JN-SF-DKBLU-34', 'Dark Blue', '34x32', 59.95, '/images/products/slim-jeans-dkblue-34.jpg', 75, 10, 0.71, TRUE),
(12, 'GAP-JN-SF-BLK-30', 'Black', '30x32', 59.95, '/images/products/slim-jeans-black-30.jpg', 65, 10, 0.65, TRUE),
(12, 'GAP-JN-SF-BLK-32', 'Black', '32x32', 59.95, '/images/products/slim-jeans-black-32.jpg', 75, 10, 0.68, TRUE),
(12, 'GAP-JN-SF-BLK-34', 'Black', '34x32', 59.95, '/images/products/slim-jeans-black-34.jpg', 70, 10, 0.71, TRUE),

-- Windbreaker Jacket (Product ID: 13) - 4 variants
(13, 'GAP-JK-WB-RED-S', 'Red', 'S', 79.95, '/images/products/windbreaker-red-s.jpg', 45, 8, 0.55, TRUE),
(13, 'GAP-JK-WB-RED-M', 'Red', 'M', 79.95, '/images/products/windbreaker-red-m.jpg', 55, 8, 0.6, TRUE),
(13, 'GAP-JK-WB-BLU-S', 'Blue', 'S', 79.95, '/images/products/windbreaker-blue-s.jpg', 40, 8, 0.55, TRUE),
(13, 'GAP-JK-WB-BLU-M', 'Blue', 'M', 79.95, '/images/products/windbreaker-blue-m.jpg', 50, 8, 0.6, TRUE),

-- Athletic Fit Joggers (Product ID: 14) - 4 variants
(14, 'GAP-JG-AF-GRY-S', 'Gray', 'S', 54.95, '/images/products/athletic-joggers-gray-s.jpg', 60, 10, 0.45, TRUE),
(14, 'GAP-JG-AF-GRY-M', 'Gray', 'M', 54.95, '/images/products/athletic-joggers-gray-m.jpg', 70, 10, 0.48, TRUE),
(14, 'GAP-JG-AF-BLK-S', 'Black', 'S', 54.95, '/images/products/athletic-joggers-black-s.jpg', 65, 10, 0.45, TRUE),
(14, 'GAP-JG-AF-BLK-M', 'Black', 'M', 54.95, '/images/products/athletic-joggers-black-m.jpg', 75, 10, 0.48, TRUE),

-- Essential V-Neck Tee (Product ID: 15) - 6 variants
(15, 'GAP-TS-VN-WHT-S', 'White', 'S', 22.95, '/images/products/vneck-tee-white-s.jpg', 100, 15, 0.25, TRUE),
(15, 'GAP-TS-VN-WHT-M', 'White', 'M', 22.95, '/images/products/vneck-tee-white-m.jpg', 120, 15, 0.27, TRUE),
(15, 'GAP-TS-VN-WHT-L', 'White', 'L', 22.95, '/images/products/vneck-tee-white-l.jpg', 110, 15, 0.29, TRUE),
(15, 'GAP-TS-VN-GRY-S', 'Gray', 'S', 22.95, '/images/products/vneck-tee-gray-s.jpg', 95, 15, 0.25, TRUE),
(15, 'GAP-TS-VN-GRY-M', 'Gray', 'M', 22.95, '/images/products/vneck-tee-gray-m.jpg', 115, 15, 0.27, TRUE),
(15, 'GAP-TS-VN-GRY-L', 'Gray', 'L', 22.95, '/images/products/vneck-tee-gray-l.jpg', 105, 15, 0.29, TRUE),

-- Relaxed Fit Cargo Pants (Product ID: 16) - 4 variants
(16, 'GAP-CP-RF-OLV-32', 'Olive', '32x32', 64.95, '/images/products/cargo-pants-olive-32.jpg', 55, 10, 0.65, TRUE),
(16, 'GAP-CP-RF-OLV-34', 'Olive', '34x32', 64.95, '/images/products/cargo-pants-olive-34.jpg', 60, 10, 0.68, TRUE),
(16, 'GAP-CP-RF-KHK-32', 'Khaki', '32x32', 64.95, '/images/products/cargo-pants-khaki-32.jpg', 50, 10, 0.65, TRUE),
(16, 'GAP-CP-RF-KHK-34', 'Khaki', '34x32', 64.95, '/images/products/cargo-pants-khaki-34.jpg', 55, 10, 0.68, TRUE),

-- Women's products variants (21-30)
-- Floral Print Blouse (Product ID: 21) - 6 variants
(21, 'GAP-BL-FL-WHT-XS', 'White Floral', 'XS', 49.95, '/images/products/floral-blouse-white-xs.jpg', 60, 8, 0.25, TRUE),
(21, 'GAP-BL-FL-WHT-S', 'White Floral', 'S', 49.95, '/images/products/floral-blouse-white-s.jpg', 70, 8, 0.27, TRUE),
(21, 'GAP-BL-FL-WHT-M', 'White Floral', 'M', 49.95, '/images/products/floral-blouse-white-m.jpg', 65, 8, 0.29, TRUE),
(21, 'GAP-BL-FL-BLU-XS', 'Blue Floral', 'XS', 49.95, '/images/products/floral-blouse-blue-xs.jpg', 55, 8, 0.25, TRUE),
(21, 'GAP-BL-FL-BLU-S', 'Blue Floral', 'S', 49.95, '/images/products/floral-blouse-blue-s.jpg', 65, 8, 0.27, TRUE),
(21, 'GAP-BL-FL-BLU-M', 'Blue Floral', 'M', 49.95, '/images/products/floral-blouse-blue-m.jpg', 60, 8, 0.29, TRUE),

-- High Rise Skinny Jeans (Product ID: 22) - 6 variants
(22, 'GAP-JN-HR-DKBLU-25', 'Dark Blue', '25', 69.95, '/images/products/skinny-jeans-dkblue-25.jpg', 65, 10, 0.65, TRUE),
(22, 'GAP-JN-HR-DKBLU-27', 'Dark Blue', '27', 69.95, '/images/products/skinny-jeans-dkblue-27.jpg', 75, 10, 0.67, TRUE),
(22, 'GAP-JN-HR-DKBLU-29', 'Dark Blue', '29', 69.95, '/images/products/skinny-jeans-dkblue-29.jpg', 70, 10, 0.69, TRUE),
(22, 'GAP-JN-HR-BLK-25', 'Black', '25', 69.95, '/images/products/skinny-jeans-black-25.jpg', 60, 10, 0.65, TRUE),
(22, 'GAP-JN-HR-BLK-27', 'Black', '27', 69.95, '/images/products/skinny-jeans-black-27.jpg', 70, 10, 0.67, TRUE),
(22, 'GAP-JN-HR-BLK-29', 'Black', '29', 69.95, '/images/products/skinny-jeans-black-29.jpg', 65, 10, 0.69, TRUE),

-- Puff Sleeve Midi Dress (Product ID: 23) - 4 variants
(23, 'GAP-DR-PS-BLK-XS', 'Black', 'XS', 79.95, '/images/products/puff-dress-black-xs.jpg', 50, 8, 0.45, TRUE),
(23, 'GAP-DR-PS-BLK-S', 'Black', 'S', 79.95, '/images/products/puff-dress-black-s.jpg', 60, 8, 0.48, TRUE),
(23, 'GAP-DR-PS-BLU-XS', 'Blue', 'XS', 79.95, '/images/products/puff-dress-blue-xs.jpg', 45, 8, 0.45, TRUE),
(23, 'GAP-DR-PS-BLU-S', 'Blue', 'S', 79.95, '/images/products/puff-dress-blue-s.jpg', 55, 8, 0.48, TRUE),

-- Kids products variants (31-35)
-- Kids Graphic T-Shirt (Product ID: 31) - 4 variants
(31, 'GAP-KT-GR-BLU-4T', 'Blue', '4T', 19.95, '/images/products/kids-tee-blue-4t.jpg', 80, 10, 0.18, TRUE),
(31, 'GAP-KT-GR-BLU-5T', 'Blue', '5T', 19.95, '/images/products/kids-tee-blue-5t.jpg', 85, 10, 0.19, TRUE),
(31, 'GAP-KT-GR-RED-4T', 'Red', '4T', 19.95, '/images/products/kids-tee-red-4t.jpg', 75, 10, 0.18, TRUE),
(31, 'GAP-KT-GR-RED-5T', 'Red', '5T', 19.95, '/images/products/kids-tee-red-5t.jpg', 80, 10, 0.19, TRUE),

-- Baby products variants (36-40)
-- Baby Organic Onesie Set (Product ID: 36) - 3 variants
(36, 'GAP-BO-OS-WHT-0M3M', 'White', '0-3M', 24.95, '/images/products/baby-onesie-white-0-3m.jpg', 65, 10, 0.18, TRUE),
(36, 'GAP-BO-OS-WHT-3M6M', 'White', '3-6M', 24.95, '/images/products/baby-onesie-white-3-6m.jpg', 70, 10, 0.19, TRUE),
(36, 'GAP-BO-OS-WHT-6M9M', 'White', '6-9M', 24.95, '/images/products/baby-onesie-white-6-9m.jpg', 60, 10, 0.2, TRUE),

-- Home products variants (41-45)
-- Soft Jersey Bedding Set (Product ID: 41) - 3 variants
(41, 'GAP-HM-BD-GRY-TWN', 'Gray', 'Twin', 99.95, '/images/products/bedding-gray-twin.jpg', 40, 5, 1.8, TRUE),
(41, 'GAP-HM-BD-GRY-QN', 'Gray', 'Queen', 119.95, '/images/products/bedding-gray-queen.jpg', 45, 5, 2.0, TRUE),
(41, 'GAP-HM-BD-WHT-TWN', 'White', 'Twin', 99.95, '/images/products/bedding-white-twin.jpg', 35, 5, 1.8, TRUE),

-- Accessories variants (46-50)
-- Structured Baseball Cap (Product ID: 46) - 2 variants
(46, 'GAP-AC-CP-NVY-OS', 'Navy', 'One Size', 24.95, '/images/products/cap-navy-os.jpg', 55, 8, 0.2, TRUE),
(46, 'GAP-AC-CP-BLK-OS', 'Black', 'One Size', 24.95, '/images/products/cap-black-os.jpg', 60, 8, 0.2, TRUE),

-- Leather Belt (Product ID: 47) - 3 variants
(47, 'GAP-AC-BL-BRN-32', 'Brown', '32', 39.95, '/images/products/belt-brown-32.jpg', 40, 5, 0.3, TRUE),
(47, 'GAP-AC-BL-BRN-34', 'Brown', '34', 39.95, '/images/products/belt-brown-34.jpg', 45, 5, 0.31, TRUE),
(47, 'GAP-AC-BL-BRN-36', 'Brown', '36', 39.95, '/images/products/belt-brown-36.jpg', 35, 5, 0.32, TRUE),

-- Canvas Tote Bag (Product ID: 48) - 2 variants
(48, 'GAP-AC-TB-NTL-OS', 'Natural', 'One Size', 34.95, '/images/products/tote-natural-os.jpg', 70, 10, 0.5, TRUE),
(48, 'GAP-AC-TB-BLK-OS', 'Black', 'One Size', 34.95, '/images/products/tote-black-os.jpg', 65, 10, 0.5, TRUE),

-- Statement Necklace (Product ID: 49) - 1 variant
(49, 'GAP-AC-NC-GLD-OS', 'Gold', 'One Size', 29.95, '/images/products/necklace-gold-os.jpg', 50, 8, 0.2, TRUE),

-- Wool Blend Scarf (Product ID: 50) - 3 variants
(50, 'GAP-AC-SC-GRY-OS', 'Gray', 'One Size', 34.95, '/images/products/scarf-gray-os.jpg', 45, 8, 0.3, TRUE),
(50, 'GAP-AC-SC-NVY-OS', 'Navy', 'One Size', 34.95, '/images/products/scarf-navy-os.jpg', 40, 8, 0.3, TRUE),
(50, 'GAP-AC-SC-RED-OS', 'Red', 'One Size', 34.95, '/images/products/scarf-red-os.jpg', 35, 8, 0.3, TRUE),

-- Additional variants to reach 150 total
-- Classic Logo T-Shirt additional variants
(1, 'GAP-TS-LG-WHT-XL', 'White', 'XL', 24.95, '/images/products/classic-logo-tshirt-white-xl.jpg', 130, 15, 0.31, TRUE),
(1, 'GAP-TS-LG-WHT-XXL', 'White', 'XXL', 26.95, '/images/products/classic-logo-tshirt-white-xxl.jpg', 80, 10, 0.33, TRUE),
(1, 'GAP-TS-LG-NVY-XL', 'Navy', 'XL', 24.95, '/images/products/classic-logo-tshirt-navy-xl.jpg', 100, 15, 0.31, TRUE),
(1, 'GAP-TS-LG-NVY-XXL', 'Navy', 'XXL', 26.95, '/images/products/classic-logo-tshirt-navy-xxl.jpg', 70, 10, 0.33, TRUE),
(1, 'GAP-TS-LG-GRY-S', 'Gray', 'S', 24.95, '/images/products/classic-logo-tshirt-gray-s.jpg', 85, 15, 0.25, TRUE),
(1, 'GAP-TS-LG-GRY-M', 'Gray', 'M', 24.95, '/images/products/classic-logo-tshirt-gray-m.jpg', 95, 15, 0.27, TRUE),
(1, 'GAP-TS-LG-GRY-L', 'Gray', 'L', 24.95, '/images/products/classic-logo-tshirt-gray-l.jpg', 90, 15, 0.29, TRUE),

-- Vintage Wash Jeans additional variants
(2, 'GAP-JN-VW-LTBLU-36', 'Light Blue', '36x32', 69.95, '/images/products/vintage-wash-jeans-ltblue-36.jpg', 85, 10, 0.83, TRUE),
(2, 'GAP-JN-VW-LTBLU-38', 'Light Blue', '38x32', 69.95, '/images/products/vintage-wash-jeans-ltblue-38.jpg', 70, 10, 0.85, TRUE),
(2, 'GAP-JN-VW-MDMBLU-36', 'Medium Blue', '36x32', 69.95, '/images/products/vintage-wash-jeans-mdblue-36.jpg', 75, 10, 0.83, TRUE),
(2, 'GAP-JN-VW-MDMBLU-38', 'Medium Blue', '38x32', 69.95, '/images/products/vintage-wash-jeans-mdblue-38.jpg', 65, 10, 0.85, TRUE),

-- Lightweight Puffer Jacket additional variants
(3, 'GAP-JK-PF-BLK-L', 'Black', 'L', 89.95, '/images/products/lightweight-puffer-black-l.jpg', 65, 8, 1.3, TRUE),
(3, 'GAP-JK-PF-BLK-XL', 'Black', 'XL', 89.95, '/images/products/lightweight-puffer-black-xl.jpg', 50, 8, 1.4, TRUE),
(3, 'GAP-JK-PF-NVY-L', 'Navy', 'L', 89.95, '/images/products/lightweight-puffer-navy-l.jpg', 60, 8, 1.3, TRUE),
(3, 'GAP-JK-PF-NVY-XL', 'Navy', 'XL', 89.95, '/images/products/lightweight-puffer-navy-xl.jpg', 45, 8, 1.4, TRUE),

-- Performance Stretch Shorts additional variants
(4, 'GAP-SH-PS-GRY-L', 'Gray', 'L', 39.95, '/images/products/performance-shorts-gray-l.jpg', 85, 10, 0.41, TRUE),
(4, 'GAP-SH-PS-GRY-XL', 'Gray', 'XL', 39.95, '/images/products/performance-shorts-gray-xl.jpg', 70, 10, 0.44, TRUE),
(4, 'GAP-SH-PS-BLK-L', 'Black', 'L', 39.95, '/images/products/performance-shorts-black-l.jpg', 90, 10, 0.41, TRUE),
(4, 'GAP-SH-PS-BLK-XL', 'Black', 'XL', 39.95, '/images/products/performance-shorts-black-xl.jpg', 75, 10, 0.44, TRUE),

-- Organic Cotton Hoodie additional variants
(5, 'GAP-HD-OC-GRY-XL', 'Gray', 'XL', 59.95, '/images/products/organic-hoodie-gray-xl.jpg', 60, 8, 1.0, TRUE),
(5, 'GAP-HD-OC-BLK-XL', 'Black', 'XL', 59.95, '/images/products/organic-hoodie-black-xl.jpg', 55, 8, 1.0, TRUE),
(5, 'GAP-HD-OC-NVY-S', 'Navy', 'S', 59.95, '/images/products/organic-hoodie-navy-s.jpg', 62, 8, 0.85, TRUE),
(5, 'GAP-HD-OC-NVY-M', 'Navy', 'M', 59.95, '/images/products/organic-hoodie-navy-m.jpg', 72, 8, 0.9, TRUE),
(5, 'GAP-HD-OC-NVY-L', 'Navy', 'L', 59.95, '/images/products/organic-hoodie-navy-l.jpg', 67, 8, 0.95, TRUE),

-- Slim Fit Chinos additional variants
(6, 'GAP-CH-SF-KHK-36', 'Khaki', '36x32', 49.95, '/images/products/slim-chinos-khaki-36.jpg', 65, 10, 0.64, TRUE),
(6, 'GAP-CH-SF-NVY-36', 'Navy', '36x32', 49.95, '/images/products/slim-chinos-navy-36.jpg', 60, 10, 0.64, TRUE),
(6, 'GAP-CH-SF-OLV-30', 'Olive', '30x32', 49.95, '/images/products/slim-chinos-olive-30.jpg', 62, 10, 0.55, TRUE),
(6, 'GAP-CH-SF-OLV-32', 'Olive', '32x32', 49.95, '/images/products/slim-chinos-olive-32.jpg', 72, 10, 0.58, TRUE),
(6, 'GAP-CH-SF-OLV-34', 'Olive', '34x32', 49.95, '/images/products/slim-chinos-olive-34.jpg', 67, 10, 0.61, TRUE),

-- Recycled Polyester Fleece additional variants
(7, 'GAP-FL-RP-GRN-L', 'Green', 'L', 64.95, '/images/products/recycled-fleece-green-l.jpg', 60, 8, 0.75, TRUE),
(7, 'GAP-FL-RP-GRY-L', 'Gray', 'L', 64.95, '/images/products/recycled-fleece-gray-l.jpg', 55, 8, 0.75, TRUE),
(7, 'GAP-FL-RP-BLU-S', 'Blue', 'S', 64.95, '/images/products/recycled-fleece-blue-s.jpg', 52, 8, 0.65, TRUE),
(7, 'GAP-FL-RP-BLU-M', 'Blue', 'M', 64.95, '/images/products/recycled-fleece-blue-m.jpg', 62, 8, 0.7, TRUE),

-- Classic Oxford Shirt additional variants
(8, 'GAP-SH-OX-WHT-XL', 'White', 'XL', 54.95, '/images/products/oxford-shirt-white-xl.jpg', 80, 12, 0.44, TRUE),
(8, 'GAP-SH-OX-LBL-XL', 'Light Blue', 'XL', 54.95, '/images/products/oxford-shirt-lblue-xl.jpg', 75, 12, 0.44, TRUE),
(8, 'GAP-SH-OX-PNK-S', 'Pink', 'S', 54.95, '/images/products/oxford-shirt-pink-s.jpg', 70, 12, 0.35, TRUE),
(8, 'GAP-SH-OX-PNK-M', 'Pink', 'M', 54.95, '/images/products/oxford-shirt-pink-m.jpg', 80, 12, 0.38, TRUE),
(8, 'GAP-SH-OX-PNK-L', 'Pink', 'L', 54.95, '/images/products/oxford-shirt-pink-l.jpg', 75, 12, 0.41, TRUE),

-- Straight Leg Khakis additional variants
(9, 'GAP-KH-SL-KHK-36', 'Khaki', '36x32', 44.95, '/images/products/straight-khakis-khaki-36.jpg', 65, 10, 0.61, TRUE),
(9, 'GAP-KH-SL-OLV-36', 'Olive', '36x32', 44.95, '/images/products/straight-khakis-olive-36.jpg', 60, 10, 0.61, TRUE),

-- Quilted Vest additional variants
(10, 'GAP-VS-QT-NVY-L', 'Navy', 'L', 49.95, '/images/products/quilted-vest-navy-l.jpg', 55, 8, 0.65, TRUE),
(10, 'GAP-VS-QT-OLV-L', 'Olive', 'L', 49.95, '/images/products/quilted-vest-olive-l.jpg', 50, 8, 0.65, TRUE),
(10, 'GAP-VS-QT-BLK-S', 'Black', 'S', 49.95, '/images/products/quilted-vest-black-s.jpg', 48, 8, 0.55, TRUE),
(10, 'GAP-VS-QT-BLK-M', 'Black', 'M', 49.95, '/images/products/quilted-vest-black-m.jpg', 58, 8, 0.6, TRUE),

-- Ribbed Tank Top additional variants
(11, 'GAP-TK-RB-WHT-L', 'White', 'L', 19.95, '/images/products/ribbed-tank-white-l.jpg', 80, 15, 0.24, TRUE),
(11, 'GAP-TK-RB-BLK-L', 'Black', 'L', 19.95, '/images/products/ribbed-tank-black-l.jpg', 75, 15, 0.24, TRUE),
(11, 'GAP-TK-RB-GRY-XS', 'Gray', 'XS', 19.95, '/images/products/ribbed-tank-gray-xs.jpg', 72, 15, 0.18, TRUE),
(11, 'GAP-TK-RB-GRY-S', 'Gray', 'S', 19.95, '/images/products/ribbed-tank-gray-s.jpg', 82, 15, 0.2, TRUE),
(11, 'GAP-TK-RB-GRY-M', 'Gray', 'M', 19.95, '/images/products/ribbed-tank-gray-m.jpg', 77, 15, 0.22, TRUE),

-- Slim Fit Jeans additional variants
(12, 'GAP-JN-SF-DKBLU-36', 'Dark Blue', '36x32', 59.95, '/images/products/slim-jeans-dkblue-36.jpg', 65, 10, 0.74, TRUE),
(12, 'GAP-JN-SF-BLK-36', 'Black', '36x32', 59.95, '/images/products/slim-jeans-black-36.jpg', 60, 10, 0.74, TRUE),

-- Windbreaker Jacket additional variants
(13, 'GAP-JK-WB-RED-L', 'Red', 'L', 79.95, '/images/products/windbreaker-red-l.jpg', 50, 8, 0.65, TRUE),
(13, 'GAP-JK-WB-BLU-L', 'Blue', 'L', 79.95, '/images/products/windbreaker-blue-l.jpg', 45, 8, 0.65, TRUE),

-- Athletic Fit Joggers additional variants
(14, 'GAP-JG-AF-GRY-L', 'Gray', 'L', 54.95, '/images/products/athletic-joggers-gray-l.jpg', 65, 10, 0.51, TRUE),
(14, 'GAP-JG-AF-BLK-L', 'Black', 'L', 54.95, '/images/products/athletic-joggers-black-l.jpg', 70, 10, 0.51, TRUE),
(14, 'GAP-JG-AF-NVY-S', 'Navy', 'S', 54.95, '/images/products/athletic-joggers-navy-s.jpg', 62, 10, 0.45, TRUE),
(14, 'GAP-JG-AF-NVY-M', 'Navy', 'M', 54.95, '/images/products/athletic-joggers-navy-m.jpg', 72, 10, 0.48, TRUE),
(14, 'GAP-JG-AF-NVY-L', 'Navy', 'L', 54.95, '/images/products/athletic-joggers-navy-l.jpg', 67, 10, 0.51, TRUE),

-- Essential V-Neck Tee additional variants
(15, 'GAP-TS-VN-WHT-XL', 'White', 'XL', 22.95, '/images/products/vneck-tee-white-xl.jpg', 100, 15, 0.31, TRUE),
(15, 'GAP-TS-VN-GRY-XL', 'Gray', 'XL', 22.95, '/images/products/vneck-tee-gray-xl.jpg', 95, 15, 0.31, TRUE),
(15, 'GAP-TS-VN-BLK-S', 'Black', 'S', 22.95, '/images/products/vneck-tee-black-s.jpg', 92, 15, 0.25, TRUE),
(15, 'GAP-TS-VN-BLK-M', 'Black', 'M', 22.95, '/images/products/vneck-tee-black-m.jpg', 112, 15, 0.27, TRUE),
(15, 'GAP-TS-VN-BLK-L', 'Black', 'L', 22.95, '/images/products/vneck-tee-black-l.jpg', 102, 15, 0.29, TRUE),
(15, 'GAP-TS-VN-BLK-XL', 'Black', 'XL', 22.95, '/images/products/vneck-tee-black-xl.jpg', 92, 15, 0.31, TRUE);

COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

-- Verify data
SELECT COUNT(*) AS TotalVariants FROM product_variants;

-- 06_inventory.sql - Populate inventory levels
USE gap_retail_db;

SET FOREIGN_KEY_CHECKS=0;
START TRANSACTION;
ALTER TABLE inventory_levels AUTO_INCREMENT = 1;

-- Warehouse inventory - East Coast
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
-- Northeast Distribution Center (ID: 1)
(1, 'GAP-TS-LG-WHT-S', 1, NULL, 'Warehouse', 50, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 20, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(2, 'GAP-TS-LG-WHT-M', 1, NULL, 'Warehouse', 65, 0, NULL, 3, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 20, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(3, 'GAP-TS-LG-WHT-L', 1, NULL, 'Warehouse', 60, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 20, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(4, 'GAP-TS-LG-NVY-S', 1, NULL, 'Warehouse', 40, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(5, 'GAP-TS-LG-NVY-M', 1, NULL, 'Warehouse', 50, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(6, 'GAP-TS-LG-NVY-L', 1, NULL, 'Warehouse', 45, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(77, 'GAP-BL-FL-WHT-XS', 1, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(78, 'GAP-BL-FL-WHT-S', 1, NULL, 'Warehouse', 35, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(79, 'GAP-BL-FL-WHT-M', 1, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- Mid-Atlantic Fulfillment Center (ID: 2)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(7, 'GAP-JN-VW-LTBLU-30', 2, NULL, 'Warehouse', 35, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(8, 'GAP-JN-VW-LTBLU-32', 2, NULL, 'Warehouse', 40, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(9, 'GAP-JN-VW-LTBLU-34', 2, NULL, 'Warehouse', 38, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(10, 'GAP-JN-VW-MDMBLU-30', 2, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(11, 'GAP-JN-VW-MDMBLU-32', 2, NULL, 'Warehouse', 36, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(12, 'GAP-JN-VW-MDMBLU-34', 2, NULL, 'Warehouse', 35, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(83, 'GAP-JN-HR-DKBLU-25', 2, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(84, 'GAP-JN-HR-DKBLU-27', 2, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(85, 'GAP-JN-HR-DKBLU-29', 2, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- Southeast Regional Hub (ID: 3)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(13, 'GAP-JK-PF-BLK-S', 3, NULL, 'Warehouse', 25, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(14, 'GAP-JK-PF-BLK-M', 3, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(15, 'GAP-JK-PF-NVY-S', 3, NULL, 'Warehouse', 22, 0, NULL, 0, NULL, 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(16, 'GAP-JK-PF-NVY-M', 3, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(89, 'GAP-DR-PS-BLK-XS', 3, NULL, 'Warehouse', 20, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(90, 'GAP-DR-PS-BLK-S', 3, NULL, 'Warehouse', 25, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(91, 'GAP-DR-PS-BLU-XS', 3, NULL, 'Warehouse', 18, 0, NULL, 0, NULL, 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(92, 'GAP-DR-PS-BLU-S', 3, NULL, 'Warehouse', 22, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY));

-- Midwest Distribution Facility (ID: 4)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(17, 'GAP-SH-PS-GRY-S', 4, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(18, 'GAP-SH-PS-GRY-M', 4, NULL, 'Warehouse', 38, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(19, 'GAP-SH-PS-BLK-S', 4, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(20, 'GAP-SH-PS-BLK-M', 4, NULL, 'Warehouse', 40, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(93, 'GAP-KT-GR-BLU-4T', 4, NULL, 'Warehouse', 35, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(94, 'GAP-KT-GR-BLU-5T', 4, NULL, 'Warehouse', 38, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(95, 'GAP-KT-GR-RED-4T', 4, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(96, 'GAP-KT-GR-RED-5T', 4, NULL, 'Warehouse', 35, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY));

-- Southwest Fulfillment Center (ID: 5)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(21, 'GAP-HD-OC-GRY-S', 5, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(22, 'GAP-HD-OC-GRY-M', 5, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(23, 'GAP-HD-OC-GRY-L', 5, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(24, 'GAP-HD-OC-BLK-S', 5, NULL, 'Warehouse', 25, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(25, 'GAP-HD-OC-BLK-M', 5, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(26, 'GAP-HD-OC-BLK-L', 5, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(97, 'GAP-BO-OS-WHT-0M3M', 5, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(98, 'GAP-BO-OS-WHT-3M6M', 5, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(99, 'GAP-BO-OS-WHT-6M9M', 5, NULL, 'Warehouse', 25, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- Northwest Distribution Hub (ID: 6)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(27, 'GAP-CH-SF-KHK-30', 6, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(28, 'GAP-CH-SF-KHK-32', 6, NULL, 'Warehouse', 35, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(29, 'GAP-CH-SF-KHK-34', 6, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(30, 'GAP-CH-SF-NVY-30', 6, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(31, 'GAP-CH-SF-NVY-32', 6, NULL, 'Warehouse', 32, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(32, 'GAP-CH-SF-NVY-34', 6, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(100, 'GAP-HM-BD-GRY-TWN', 6, NULL, 'Warehouse', 18, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(101, 'GAP-HM-BD-GRY-QN', 6, NULL, 'Warehouse', 20, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(102, 'GAP-HM-BD-WHT-TWN', 6, NULL, 'Warehouse', 16, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- West Coast Primary Center (ID: 7)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(33, 'GAP-FL-RP-GRN-S', 7, NULL, 'Warehouse', 24, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(34, 'GAP-FL-RP-GRN-M', 7, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(35, 'GAP-FL-RP-GRY-S', 7, NULL, 'Warehouse', 22, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(36, 'GAP-FL-RP-GRY-M', 7, NULL, 'Warehouse', 26, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(103, 'GAP-AC-CP-NVY-OS', 7, NULL, 'Warehouse', 25, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(104, 'GAP-AC-CP-BLK-OS', 7, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(105, 'GAP-AC-BL-BRN-32', 7, NULL, 'Warehouse', 18, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(106, 'GAP-AC-BL-BRN-34', 7, NULL, 'Warehouse', 20, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(107, 'GAP-AC-BL-BRN-36', 7, NULL, 'Warehouse', 15, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY));

-- Store inventory
-- GAP 5th Avenue Flagship (ID: 1)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(1, 'GAP-TS-LG-WHT-S', NULL, 1, 'Store', 15, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(2, 'GAP-TS-LG-WHT-M', NULL, 1, 'Store', 18, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(3, 'GAP-TS-LG-WHT-L', NULL, 1, 'Store', 16, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(4, 'GAP-TS-LG-NVY-S', NULL, 1, 'Store', 12, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(5, 'GAP-TS-LG-NVY-M', NULL, 1, 'Store', 15, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(6, 'GAP-TS-LG-NVY-L', NULL, 1, 'Store', 14, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(77, 'GAP-BL-FL-WHT-XS', NULL, 1, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(78, 'GAP-BL-FL-WHT-S', NULL, 1, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(79, 'GAP-BL-FL-WHT-M', NULL, 1, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(83, 'GAP-JN-HR-DKBLU-25', NULL, 1, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(84, 'GAP-JN-HR-DKBLU-27', NULL, 1, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(85, 'GAP-JN-HR-DKBLU-29', NULL, 1, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY));

-- GAP Times Square (ID: 2)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(7, 'GAP-JN-VW-LTBLU-30', NULL, 2, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(8, 'GAP-JN-VW-LTBLU-32', NULL, 2, 'Store', 12, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(9, 'GAP-JN-VW-LTBLU-34', NULL, 2, 'Store', 11, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(10, 'GAP-JN-VW-MDMBLU-30', NULL, 2, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(11, 'GAP-JN-VW-MDMBLU-32', NULL, 2, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(12, 'GAP-JN-VW-MDMBLU-34', NULL, 2, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(103, 'GAP-AC-CP-NVY-OS', NULL, 2, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(104, 'GAP-AC-CP-BLK-OS', NULL, 2, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(108, 'GAP-AC-TB-NTL-OS', NULL, 2, 'Store', 12, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(109, 'GAP-AC-TB-BLK-OS', NULL, 2, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY));

-- GAP Beverly Center (ID: 4)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(13, 'GAP-JK-PF-BLK-S', NULL, 4, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(14, 'GAP-JK-PF-BLK-M', NULL, 4, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(15, 'GAP-JK-PF-NVY-S', NULL, 4, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(16, 'GAP-JK-PF-NVY-M', NULL, 4, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(89, 'GAP-DR-PS-BLK-XS', NULL, 4, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(90, 'GAP-DR-PS-BLK-S', NULL, 4, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(91, 'GAP-DR-PS-BLU-XS', NULL, 4, 'Store', 6, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(92, 'GAP-DR-PS-BLU-S', NULL, 4, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- GAP Grove (ID: 5)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(17, 'GAP-SH-PS-GRY-S', NULL, 5, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(18, 'GAP-SH-PS-GRY-M', NULL, 5, 'Store', 12, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(19, 'GAP-SH-PS-BLK-S', NULL, 5, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(20, 'GAP-SH-PS-BLK-M', NULL, 5, 'Store', 13, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(93, 'GAP-KT-GR-BLU-4T', NULL, 5, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(94, 'GAP-KT-GR-BLU-5T', NULL, 5, 'Store', 12, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(95, 'GAP-KT-GR-RED-4T', NULL, 5, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(96, 'GAP-KT-GR-RED-5T', NULL, 5, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- GAP Michigan Avenue (ID: 7)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(21, 'GAP-HD-OC-GRY-S', NULL, 7, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(22, 'GAP-HD-OC-GRY-M', NULL, 7, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(23, 'GAP-HD-OC-GRY-L', NULL, 7, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(24, 'GAP-HD-OC-BLK-S', NULL, 7, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(25, 'GAP-HD-OC-BLK-M', NULL, 7, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(26, 'GAP-HD-OC-BLK-L', NULL, 7, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(97, 'GAP-BO-OS-WHT-0M3M', NULL, 7, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(98, 'GAP-BO-OS-WHT-3M6M', NULL, 7, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(99, 'GAP-BO-OS-WHT-6M9M', NULL, 7, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- GAP Market Street (ID: 9)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(27, 'GAP-CH-SF-KHK-30', NULL, 9, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(28, 'GAP-CH-SF-KHK-32', NULL, 9, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(29, 'GAP-CH-SF-KHK-34', NULL, 9, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(30, 'GAP-CH-SF-NVY-30', NULL, 9, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(31, 'GAP-CH-SF-NVY-32', NULL, 9, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(32, 'GAP-CH-SF-NVY-34', NULL, 9, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(100, 'GAP-HM-BD-GRY-TWN', NULL, 9, 'Store', 5, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 2, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(101, 'GAP-HM-BD-GRY-QN', NULL, 9, 'Store', 6, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 2, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(102, 'GAP-HM-BD-WHT-TWN', NULL, 9, 'Store', 4, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 2, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- GAP Union Square (ID: 10)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(33, 'GAP-FL-RP-GRN-S', NULL, 10, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(34, 'GAP-FL-RP-GRN-M', NULL, 10, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(35, 'GAP-FL-RP-GRY-S', NULL, 10, 'Store', 6, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(36, 'GAP-FL-RP-GRY-M', NULL, 10, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(105, 'GAP-AC-BL-BRN-32', NULL, 10, 'Store', 5, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 2, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(106, 'GAP-AC-BL-BRN-34', NULL, 10, 'Store', 6, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 2, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(107, 'GAP-AC-BL-BRN-36', NULL, 10, 'Store', 5, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 2, 2, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(110, 'GAP-AC-NC-GLD-OS', NULL, 10, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- GAP Newbury (ID: 11)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(37, 'GAP-SH-OX-WHT-S', NULL, 11, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(38, 'GAP-SH-OX-WHT-M', NULL, 11, 'Store', 12, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(39, 'GAP-SH-OX-WHT-L', NULL, 11, 'Store', 11, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(40, 'GAP-SH-OX-LBL-S', NULL, 11, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(41, 'GAP-SH-OX-LBL-M', NULL, 11, 'Store', 11, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(42, 'GAP-SH-OX-LBL-L', NULL, 11, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(111, 'GAP-AC-SC-GRY-OS', NULL, 11, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(112, 'GAP-AC-SC-NVY-OS', NULL, 11, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(113, 'GAP-AC-SC-RED-OS', NULL, 11, 'Store', 6, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- GAP Lincoln Road (ID: 15)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(43, 'GAP-KH-SL-KHK-32', NULL, 15, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(44, 'GAP-KH-SL-KHK-34', NULL, 15, 'Store', 10, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(45, 'GAP-KH-SL-OLV-32', NULL, 15, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(46, 'GAP-KH-SL-OLV-34', NULL, 15, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(108, 'GAP-AC-TB-NTL-OS', NULL, 15, 'Store', 15, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(109, 'GAP-AC-TB-BLK-OS', NULL, 15, 'Store', 14, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY));

-- GAP Lenox Square (ID: 17)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(47, 'GAP-VS-QT-NVY-S', NULL, 17, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(48, 'GAP-VS-QT-NVY-M', NULL, 17, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(49, 'GAP-VS-QT-OLV-S', NULL, 17, 'Store', 6, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(50, 'GAP-VS-QT-OLV-M', NULL, 17, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(80, 'GAP-BL-FL-BLU-XS', NULL, 17, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(81, 'GAP-BL-FL-BLU-S', NULL, 17, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(82, 'GAP-BL-FL-BLU-M', NULL, 17, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(86, 'GAP-JN-HR-BLK-25', NULL, 17, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(87, 'GAP-JN-HR-BLK-27', NULL, 17, 'Store', 9, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(88, 'GAP-JN-HR-BLK-29', NULL, 17, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- Additional inventory for West Coast Primary Center (ID: 7)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(51, 'GAP-TK-RB-WHT-XS', 7, NULL, 'Warehouse', 35, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(52, 'GAP-TK-RB-WHT-S', 7, NULL, 'Warehouse', 40, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(53, 'GAP-TK-RB-WHT-M', 7, NULL, 'Warehouse', 38, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(54, 'GAP-TK-RB-BLK-XS', 7, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(55, 'GAP-TK-RB-BLK-S', 7, NULL, 'Warehouse', 38, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(56, 'GAP-TK-RB-BLK-M', 7, NULL, 'Warehouse', 34, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 15, 15, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY));

-- Slim Fit Jeans at Southeast Regional Hub (ID: 3)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(57, 'GAP-JN-SF-DKBLU-30', 3, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(58, 'GAP-JN-SF-DKBLU-32', 3, NULL, 'Warehouse', 34, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(59, 'GAP-JN-SF-DKBLU-34', 3, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(60, 'GAP-JN-SF-BLK-30', 3, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(61, 'GAP-JN-SF-BLK-32', 3, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(62, 'GAP-JN-SF-BLK-34', 3, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY));

-- Windbreaker Jackets at Mid-Atlantic Fulfillment Center (ID: 2)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(63, 'GAP-JK-WB-RED-S', 2, NULL, 'Warehouse', 20, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(64, 'GAP-JK-WB-RED-M', 2, NULL, 'Warehouse', 25, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(65, 'GAP-JK-WB-BLU-S', 2, NULL, 'Warehouse', 18, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(66, 'GAP-JK-WB-BLU-M', 2, NULL, 'Warehouse', 22, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(67, 'GAP-JK-WB-BLK-S', 2, NULL, 'Warehouse', 24, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(68, 'GAP-JK-WB-BLK-M', 2, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(69, 'GAP-JK-WB-BLK-L', 2, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- Add inventory for GAP Accessories at Southeast Regional Hub (ID: 3)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(70, 'GAP-AC-HB-BLK-OS', 3, NULL, 'Warehouse', 25, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(71, 'GAP-AC-HB-WHT-OS', 3, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(72, 'GAP-AC-BT-BRN-OS', 3, NULL, 'Warehouse', 22, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- Add inventory for GAP Accessories at Southwest Fulfillment Center (ID: 5)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(73, 'GAP-AC-WL-BLK-OS', 5, NULL, 'Warehouse', 18, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(74, 'GAP-AC-WL-TAN-OS', 5, NULL, 'Warehouse', 20, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(75, 'GAP-AC-SH-BLK-OS', 5, NULL, 'Warehouse', 15, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY)),
(76, 'GAP-AC-SH-BRN-OS', 5, NULL, 'Warehouse', 12, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- Add Slim Fit Jeans at Midwest Distribution Facility (ID: 4)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(77, 'GAP-JN-SF-LTBLU-30', 4, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(78, 'GAP-JN-SF-LTBLU-32', 4, NULL, 'Warehouse', 34, 0, NULL, 2, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(79, 'GAP-JN-SF-LTBLU-34', 4, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(80, 'GAP-JN-SF-BLK-30', 4, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(81, 'GAP-JN-SF-BLK-32', 4, NULL, 'Warehouse', 32, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY)),
(82, 'GAP-JN-SF-BLK-34', 4, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 10, 10, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 4 DAY));

-- Add additional inventory to West Coast Primary Center (ID: 7)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(83, 'GAP-AC-SF-BLK-OS', 7, NULL, 'Warehouse', 28, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(84, 'GAP-AC-SF-BRN-OS', 7, NULL, 'Warehouse', 30, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(85, 'GAP-AC-SF-TAN-OS', 7, NULL, 'Warehouse', 24, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY)),
(86, 'GAP-AC-SF-GRY-OS', 7, NULL, 'Warehouse', 26, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 8, 8, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 5 DAY));

-- Add GAP Shoes at Northwest Distribution Hub (ID: 6)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(87, 'GAP-SH-CV-WHT-OS', 6, NULL, 'Warehouse', 20, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(88, 'GAP-SH-CV-BLK-OS', 6, NULL, 'Warehouse', 18, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(89, 'GAP-SH-LC-BRN-OS', 6, NULL, 'Warehouse', 22, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(90, 'GAP-SH-LC-GRY-OS', 6, NULL, 'Warehouse', 24, 0, NULL, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 2 DAY), 5, 5, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- Add GAP Coats at GAP Union Square (ID: 10)
INSERT INTO inventory_levels (VariantID, SKU, WarehouseID, StoreID, LocationType, QuantityOnHand, ReservedForPickup, PickupReservationExpiry, ReservedQuantity, ReservationExpiry, ReorderPoint, LowStockThreshold, LastStockCheckDate)
VALUES
(91, 'GAP-CT-WL-BLK-S', NULL, 10, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(92, 'GAP-CT-WL-BLK-M', NULL, 10, 'Store', 8, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(93, 'GAP-CT-WL-GRY-S', NULL, 10, 'Store', 6, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)),
(94, 'GAP-CT-WL-GRY-M', NULL, 10, 'Store', 7, 1, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 1 DAY), 0, NULL, 3, 3, DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY));

-- 07_datap1.sql
-- Part 1: Populates shopping carts and cart items

START TRANSACTION;

-- Temporarily disable foreign key checks
SET FOREIGN_KEY_CHECKS=0;

-- Reset auto-increment values for cart tables
ALTER TABLE shopping_cart AUTO_INCREMENT = 1;
ALTER TABLE shopping_cart_items AUTO_INCREMENT = 1;

-- =====================================================
-- SHOPPING CARTS (35 rows)
-- =====================================================
INSERT INTO shopping_cart (CustomerID, SessionID, LastActiveTime, AppliedPromotions, ItemDiscounts, CreatedAt, UpdatedAt) VALUES
(1, NULL, '2025-04-08 08:12:35', '[{"promotionId": 3, "code": "SPRING25", "discountAmount": 25.00}]', '{"1": 15.00, "2": 10.00}', '2025-04-01 08:12:35', '2025-04-08 08:12:35'),
(2, NULL, '2025-04-09 01:21:43', NULL, NULL, '2025-04-09 01:10:22', '2025-04-09 01:21:43'),
(3, NULL, '2025-04-08 14:23:12', '[{"promotionId": 5, "code": "NEWCUST15", "discountAmount": 15.00}]', NULL, '2025-04-08 13:45:30', '2025-04-08 14:23:12'),
(4, NULL, '2025-04-08 19:55:03', NULL, NULL, '2025-04-08 19:44:11', '2025-04-08 19:55:03'),
(5, NULL, '2025-04-09 02:12:26', '[{"promotionId": 7, "code": "WEEKEND10", "discountAmount": 10.00}]', '{"5": 5.00, "6": 5.00}', '2025-04-08 23:58:43', '2025-04-09 02:12:26'),
(6, NULL, '2025-04-08 11:34:17', NULL, NULL, '2025-04-08 11:22:05', '2025-04-08 11:34:17'),
(7, NULL, '2025-04-07 09:01:29', '[{"promotionId": 2, "code": "LOYALTY20", "discountAmount": 20.00}]', NULL, '2025-04-07 08:45:12', '2025-04-07 09:01:29'),
(8, NULL, '2025-04-08 16:29:52', NULL, NULL, '2025-04-08 16:10:33', '2025-04-08 16:29:52'),
(9, NULL, '2025-04-09 03:15:47', '[{"promotionId": 4, "code": "SAVE30NOW", "discountAmount": 30.00}]', '{"18": 20.00, "19": 10.00}', '2025-04-09 02:48:31', '2025-04-09 03:15:47'),
(10, NULL, '2025-04-08 22:41:05', NULL, NULL, '2025-04-08 22:25:19', '2025-04-08 22:41:05'),
(NULL, 'sess_c37de92a1b5f4e6c', '2025-04-08 20:12:36', NULL, NULL, '2025-04-08 20:05:41', '2025-04-08 20:12:36'),
(NULL, 'sess_8f91ab25c4e7d3b8', '2025-04-09 01:47:23', '[{"promotionId": 6, "code": "FLASH20", "discountAmount": 20.00}]', NULL, '2025-04-09 01:32:18', '2025-04-09 01:47:23'),
(NULL, 'sess_1a2b3c4d5e6f7g8h', '2025-04-08 18:23:41', NULL, NULL, '2025-04-08 18:05:12', '2025-04-08 18:23:41'),
(NULL, 'sess_9i8h7g6f5e4d3c2b', '2025-04-08 17:11:09', '[{"promotionId": 8, "code": "WELCOME10", "discountAmount": 10.00}]', '{"26": 5.00, "27": 5.00}', '2025-04-08 16:59:23', '2025-04-08 17:11:09'),
(NULL, 'sess_2j3k4l5m6n7o8p9q', '2025-04-09 00:30:27', NULL, NULL, '2025-04-09 00:15:51', '2025-04-09 00:30:27'),
(11, NULL, '2025-04-08 09:22:14', '[{"promotionId": 10, "code": "MEMBER15", "discountAmount": 15.00}]', NULL, '2025-04-08 09:10:08', '2025-04-08 09:22:14'),
(12, NULL, '2025-04-09 02:58:33', NULL, NULL, '2025-04-09 02:45:02', '2025-04-09 02:58:33'),
(13, NULL, '2025-04-08 13:40:27', '[{"promotionId": 9, "code": "SPRING10", "discountAmount": 10.00}]', '{"34": 10.00}', '2025-04-08 13:22:15', '2025-04-08 13:40:27'),
(14, NULL, '2025-04-08 15:12:09', NULL, NULL, '2025-04-08 15:01:37', '2025-04-08 15:12:09'),
(15, NULL, '2025-04-09 01:09:53', '[{"promotionId": 11, "code": "APRIL25", "discountAmount": 25.00}]', NULL, '2025-04-09 00:52:19', '2025-04-09 01:09:53'),
(NULL, 'sess_r1s2t3u4v5w6x7y8z', '2025-04-08 19:28:41', NULL, NULL, '2025-04-08 19:15:07', '2025-04-08 19:28:41'),
(NULL, 'sess_a1b2c3d4e5f6g7h8i9', '2025-04-09 03:05:12', '[{"promotionId": 12, "code": "SAVE15TODAY", "discountAmount": 15.00}]', '{"42": 10.00, "43": 5.00}', '2025-04-09 02:47:28', '2025-04-09 03:05:12'),
(NULL, 'sess_j1k2l3m4n5o6p7q8r9', '2025-04-08 14:59:02', NULL, NULL, '2025-04-08 14:43:25', '2025-04-08 14:59:02'),
(16, NULL, '2025-04-08 10:32:18', '[{"promotionId": 1, "code": "FIRST10", "discountAmount": 10.00}]', NULL, '2025-04-08 10:18:42', '2025-04-08 10:32:18'),
(17, NULL, '2025-04-09 00:15:49', NULL, NULL, '2025-04-09 00:02:21', '2025-04-09 00:15:49'),
(18, NULL, '2025-04-08 12:45:33', '[{"promotionId": 13, "code": "ICON25", "discountAmount": 25.00}]', '{"50": 15.00, "51": 10.00}', '2025-04-08 12:28:19', '2025-04-08 12:45:33'),
(19, NULL, '2025-04-08 18:03:27', NULL, NULL, '2025-04-08 17:52:14', '2025-04-08 18:03:27'),
(20, NULL, '2025-04-09 02:41:15', '[{"promotionId": 14, "code": "EASTER20", "discountAmount": 20.00}]', NULL, '2025-04-09 02:25:38', '2025-04-09 02:41:15'),
(NULL, 'sess_s1t2u3v4w5x6y7z8a9', '2025-04-08 21:17:09', NULL, NULL, '2025-04-08 21:02:33', '2025-04-08 21:17:09'),
(NULL, 'sess_b1c2d3e4f5g6h7i8j9', '2025-04-08 23:28:56', '[{"promotionId": 15, "code": "NIGHT15", "discountAmount": 15.00}]', '{"58": 15.00}', '2025-04-08 23:12:22', '2025-04-08 23:28:56'),
(NULL, 'sess_k1l2m3n4o5p6q7r8s9', '2025-04-09 01:31:42', NULL, NULL, '2025-04-09 01:20:15', '2025-04-09 01:31:42'),
(21, NULL, '2025-04-08 08:55:37', '[{"promotionId": 16, "code": "MORNING10", "discountAmount": 10.00}]', NULL, '2025-04-08 08:42:04', '2025-04-08 08:55:37'),
(22, NULL, '2025-04-08 16:49:21', NULL, NULL, '2025-04-08 16:33:45', '2025-04-08 16:49:21'),
(23, NULL, '2025-04-09 00:58:14', '[{"promotionId": 17, "code": "MIDNIGHT20", "discountAmount": 20.00}]', '{"66": 12.00, "67": 8.00}', '2025-04-09 00:41:29', '2025-04-09 00:58:14');

-- =====================================================
-- SHOPPING CART ITEMS (70 rows)
-- =====================================================
INSERT INTO shopping_cart_items (CartID, ProductVariantID, Quantity, CreatedAt, UpdatedAt) VALUES
(1, 5, 2, '2025-04-01 08:15:22', '2025-04-01 08:15:22'),
(1, 12, 1, '2025-04-01 08:17:45', '2025-04-01 08:17:45'),
(2, 8, 1, '2025-04-09 01:12:35', '2025-04-09 01:12:35'),
(2, 24, 2, '2025-04-09 01:15:17', '2025-04-09 01:15:17'),
(3, 3, 1, '2025-04-08 13:48:12', '2025-04-08 13:48:12'),
(3, 15, 1, '2025-04-08 13:52:41', '2025-04-08 13:52:41'),
(3, 22, 1, '2025-04-08 14:01:03', '2025-04-08 14:01:03'),
(4, 7, 2, '2025-04-08 19:45:26', '2025-04-08 19:45:26'),
(5, 10, 1, '2025-04-08 23:59:15', '2025-04-08 23:59:15'),
(5, 18, 1, '2025-04-09 00:02:48', '2025-04-09 00:02:48'),
(6, 25, 3, '2025-04-08 11:23:19', '2025-04-08 11:23:19'),
(7, 2, 1, '2025-04-07 08:47:32', '2025-04-07 08:47:32'),
(7, 9, 1, '2025-04-07 08:52:46', '2025-04-07 08:52:46'),
(8, 14, 2, '2025-04-08 16:12:28', '2025-04-08 16:12:28'),
(9, 1, 1, '2025-04-09 02:50:17', '2025-04-09 02:50:17'),
(9, 11, 1, '2025-04-09 02:55:42', '2025-04-09 02:55:42'),
(9, 20, 1, '2025-04-09 03:01:15', '2025-04-09 03:01:15'),
(10, 6, 2, '2025-04-08 22:28:54', '2025-04-08 22:28:54'),
(10, 13, 1, '2025-04-08 22:33:27', '2025-04-08 22:33:27'),
(11, 17, 1, '2025-04-08 20:07:12', '2025-04-08 20:07:12'),
(11, 23, 1, '2025-04-08 20:09:45', '2025-04-08 20:09:45'),
(12, 4, 1, '2025-04-09 01:35:29', '2025-04-09 01:35:29'),
(12, 16, 1, '2025-04-09 01:38:16', '2025-04-09 01:38:16'),
(12, 19, 1, '2025-04-09 01:41:53', '2025-04-09 01:41:53'),
(13, 21, 2, '2025-04-08 18:08:45', '2025-04-08 18:08:45'),
(14, 26, 1, '2025-04-08 17:01:35', '2025-04-08 17:01:35'),
(14, 27, 1, '2025-04-08 17:05:22', '2025-04-08 17:05:22'),
(15, 28, 2, '2025-04-09 00:17:32', '2025-04-09 00:17:32'),
(16, 29, 1, '2025-04-08 09:12:43', '2025-04-08 09:12:43'),
(16, 30, 1, '2025-04-08 09:16:18', '2025-04-08 09:16:18'),
(17, 32, 3, '2025-04-09 00:05:47', '2025-04-09 00:05:47'),
(18, 34, 1, '2025-04-08 13:24:39', '2025-04-08 13:24:39'),
(18, 36, 1, '2025-04-08 13:27:52', '2025-04-08 13:27:52'),
(19, 38, 2, '2025-04-08 15:03:26', '2025-04-08 15:03:26'),
(20, 40, 1, '2025-04-09 00:55:43', '2025-04-09 00:55:43'),
(20, 41, 1, '2025-04-09 00:58:12', '2025-04-09 00:58:12'),
(20, 42, 1, '2025-04-09 01:02:37', '2025-04-09 01:02:37'),
(21, 43, 2, '2025-04-08 19:17:25', '2025-04-08 19:17:25'),
(22, 44, 1, '2025-04-09 02:49:33', '2025-04-09 02:49:33'),
(22, 45, 1, '2025-04-09 02:52:17', '2025-04-09 02:52:17'),
(22, 46, 1, '2025-04-09 02:58:42', '2025-04-09 02:58:42'),
(23, 48, 2, '2025-04-08 14:45:36', '2025-04-08 14:45:36'),
(24, 50, 1, '2025-04-08 10:20:17', '2025-04-08 10:20:17'),
(24, 51, 1, '2025-04-08 10:23:42', '2025-04-08 10:23:42'),
(25, 52, 3, '2025-04-09 00:04:15', '2025-04-09 00:04:15'),
(26, 54, 1, '2025-04-08 12:30:28', '2025-04-08 12:30:28'),
(26, 55, 1, '2025-04-08 12:32:51', '2025-04-08 12:32:51'),
(26, 56, 1, '2025-04-08 12:38:19', '2025-04-08 12:38:19'),
(27, 58, 2, '2025-04-08 17:54:22', '2025-04-08 17:54:22'),
(28, 60, 1, '2025-04-09 02:27:45', '2025-04-09 02:27:45'),
(28, 62, 1, '2025-04-09 02:31:17', '2025-04-09 02:31:17'),
(29, 64, 2, '2025-04-08 21:04:25', '2025-04-08 21:04:25'),
(30, 65, 1, '2025-04-08 23:14:37', '2025-04-08 23:14:37'),
(30, 66, 1, '2025-04-08 23:17:58', '2025-04-08 23:17:58'),
(31, 68, 3, '2025-04-09 01:22:33', '2025-04-09 01:22:33'),
(32, 70, 1, '2025-04-08 08:43:28', '2025-04-08 08:43:28'),
(32, 72, 1, '2025-04-08 08:47:12', '2025-04-08 08:47:12'),
(33, 74, 2, '2025-04-08 16:35:18', '2025-04-08 16:35:18'),
(34, 76, 1, '2025-04-09 00:42:45', '2025-04-09 00:42:45'),
(34, 78, 1, '2025-04-09 00:45:28', '2025-04-09 00:45:28'),
(34, 80, 1, '2025-04-09 00:49:12', '2025-04-09 00:49:12'),
(5, 82, 2, '2025-04-09 01:25:17', '2025-04-09 01:25:17'),
(8, 84, 1, '2025-04-08 16:18:43', '2025-04-08 16:18:43'),
(12, 86, 1, '2025-04-09 01:44:27', '2025-04-09 01:44:27'),
(20, 88, 2, '2025-04-09 01:05:42', '2025-04-09 01:05:42'),
(25, 90, 1, '2025-04-09 00:07:33', '2025-04-09 00:07:33'),
(30, 92, 1, '2025-04-08 23:21:16', '2025-04-08 23:21:16');

-- Commit the transaction
COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;
-- 07_datap2.sql
-- Part 2: Populates orders table
-- Current Date: 2025-04-09

START TRANSACTION;

-- Temporarily disable foreign key checks
SET FOREIGN_KEY_CHECKS=0;

-- Reset auto-increment values for orders table
ALTER TABLE orders AUTO_INCREMENT = 1;

-- =====================================================
-- ORDERS (100 rows)
-- =====================================================
INSERT INTO orders (CustomerID, OrderDate, OrderStatus, ShippingAddressID, BillingAddressID, SubTotal, TaxAmount, ShippingAmount, TotalAmount, IsFirstTimePurchase, CreatedAt, UpdatedAt) VALUES
(1, '2025-04-01 09:15:22', 'Delivered', 1, 1, 129.98, 10.40, 7.99, 148.37, FALSE, '2025-04-01 09:15:22', '2025-04-03 15:22:47'),
(2, '2025-04-01 10:23:45', 'Delivered', 3, 3, 79.99, 6.40, 7.99, 94.38, FALSE, '2025-04-01 10:23:45', '2025-04-03 16:45:12'),
(3, '2025-04-01 11:37:19', 'Delivered', 4, 4, 45.99, 3.68, 7.99, 57.66, TRUE, '2025-04-01 11:37:19', '2025-04-03 14:15:32'),
(4, '2025-04-01 12:45:32', 'Delivered', 6, 6, 159.97, 12.80, 0.00, 172.77, FALSE, '2025-04-01 12:45:32', '2025-04-03 18:12:51'),
(5, '2025-04-01 13:12:48', 'Delivered', 7, 7, 89.99, 7.20, 7.99, 105.18, FALSE, '2025-04-01 13:12:48', '2025-04-03 17:24:38'),
(6, '2025-04-01 14:28:51', 'Delivered', 8, 8, 64.97, 5.20, 7.99, 78.16, FALSE, '2025-04-01 14:28:51', '2025-04-03 19:15:27'),
(7, '2025-04-01 15:41:23', 'Delivered', 10, 10, 199.98, 16.00, 0.00, 215.98, FALSE, '2025-04-01 15:41:23', '2025-04-04 11:32:15'),
(8, '2025-04-01 16:15:47', 'Delivered', 11, 11, 75.98, 6.08, 7.99, 90.05, FALSE, '2025-04-01 16:15:47', '2025-04-04 10:24:32'),
(9, '2025-04-01 17:22:35', 'Delivered', 12, 12, 119.97, 9.60, 7.99, 137.56, FALSE, '2025-04-01 17:22:35', '2025-04-04 13:18:47'),
(10, '2025-04-01 18:34:12', 'Delivered', 14, 14, 49.99, 4.00, 7.99, 61.98, TRUE, '2025-04-01 18:34:12', '2025-04-04 12:45:23'),
(11, '2025-04-02 09:12:45', 'Delivered', 15, 15, 189.97, 15.20, 0.00, 205.17, FALSE, '2025-04-02 09:12:45', '2025-04-04 15:28:46'),
(12, '2025-04-02 10:34:26', 'Delivered', 17, 17, 99.99, 8.00, 7.99, 115.98, FALSE, '2025-04-02 10:34:26', '2025-04-04 16:42:19'),
(13, '2025-04-02 11:45:38', 'Delivered', 18, 18, 59.99, 4.80, 7.99, 72.78, FALSE, '2025-04-02 11:45:38', '2025-04-04 17:15:42'),
(14, '2025-04-02 12:52:14', 'Delivered', 19, 19, 149.98, 12.00, 0.00, 161.98, FALSE, '2025-04-02 12:52:14', '2025-04-04 18:23:45'),
(15, '2025-04-02 13:15:29', 'Delivered', 20, 20, 39.99, 3.20, 7.99, 51.18, TRUE, '2025-04-02 13:15:29', '2025-04-04 16:15:27'),
(16, '2025-04-02 14:27:41', 'Delivered', 22, 22, 89.97, 7.20, 7.99, 105.16, FALSE, '2025-04-02 14:27:41', '2025-04-04 19:12:38'),
(17, '2025-04-02 15:39:23', 'Delivered', 23, 23, 129.99, 10.40, 0.00, 140.39, FALSE, '2025-04-02 15:39:23', '2025-04-05 10:45:29'),
(18, '2025-04-02 16:52:18', 'Delivered', 25, 25, 69.99, 5.60, 7.99, 83.58, FALSE, '2025-04-02 16:52:18', '2025-04-05 11:34:26'),
(19, '2025-04-02 17:28:36', 'Delivered', 26, 26, 219.97, 17.60, 0.00, 237.57, FALSE, '2025-04-02 17:28:36', '2025-04-05 12:28:47'),
(20, '2025-04-02 18:45:17', 'Delivered', 27, 27, 79.98, 6.40, 7.99, 94.37, FALSE, '2025-04-02 18:45:17', '2025-04-05 14:15:38'),
(21, '2025-04-03 09:23:51', 'Delivered', 29, 29, 109.99, 8.80, 7.99, 126.78, FALSE, '2025-04-03 09:23:51', '2025-04-05 15:26:41'),
(22, '2025-04-03 10:42:19', 'Delivered', 30, 30, 179.98, 14.40, 0.00, 194.38, FALSE, '2025-04-03 10:42:19', '2025-04-05 16:34:25'),
(23, '2025-04-03 11:56:47', 'Delivered', 31, 31, 49.97, 4.00, 7.99, 61.96, TRUE, '2025-04-03 11:56:47', '2025-04-05 17:28:19'),
(24, '2025-04-03 12:34:25', 'Delivered', 33, 33, 139.97, 11.20, 0.00, 151.17, FALSE, '2025-04-03 12:34:25', '2025-04-05 18:12:43'),
(25, '2025-04-03 13:57:33', 'Delivered', 34, 34, 69.98, 5.60, 7.99, 83.57, FALSE, '2025-04-03 13:57:33', '2025-04-05 19:25:18'),
(26, '2025-04-03 14:45:19', 'Delivered', 35, 35, 199.99, 16.00, 0.00, 215.99, FALSE, '2025-04-03 14:45:19', '2025-04-06 10:34:47'),
(27, '2025-04-03 15:28:46', 'Delivered', 37, 37, 59.98, 4.80, 7.99, 72.77, FALSE, '2025-04-03 15:28:46', '2025-04-06 11:28:35'),
(28, '2025-04-03 16:12:38', 'Delivered', 38, 38, 129.97, 10.40, 0.00, 140.37, FALSE, '2025-04-03 16:12:38', '2025-04-06 12:45:27'),
(29, '2025-04-03 17:25:14', 'Delivered', 39, 39, 79.97, 6.40, 7.99, 94.36, FALSE, '2025-04-03 17:25:14', '2025-04-06 14:18:32'),
(30, '2025-04-03 18:39:28', 'Delivered', 40, 40, 149.99, 12.00, 0.00, 161.99, FALSE, '2025-04-03 18:39:28', '2025-04-06 15:26:19'),
(31, '2025-04-04 09:18:25', 'Delivered', 42, 42, 29.99, 2.40, 7.99, 40.38, TRUE, '2025-04-04 09:18:25', '2025-04-06 16:47:25'),
(32, '2025-04-04 10:42:37', 'Delivered', 43, 43, 169.97, 13.60, 0.00, 183.57, FALSE, '2025-04-04 10:42:37', '2025-04-06 17:35:42'),
(33, '2025-04-04 11:53:19', 'Delivered', 45, 45, 89.98, 7.20, 7.99, 105.17, FALSE, '2025-04-04 11:53:19', '2025-04-06 18:42:38'),
(34, '2025-04-04 12:35:47', 'Delivered', 46, 46, 119.99, 9.60, 0.00, 129.59, FALSE, '2025-04-04 12:35:47', '2025-04-07 10:15:26'),
(35, '2025-04-04 13:48:26', 'Delivered', 47, 47, 34.97, 2.80, 7.99, 45.76, TRUE, '2025-04-04 13:48:26', '2025-04-07 11:23:45'),
(36, '2025-04-04 14:29:38', 'Delivered', 48, 48, 159.98, 12.80, 0.00, 172.78, FALSE, '2025-04-04 14:29:38', '2025-04-07 12:34:56'),
(37, '2025-04-04 15:24:17', 'Delivered', 50, 50, 69.97, 5.60, 7.99, 83.56, FALSE, '2025-04-04 15:24:17', '2025-04-07 13:42:28'),
(38, '2025-04-04 16:38:26', 'Delivered', 51, 51, 219.98, 17.60, 0.00, 237.58, FALSE, '2025-04-04 16:38:26', '2025-04-07 14:25:36'),
(39, '2025-04-04 17:45:33', 'Delivered', 52, 52, 39.98, 3.20, 7.99, 51.17, FALSE, '2025-04-04 17:45:33', '2025-04-07 15:38:42'),
(40, '2025-04-04 18:26:48', 'Delivered', 54, 54, 189.99, 15.20, 0.00, 205.19, FALSE, '2025-04-04 18:26:48', '2025-04-07 16:45:27'),
(41, '2025-04-05 09:34:28', 'Delivered', 55, 55, 59.97, 4.80, 7.99, 72.76, FALSE, '2025-04-05 09:34:28', '2025-04-07 17:23:45'),
(42, '2025-04-05 10:45:36', 'Delivered', 56, 56, 139.98, 11.20, 0.00, 151.18, FALSE, '2025-04-05 10:45:36', '2025-04-07 18:12:34'),
(43, '2025-04-05 11:27:48', 'Delivered', 58, 58, 24.99, 2.00, 7.99, 34.98, TRUE, '2025-04-05 11:27:48', '2025-04-07 19:08:27'),
(44, '2025-04-05 12:38:25', 'Delivered', 59, 59, 199.97, 16.00, 0.00, 215.97, FALSE, '2025-04-05 12:38:25', '2025-04-08 10:25:36'),
(45, '2025-04-05 13:49:52', 'Delivered', 60, 60, 49.98, 4.00, 7.99, 61.97, FALSE, '2025-04-05 13:49:52', '2025-04-08 11:28:47'),
(46, '2025-04-05 14:27:39', 'Delivered', 62, 62, 129.98, 10.40, 0.00, 140.38, FALSE, '2025-04-05 14:27:39', '2025-04-08 12:35:41'),
(47, '2025-04-05 15:35:28', 'Shipped', 63, 63, 74.97, 6.00, 7.99, 88.96, FALSE, '2025-04-05 15:35:28', '2025-04-08 13:27:38'),
(48, '2025-04-05 16:28:47', 'Shipped', 64, 64, 179.99, 14.40, 0.00, 194.39, FALSE, '2025-04-05 16:28:47', '2025-04-08 14:15:26'),
(49, '2025-04-05 17:42:31', 'Shipped', 66, 66, 54.99, 4.40, 7.99, 67.38, FALSE, '2025-04-05 17:42:31', '2025-04-08 15:28:42'),
(50, '2025-04-05 18:35:47', 'Shipped', 67, 67, 99.98, 8.00, 7.99, 115.97, FALSE, '2025-04-05 18:35:47', '2025-04-08 16:35:28'),
(51, '2025-04-06 09:27:46', 'Shipped', 68, 68, 134.97, 10.80, 0.00, 145.77, FALSE, '2025-04-06 09:27:46', '2025-04-08 17:42:35'),
(52, '2025-04-06 10:38:25', 'Shipped', 70, 70, 79.96, 6.40, 7.99, 94.35, FALSE, '2025-04-06 10:38:25', '2025-04-08 18:26:47'),
(53, '2025-04-06 11:47:52', 'Shipped', 71, 71, 169.99, 13.60, 0.00, 183.59, FALSE, '2025-04-06 11:47:52', '2025-04-08 19:15:28'),
(54, '2025-04-06 12:28:36', 'Shipped', 72, 72, 44.98, 3.60, 7.99, 56.57, FALSE, '2025-04-06 12:28:36', '2025-04-08 13:42:28'),
(55, '2025-04-06 13:35:47', 'Shipped', 74, 74, 189.98, 15.20, 0.00, 205.18, FALSE, '2025-04-06 13:35:47', '2025-04-08 14:25:36'),
(56, '2025-04-06 14:28:39', 'Shipped', 75, 75, 39.97, 3.20, 7.99, 51.16, FALSE, '2025-04-06 14:28:39', '2025-04-08 15:38:42'),
(57, '2025-04-06 15:42:28', 'Shipped', 1, 1, 149.97, 12.00, 0.00, 161.97, FALSE, '2025-04-06 15:42:28', '2025-04-08 16:45:27'),
(58, '2025-04-06 16:35:47', 'Shipped', 3, 3, 29.98, 2.40, 7.99, 40.37, FALSE, '2025-04-06 16:35:47', '2025-04-08 17:23:45'),
(59, '2025-04-06 17:28:36', 'Shipped', 4, 4, 159.99, 12.80, 0.00, 172.79, FALSE, '2025-04-06 17:28:36', '2025-04-08 18:12:34'),
(60, '2025-04-06 18:35:28', 'Shipped', 6, 6, 18.99, 1.52, 7.99, 28.50, TRUE, '2025-04-06 18:35:28', '2025-04-08 19:08:27'),
(61, '2025-04-07 09:45:38', 'Processing', 7, 7, 209.97, 16.80, 0.00, 226.77, FALSE, '2025-04-07 09:45:38', '2025-04-07 09:45:38'),
(62, '2025-04-07 10:32:47', 'Processing', 8, 8, 49.96, 4.00, 7.99, 61.95, FALSE, '2025-04-07 10:32:47', '2025-04-07 10:32:47'),
(63, '2025-04-07 11:28:36', 'Processing', 10, 10, 109.98, 8.80, 0.00, 118.78, FALSE, '2025-04-07 11:28:36', '2025-04-07 11:28:36'),
(64, '2025-04-07 12:37:45', 'Processing', 11, 11, 64.98, 5.20, 7.99, 78.17, FALSE, '2025-04-07 12:37:45', '2025-04-07 12:37:45'),
(65, '2025-04-07 13:25:36', 'Processing', 12, 12, 179.97, 14.40, 0.00, 194.37, FALSE, '2025-04-07 13:25:36', '2025-04-07 13:25:36'),
(66, '2025-04-07 14:38:45', 'Processing', 14, 14, 14.99, 1.20, 7.99, 24.18, TRUE, '2025-04-07 14:38:45', '2025-04-07 14:38:45'),
(67, '2025-04-07 15:24:36', 'Processing', 15, 15, 219.96, 17.60, 0.00, 237.56, FALSE, '2025-04-07 15:24:36', '2025-04-07 15:24:36'),
(68, '2025-04-07 16:35:28', 'Processing', 17, 17, 34.96, 2.80, 7.99, 45.75, FALSE, '2025-04-07 16:35:28', '2025-04-07 16:35:28'),
(69, '2025-04-07 17:45:36', 'Processing', 18, 18, 89.96, 7.20, 0.00, 97.16, FALSE, '2025-04-07 17:45:36', '2025-04-07 17:45:36'),
(70, '2025-04-07 18:28:47', 'Processing', 19, 19, 59.96, 4.80, 7.99, 72.75, FALSE, '2025-04-07 18:28:47', '2025-04-07 18:28:47'),
(71, '2025-04-08 09:35:26', 'Pending', 20, 20, 119.98, 9.60, 0.00, 129.58, FALSE, '2025-04-08 09:35:26', '2025-04-08 09:35:26'),
(72, '2025-04-08 10:27:37', 'Pending', 22, 22, 19.98, 1.60, 7.99, 29.57, TRUE, '2025-04-08 10:27:37', '2025-04-08 10:27:37'),
(73, '2025-04-08 11:38:45', 'Pending', 23, 23, 169.96, 13.60, 0.00, 183.56, FALSE, '2025-04-08 11:38:45', '2025-04-08 11:38:45'),
(74, '2025-04-08 12:24:36', 'Pending', 25, 25, 39.96, 3.20, 7.99, 51.15, FALSE, '2025-04-08 12:24:36', '2025-04-08 12:24:36'),
(75, '2025-04-08 13:35:48', 'Pending', 26, 26, 99.97, 8.00, 0.00, 107.97, FALSE, '2025-04-08 13:35:48', '2025-04-08 13:35:48'),
(76, '2025-04-08 14:28:37', 'Pending', 27, 27, 69.96, 5.60, 7.99, 83.55, FALSE, '2025-04-08 14:28:37', '2025-04-08 14:28:37'),
(77, '2025-04-08 15:42:26', 'Pending', 29, 29, 139.96, 11.20, 0.00, 151.16, FALSE, '2025-04-08 15:42:26', '2025-04-08 15:42:26'),
(78, '2025-04-08 16:35:48', 'Pending', 30, 30, 9.99, 0.80, 7.99, 18.78, TRUE, '2025-04-08 16:35:48', '2025-04-08 16:35:48'),
(79, '2025-04-08 17:23:36', 'Pending', 31, 31, 199.96, 16.00, 0.00, 215.96, FALSE, '2025-04-08 17:23:36', '2025-04-08 17:23:36'),
(80, '2025-04-08 18:35:48', 'Pending', 33, 33, 29.97, 2.40, 7.99, 40.36, FALSE, '2025-04-08 18:35:48', '2025-04-08 18:35:48'),
(81, '2025-04-08 19:27:36', 'Cancelled', 34, 34, 79.95, 6.40, 0.00, 86.35, FALSE, '2025-04-08 19:27:36', '2025-04-08 20:15:28'),
(82, '2025-04-08 20:35:48', 'Cancelled', 35, 35, 49.95, 4.00, 7.99, 61.94, FALSE, '2025-04-08 20:35:48', '2025-04-08 21:22:36'),
(83, '2025-04-08 21:24:37', 'Cancelled', 37, 37, 129.96, 10.40, 0.00, 140.36, FALSE, '2025-04-08 21:24:37', '2025-04-08 22:15:48'),
(84, '2025-04-08 22:15:26', 'Cancelled', 38, 38, 4.99, 0.40, 7.99, 13.38, TRUE, '2025-04-08 22:15:26', '2025-04-08 23:05:37'),
(85, '2025-04-08 23:28:37', 'Cancelled', 39, 39, 159.96, 12.80, 0.00, 172.76, FALSE, '2025-04-08 23:28:37', '2025-04-09 00:18:26'),
(86, '2025-04-09 00:35:26', 'Returned', 40, 40, 54.96, 4.40, 7.99, 67.35, FALSE, '2025-04-09 00:35:26', '2025-04-09 02:05:26'),
(87, '2025-04-09 01:28:37', 'Returned', 42, 42, 109.97, 8.80, 0.00, 118.77, FALSE, '2025-04-09 01:28:37', '2025-04-09 02:45:37'),
(88, '2025-04-09 02:15:48', 'Returned', 43, 43, 24.98, 2.00, 7.99, 34.97, TRUE, '2025-04-09 02:15:48', '2025-04-09 03:15:48'),
(89, '2025-03-25 13:48:36', 'Returned', 45, 45, 179.96, 14.40, 0.00, 194.36, FALSE, '2025-03-25 13:48:36', '2025-03-28 15:25:36'),
(90, '2025-03-25 14:35:26', 'Returned', 46, 46, 44.97, 3.60, 7.99, 56.56, FALSE, '2025-03-25 14:35:26', '2025-03-28 16:18:26'),
(91, '2025-03-25 15:26:37', 'Delivered', 47, 47, 99.96, 8.00, 0.00, 107.96, FALSE, '2025-03-25 15:26:37', '2025-03-27 16:45:26'),
(92, '2025-03-25 16:48:26', 'Delivered', 48, 48, 59.95, 4.80, 7.99, 72.74, FALSE, '2025-03-25 16:48:26', '2025-03-27 17:35:26'),
(93, '2025-03-25 17:35:37', 'Delivered', 50, 50, 149.96, 12.00, 0.00, 161.96, FALSE, '2025-03-25 17:35:37', '2025-03-27 18:25:37'),
(94, '2025-03-25 18:24:36', 'Delivered', 51, 51, 39.95, 3.20, 7.99, 51.14, FALSE, '2025-03-25 18:24:36', '2025-03-27 19:15:26'),
(95, '2025-03-26 09:35:26', 'Delivered', 52, 52, 89.95, 7.20, 0.00, 97.15, FALSE, '2025-03-26 09:35:26', '2025-03-28 10:28:26'),
(96, '2025-03-26 10:48:37', 'Delivered', 54, 54, 69.95, 5.60, 7.99, 83.54, FALSE, '2025-03-26 10:48:37', '2025-03-28 11:35:26'),
(97, '2025-03-26 11:35:26', 'Delivered', 55, 55, 119.96, 9.60, 0.00, 129.56, FALSE, '2025-03-26 11:35:26', '2025-03-28 12:28:26'),
(98, '2025-03-26 12:28:37', 'Delivered', 56, 56, 29.96, 2.40, 7.99, 40.35, FALSE, '2025-03-26 12:28:37', '2025-03-28 13:15:26'),
(99, '2025-03-26 13:15:26', 'Delivered', 58, 58, 189.97, 15.20, 0.00, 205.17, FALSE, '2025-03-26 13:15:26', '2025-03-28 14:28:26'),
(100, '2025-03-26 14:35:37', 'Delivered', 59, 59, 34.95, 2.80, 7.99, 45.74, TRUE, '2025-03-26 14:35:37', '2025-03-28 15:35:26');

-- Commit the transaction
COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;

START TRANSACTION;

-- Temporarily disable foreign key checks
SET FOREIGN_KEY_CHECKS=0;

-- Reset auto-increment values for order items table
ALTER TABLE order_items AUTO_INCREMENT = 1;

-- ORDER ITEMS

INSERT INTO order_items (OrderID, ProductVariantID, Quantity, UnitPrice, SubTotal, CreatedAt, UpdatedAt) VALUES
(1, 5, 2, 49.99, 99.98, '2025-04-01 09:15:22', '2025-04-01 09:15:22'),
(1, 12, 1, 29.99, 29.99, '2025-04-01 09:15:22', '2025-04-01 09:15:22'),
(2, 8, 1, 79.99, 79.99, '2025-04-01 10:23:45', '2025-04-01 10:23:45'),
(3, 3, 1, 45.99, 45.99, '2025-04-01 11:37:19', '2025-04-01 11:37:19'),
(4, 7, 2, 39.99, 79.98, '2025-04-01 12:45:32', '2025-04-01 12:45:32'),
(4, 15, 1, 79.99, 79.99, '2025-04-01 12:45:32', '2025-04-01 12:45:32'),
(5, 10, 1, 89.99, 89.99, '2025-04-01 13:12:48', '2025-04-01 13:12:48'),
(6, 25, 3, 21.99, 65.97, '2025-04-01 14:28:51', '2025-04-01 14:28:51'),
(7, 2, 1, 99.99, 99.99, '2025-04-01 15:41:23', '2025-04-01 15:41:23'),
(7, 9, 1, 99.99, 99.99, '2025-04-01 15:41:23', '2025-04-01 15:41:23'),
(8, 14, 2, 37.99, 75.98, '2025-04-01 16:15:47', '2025-04-01 16:15:47'),
(9, 1, 1, 49.99, 49.99, '2025-04-01 17:22:35', '2025-04-01 17:22:35'),
(9, 11, 1, 39.99, 39.99, '2025-04-01 17:22:35', '2025-04-01 17:22:35'),
(9, 20, 1, 29.99, 29.99, '2025-04-01 17:22:35', '2025-04-01 17:22:35'),
(10, 6, 1, 49.99, 49.99, '2025-04-01 18:34:12', '2025-04-01 18:34:12'),
(11, 13, 1, 89.99, 89.99, '2025-04-02 09:12:45', '2025-04-02 09:12:45'),
(11, 17, 1, 49.99, 49.99, '2025-04-02 09:12:45', '2025-04-02 09:12:45'),
(11, 23, 1, 49.99, 49.99, '2025-04-02 09:12:45', '2025-04-02 09:12:45'),
(12, 4, 1, 99.99, 99.99, '2025-04-02 10:34:26', '2025-04-02 10:34:26'),
(13, 16, 1, 59.99, 59.99, '2025-04-02 11:45:38', '2025-04-02 11:45:38'),
(14, 19, 1, 49.99, 49.99, '2025-04-02 12:52:14', '2025-04-02 12:52:14'),
(14, 21, 2, 49.99, 99.99, '2025-04-02 12:52:14', '2025-04-02 12:52:14'),
(15, 26, 1, 39.99, 39.99, '2025-04-02 13:15:29', '2025-04-02 13:15:29'),
(16, 27, 1, 29.99, 29.99, '2025-04-02 14:27:41', '2025-04-02 14:27:41'),
(16, 28, 2, 29.99, 59.98, '2025-04-02 14:27:41', '2025-04-02 14:27:41'),
(17, 29, 1, 69.99, 69.99, '2025-04-02 15:39:23', '2025-04-02 15:39:23'),
(17, 30, 1, 59.99, 59.99, '2025-04-02 15:39:23', '2025-04-02 15:39:23'),
(18, 32, 1, 69.99, 69.99, '2025-04-02 16:52:18', '2025-04-02 16:52:18'),
(19, 34, 1, 79.99, 79.99, '2025-04-02 17:28:36', '2025-04-02 17:28:36'),
(19, 36, 1, 69.99, 69.99, '2025-04-02 17:28:36', '2025-04-02 17:28:36'),
(19, 38, 1, 69.99, 69.99, '2025-04-02 17:28:36', '2025-04-02 17:28:36'),
(20, 40, 1, 39.99, 39.99, '2025-04-02 18:45:17', '2025-04-02 18:45:17'),
(20, 41, 1, 39.99, 39.99, '2025-04-02 18:45:17', '2025-04-02 18:45:17'),
(21, 42, 1, 39.99, 39.99, '2025-04-03 09:23:51', '2025-04-03 09:23:51'),
(21, 43, 1, 29.99, 29.99, '2025-04-03 09:23:51', '2025-04-03 09:23:51'),
(21, 44, 1, 39.99, 39.99, '2025-04-03 09:23:51', '2025-04-03 09:23:51'),
(22, 45, 1, 89.99, 89.99, '2025-04-03 10:42:19', '2025-04-03 10:42:19'),
(22, 46, 1, 89.99, 89.99, '2025-04-03 10:42:19', '2025-04-03 10:42:19'),
(23, 48, 1, 49.97, 49.97, '2025-04-03 11:56:47', '2025-04-03 11:56:47'),
(24, 50, 1, 49.99, 49.99, '2025-04-03 12:34:25', '2025-04-03 12:34:25'),
(24, 51, 1, 39.99, 39.99, '2025-04-03 12:34:25', '2025-04-03 12:34:25'),
(24, 52, 1, 49.99, 49.99, '2025-04-03 12:34:25', '2025-04-03 12:34:25'),
(25, 54, 1, 34.99, 34.99, '2025-04-03 13:57:33', '2025-04-03 13:57:33'),
(25, 55, 1, 34.99, 34.99, '2025-04-03 13:57:33', '2025-04-03 13:57:33'),
(26, 56, 1, 199.99, 199.99, '2025-04-03 14:45:19', '2025-04-03 14:45:19'),
(27, 58, 2, 29.99, 59.98, '2025-04-03 15:28:46', '2025-04-03 15:28:46'),
(28, 60, 1, 39.99, 39.99, '2025-04-03 16:12:38', '2025-04-03 16:12:38'),
(28, 62, 1, 49.99, 49.99, '2025-04-03 16:12:38', '2025-04-03 16:12:38'),
(28, 64, 1, 39.99, 39.99, '2025-04-03 16:12:38', '2025-04-03 16:12:38'),
(29, 65, 1, 29.99, 29.99, '2025-04-03 17:25:14', '2025-04-03 17:25:14'),
(29, 66, 1, 24.99, 24.99, '2025-04-03 17:25:14', '2025-04-03 17:25:14'),
(29, 68, 1, 24.99, 24.99, '2025-04-03 17:25:14', '2025-04-03 17:25:14'),
(30, 70, 1, 149.99, 149.99, '2025-04-03 18:39:28', '2025-04-03 18:39:28'),
(31, 72, 1, 29.99, 29.99, '2025-04-04 09:18:25', '2025-04-04 09:18:25'),
(32, 74, 1, 69.99, 69.99, '2025-04-04 10:42:37', '2025-04-04 10:42:37'),
(32, 75, 1, 49.99, 49.99, '2025-04-04 10:42:37', '2025-04-04 10:42:37'),
(32, 76, 1, 49.99, 49.99, '2025-04-04 10:42:37', '2025-04-04 10:42:37'),
(33, 78, 1, 39.99, 39.99, '2025-04-04 11:53:19', '2025-04-04 11:53:19'),
(33, 80, 1, 49.99, 49.99, '2025-04-04 11:53:19', '2025-04-04 11:53:19'),
(34, 82, 1, 49.99, 49.99, '2025-04-04 12:35:47', '2025-04-04 12:35:47'),
(34, 84, 1, 69.99, 69.99, '2025-04-04 12:35:47', '2025-04-04 12:35:47'),
(35, 86, 1, 19.99, 19.99, '2025-04-04 13:48:26', '2025-04-04 13:48:26'),
(35, 88, 1, 14.98, 14.98, '2025-04-04 13:48:26', '2025-04-04 13:48:26'),
(36, 90, 1, 79.99, 79.99, '2025-04-04 14:29:38', '2025-04-04 14:29:38'),
(36, 92, 1, 79.99, 79.99, '2025-04-04 14:29:38', '2025-04-04 14:29:38'),
(37, 94, 1, 29.99, 29.99, '2025-04-04 15:24:17', '2025-04-04 15:24:17'),
(37, 96, 1, 39.98, 39.98, '2025-04-04 15:24:17', '2025-04-04 15:24:17'),
(38, 98, 1, 119.99, 119.99, '2025-04-04 16:38:26', '2025-04-04 16:38:26'),
(38, 100, 1, 99.99, 99.99, '2025-04-04 16:38:26', '2025-04-04 16:38:26'),
(39, 102, 1, 19.99, 19.99, '2025-04-04 17:45:33', '2025-04-04 17:45:33'),
(39, 104, 1, 19.99, 19.99, '2025-04-04 17:45:33', '2025-04-04 17:45:33'),
(40, 106, 1, 189.99, 189.99, '2025-04-04 18:26:48', '2025-04-04 18:26:48'),
(41, 108, 1, 29.99, 29.99, '2025-04-05 09:34:28', '2025-04-05 09:34:28'),
(41, 110, 1, 29.98, 29.98, '2025-04-05 09:34:28', '2025-04-05 09:34:28'),
(42, 112, 1, 69.99, 69.99, '2025-04-05 10:45:36', '2025-04-05 10:45:36'),
(42, 114, 1, 69.99, 69.99, '2025-04-05 10:45:36', '2025-04-05 10:45:36'),
(43, 116, 1, 24.99, 24.99, '2025-04-05 11:27:48', '2025-04-05 11:27:48'),
(44, 118, 1, 99.99, 99.99, '2025-04-05 12:38:25', '2025-04-05 12:38:25'),
(44, 120, 1, 49.99, 49.99, '2025-04-05 12:38:25', '2025-04-05 12:38:25'),
(44, 122, 1, 49.99, 49.99, '2025-04-05 12:38:25', '2025-04-05 12:38:25'),
(45, 124, 1, 24.99, 24.99, '2025-04-05 13:49:52', '2025-04-05 13:49:52'),
(45, 125, 1, 24.99, 24.99, '2025-04-05 13:49:52', '2025-04-05 13:49:52'),
(46, 126, 1, 64.99, 64.99, '2025-04-05 14:27:39', '2025-04-05 14:27:39'),
(46, 128, 1, 64.99, 64.99, '2025-04-05 14:27:39', '2025-04-05 14:27:39'),
(47, 130, 1, 34.99, 34.99, '2025-04-05 15:35:28', '2025-04-05 15:35:28'),
(47, 132, 1, 39.98, 39.98, '2025-04-05 15:35:28', '2025-04-05 15:35:28'),
(48, 134, 1, 179.99, 179.99, '2025-04-05 16:28:47', '2025-04-05 16:28:47'),
(49, 136, 1, 54.99, 54.99, '2025-04-05 17:42:31', '2025-04-05 17:42:31'),
(50, 138, 1, 49.99, 49.99, '2025-04-05 18:35:47', '2025-04-05 18:35:47'),
(50, 140, 1, 49.99, 49.99, '2025-04-05 18:35:47', '2025-04-05 18:35:47'),
(51, 142, 1, 44.99, 44.99, '2025-04-06 09:27:46', '2025-04-06 09:27:46'),
(51, 144, 1, 44.99, 44.99, '2025-04-06 09:27:46', '2025-04-06 09:27:46'),
(51, 146, 1, 44.99, 44.99, '2025-04-06 09:27:46', '2025-04-06 09:27:46'),
(52, 148, 2, 39.98, 79.96, '2025-04-06 10:38:25', '2025-04-06 10:38:25'),
(53, 150, 1, 169.99, 169.99, '2025-04-06 11:47:52', '2025-04-06 11:47:52'),
(54, 1, 1, 44.98, 44.98, '2025-04-06 12:28:36', '2025-04-06 12:28:36'),
(55, 3, 1, 94.99, 94.99, '2025-04-06 13:35:47', '2025-04-06 13:35:47'),
(55, 5, 1, 94.99, 94.99, '2025-04-06 13:35:47', '2025-04-06 13:35:47'),
(56, 7, 1, 39.97, 39.97, '2025-04-06 14:28:39', '2025-04-06 14:28:39'),
(57, 9, 1, 49.99, 49.99, '2025-04-06 15:42:28', '2025-04-06 15:42:28'),
(57, 11, 1, 49.99, 49.99, '2025-04-06 15:42:28', '2025-04-06 15:42:28'),
(57, 13, 1, 49.99, 49.99, '2025-04-06 15:42:28', '2025-04-06 15:42:28'),
(58, 15, 1, 29.98, 29.98, '2025-04-06 16:35:47', '2025-04-06 16:35:47'),
(59, 17, 1, 159.99, 159.99, '2025-04-06 17:28:36', '2025-04-06 17:28:36'),
(60, 19, 1, 18.99, 18.99, '2025-04-06 18:35:28', '2025-04-06 18:35:28'),
(61, 21, 1, 69.99, 69.99, '2025-04-07 09:45:38', '2025-04-07 09:45:38'),
(61, 23, 1, 69.99, 69.99, '2025-04-07 09:45:38', '2025-04-07 09:45:38'),
(61, 25, 1, 69.99, 69.99, '2025-04-07 09:45:38', '2025-04-07 09:45:38'),
(62, 27, 2, 24.98, 49.96, '2025-04-07 10:32:47', '2025-04-07 10:32:47'),
(63, 29, 1, 54.99, 54.99, '2025-04-07 11:28:36', '2025-04-07 11:28:36'),
(63, 31, 1, 54.99, 54.99, '2025-04-07 11:28:36', '2025-04-07 11:28:36'),
(64, 33, 1, 32.49, 32.49, '2025-04-07 12:37:45', '2025-04-07 12:37:45'),
(64, 35, 1, 32.49, 32.49, '2025-04-07 12:37:45', '2025-04-07 12:37:45'),
(65, 37, 1, 59.99, 59.99, '2025-04-07 13:25:36', '2025-04-07 13:25:36'),
(65, 39, 1, 59.99, 59.99, '2025-04-07 13:25:36', '2025-04-07 13:25:36'),
(65, 41, 1, 59.99, 59.99, '2025-04-07 13:25:36', '2025-04-07 13:25:36'),
(66, 43, 1, 14.99, 14.99, '2025-04-07 14:38:45', '2025-04-07 14:38:45'),
(67, 45, 1, 54.99, 54.99, '2025-04-07 15:24:36', '2025-04-07 15:24:36'),
(67, 47, 1, 54.99, 54.99, '2025-04-07 15:24:36', '2025-04-07 15:24:36'),
(67, 49, 1, 54.99, 54.99, '2025-04-07 15:24:36', '2025-04-07 15:24:36'),
(67, 51, 1, 54.99, 54.99, '2025-04-07 15:24:36', '2025-04-07 15:24:36'),
(68, 53, 2, 17.48, 34.96, '2025-04-07 16:35:28', '2025-04-07 16:35:28'),
(69, 55, 1, 44.98, 44.98, '2025-04-07 17:45:36', '2025-04-07 17:45:36'),
(69, 57, 1, 44.98, 44.98, '2025-04-07 17:45:36', '2025-04-07 17:45:36'),
(70, 59, 2, 29.98, 59.96, '2025-04-07 18:28:47', '2025-04-07 18:28:47'),
(71, 61, 1, 59.99, 59.99, '2025-04-08 09:35:26', '2025-04-08 09:35:26'),
(71, 63, 1, 59.99, 59.99, '2025-04-08 09:35:26', '2025-04-08 09:35:26'),
(72, 65, 1, 19.98, 19.98, '2025-04-08 10:27:37', '2025-04-08 10:27:37'),
(73, 67, 1, 56.65, 56.65, '2025-04-08 11:38:45', '2025-04-08 11:38:45'),
(73, 69, 1, 56.65, 56.65, '2025-04-08 11:38:45', '2025-04-08 11:38:45'),
(73, 71, 1, 56.66, 56.66, '2025-04-08 11:38:45', '2025-04-08 11:38:45'),
(74, 73, 2, 19.98, 39.96, '2025-04-08 12:24:36', '2025-04-08 12:24:36'),
(75, 75, 1, 49.99, 49.99, '2025-04-08 13:35:48', '2025-04-08 13:35:48'),
(75, 77, 1, 49.98, 49.98, '2025-04-08 13:35:48', '2025-04-08 13:35:48'),
(76, 79, 2, 34.98, 69.96, '2025-04-08 14:28:37', '2025-04-08 14:28:37'),
(77, 81, 1, 69.98, 69.98, '2025-04-08 15:42:26', '2025-04-08 15:42:26'),
(77, 83, 1, 69.98, 69.98, '2025-04-08 15:42:26', '2025-04-08 15:42:26'),
(78, 85, 1, 9.99, 9.99, '2025-04-08 16:35:48', '2025-04-08 16:35:48'),
(79, 87, 1, 49.99, 49.99, '2025-04-08 17:23:36', '2025-04-08 17:23:36'),
(79, 89, 1, 49.99, 49.99, '2025-04-08 17:23:36', '2025-04-08 17:23:36'),
(79, 91, 1, 49.99, 49.99, '2025-04-08 17:23:36', '2025-04-08 17:23:36'),
(79, 93, 1, 49.99, 49.99, '2025-04-08 17:23:36', '2025-04-08 17:23:36'),
(80, 95, 1, 29.97, 29.97, '2025-04-08 18:35:48', '2025-04-08 18:35:48'),
(81, 97, 1, 39.98, 39.98, '2025-04-08 19:27:36', '2025-04-08 19:27:36'),
(81, 99, 1, 39.97, 39.97, '2025-04-08 19:27:36', '2025-04-08 19:27:36'),
(82, 101, 1, 49.95, 49.95, '2025-04-08 20:35:48', '2025-04-08 20:35:48'),
(83, 103, 1, 42.99, 42.99, '2025-04-08 21:24:37', '2025-04-08 21:24:37'),
(83, 105, 1, 42.98, 42.98, '2025-04-08 21:24:37', '2025-04-08 21:24:37'),
(83, 107, 1, 43.99, 43.99, '2025-04-08 21:24:37', '2025-04-08 21:24:37'),
(84, 109, 1, 4.99, 4.99, '2025-04-08 22:15:26', '2025-04-08 22:15:26'),
(85, 111, 1, 53.32, 53.32, '2025-04-08 23:28:37', '2025-04-08 23:28:37'),
(85, 113, 1, 53.32, 53.32, '2025-04-08 23:28:37', '2025-04-08 23:28:37'),
(85, 115, 1, 53.32, 53.32, '2025-04-08 23:28:37', '2025-04-08 23:28:37'),
(86, 117, 1, 27.48, 27.48, '2025-04-09 00:35:26', '2025-04-09 00:35:26'),
(86, 119, 1, 27.48, 27.48, '2025-04-09 00:35:26', '2025-04-09 00:35:26'),
(87, 121, 1, 36.65, 36.65, '2025-04-09 01:28:37', '2025-04-09 01:28:37'),
(87, 123, 1, 36.66, 36.66, '2025-04-09 01:28:37', '2025-04-09 01:28:37'),
(87, 125, 1, 36.66, 36.66, '2025-04-09 01:28:37', '2025-04-09 01:28:37'),
(88, 127, 1, 24.98, 24.98, '2025-04-09 02:15:48', '2025-04-09 02:15:48'),
(89, 129, 1, 44.99, 44.99, '2025-03-25 13:48:36', '2025-03-25 13:48:36'),
(89, 131, 1, 44.99, 44.99, '2025-03-25 13:48:36', '2025-03-25 13:48:36'),
(89, 133, 1, 44.99, 44.99, '2025-03-25 13:48:36', '2025-03-25 13:48:36'),
(89, 135, 1, 44.99, 44.99, '2025-03-25 13:48:36', '2025-03-25 13:48:36'),
(90, 137, 1, 44.97, 44.97, '2025-03-25 14:35:26', '2025-03-25 14:35:26'),
(91, 139, 1, 49.98, 49.98, '2025-03-25 15:26:37', '2025-03-25 15:26:37'),
(91, 141, 1, 49.98, 49.98, '2025-03-25 15:26:37', '2025-03-25 15:26:37'),
(92, 143, 1, 59.95, 59.95, '2025-03-25 16:48:26', '2025-03-25 16:48:26'),
(93, 145, 1, 49.98, 49.98, '2025-03-25 17:35:37', '2025-03-25 17:35:37'),
(93, 147, 1, 49.99, 49.99, '2025-03-25 17:35:37', '2025-03-25 17:35:37'),
(93, 149, 1, 49.99, 49.99, '2025-03-25 17:35:37', '2025-03-25 17:35:37'),
(94, 2, 1, 39.95, 39.95, '2025-03-25 18:24:36', '2025-03-25 18:24:36'),
(95, 4, 1, 44.98, 44.98, '2025-03-26 09:35:26', '2025-03-26 09:35:26'),
(95, 6, 1, 44.97, 44.97, '2025-03-26 09:35:26', '2025-03-26 09:35:26'),
(96, 8, 1, 69.95, 69.95, '2025-03-26 10:48:37', '2025-03-26 10:48:37'),
(97, 10, 1, 59.98, 59.98, '2025-03-26 11:35:26', '2025-03-26 11:35:26'),
(97, 12, 1, 59.98, 59.98, '2025-03-26 11:35:26', '2025-03-26 11:35:26'),
(98, 14, 1, 29.96, 29.96, '2025-03-26 12:28:37', '2025-03-26 12:28:37'),
(99, 16, 1, 47.49, 47.49, '2025-03-26 13:15:26', '2025-03-26 13:15:26'),
(99, 18, 1, 47.49, 47.49, '2025-03-26 13:15:26', '2025-03-26 13:15:26'),
(99, 20, 1, 47.49, 47.49, '2025-03-26 13:15:26', '2025-03-26 13:15:26'),
(99, 22, 1, 47.50, 47.50, '2025-03-26 13:15:26', '2025-03-26 13:15:26'),
(100, 24, 1, 34.95, 34.95, '2025-03-26 14:35:37', '2025-03-26 14:35:37'),
(1, 26, 1, 37.99, 37.99, '2025-04-01 09:15:22', '2025-04-01 09:15:22'),
(2, 28, 1, 45.99, 45.99, '2025-04-01 10:23:45', '2025-04-01 10:23:45'),
(3, 30, 1, 35.99, 35.99, '2025-04-01 11:37:19', '2025-04-01 11:37:19'),
(4, 32, 1, 55.99, 55.99, '2025-04-01 12:45:32', '2025-04-01 12:45:32'),
(5, 34, 1, 65.99, 65.99, '2025-04-01 13:12:48', '2025-04-01 13:12:48'),
(6, 36, 1, 29.99, 29.99, '2025-04-01 14:28:51', '2025-04-01 14:28:51'),
(7, 38, 1, 59.99, 59.99, '2025-04-01 15:41:23', '2025-04-01 15:41:23'),
(8, 40, 1, 42.99, 42.99, '2025-04-01 16:15:47', '2025-04-01 16:15:47'),
(9, 42, 1, 38.99, 38.99, '2025-04-01 17:22:35', '2025-04-01 17:22:35'),
(10, 44, 1, 36.99, 36.99, '2025-04-01 18:34:12', '2025-04-01 18:34:12'),
(11, 46, 1, 48.99, 48.99, '2025-04-02 09:12:45', '2025-04-02 09:12:45'),
(12, 48, 1, 54.99, 54.99, '2025-04-02 10:34:26', '2025-04-02 10:34:26'),
(13, 50, 1, 44.99, 44.99, '2025-04-02 11:45:38', '2025-04-02 11:45:38'),
(14, 52, 1, 64.99, 64.99, '2025-04-02 12:52:14', '2025-04-02 12:52:14'),
(15, 54, 1, 28.99, 28.99, '2025-04-02 13:15:29', '2025-04-02 13:15:29'),
(16, 56, 1, 34.99, 34.99, '2025-04-02 14:27:41', '2025-04-02 14:27:41'),
(17, 58, 1, 49.99, 49.99, '2025-04-02 15:39:23', '2025-04-02 15:39:23'),
(18, 60, 1, 39.99, 39.99, '2025-04-02 16:52:18', '2025-04-02 16:52:18'),
(19, 62, 1, 59.99, 59.99, '2025-04-02 17:28:36', '2025-04-02 17:28:36'),
(20, 64, 1, 44.99, 44.99, '2025-04-02 18:45:17', '2025-04-02 18:45:17'),
(21, 66, 1, 39.99, 39.99, '2025-04-03 09:23:51', '2025-04-03 09:23:51'),
(22, 68, 1, 54.99, 54.99, '2025-04-03 10:42:19', '2025-04-03 10:42:19'),
(23, 70, 1, 34.99, 34.99, '2025-04-03 11:56:47', '2025-04-03 11:56:47'),
(24, 72, 1, 49.99, 49.99, '2025-04-03 12:34:25', '2025-04-03 12:34:25'),
(25, 74, 1, 39.99, 39.99, '2025-04-03 13:57:33', '2025-04-03 13:57:33'),
(26, 76, 1, 119.99, 119.99, '2025-04-03 14:45:19', '2025-04-03 14:45:19'),
(27, 78, 1, 34.99, 34.99, '2025-04-03 15:28:46', '2025-04-03 15:28:46'),
(28, 80, 1, 44.99, 44.99, '2025-04-03 16:12:38', '2025-04-03 16:12:38'),
(29, 82, 1, 29.99, 29.99, '2025-04-03 17:25:14', '2025-04-03 17:25:14'),
(30, 84, 1, 89.99, 89.99, '2025-04-03 18:39:28', '2025-04-03 18:39:28');

-- Commit the transaction
COMMIT;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=1;