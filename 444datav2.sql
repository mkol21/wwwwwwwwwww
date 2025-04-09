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