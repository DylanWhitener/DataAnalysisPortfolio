-- Easy Question difficulty
-- 1: Show the category_name and description from the categories table sorted by category_name.
select
	category_name,
    description
from categories
order by category_name

-- 2: Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
select
	contact_name,
    address,
    city
from customers
where
	country NOT IN ('Germany', 'Mexico', 'Spain')
    
-- 3: Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
select
	order_date,
    shipped_date,
    customer_id,
    freight
from orders
Where
	order_date = '2018-02-26'

-- 4: Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date
select
	employee_id,
    order_id,
    customer_id,
    required_date,
    shipped_date
from orders
where
	shipped_date > required_date
    
-- 5: Show all the even numbered Order_id from the orders table
select
	order_id
from orders
where
	mod(order_id,2) = 0 --- same as order_id % 2 = 0

-- 6: Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' 
-- in the city name, sorted by contact_name
select
	city,
    company_name,
    contact_name
from customers
where
	city like '%L%'
order by contact_name

-- 7: Show the company_name, contact_name, fax number of all customers that has a fax number. (not null) 
select
	company_name,
    contact_name,
    fax
From customers
where
	fax is not null

-- 8: Show the first_name, last_name. hire_date of the most recently hired employee.
select
	first_name,
    last_name,
    Max(hire_date) as hire_date
from employees

-- 9: Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.
select
	Round(avg(unit_price),2) as avg_unit_price,
    sum(units_in_stock) as total_units_in_stock,
    sum(discontinued) as total_discontinued
from products

-- Medium Question difficulty
-- 1: Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
select
	prod.product_name,
    cat.category_name,
    sup.company_name
from products prod
join categories cat on prod.category_id = cat.category_id
join suppliers sup on prod.supplier_id = sup.supplier_id

-- 2: Show the category_name and the average product unit price for each category rounded to 2 decimal places.
select
	cat.category_name,
    round(avg(prod.unit_price),2) as avg_product_unit_price
from categories cat
join products prod ON cat.category_id = prod.category_id
group by category_name

-- 3: Show the city, company_name, contact_name from the customers and suppliers table merged together.
-- Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
select
	city,
    company_name,
    contact_name,
    'customers' as description
from customers
union
select
	city,
    company_name,
    contact_name,
    'suppliers'
from suppliers

-- Hard Question difficulty
-- 1: Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, 
-- and a column called "Shipped" that displays "On Time" if the order shipped on time and "Late" if the order shipped late.

-- Order by employee last_name, then by first_name, and then descending by number of orders.
select
	employees.first_name,
    employees.last_name,
    count(order_id) as num_orders,
    (case when shipped_date < required_date Then 'On Time'
     else 'Late'
     END) as Shipped
from employees
join orders on employees.employee_id = orders.employee_id
group by
	employees.first_name,
    employees.last_name,
    Shipped
order by
	employees.last_name,
    employees.first_name,
    num_orders desc
