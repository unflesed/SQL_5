use ShopDB;

select e.FName, c.FName, totalPrice  from orders as o
join orderdetails as od on od.orderID = o.OrderID
Join customers as c on o.CustomerNo = c.customerNo
Join employees as e on o.EmployeeID = e.EmployeeID
where totalprice > 1000;

select 	(select FName from customers as c where c.CustomerNo = o.CustomerNo) as Customer,
		(select FName from employees as e where o.EmployeeID = e.EmployeeID) as Employee
from orders as o
join orderdetails as od on od.orderID = o.OrderID
where totalprice > 1000;