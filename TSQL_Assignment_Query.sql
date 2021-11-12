/1. create a table-valued function that returns a list of orders including order id, customer id, order status, store id and staff id for the given year range/

select * from SALES.orders;

CREATE FUNCTION orders_in_range (
    @start_year datetime,
    @end_year datetime	
)
RETURNS TABLE
AS
RETURN
    SELECT 
        order_id,
		customer_id,
        order_status,
		store_id,
		staff_id
		
    FROM
        sales.orders
    WHERE
        year(order_date) BETWEEN @start_year AND @end_year

SELECT 
    order_id,
		customer_id,
        order_status,
		store_id,
		staff_id
FROM 
    orders_in_range(2017,2018)

/2.  create a trigger that logs all removed records of customers table/

CREATE TABLE Deleted_Entry_Logs(
    customer_id int,
	first_name varchar(255),
    last_name varchar(255),
    phone varchar(12),
	email varchar(20),
	street varchar(30),
	city varchar(15),
	state varchar(20),
	zip_code int,
);

CREATE TRIGGER Customer_Delete_Trigger
ON sales.customers
FOR DELETE
AS
BEGIN
INSERT INTO Deleted_Entry_Logs(customer_id, First_name, last_name, phone, email, street, city, state, zip_code)
select customer_id, first_name, last_name, phone, email, street, city, state, zip_code from deleted
select * from Deleted_Entry_Logs
END;

SELECT * FROM sales.customers;
DELETE from sales.customers 
WHERE customer_id = 2;