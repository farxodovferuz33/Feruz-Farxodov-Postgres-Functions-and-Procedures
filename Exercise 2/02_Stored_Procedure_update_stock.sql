-- 02_Stored_Procedures.sql
-- Stored procedure to update UnitsInStock for a given product ID

CREATE OR REPLACE PROCEDURE update_stock(product_id INT, quantity INT)
AS $$
BEGIN
    -- Update the stock by setting the UnitsInStock
    UPDATE northwind.products
    SET UnitsInStock = UnitsInStock + quantity
    WHERE ProductID = product_id;

    -- Check if the stock went negative and set it to 0 if so
    UPDATE northwind.products
    SET UnitsInStock = 0
    WHERE ProductID = product_id AND UnitsInStock < 0;
END;
$$ LANGUAGE plpgsql;

-- Test the procedure with product ID 11
CALL update_stock(11, 20);
