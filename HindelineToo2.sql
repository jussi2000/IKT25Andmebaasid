-- Hindeline töö2 --

-- 1.
select count(*) from SalesLT.Customer

-- 2.
select count_big(*) from SalesLT.SalesOrderHeader

-- 3.
select max(cast(TotalDue as int)) from SalesLT.SalesOrderHeader

select * from SalesLT.SalesOrderHeader

-- 4.
select min(cast(TotalDue as int)) from SalesLT.SalesOrderHeader

-- 5.
select SUM(cast(TotalDue as int)) from SalesLT.SalesOrderHeader

--6 
select count(cast(ListPrice as int)) from SalesLT.Product where ListPrice >= 100

select * from SalesLT.Product

--7.
select max(cast(ListPrice as int)) from SalesLT.Product where ListPrice >= 1000

--8.
select min(cast(ListPrice as int)) from SalesLT.Product where ListPrice >= 0

--9.
select sum(cast(ListPrice as int)) from SalesLT.Product where 
Color is not null

--10.
select count(*) from SalesLT.Customer where ModifiedDate >= '2010'

select * from SalesLT.Customer

--11.
select Min(ModifiedDate) from SalesLT.SalesOrderDetail where ModifiedDate <= '2009'

--12.
select CustomerId, SUM(TotalDue) as TotalDue from SalesLT.SalesOrderHeader group by CustomerId

select * from SalesLT.SalesOrderHeader

--13.


--14.


--15.
