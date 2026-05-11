--175. Combine Two Tables
select firstName, lastName, city, state
from Person 
left join Address on Person.personId = Address.personId;

--181. Employees Earning More Than Their Managers
select e.name as Employee
from Employee e
join Employee m on e.managerId = m.id
where e.salary > m.salary;

--183. Customers Who Never Order
select c.name as Customers
from Customers c
left join Orders o on c.id = o.customerId
where o.id is null;

--197 Rising Temperature
from Weather w1
left join Weather w2 on w2.recordDate = w1.recordDate + 1
where w2.temperature > w1.temperature;
