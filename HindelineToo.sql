-- Spordiklubi süteem --
------------------------

create database HindelineToo
use HindelineToo

create table Liikmed
(
Id int not null primary key,
Eesnimi nvarchar(50),
Perenimi nvarchar(50),
Vanus int,
LiitumiseAasta int
)

insert into Liikmed (Id, Eesnimi, Perenimi, Vanus, LiitumiseAasta)
values (1, 'Jaan','Kask','33','2009'),
(2, 'Oder','Lees','12','2022'),
(3, 'Toome','puder','65','1997'),
(4, 'Jaana','kana','27','2016'),
(5, 'Puuoks','kajakas','97','1999'),
(6, 'Seppo','muru','19','2019')

update Liikmed
set Vanus = 13
where Id = 2

update Liikmed
set Perenimi = 'Papp'
where Id = 1

alter table Liikmed
add Kuutasu Decimal(5,2)

update Liikmed
set Kuutasu = 120
where Id = 5

update Liikmed
set Kuutasu = 70
where Id = 3

update Liikmed
set Kuutasu = 55
where Id = 1

alter table Liikmed
drop column LiitumiseAasta

delete from Liikmed where id = 6