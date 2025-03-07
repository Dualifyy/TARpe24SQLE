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

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust,
-- siis see automaatselt sisestab sellele reale väärtuse 3 e nagu meil
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

--kõik kes elavad gothami linnas
select * from Person where City = 'Gotham'

--kõik kes ei ela gothamis
select * from Person where City != 'Gotham'

--näitab teatud vanusega inimesi
select * from Person Where Age = 100 or Age = 35 or Age = 27

--näitab teatud vanusevahemikus olevaid inimesi
select * from Person where age < 100 and age > 35
select * from Person where age between 22 and 50

--wildcard e näitab
select * from Person where City like 'n%'

--kõik emailid, kus on @-märk emailis
select * from Person where Email like '%@%'

--näitab kõiki, kellel ei ole @ märki emailis
select * from Person where Email not like '%@%'

--
--tund 2

--näitab, kellel emailis ees ja peale @märki ainult üks täht
select * from Person where Email like '_@_.com'

--kõik kellel on nimes esimene täht W,A,S
select * from Person where name like '[^WAS]%'
select * from Person 

--kes elavad gothamis ja new yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--kõik kes elavad gothami ja new yorki linnas ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age >=30

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name

--sama aga vastupidises järjekorras
select * from Person order by Name desc

--kolm esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli järjestus on age ja siis name

select top 3 * from Person order by Age, Name

--näitab esimesed 50% tabelis
select top 50 percent * from Person order by Name desc

--järjestab vanuse järgi
select * from Person order by Age desc

--muudab Age muutuja intiks ja näitab vanuselises järjekorras
select * from Person order by CAST(Age as int)

--kõikide isikute koond vanus
select SUM(CAST(age as int)) from Person

--kuvab kõige nooremat isikut
select min(CAST(age as int)) from Person

--kuvab kõige vanemat

select max(CAST(age as int)) from Person

--kõige konkreetsetes linnades olevate isikute koondvanus
--enne oli age nvarchar aga muudame selle int andmetüübiks

select City, SUM(Age) as totalAge from Person group by City

-- kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person
alter column name nvarchar(25)

--kuvab esimeses reas välja toodud järjestuses ja kuvab Age TotalAgeks
--järjestab city olevate nimede järgi ja siis genderID
select City, GenderId, SUM(Age) as TotalAge from Person
group by City, GenderId order by City

--näitab ridade arvu tabelis
select COUNT(*) from Person
select * from Person

--näitab tulemust, et mitu inimest on genderId väärtusega 2 konkreetses linnas
-- arvutab vanuse kokku selles linnas
select GenderId City, SUM(age) as totalAge, COUNT(iD) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--loome tabelid employees ja department

create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50),
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)