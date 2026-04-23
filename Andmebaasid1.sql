     
	    -- Tund nr 1 11.02.26 --
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
--      vvv     --
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

  --Minu kood--
------------------
--     vvv
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

-----------------------------
 -- Tund nr 6  12.03.2026 --
-----------------------------

--isnull funktsiooni kasutamine
select Isnull('Ingvar','No Manager') as Manager

-- NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

alter table Employees
add ManagerId int

-- neile, kellel ei ole ülemust, siis paneb neile 'No Manager' teksti
-- Kasutage left join

select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- kasutame inner joini
--kuvab ainult ManagerId all olevate isikute väärtuseid
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

-- kõik saavad kõikide ülemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

--lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

--muudame olemasoleva veeru nimetust
sp_rename 'Employees.Name','FirstName'

-- Lisame Employees tabelisse MiddleName ning LastName
UPDATE Employees 
SET FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
WHERE Id = 1;

UPDATE Employees 
SET FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
WHERE Id = 2;

UPDATE Employees 
SET FirstName = 'John', MiddleName = NULL, LastName = NULL
WHERE Id = 3;

UPDATE Employees 
SET FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
WHERE Id = 4;

UPDATE Employees 
SET FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
WHERE Id = 5;

UPDATE Employees 
SET FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
WHERE Id = 6;

UPDATE Employees 
SET FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
WHERE Id = 7;

UPDATE Employees 
SET FirstName = 'Valarine', MiddleName = 'Balerine', LastName = NULL
WHERE Id = 8;

UPDATE Employees 
SET FirstName = 'James', MiddleName = '007', LastName = 'Bond'
WHERE Id = 9;

UPDATE Employees 
SET FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
WHERE Id = 10;

-- igast reast võtab esimesena täidetud lahtri ja kuvab ainult seda
--
select * from Employees
select Id, coalesce(FirstName, MiddleName, LastName) AS Name
from Employees

--loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

-- sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam','S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam','S@S.com')

select * from IndianCustomers
select * from UKCustomers

-- kasutame union all, mis näitab kõiki ridu
-- union all ühendab tabeleid ja näitab sisu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

-- korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

-- kasutad union all, aga sorteerid nime järgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

-- stored procedure
-- tavaliselt pannakse nimetuse ette 'sp', mis tähendab stored procetures
create procedure spGetEmployees
as begin
    select FirstName, Gender from Employees
end

--nüüd saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepatment
--'@' tähendab muutujat
@Gender nvarchar(20),
@DepartmentId int
as begin
    select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--kui nüüd allolevate käsklust käima panna, siis nõuab gender parameetrit
spGetEmployeesByGenderAndDepatment

--õige varjant
spGetEmployeesByGenderAndDepatment 'Male', 1

--niimoodi saab sp kirja pandud järjekorrast
spGetEmployeesByGenderAndDepatment @DepartmentId = 1, @Gender ='Male'

---saab vaadata sp sisu result vates
sp_helptext spGetEmployeesByGenderAndDepatment

--kuidas muuta sp-d ja panna sinna võti peale, et
--keegi peale teie ei saaks muuta kuskile tuleb lisada with encryption
alter proc spGetEmployeesByGenderAndDepatment
@Gender nvarchar(20),
@DepartmentId int
with encryption
as begin
    select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
     select @EmployeeCount = COUNT(Id) from Employees where Gender = @Gender
end

-- annab tulemuse, kus loendab ära nõuetele vastavad read
-- prindib ka tulemuse kirja teel
-- tuleb teha declare muutuja @TotalCount, mis on int
declare @TotalCount int
-- execute spGetEmployeeCountByGender sp, kus on parameetrid Male ja TotalCount
execute spGetEmployeeCountByGender 'Male', @TotalCount out 
-- if ja else, kui TotalCount = 0, siis tuleb tekst TotalCount is null
if (@TotalCount = 0)
    print '@TotalCount is null'
else 
    print '@TotalCount is null'
print @TotalCount
--Lõpus kasuta printi @TotalCounti puhul

-----------------------------
 -- Tund nr 7  17.03.2026 -- 
-----------------------------

-- Näitab ära, mitu rida vastab nõuetele

-- deklareerime muutuja @TotalCount, mis on int admetüüp
declare @TotalCount int
-- käivitame stored procedure spGetEmployeeCountByGender,
-- kus on parameetrid
-- @EmployeeCount = @TotalCount out ja @Gender
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out,
@Gender = 'Female'
-- prindib konsooli välja, kui TotalCount on null või mitte null
print @TotalCount

-- sp sisu vaatamine
sp_help spGetEmployeeCountByGender
-- tabeli info vaatamine
sp_help Employees
-- kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

-- vaatame, millest sõltub meie valitud sp
sp_depends spGetEmployeeCountByGender
-- näitab, et sp sõltub Empolyees tabelist, kuna seal on count(id)
-- ja Id on Employees tabelis

-- vaatame tabelist
sp_depends Employees

-- teeme sp, mis annab andmeid Id ja Name veergude kohta Employees tabelist
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
   select @Id = Id, @Name = FirstName from Employees
end

-- annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
   select @TotalCount = COUNT(Id) from Employees
end

-- on vaja teha uus päring, kus kasutame spTotalCount2 sp-d,
-- et saada tabeli arv
-- tuleb deklarerida muutuja @TotalCount, mis on int andmetüüp
-- tuleb execute spTotalCount2, kus on parameeter @TotalCount = @TotalCount out
declare @TotalEmployees int
exec spTotalCount2 @TotalEmployees output
select @TotalEmployees

-- mis Id all on keegi nime järgi
create proc spGetNameById1
@Id int,
@Name nvarchar(20) output
as begin
   select @Name = FirstName from Employees where Id = @Id
end

-- annab tulemuse. kus id 1(seda numbrit saab muuta) real on keegi
-- koos nimega
-- print'i tuleb kasutada, et näidata tulemust
declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName output
print 'Name of the employee = ' + @FirstName

-- tehke sama, mis eelmine, aga kasutage spGetNameById sp-d
-- FirstName lõpus on outdeclare

declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName out
print 'Name = ' + @FirstName

-- output tagastab muudetud read kohe päringu tulemusena
-- see on salvestatut protsetuuris ja ühe väärtuse tagastamine
-- out ei anna mitte midagi, kui seda ei määra execute käsus

-----------------------------
 -- Tund nr 8  19.03.2026 -- 
-----------------------------

sp_help spGetNameById

create proc spGetNameById2
@Id int
-- Kui on begin, siis on ka end kuskil olemas
as begin
    return (select FirstName from Emloyees where Id = @Id)
end

-- tuleb veateade kuna kutsusime välja int'i, aga Tom on nvarchar
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee' + @EmployeeName

-- Sisseehitatud string funktsioonid
-- see konverteerib ASCII tähe väärtuse numbriks
select ASCII('A')

select char(65)

-- prindime kogu tähestiku välja
declare @start int
set @start = 97
-- kasutate while'i, et näidata kogu tähestik ette sql
while (@start <= 122)
begin
    select CHAR (@start)
	set @start = @start + 1
end

-- eemaldame tühjad kohad sulgudes
select ('                 HELLO!!!')
select LTRIM('                 HELLO!!!')

-- tühikute eemaldamine veerust, mis on tabelis
select FirstName, MiddleName,LastName from Employees
-- eemaldage tühikud FirstName veerust ära

select LTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

-- paremalt poolt tühjad stringid lõikab ära
select RTRIM('       HELLO!!!        ')

-- keerab kooloni sees olevad andmed vastupidiseks
-- vastavalt lower'iga ja upper'iga saan märkide suurust
-- reverse funktsioon pöörab kõik ümber
select REVERSE(upper(ltrim(FirstName))) as FirstName, MiddleName, 
lower(LastName), ltrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName
as FullName from Employees

-- left, right, substring
--Vasakult poolt neli esimest tähte
select LEFT('ABCDEF', 4)
-- Paremalt poolt kolm esimest tähte
select RIGHT('ABCDEF', 3)

-- Kuvab @-tähemärgi asetust e. mitmes on '@' märk 
select CHARINDEX('@', 'sara@aaa.com')

-- esimene nr peale komakohta näitab, et mitmendast alustab ja
-- siis minu nr peale seda kuvada
select SUBSTRING('pam@bbb.com', 5,2)

-- '@' märgist kuvab tähemärki. Viimase nr-ga saab määrata pikkust
select SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 3)


-- peale @-märki hakkab kuvama tulemust, nr-ga saab kaugust seadistada
select SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 3,
LEN('pam@bbb.com') - CHARINDEX('@','pam@bbb.com'))

alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees set Email = 'tom@aaa.com' where Id = 1;
update Employees set Email = 'pam@bbb.com' where Id = 2;
update Employees set Email = 'john@aaa.com' where Id = 3;
update Employees set Email = 'sam@bbb.com' where Id = 4;
update Employees set Email = 'todd@bbb.com' where Id = 5;
update Employees set Email = 'ben@ccc.com' where Id = 6;
update Employees set Email = 'sara@ccc.com' where Id = 7;
update Employees set Email = 'valarie@aaa.com' where Id = 8;
update Employees set Email = 'james@bbb.com' where Id = 9;
update Employees set Email = 'russell@bbb.com' where Id = 10;

-- soovime teada saada domeeninimesid emailides
select SUBSTRING (Email, CHARINDEX('@', Email) + 1,
len(Email) - charindex('@', Email)) as EmailDomain
from Employees

-- alates teisest tähest emailis kuni @ märgini on tärnid
select FirstName, LastName,
SUBSTRING(Email, 1, 2) + replicate('*', 5) +
substring(Email, charindex('@', Email), len(Email) -
charindex('@', Email)+1) as Email
from Employees

-- kolm korda näitab stringis olevat väärtust
select REPLICATE('asd', 3)

-- tühiku sisestamine
select SPACE(5)

-- tühiku sisestamine FirstName ja LastName

select FirstName + space(25) + LastName as FullName 
from Employees

-- PatIndex
-- Sama, mis charindex, aga dünaamilisem ja saab kasutada wildcardi
select Email,PATINDEX('%@aaa.com', Email) as FirstOccurence
From Employees
Where PATINDEX('%@aaa.com', Email) > 0
-- leian kõik selle domeeni esindajad ja alates mitmendast
-- märgist algab @

-- kõik .com emailid asendab .net-iga
select Email, REPLACE(Email, '.Com', '.net') as ConvertedEmail
From Employees

--soovin asendada peale esimest märki kolm tähte viie tärniga
select FirstName, LastName, Email,
stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

-- Vot tak vot nye nada, nada vot tak tak tak

create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetne masina kellaaeg
select getdate(), 'GETDATE()'

insert into DateTime
values(GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

select * from DateTime

update DateTime set c_datetimeoffset = '2026-03-19 14:25:33.7166667 +10:00'
where c_datetimeoffset = '2026-03-19 14:25:33.7166667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' -- See on ajapäring
select SYSDATETIME(), 'SYSDATETIME' -- See on veel täpsem päring
select SYSDATETIMEOFFSET() 'SYSDATETIMEOFFSET' -- See on veel veel veel täpsem
select GETUTCDATE(), 'GETUTCDATE' -- UTC aeg

-- Saab kontrollida, kas on õige andemtüüp
select ISDATE('asd') --tagastab 0 kuna string ei ole date

--Kuidas saada vastuseks 1 isdate puhul?? :
select ISDATE(GETDATE()) --GETDATE - võtab selle arvuti aja
select ISDATE('2026-03-19 14:25:33.7166667') --tagastab 0 kuna max kolm koma kohta võib olla
select ISDATE('2026-03-19 14:25:33.716') -- tagastab nr '1'
select DAY(GETDATE()) --annab tänase päeva numbri
select DAY('01/24/2026') -- annab stringis oleva kuupäeva, ja järjestus peab olema õige
select month(GETDATE()) -- annab jooksva kuu numbri
select month('01/24/2026') -- annab stringis oleva kp ja järjestus peab olema õige
select year(GETDATE()) -- annab jooksva aasta numbri
select year('01/24/2026') -- annab stringis oleva aasta ja järjestus peab olema õige

select DATENAME(DAY, '2026-03-19 14:25:33.716') -- annab stringis oleva päeva nr
select DATENAME(WEEKDAY, '2026-03-19 14:25:33.716') -- annab stringis oleva päeva sõnana
select DATENAME(MONTH, '2026-03-19 14:25:33.716') -- annab stringis oleva kuu sõnana

create table EmployeeWithDates
(
   Id nvarchar(2),
   Name varchar(20),
   DateOfBirth datetime
)

select * from EmployeeWithDates

insert into EmployeeWithDates (Id, Name, DateOfBirth)
values (1, 'Sam', '1980 12-30-00:00:00.000'),
(2, 'Pam', '1982-09-01 12:02:36.260'),
(3, 'John', '1985-08-22 12:03:30.370'),
(4, 'Sara', '1979-11-29 12:59:30.670')

-----------------------------
 -- Tund nr 9  24.03.2026 -- 
-----------------------------

-- Kuidas võtta ühest veerust andemid ja selle abil luua uued veerud
-- vaatab DoB(DateOfBirth) veerust päeva ja kuvab päeva nimetuse sõnana

select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [day],
     -- vaatab VoB veerust kuupäeva ja kuvab kuu nr
     MONTH(DateOfBirth) as MonthNumber,
	 -- vaatab DoB veerust kuud ja kuvab sõnana
	 DATENAME(MONTH, DateOfBirth) as [MonthName],
	 -- võtab DoB veerust aasta
	 YEAR(DateOfBirth) as [Year]
from EmployeeWithDates

-- kuvab 3 kuna USA nädal algab pühapäevaga
select DATEPART(WEEKDAY, '2026-03-24 12:59:30.670')
-- tehke sama, aga arvutage kuu-d
select DATEPART(MONTH, '2026-03-24 12:59:30.670')
-- liidab stringis olevale kp 20 päeva juurde
select DATEADD(DAY, 20, '2026-03-24 12:59:30.670')
-- lahutab 20 päeva maha
select DATEADD(DAY, -20, '2026-03-24 12:59:30.670')
-- kuvab kahe stringis oleva kuudevahelist aega nr-na
select DATEdiff(MONTH, '11/20/2026', '01/20/2024')
-- tehke sama, aga kasutage aastat
select DATEdiff(year, '11/20/2026', '01/20/2028')

-- uuri mis on funktsioon MS SQL'is [1.]
-- miks seda vaja on [2.]
-- mis on selle eelised ja puudused
------------------------------------------
-- [1.] MS SQL funktsioon on andmebaasis salvestatud alamprogramm.

-- [2.] Pakkuda DB-s korduvkasutatud funktsionaalsust

-- [3.] Funktsiooni eelised: 
-- Kood on jagatud väiksemateks, hallatavateks osadeks;
-- Saab kasutada SELECT, WHERE, HAVING klauslites; 
-- Muutes funktsiooni sisu, uueneb loogika kõikjal.

-- [3.] Funktsiooni puudused: 
-- Funktsioonid ei saa muuta andmebaasi olekut;
-- Funktsioonides ei saa kasutada keerukat TRY...CATCH veatöötlust;
-- Skalaar-funktsioonid võivad suures andmemahus aeglustada päringuid,
-- kuna neid käivitatakse iga rea kohta eraldi.

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
    declare @tempdate datetime, @years int, @months int, @days int
	select @tempdate = @DOB

	select @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - case when (month(@DOB)>
	MONTH(GETDATE())) or (MONTH(@DOB) = MONTH(GETDATE())and day(@DOB) > DAY(GETDATE()))
	then 1 else 0 end
	select @tempdate = DATEADD(YEAR, @years, @tempdate)

	select @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - case when DAY(@DOB) > 
	DAY(getdate()) then 1 else 0 end
	select @tempdate = DATEADD(MONTH, @months, @tempdate)

	select @days = datediff(day, @tempdate, GETDATE())

	declare @Age nvarchar(50)
	    set @Age = CAST (@years as nvarchar(4)) + 'Years' + CAST(@months as nvarchar(2))
		+ 'Months' + CAST (@days as nvarchar(2)) + 'Days old'
    return @Age
end

select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) 
as Age from EmployeeWithDates

-----------------------------
 -- Tund nr 10  31.03.2026 -- 
-----------------------------

-- kui kasutame seda funktsiooni, siis saame teada tänase päeva vahet sringis välja tooduga
select dbo.fnComputeAge('02/24/2010') as Age

-- nnpeale DOB muutjat näitab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
CONVERT(nvarchar, DateOfBirth, 109) as ConvertedDOB
from EmployeeWithDates

select Id,Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeeWithDates

select CAST(getdate() as date) --tänane kuupäev
-- Tänane kuupäev, aga kasutate convert'i, et kuvada stringiga
SELECT CONVERT(VARCHAR(10), GETDATE(), 104) AS Tänane_KuupäevStringiga;

-- matemaatilised funktsioonid
select ABS(-5) -- abs on absoluutväärtusega number ja tulemuseks saame ilma miinus märgita 5
select CEILING(4.2) -- celing on funktsioon, mis ümardab ülespoole ja tulemuseks saame 5
select CEILING(-4.2) -- celing ümardab ka miinus numbri ülespoole, mis tähendab, et saame -4
select FLOOR(15.2) -- floor on funktsioon, mis ümbritseb alla ja tulemuseks saame 15
select FLOOR(-15.2) -- floor ümardab ka miinus numbrid alla, mis tähendab, et saame -16
select POWER(2, 4) -- kaks astemes neli
select SQUARE(9) -- antud juhul 9 ruudus
select SQRT(16) -- antud juhul 16 ruutjuur

select RAND() -- rand on funktsioon, mis genereerib
--juhusliku numbri vehemikus 0 kuni 1

--kuidas saada täisnumber igakord?
SELECT FLOOR(RAND() * 100); --KORRUTAB SAJAGA IGA SUVALISE NUMBRI
--
--iga kord näitab 10 suvalist numbrit
declare @counter int
set @counter = 1
while (@counter <= 10)
BEGIN
    PRINT FLOOR(RAND() * 100)
    SET @counter = @counter + 1;
END

select ROUND(850.556, 2) -- random funktsioon, mis ümardab kaks kumakohta
-- ning tulemuseks saame 850.56
select ROUND(850.556,2 ,1)
-- round funktsioon, mis ümardab kaks komakohta ja
-- kui kolmas parameeter on 1, siis ümardab alla
select ROUND(850.556, 1)
-- round on funktsioon, mis ümardab ühe komakoha ja
-- tulemuseks saame 750.6
select ROUND(850.556,1, 1) --ümardab alla ühe komakoha pealt
-- ning tulemuseks saame 850.5
select ROUND(850.556, -2) -- ümardab täisnumbri ülessepoole 
-- ning tulemuseks saame 900
select ROUND(850.556, -1) -- ümardab täisnumbri alla ning tulemuseks on 850

---
create function dbo.CalculateAge(@DOB date)
returns int
as begin 
declare @Age int

   set @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
   CASE 
      when (month(@DOB) > month(getdate())) or
           (month(@DOB) > month(getdate()) and day(@DOB) > day(getdate()))
		   then 1 else 0 end
	return @Age
end

--kui valmis, siis proovige seda funktsiooni
--ja vaadake, kas annab õige vanuse
exec dbo.CalculateAge '1980-12-30'

--arvutab välja, kui vana on isik ja võtab srvesse kuud ning päevad
--antud juhul näitab, kes on üle 36 a vanad
select Id, dbo.CalculateAge(DateOfBirth) as Age from EmployeeWithDates
where dbo.CalculateAge(DateOfBirth) > 36
-----------------------------
 -- Tund nr 11  02.04.2026 -- 
-----------------------------

--- inline table valued functions
alter table EmployeeWithDates
add DepartmentId int
alter table EmployeeWithDates
add Gender nvarchar(10)

select * from EmployeeWithDates

insert into EmployeeWithDates (Id, Name, DateOfBirth,DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')


update EmployeeWithDates set DepartmentId = 1 where Id = 1;
update EmployeeWithDates set DepartmentId = 2 where Id = 2;
update EmployeeWithDates set DepartmentId = 1 where Id = 3;
update EmployeeWithDates set DepartmentId = 3 where Id = 4;

update EmployeeWithDates set Gender = 'Male' where Id = 1;
update EmployeeWithDates set Gender = 'Female' where Id = 2;
update EmployeeWithDates set Gender = 'Male' where Id = 3;
update EmployeeWithDates set Gender = 'Female' where Id = 4;

select * from EmployeeWithDates

--scalar function annab mingis vahemikus andmeid,
--inline table values ei kasuta begin ja end funktsioone
--scalar annab väärtused ja inline annab tabeli
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table 
as 
return (select Id ,Name, DateOfBirth, DepartmentId, Gender
        From EmployeeWithDates
		where Gender = @Gender)

--kuidas leida kõik naised tabelis EmployeesWithDates
-- ja kasutada funktsiooni fn_EmployeesByGender
SELECT * FROM fn_EmployeesByGender('Female');

-- tahaks ainult Pami nime näha
SELECT * FROM fn_EmployeesByGender('Female') where Id = 2
-- Või           Mõlemad annavad terve isku rea
SELECT * FROM fn_EmployeesByGender('Female') Where Name = 'Pam'

-- kahest erinevast tabelist andmete võtmine ja koos kuvamine
-- esimene on funktsioon ja teine on tabel

select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.id = E.DepartmentId

-- multi tabel statement
-- inline funktsioon
create function fn_GetEmployees()
returns table as
return (select Id, Name, CAST(DateOfBirth as date) 
         as DOB
		 from EmployeeWithDates)

select * from fn_GetEmployees()

-- multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
-- funktsiooni nimi on fn_MS_GetEmployees()
-- peab edastama meile Id, Name, DOB tabelist EmployeesWithDates

create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
  as begin
    insert into @Table
    select Id, Name, cast(DateOfBirth as date)
    from EmployeeWithDates
    return
end	

select * from fn_MS_GetEmployees()

-- inline tabeli funktsioonid on paremini töötamas kuna käsitletakse vaatena
-- multi puhul on pm tegemist stored procéduriga ja kulutab ressurssi rohkem

-- muudame andmeid ja vaatame, kas inline funktsioonis on muutused kajastatud
update fn_GetEmployees() set Name = 'Sam1' where Id = 1
select * from fn_GetEmployees() --saab muuta andmeid

update fn_GetEmployees() set Name = 'Sam2' where Id = 1
-- ei saa muuta andmeid, multi state funktsioonis,
-- kuna see on nagu stored procedure

--deterministic vs non-deterministic functsions
--deterministic funktsioonid annavad alati sama tulemus,
--kui sisend on sama
select COUNT(*) from EmployeeWithDates
select SQUARE(4)

--non-deterministic funktsioonid annavad alati sama tulemus,
--kui sisend on sama
select GETDATE()
select CURRENT_TIMESTAMP
select RAND()

-----------------------------
 -- Tund nr 12  16.04.2026 -- 
-----------------------------

--loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
    return (select Name from EmployeeWithDates where Id = @id)
end

--kasutame funktsiooni, leides Id 1 all olev inimene
select dbo.fn_GetNameById(1)


select * from EmployeeWithDates

--saab näha funktsiooni sisu
sp_helptext fn_GetNameById

--nüüd muudate funktsiooni nimega fn_GetNameById
--ja panete sinna encryption, et keegi peale teie ei saaks sisu näha

alter function fn_GetNameById(@id int)
returns nvarchar(30)
with encryption
as begin
    return (select Name from EmployeeWithDates where Id = @id)
end

--kui nüüd sp_helptext'i kasutada, siis ei näe funktsiooni sisu
sp_helptext fn_GetNameById

--kasutame schemabindingut, et näha, mis on funktsiooni sisu
alter function dbo.fn_GetNameById(@id int)
returns nvarchar(30)
with schemabinding
as begin
    return (select Name from dbo.EmployeeWithDates where Id = @id)
end
--schemabinding tähendab, et kui keegi üritab muuta EmployeeWithDates
--tabelit, siis see ei lase seda teha, kuna see on seotud
--fn_GetNameById funktsiooniga

--ei saa kustutada ega muuta tabelit EmployeeWithDates,
--kuna on seotud fn_GetNameById funktsiooniga
drop table dbo_EmployeeWithDates



-- Temporary tables --
--See on olemas ainult selle sessiooni jooksul

--kasutatajse '#' sümbolit, et saada aru, et tegemist on temporary tabeliga
create table #PersonDetails (Id int, Name nvarchar(20))

insert into #PersonDetails values (1, 'Sam')
insert into #PersonDetails values (2, 'pam')
insert into #PersonDetails values (3, 'John')

select * from #PersonDetails

--temporary tabelite nimekirja ei näe, kui kasutada sysobjects
--tabelist, kuna need on ajutised
select Name from sysobjects
where name like '#PersonDetails'

--kasutame temporary tabeli
drop table #PersonDetails

create proc spCreateLocalTempTable
as begin
create table #PersonDetails (Id int, Name nvarchar(20))

insert into #PersonDetails values (1,'Sam')
insert into #PersonDetails values (2,'Pam')
insert into #PersonDetails values (3,'John')

select * from #PersonDetails
end
---
exec spCreateLocalTempTable

--globaalne temp tabel on olemas kogu
--serveris ja kõigile kasutajatele, kes on ühendatud
create table ##GlobalPersonDetails (Id int, Name nvarchar(20))

--index
create table EmployeeWithSalary
(
   Id int primary key,
   Name nvarchar(20),
   Salary int,
   Gender nvarchar(10)
)

insert into EmployeeWithSalary values (1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values (2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values (3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values (4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values (5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

--otsime inimesi, kelle palgavahemik on 5 000 kuni 7 000

select * from EmployeeWithSalary where Salary between 5000 and 7000

--loome indeksi Salary veerule, et kiirendada otsingut
--mis asetab Salary veeru järgi järjestatult
create index IX_EmployeeSalary
on EmployeeWithSalary(Salary asc)

--saame teada, et mis on selle tabeli primaarvõti ja index
exec.sys.sp_helpindex @objname = 'EmployeeWithSalary'


--tahaks IX_EmployeeSalary indeksi kasutada, et otsing oleks kiirem

select * from EmployeeWithSalary
where Salary between 5000 and 7000


--näitab, et kasutatakse indeksi IX_EmployeeSalary,
--kuna see on järjestatud Salary veeru järgi
select * from EmployeeWithSalary with (index(IX_EmployeeSalary))

--indeksi kustutamine
drop index IX_EmployeeSalary on EmployeeWithSalary --1 variant
drop index EmployeeWithSalary.IX_EmployeeSalary --2variant

--- indeksi tüübid ---
--1. klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. Täistekst
--7. Ruumiline
--8. Veerusäilitav
--9. Veergude indeksid
--10. Välja arvatud veergudega indeksid

--Klastris olev indeks määrab tabelis oleva füüsilise järjestuse
--ja selle tulemusel saab tabelis olla ainult üks klastris olev indeks

create table EmployeeCity
(
    Id int primary key,
    Name nvarchar(20),
    Salary int,
    Gender nvarchar(10),
    City nvarchar(50)
)

exec sp_helpindex EmployeeCity

--andmete õige järjestuse loovad klastris olevad indeksid
--ja kasutab selleks Id nr'it
--põhjus, miks antud juhul kasutab Id-d, tuleneb primaarvõtmest
insert into EmployeeCity values (3, 'John', 4500, 'Male','New Yoek')
insert into EmployeeCity values (1, 'Sam', 2500, 'Male','London')
insert into EmployeeCity values (4, 'Sara', 5500, 'Female','Tokyo')
insert into EmployeeCity values (5, 'Todd', 3100, 'Male','Tronto')
insert into EmployeeCity values (2, 'Pam', 6500, 'Male','Sydney')

select * from EmployeeCity
create clustered index IX_EmployeeCityName
on EmployeeCity(Name)
--põhjus, miks ei saa luua klastris  olevat indeksit Name veerue,
--on see, et tabelis on juba klastris olev indeks Id veerul,
--kuna see on primaarvõti

--loome composite indeksi, mis tähendab, et see on mitme veeru indeks
--enne tuleb kustutada klastris olev indeks, kuna composite indeks
--on klastris olev indeksi tüüp
create clustered index IX_EmployeeGenderSalary
on EmployeeCity(Gender desc, Salary asc)
--kui teed select päringu sellele tabelile, siis peaksid nägema andmeid,
--mis on järjestatud selliselt: Esimeseks võetakse aluseks Gender veerg
--kahavenavs järjestuses ja siis Salary veerg tõusvas järjestuses

select * from EmployeeCity

--mitte klastris olev indeks on eraldi struktuur,
--mis hoiab indeksi veeru väärtuso
create nonclustered index IX_EmployeeCityName
on EmployeeCity(Name)
--kui nüüd teed päringu, siis näed, et andmed on järjestatud Id
--veeru järgi
select * from EmployeeCity

-- erinevused kahe indeksi vahel --
--1. ainult üks klastris olev indeks saab olla tabeli peale,
--mitte-klastris olevaid indekseid saab olla mitu
--2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi
--viitama tabelile juhul, kui selekteeritud veerg ei ole olemas indeksis
--3. klastris olev indeks määratleb ära tabeli ridade salvestusjärjestuse
-- ja ei nõua kettal lisa ruumi, Samas mitte klastris olevad indeksid on
--salvestatud tabelist eraldi ja nõuab lisa ruumi

create table EmployeeFirstName
(
    Id int primary key,
    FirstName nvarchar(20),
    LastName nvarchar(20),
    Salary int,
    Gender nvarchar(10),
    City nvarchar(50)

)

exec sp_helpindex EmployeeFirstName

insert into EmployeeFirstName values (1, 'John', 'Smith', 4500, 'Male', 'New York')
insert into EmployeeFirstName values (1, 'Mike', 'Sandoz', 2500, 'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3214EC0720A89DF4
--kui käivitad ülevalpool oleva koodi, iis tuleb veateade
--et SQL server kasutab UNIQUE indeksit jõustamaks väärtuste
--unikaalsust ja primaarvõtit koodiga Unikaalseid indekseid
--ei saa kustutada, aga käsitsi saab

create unique nonclustered index UIX_Employee_FirstName_LastName
on EmployeeFirstName(FirstName,LastName)

--lisame uue piirangu peale
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstNameCity
unique nonclustered (City)

--sisestage kolmas rida andmetega, mis on id-s 3, FirstName-s John,
--LastName-s Menco ja linn on London
insert into EmployeeFirstName values (3, 'John', 'Menco', 3500, 'Male', 'London')

--saab vaadata indeksite infot

exec sp_helpconstraint EmployeeFirstName
-- 1. Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi,
-- samas unikaalne piirang loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelis
-- kui tabel juba sisaldab väärtusi võtmeveerus
-- 3. Vaikimisi korduvaid väärtuseid ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks või piirang. Nt, kui tahad sisestada
-- 10 rida andmeid, millest 5 sisaldavad korduvaid andmeid,
-- siis kõik 10 lükatakse tagasi. Kui soovin ainult 5
-- rea tagasilükkamist ja ülejäänud 5 rea sisestamist, siis selleks
-- kasutatakse IGNORE_DUP_KEY

--näide
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values (5, 'John', 'Menco', 3512, 'Male', 'London1')
insert into EmployeeFirstName values (6, 'John', 'Menco', 3123, 'Male', 'London2')
insert into EmployeeFirstName values (6, 'John', 'Menco', 3220, 'Male', 'London2')
--enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga
-- nüüd läks keskmine rida läebi kuns linna nimi oli unikaalne
select * from EmployeeFirstName

--view on virtuaalne tabel, mis on loodud ühe või mitme tabeli põhjal
select FirstName, Salary, Gender, DepartmentName
From Employees
join Department
on Department.id = Employees.DepartmentId

create view vw_EmployeesByDetails
as
select FirstName, Salary, Gender, DepartmentName
From Employees
join Department
on Department.id = Employees.DepartmentId
--otsige ülesse view

--kuidas veiw-d kasutada: vw_EmployeesByDetails

select * from vw_EmployeesByDetails
-- view ei salvesta andmeid vaikimisi
-- seda tasub vötta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe köiki veerge

-- teeme view, mis näeb ainult IT- töötajaid
create view vTTEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.id = Employees.DepartmentId
where Department.DepartmentName = 'IT'
--ülevalpool olevat päringut saab liigitada reataseme turvalisuse
-- alla. Tahan ainult näidata IT osakonna töötajaid

select * from vTTEmployeesInDepartment

-----------------------------
 -- Tund nr 13  23.04.2026 -- 
-----------------------------

--Veeru taseme turvalisus
--peale selecti määratled veergudenäitamise ära
create view vEmployeeInDepartmentSalaryNoShow
as 
select FirstName, Gender, DepartmentName
from Employees
Join Department
on Employees.DepartmentId = Department.id

select * from vEmployeeInDepartmentSalaryNoShow

--saab kasutada esitlemaks koondandmeid ja üksikasjalike andmeid
--view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, COUNT(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.id
group by DepartmentName

select * from vEmployeesCountByDepartment

--kui soovid view sisu vaadata?
sp_helptext vEmployeesCountByDepartment
--kui soovid muuta, siis kasutad alter view

--kui soovid kustutada, siis kasutad drop view
drop view vEmployeesCountByDepartment

--andmete uuendamine läbi view
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
From Employees

select * from Employees
update vEmployeesDataExceptSalary
set [FirstName] = 'Pam' where Id = 2 

--Kustutage Id 2 rida ära
delete from vEmployeesDataExceptSalary where id = 2

select * from vEmployeesDataExceptSalary

-- andmete sisestamine läbi view
-- Id 2, Female, osakond 2, Nimi on Pam

insert into vEmployeesDataExceptSalary(Id, Gender, DepartmentId, FirstName) 
values (2, 'Female', 2, 'Pam')

--indekseeritud view
--MS SQUL-s on indekseeritud view ni nime all ja
--oracles materjaliseeritud view nimega

create table product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

select * from product

insert into product (Id, Name, UnitPrice) 
values (1, 'Books', 20),
(2, 'Pens', 14),
(3, 'Pencils', 11),
(4, 'Clips', 10)
---
create table productSales
(
Id int,
QuantitySold int,
)

select * from productSales

insert into productSales values 
(1, 10),
(3, 23),
(4, 21),
(2, 12),
(1, 13),
(3, 12),
(4, 13),
(1, 11),
(2, 12),
(1, 14)

--loome view, mis annab meile veerud TotalSales ja TotalTransaction

create view vTotalSalesByProduct
With schemabinding
as 
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.productSales.Id
group by Name

select * from vTotalSalesByProduct

-- kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks
-- vöib olla NULL, siis asendusväärtus peaks olema täpsustatud.
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust
-- 3. kui GroupBy on täpsustatud, siis view select list peab
-- sisaldama COUNT_BIG(*) väljendit
-- 4. Baastabelis peaksid view-d olema viidatud kahesosalie nimega
-- e. antud juhul dbo.Product ja dbo.ProductSales.

create unique clustered index UIX_vTotalSalesByProduct_Name
on vTotalSalesByProduct(Name)

select * from vTotalSalesByProduct

--view piirangud
create view vEmployeeDetails
@Gender nvarchar(20)
as
select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
--Mis on selles views valesti??
--vaatesse ehk view-sse ei saa panna kaasa parameetreid ehk antud juhul gender

--teha funktsioon, kus parameetriks on gender
--soovin näha veerge: Id, FirstName, Gender, DepartmentId
--tabeli nimi on Employees
--funktsiooni nimi on fnEmployeeDetails

create function fnEmployeeDetails (@Gender nvarchar (20))
returns table
as
return
(select Id, FirstName, Gender, DepartmentId 
from Employees where Gender = @Gender)

--kasutame funktsiooni fnEmployeeDetails koos parameetriga

select * from fnEmployeeDetails('Female')

--order by kasutamine
create view vEmployeeDetailsStored
as
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id
--order by'd ei saa kasutada

--trmp tabeli kasutamine
create table ##TestTempTbale
(Id int, FirstName nvarchar(20), Gender nvarchar(20))

insert into ##TestTempTbale values(101, 'Mart', 'Male')
insert into ##TestTempTbale values(102, 'Joe', 'Female')
insert into ##TestTempTbale values(103, 'Pam', 'Female')
insert into ##TestTempTbale values(104, 'James', 'Male')

--View nimi on vOnTempTable
--kasutame ##TestTempTable
select * from ##TestTempTbale

create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTbale
--View-id ja funktsioone ei saa teha ajutistele tabelitle

--Triggerid--
--DML trigger
--kokku on kolme tüüpi_ DML,DDL ja LOGON

--trigger on stored procedure eriliik, mis automaatselt käivitub,
--kui mingi tegevus
--peaks andmebaasis aset leidma

--DML - data manipulation langugae
--DML-i põhilised käsklused: insert, update ja delete

--DML triggerid saab klassifitseerida kahte tüüpi:
--1.After trigger (kasutage ka FOR triggeriks)
--2.Instead of trigger (selmet trigger e selle asemel trigger)

--after trigger käibitub peale sündmust, kui kuskil on tehtud insert,
--update ja delete

-- loome uue tabeli
create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

--peale iga töötaja sisestamist tahame teada saada töötaja Id-d,
--päeva ning agea(millal sisestati)
--kõik andmed tulevad EmployeeAudit tabelisse
--andmed sisestame Employees tabelisse

create trigger trEmployeeForIndert
on Employees
for insert
as begin
declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = ' + cast(@Id as nvarchar(5)) + 
' is added at ' + cast(getdate() as nvarchar(20)))
end

select * from Employees

insert into Employees values 
(11, 'Bob','Blob','Bomb','Male',3000, 1, 3, 'bob@bob.com')
go
select * from EmployeeAudit


--delete trigger
create trigger trEmployeeForDelete
on Employees
for delete
as begin
declare @Id int
select @Id = Id from deleted

insert into EmployeeAudit
values('An existing employee with Id = ' + CAST(@Id as nvarchar(5))
+ ' is deleted at ' + cast(getdate() as nvarchar(20)))
end

delete from Employees where Id = 11
select * from EmployeeAudit

--update trigger
create trigger trEmployeesForUpdate
on Employees
for update
as begin
--muutujate deklareerimkine
declare @Id int
declare @OldGender nvarchar(20), @NewGender nvarchar(20)
declare @OldSalary int, @NewSalary int
declare @OldDepartmentId int, @NewDepartmentId int
declare @OldManagerId int,@NewManagerId Int
declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
declare @OldMiddletName nvarchar(20), @NewMiddleName nvarchar(20)
declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
declare @OldEmail nvarchar(50), @NewEmail nvarchar(50)


--muutuja, kuhu läheb lõpptekst
declare @AudiString nvarchar(1000)

--laeb kõik uuendatud andmed temp tablei alla
delect * from #TempTable
from inserted

--käib läbi kõik andme temp tabelist
while(exists(select Id from #TempTable))
begin
set @AudiString = ''
--selekteerib esimese rea andmed temp tabelist
select top 1 @Id, 
@NewGender = Gender,
@NewSalary = Salary,
@NewDepartmentId = DepartmentId,
@NewManagerId= ManagerId,
@NewFirstName = FirstName,
@NewMiddleName = MiddleName,
@NewLastName = LastName,
@NewEmail = Email
from #TempTable
--võtab vanad andmed kustutatud tabelist
select @OldGender = Gender,
@OldSalary = Salary,
@OldDepartmentId = DepartmentId,
@OldManagerId= ManagerId,
@OldFirstName = FirstName,
@OldMiddleName = MiddleName,
@OldLastName = LastName,
@OldEmail = Email
from deleted where Id = @Id