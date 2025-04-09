# GAP Retail Database Population Guidelines

## Core Principles
- Maintain schema structure consistency and naming conventions
- Prioritize data integrity through foreign key relationships and constraints
- Ensure code compatibility and interoperability
- Frame solutions within retail business context (online, in-store, pickup)
- Optimize SQL queries for performance and readability
- Ensure transactional accuracy for inventory and sales data

## File Structure and Population Plan

1. **01_base_tables.sql**
   - Categories (50 rows)
   - Payment methods (15 rows)
   - Payment status (10 rows)

2. **02_locations.sql**
   - Warehouses (50 rows)
   - Stores (50 rows)

3. **03_suppliers_and_customers.sql**
   - Suppliers (30 rows)
   - Customers (50 rows)
   - Addresses (75 rows)
   - Loyalty accounts (50 rows)

4. **04_products_main.sql**
   - Products (50 rows)
   - Product categories (75 rows)

5. **05_product_variants.sql**
   - Product variants (150 rows)

6. **06_inventory.sql**
   - Inventory levels (300+ rows)

7. **07_carts_and_orders.sql**
   - Shopping carts (35 rows)
   - Shopping cart items (70 rows)
   - Orders (100 rows)
   - Order items (250 rows)

8. **08_fulfillment.sql**
   - Payments (100 rows)
   - Shipments (80 rows)
   - Shipment items (160 rows)

9. **09_returns_and_promos.sql**
   - Returns (20 rows)
   - Return items (30 rows)
   - Promotions (20 rows)
   - Promotion applications (40 rows)
   - Order promotions (30 rows)

10. **10_operations.sql**
    - Warehouse stock transfers (25 rows)
    - Store inventory replenishment (40 rows)
    - Supplier orders (20 rows)
    - Supplier order items (60 rows)
    - GAP cash (25 rows)

11. **11_analytics.sql**
    - Sales analytics (100 rows)
    - Order tracking (150 rows)

## Implementation Notes
- Use `START TRANSACTION;` and `COMMIT;` blocks for all data insertions
- Include `SET FOREIGN_KEY_CHECKS=0;` before batch inserts
- Reset with `SET FOREIGN_KEY_CHECKS=1;` after completion
- Use proper ALTER TABLE statements to reset auto-increment values
- Maintain referential integrity across all relationships
- Generate data reflecting actual GAP products, pricing, and operations
- Follow logical business sequences for dates and timestamps

## Status Distribution Guidelines
- Orders:
  - 55% Delivered
  - 15% Shipped
  - 10% Processing
  - 10% Pending
  - 5% Cancelled
  - 5% Returned

- Payments:
  - 80% Completed
  - 10% Pending
  - 5% Failed
  - 5% Refunded

- Shipments:
  - 60% Delivered
  - 15% In Transit
  - 10% Processing
  - 10% Ready for Pickup
  - 5% Failed

## CRITICAL IMPLEMENTATION NOTE
🚨 IMPORTANT: EVERY SINGLE FILE MUST CONTAIN A COMPLETE SET OF ENTRIES.
- NO ENTRIES WILL BE SKIPPED FOR BREVITY UNDER ANY CIRCUMSTANCES( DOES NOT INCLUDE COMMENTS, WHICH CAN BE REMOVED FOR BREVITY) 
- EACH FILE MUST HAVE THE FULL SPECIFIED NUMBER OF ROWS
- GENERATE COMPLETE, REALISTIC, AND FULLY POPULATED DATA SETS
- COMMENTS CAN BE REMOVED FOR BREVITY, NOT DATA

## Final Verification
- Balance inventory across warehouses and stores realistically
- Create logical promotion utilization patterns
- Test all data for schema compliance before submission
- Confirm EVERY row is unique, meaningful, and representative of actual business operations