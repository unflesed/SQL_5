use ShopDB;

-- Joins
select e.FName as Employees, c.FName as Customers, sum(totalprice) as TP
from orders as o
join orderdetails as od on od.orderID = o.OrderID
Join customers as c on o.CustomerNo = c.customerNo
Join employees as e on o.EmployeeID = e.EmployeeID
group by employees, customers
having TP > 1000;

-- Вложенные запросы
select 	(select FName from customers as c where c.CustomerNo = o.CustomerNo) as Customers,
		(select FName from employees as e where o.EmployeeID = e.EmployeeID) as Employees,
        sum(TotalPrice) as TP
from orders as o
join orderdetails as od on od.orderID = o.OrderID
group by EmployeeID, CustomerNo 
having TP > 1000;