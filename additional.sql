use ShopDB;

-- Joins
select e.FName as Employees, null as Customers, sum(totalprice) as TP
from orders as o
join orderdetails as od on od.orderID = o.OrderID 
Join employees as e on o.EmployeeID = e.EmployeeID
Join customers as c on o.CustomerNo = c.customerNo
group by Employees
having TP > 1000
union 
select null as Employees, c.FName as Customers, sum(totalprice) as TP
from orders as o
join orderdetails as od on od.orderID = o.OrderID
Join employees as e on o.EmployeeID = e.EmployeeID 
Join customers as c on o.CustomerNo = c.customerNo
group by Customers
having TP > 1000;

-- Вложенные запросы
create temporary table tmpCust
select 	(select FName from customers as c where c.CustomerNo = 
					(select o.CustomerNo from orders as o where o.OrderID = od.OrderID)) as Customers,
		(select FName from employees as e where e.EmployeeID = 
					(select o.EmployeeID from orders as o where o.OrderID = od.OrderID)) as Employees,
        totalPrice
from orderdetails as od;
select * from tmpCust;
drop temporary table tmpCust, tmpEmp;
create temporary table tmpEmp
select (select FName from customers as c where c.CustomerNo = 
					(select o.CustomerNo from orders as o where o.OrderID = od.OrderID)) as Customers,
		(select FName from employees as e where e.EmployeeID = 
					(select o.EmployeeID from orders as o where o.OrderID = od.OrderID)) as Employees,
		totalPrice
from orderdetails as od;
select * from tmpEmp;

select Customers, null as Employees, sum(totalPrice) as TP from tmpCust
group by Customers
having TP > 1000
union
select null as Customers, Employees, sum(totalPrice) as TP from tmpEmp
group by Employees
having TP > 1000;