-- 03_Triggers.sql
-- Create a table to log price updates

CREATE TABLE northwind.price_update_log (
    LogID serial PRIMARY KEY,
    ProductID INT,
    OldPrice NUMERIC(10, 2),
    NewPrice NUMERIC(10, 2),
    UpdateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a trigger function to log the price update
CREATE OR REPLACE FUNCTION log_price_update() 
RETURNS TRIGGER AS $$
BEGIN
    -- Insert the old and new price into the price_update_log table
    INSERT INTO northwind.price_update_log (ProductID, OldPrice, NewPrice)
    VALUES (NEW.ProductID, OLD.UnitPrice, NEW.UnitPrice);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger that will call the function on price update
CREATE TRIGGER trigger_log_price_update
AFTER UPDATE OF UnitPrice ON northwind.products
FOR EACH ROW
EXECUTE FUNCTION log_price_update();

-- Test the trigger by updating the UnitPrice for product ID 11
UPDATE northwind.products
SET UnitPrice = 22.50
WHERE ProductID = 11;

-- Verify the log
SELECT * FROM northwind.price_update_log;
