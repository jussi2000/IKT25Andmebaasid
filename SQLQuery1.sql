-- HINDELINE TÖÖ --

-- 1.
select ProductID, Name, ListPrice, Weight
from SalesLT.Product
where Weight > 500 and ListPrice > 500

--2.


--3.
select Name, ListPrice, DiscountPrice =  ListPrice * 0.85
from SalesLT.Product


--4.
select Name, ListPrice, PriceWithVAT =  ListPrice * 0.22
from SalesLT.Product

--5.
create procedure procedure3
as begin
    select ProductId, Name
    from SalesLT.Product
    where ProductId = 771
end

exec procedure3

--6.
create procedure procedure2222
as begin
    select ProductId, Name, ListPrice, ProductCategoryID
    from SalesLT.Product
    where ProductCategoryID = 35
end

exec procedure2222
