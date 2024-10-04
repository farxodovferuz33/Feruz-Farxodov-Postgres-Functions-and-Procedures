-- 01_Functions.sql
-- Function to calculate the total for a given order ID

CREATE OR REPLACE FUNCTION calculate_order_total(order_id INT) 
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC := 0;
BEGIN
    -- Calculate total by summing (UnitPrice * Quantity * (1 - Discount))
    SELECT SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
    INTO total
    FROM northwind.order_details od
    WHERE od.OrderID = order_id;

    -- Return the total value
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Test the function with order ID 10248 which doesnt exists and returns null testing with existing
SELECT calculate_order_total(1);