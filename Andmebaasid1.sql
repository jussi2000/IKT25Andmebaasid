     
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