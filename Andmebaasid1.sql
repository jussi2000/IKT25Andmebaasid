     
	    -- Tund 11.02.26 --
---------------------------------------

-- teeme andmebaas'i e. db(data Base)
create database IKT25TAR

-- KUS ON db?!?!??!?!?!?!
-- db oli 'Databases' all.(Folder'is)

--andmebaasi valimine
use IKT25TAR

-- andmebaasi kustutamine
drop database IKT25TAR

-- teeme uuesti andmebaasi IKT25TAR
create database IKT25TAR

-- teeme tabeli
create table Gender
(
-- Meil on muutuja Id,
-- Mis on täisarv andmetüüp,
-- kui sisestad andmed,
-- siis see veerg peab olema täidetud,
--btegemist on primaarvõtmega
id int not null primary key,
-- Veeru nimi on 'Gender',
-- 10 tähemärki on max pikkus,
-- andmed peavad olema siesestatud e.
-- ei tohi olla tühi
Gender nvarchar(10) not null
)

-- andmete sisestamine
-- proovige ise teha
-- Id 1, Gender = Male
-- Id 2, Gender = Female

insert into Gender (Id, Gender)
values (1, 'Male'),
(2, 'Female')

-- Vaatame tabeli sisu
-- '*' tähendab, et näita kõike seal sees olevat infot
select * from Gender

-- teeme uue tabeli nimega 'Person'
-- veeru nimed: Id int not null primary key,
-- Name: nvachar (30)
-- Email: nvachar (30)
-- GenderId int

create table Person
(
id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

-----------------------------
 -- tund nr 2 18.02.2026 --
-----------------------------

insert into Person (id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonerwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'CatWoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

-- näen tabelis olevat infot
select * from Person

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table person add constraint tblPerson_GenderId_FK
foreign key(GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla
-- väärtust, siis automaatselt sisestab sellele reale väärtuse 3
-- e. unknown
alter table person
add constraint DF_Person_GénderId
default 3 for GenderId

insert into Gender(id, Gender)
values (3, 'Unknown')

insert into Person(id, Name, Email, GenderId)
values (7, 'Black Panter', 'b@b.com', NULL)

insert into Person(id, Name, Email)
values (9, 'Spiderman', 'spider@man.com')

select * from Person

-- piirangu kasutamine
alter table person
drop constraint DF_Persons_GeñderId

-- kuidas lisada veergu tabelile Person
--veeru nimi on Age nvarchar(10)
alter table Person
add Age nvarchar(10)

alter table person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- kuidas uuendada andmeid
update Person
set Age = 159
where id = 7

select * from Person

-- soovin kustutada ühe rea
-- kuidas seda teha?

delete from Person where id = 8

-- lisame uue veeru City nvarchar(50)
alter table Person
add City nvarchar(50)

-- kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- kõik, kes ei ela Gothamis
select * from Person where City! = 'Gotham'
-- varjant nr 2. kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'

-- Näitab teatud vanusega inimesi
-- Valime 151, 35, 25

-- Vrs. 1
select * from Person where Age in (151, 35, 26)

-- Vrs. 2
select * from Person where Age = 151 or Age = 35 or Age = 26

-- Soovin näha inimesi vahemikus 22 kuni 41

-- Vrs. 1
select * from Person where Age between 22 and 41

-- Vrs. 2
select * from Person where Age >= 22 and Age <= 41

-- wildcard e. näitab kõik g-tähega linnad
select * from Person where City like 'G%'
-- otsib emailidm @-märgiga
select * from Person where Email like '%@%'

-- '%' näitab asukohta
-- tahan näha, kellel on emailis ees ja peale @-märki üks täht
select * from Person where Email like '_@_.%'

-- kõik, kelle nimes ei ole esimene täht W, A, S
select * from Person where Name like '[^WAS]%'

-- kõik, kes elavad Gothamis ja New Yorkis
-- vrs. 1
select * from Person where (City = 'Gotham' or City = 'New York')
-- vrs. 2
select * from Person where City in ('Gotham', 'New York')

-- kõik, kes elavad Gothamis ja New Yorkis ning peavad olema
-- vanemad, kui 29
-- vrs. 1
select * from Person where (City = 'Gotham' or City = 'New York') 
and Age >= 30
-- vrs. 2
select * from Person where (City = 'Gotham' or City = 'New York') 
and (Age > 29)

-- Kuvab tähestikulises järjekorras inimesi ja võtab aluseks
-- Name veeru
select * from Person
select * from Person order by Name

-- Võtab kolm esimest rida Person tabelist
select top 3 * from Person

---------------------------
 -- tund nr 3 25.02.2026 --
---------------------------

--näita esimesed 50% tabelist
select top 50 percent * from Person
select * from Person

--järjestab vanuse järgi isikud
select * from Person order by Age desc

--muudab Age muutuja int-ks ja näitab vanuselises järjestuses
-- cast abil saab andmetüüpi muuta
select * from Person order by cast(Age as int) desc

-- kõikide isikute koondvanus e liidab kõik kokku
select sum(cast(Age as int)) from Person

--kõige noorem isik tuleb üles leida
select min(cast(Age as int)) from Person

--kõige vanem isik
select max(cast(Age as int)) from Person

--muudame Age muutuja int peale
-- näeme konkreetsetes linnades olevate isikute koondvanust
select City, sum(Age) as TotalAge from Person group by City

--kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person 
alter column Name nvarchar(25)

-- kuvab esimeses reas välja toodud järjestuses ja kuvab Age-i 
-- TotalAge-ks
--järjestab City-s olevate nimede järgi ja siis Genderid järgi
--kasutada group by-d ja order by-d
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by City

--näitab, et mitu rida andmeid on selles tabelis
select count(*) from Person

--näitab tulemust, et mitu inimest on Genderid väärtusega 2
--konkreetses linnas
--arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as 
[Total Person(s)] from Person
where GenderId = '1'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 a ja
--kui palju neid igas linnas elab
--eristab inimese soo ära
select GenderId, City, sum(Age) as TotalAge, count(Id) as 
[Total Person(s)] from Person
where GenderId = '2'
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja Department
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

---
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
---

--arvutab k]ikide palgad kokku Employees tabelist
select sum(cast(Salary as int)) from Employees --arvutab kõikide palgad kokku
-- kõige väiksema palga saaja
select min(cast(Salary as int)) from Employees

--näitab veerge Location ja Palka. Palga veerg kuvatakse TotalSalary-ks
--teha left join Department tabeliga
--grupitab Locationiga
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

-----------------------------
 -- Tund nr 4  03.03.2026 --
-----------------------------

select * from Employees
select SUM(CAST(salary as int)) from Employees --arvutab kõikide palgad kokku

--lisame veeru City ja pikkus on 30
--employees tsbelisse lisada
alter table Employees
add city nvarchar(30)

select City, Gender, SUM(cast(salary as int)) as TotalSalary
from Employees
group by City, Gender

--peaaegu sama päring, aga linnad on tähestikulises järjestuses'
select City, Gender, SUM(cast(salary as int)) as TotalSalary
from Employees
group by City, Gender
order by City

select * from Employees
-- on vaja teada, et mitu inimest on nimekirjas selles tabelis
select count(*) from Employees

--mitu töötajat on soo ja linna kaupa töötamas
select City, Gender, SUM(cast(salary as int)) as TotalSalary,
count (id) as [Total Employee(s)]
from Employees
group by Gender, City

--kasutage kas naised või mehed kaupa
--kasutage where

select City, Gender, SUM(cast(salary as int)) as TotalSalary,
count (id) as [Total Employee(s)]
from Employees
where Gender = 'Female'
group by Gender, City

-- sama tulemuseda nagu eelmine kord, kasutage: having
select City, Gender, SUM(cast(salary as int)) as TotalSalary,
count (id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- kõik, kes teenivad rohkem, kui 4000
select * from Employees where sum(cast(salary as int)) > 4000

--teeme varjandi, kus saame tulemuse
select Gender,City, SUM(cast(salary as int)) as TotalSalary,
count (id) as [Total Employee(s)]
from Employees
group by Gender, City
having SUM(cast(salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
value nvarchar(20)
)
insert into Test1 values('x')
select * from Test1

-----------------------------
 -- Tund nr 5  04.03.2026 --
-----------------------------

-- kustutame veeru nimega 'City' Employee tabelist

alter table Employees
drop column City

-- inner join
-- kuvab neid kellel on departmenName all, olemas väärtus
-- mitte kattuvad read eemaldatakse tulemusest
-- ja sellepärast ei näidata Jamesi ja Russelit tabelis
-- kuna neil on DepartmentId NULL
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.id

-- left join 
select Name, Gender, Salary, DepartmentName
from Employees
left join Department -- võib kasutada ka LEFT OUTER JOIN'i
on Employees.DepartmentId = Department.Id
--urige, mis on left join:
-- Left join on vahend mis ühendab kaks tabelit nii,
-- et tulemuses säilivad kõik read vasakpoolsest tabelist
-- e. 'Employees' tabelist,
-- olemata sellest, kas neile leiti parempoolsest tabelist
-- e. Department tabelist vastavus või mitte.

-- Lühem seletus:
-- näitab andmeid, kus vasakpoolsest tabelist isegi, siis kui
-- seal puudub võõrvõtme reas väärus

-- right join
select Name, Gender, Salary, DepartmentName
from Employees
right join Department -- võib kasutada ka RIGHT OUTER JOIN'i
on Employees.DepartmentId = Department.id
-- Right join näitab paremas(DEPARTMENT) tabelis olevaid väärtuseid,
-- mis ei ühti vasaku(EMPLOYEES) tabeliga.

-- outer join
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.id
-- mõlema tabeli read kuvab

-- teha cross join:
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department
--korrutab kõik omavahel läbi

-- teha left join, kus Employees tabelist DepartmentId on null:
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- teine variant ja sama tulemus
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.id is null

-- näitab aniult neid, kellel on vasakus tabelis (Employees)
-- DepartmentId null
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
-- näitab ainult paremas tabelis olevat rida,
-- mis ei kattu Employees'ga.

-- full Join
-- mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where employees.DepartmentId is null
or Department.id is null

--teete AdventureWorksLT2019 andmebaasile join päringuid:
-- inner-,Left-, Right-, cross- ja full join
-- tabeleid sellesse andmebaasi juurde ei tohi teha AdventureWorksLT2019

--Õpetaja kood--
------------------
--inner Join
-- mõnikurd peab muutuja ette kirjutama tabeli nimetuse
-- nagu on product.Name, et editor saaks aru, et kumma 
-- tabeli muutujat soovitakse kasutada ja ei tekiks segadust
select Product.name as [Product Name], ProductNumber, ListPrice
, ProductModel.Name as [Product Model Name], Product.ProductModelID,
ProductModel.ProductModelID
-- mõnikord peab ka tabeli ette kirjutama 
-- täpsustama infio nagu SalesLT.Product
from SalesLT.Product 
inner join SalesLT.ProductModel
-- antud juhul Producti tabelis ProductModelId võõrvõti,
-- mis ProductModeli tabelis on primaarvõti
on Product.ProductModelId = ProductModel.ProductModelId

-- left join

-- right join

-- full join

-- cross join

--------------------------------------------------------

--Oma kood--
------------------
-- inner join
select p.Name AS ProductName, pc.Name AS CategoryName
from SalesLT.Product p
inner join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

-- left join
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
left join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

-- right join
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
right join SalesLT.Prod+uctCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

-- full join
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
full join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

-- cross join
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
cross join SalesLT.ProductCategory pc