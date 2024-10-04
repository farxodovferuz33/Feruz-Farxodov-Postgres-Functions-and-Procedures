-- 04_Cursors.sql
-- PL/pgSQL block to use a cursor to calculate totals for orders

DO $$
DECLARE
    order_cursor CURSOR FOR SELECT OrderID FROM northwind.orders;
    current_order_id INT;
    order_total NUMERIC;
BEGIN
    -- Open the cursor
    OPEN order_cursor;

    -- Loop through the orders using the cursor
    LOOP
        -- Fetch each order ID
        FETCH order_cursor INTO current_order_id;
        
        -- Exit the loop when no more rows are found
        EXIT WHEN NOT FOUND;

        -- Calculate the total using the function
        SELECT calculate_order_total(current_order_id) INTO order_total;

        -- Output the total for each order
        RAISE NOTICE 'Order ID: %, Total: %', current_order_id, order_total;
    END LOOP;

    -- Close the cursor
    CLOSE order_cursor;
END $$;
