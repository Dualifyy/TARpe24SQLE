--loome db
create database TARpe24SQL

-- db valimine
use TARpe24SQL

--db kustutamine
drop database TARpe24SQL

--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

--vaatame tabeli sisu
select * from Gender

--teeme tabeli Person
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Spiderman', 'sm@s.com', 2),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'WonderWoman', 'w@w.com', 1),
(7, 'Antman', 'ant"ant.com', 2),
(9, NULL, NULL, 2)

--soovime vaadata Person tabeli andmeid
select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v��rtust,
-- siis see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil
-- on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--

insert into Person (Id, Name, Email, GenderId)
values (10, 'Deadpool', 'd@d.com', NULL)
insert into Person (Id, Name, Email)
values (11, 'Kalevipoeg', 'k@k.com')

--piirangu kustutamine
alter table Person
drop constraint DF_Persons_GenderId

--lisame uue veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kustutame rea 
delete from Person where Id = 11

-- kuidas uuendada andmeid
update Person
set Age = 50
where Id = 4

alter table Person
add City nvarchar(50)

--k�ik kes elavad gothami linnas
select * from Person where City = 'Gotham'

--k�ik kes ei ela gothamis
select * from Person where City != 'Gotham'

--n�itab teatud vanusega inimesi
select * from Person Where Age = 100 or Age = 35 or Age = 27

--n�itab teatud vanusevahemikus olevaid inimesi
select * from Person where age < 100 and age > 35
select * from Person where age between 22 and 50

--wildcard e n�itab
select * from Person where City like 'n%'

--k�ik emailid, kus on @-m�rk emailis
select * from Person where Email like '%@%'

--n�itab k�iki, kellel ei ole @ m�rki emailis
select * from Person where Email not like '%@%'

--
--tund 2

--n�itab, kellel emailis ees ja peale @m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

--k�ik kellel on nimes esimene t�ht W,A,S
select * from Person where name like '[^WAS]%'
select * from Person 

--kes elavad gothamis ja new yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--k�ik kes elavad gothami ja new yorki linnas ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age >=30

--kuvab t�hestikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name

--sama aga vastupidises j�rjekorras
select * from Person order by Name desc

--kolm esimest rida
select top 3 * from Person