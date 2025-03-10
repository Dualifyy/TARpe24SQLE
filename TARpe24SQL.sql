--tund 1 03.03.2025
--loome db
create database TARpe24SQL

-- db valimine 
use TARpe24SQL

-- db kustutamine
drop database TARpe24SQL

-- tabeli loomine
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

-- vaatame tabeli sisu
select * from Gender

-- teeme tabeli Person
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
values (2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(7, 'Spiderman', 'spider@s.com', 2),
(9, NULL, NULL, 2)

--soovime vaadata Person tabeli andmeid
select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ele sisestanud GenderId alla v��rtust,
-- siis see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil
-- on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--
insert into Person (Id, Name, Email)
values (11, 'Kalevipoeg', 'k@k.com')

-- piirangu kustutamine
alter table person
drop constraint DF_Persons_GenderId

-- lisame uue veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kustutame rea
delete from Person where Id = 11

select * from Person

--kuidas uuendada andmeid
update Person
set Age = 50
where Id = 4


alter table Person
add City nvarchar(50)

--k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
--variant nr 2
select * from Person where City <> 'Gotham'

-- n'itab teatud vanusega inimesi
select * from Person where Age = 100 or Age = 35 or Age = 27
select * from Person where Age in (100, 35, 25)

-- n'itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 22 and 50

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'g%'
-- k]ik emailid, kus on @-m�rk emailis
select * from Person where Email like '%@%'

--n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

--tund 2 07.03.2025

--n�itab, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

--k�ik, kellel on nimes t�ht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person

--kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--- k�ik, kes elavad Gothami ja New Yorki linnas ja on vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age >=30

--kuvab t�hestikulises j�rjekorras inimesi ja v�tab auseks nime
select * from Person order by Name
--sama p�ring, aga vastupidises j�rjestuses on nimed
select * from Person order by Name desc

-- v�tab kolm esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select top 3 Age, Name from Person

--n�itab esimesed 50% tabelis
select top 50 percent * from Person

--j�rjestab vanuse j�rgi isikud
select * from Person order by Age desc

-- muudab Age muutuja intiks ja n�itab vanuselises j�rjestuses
select * from Person order by cast(Age as int)

--k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab k�ige nooremat isikut
select min(cast(Age as int)) from Person
-- kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

-- konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmet��biks
select City, sum(Age) as totalAge from Person group by City

-- kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

--kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age TotalAge-ks
-- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

--n�itab tulemust, et mitu inimest on genderId v��rtusega 2 konkreetses linnas
-- arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--- loome, tabelid Employees ja Department

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

--rida 208
-- 3tund

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', '4000', 1),
(2, 'Pam', 'Female', '3000', 3),
(3, 'John', 'Male', '3500', 1),
(4, 'Sam', 'Male', '4500', 2),
(5, 'Todd', 'Male', '2800', 2),
(6, 'Ben', 'Male', '7000', 1),
(7, 'Sara', 'Female', '4800', 3),
(8, 'Valarie', 'Female', '5500', 1),
(9, 'James', 'Male', '6500', NULL),
(10, 'Russell', 'Male', '8800', NULL)

select * From Employees


insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * From Department

--teeme p�ringu left join

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutab k�ikide palgad kokku
select sum(cast(Salary as int)) from Employees
--tahame teada saada min palga saajat

select min(cast(Salary as int)) from Employees

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location --�he kuu palgafond linnade l�ikes

alter table Employees
add City nvarchar(30)
select * from Employees
select * from Department

--n�eme palkasid ja eristame linnades soo j�rgi

select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender

--samasugune nagu eelmine p�ring aga linnad paneb t�hestikulises j�rjekorras

select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender order by City

--mitu t��tajat on soo ja linna kaupa selles firmas

select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employe(s)]
from Employees
group by Gender, City

--loeb �ra tabeli olevate ridade arvu

select count(*) from Employees

-- kuvab ainult mehed linnade kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employe(s)]
from Employees
where Gender = 'Male'
group by Gender, City

--samasugune p�ring, aga kasutame having
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employe(s)]
from Employees
group by Gender, City
having Gender = 'Female'


-- k�ik kes teenivad palka �le 4k
select * from Employees where Salary > 4000

--kasutame having
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employe(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000



-- loome tabeli , milles hakatase automaatselt Id-d nummerdama
create table Test1
(
Id int identity(1, 1),
Value nvarchar(20)
)
--sisestan andmed ja Id nummeradatakse
insert into Test1 values('X')
select * from Test1

--kustutame veeru nimega City

alter table Employees
drop column City

-- inner join 
-- kuvab neid, kellel on Departmentname all olemas v��rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k�ik andmed Employees k�tte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--right join
-- kuidas saada DepartmentName alla uus nimetus e antud juhul Other Department

select Name, Gender, Salary, DepartmentName
from Employees
right join Department -- v�ib kasutada RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- kuidas saada k�ikide v��rtused �hte p�ringusse

select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department 
on Employees.DepartmentId = Department.Id

-- cross join 
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

-- p�ringu sisu
Select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--inner join

select Name, Gender, Salary, DepartmentName
from Employees
inner join Department 
on Employees.DepartmentId = Department.Id

--kuidas kuvada ainult need isikud, kellel on departmentname null
--kasutada left joini
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentID = Department.Id
where Employees.DepartmentId is NULL

-- kuidas saame department tabelis oleva rea kus on null
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is NULL
or Department.Id is NULL

select * from Department

--saame muuta tabeli nimetust alguses vana tabeli nimi ja siis uus soovitus
sp_rename 'Department1', 'Department'

-- kasutame Employees tabeli asemel muutujat E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees 
add ManagerId int


--inner join
--kuvab ainult ManagerID all olevate isikute v��rtuseid
select E.Name as employee, M.Name as manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id 

--k�ik saavad k�ikide �lemused olla

select E.Name as employee, M.Name as manager
from Employees E
cross join Employees M
 