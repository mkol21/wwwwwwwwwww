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