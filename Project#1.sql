use jsoto;

/*
	Programmer: Johnathan Soto
    Program: Project#1.sql -- WineryDatabase
    Language: SQL
    Date: November 27, 2017
    Description: A winery database that keeps track of various 
    
				 Wineries: IDs, names, & symbol
                 specialty: IDs, name, Description
                 Wines: IDs, color, Wine Age, Wine name, vine age, Grape blend, Amount made
                 Tasting Rooms: IDs, Amount sold
                 Member: IDs, first name, last name, email, birthday, payment
                 companies: IDs, name
                 Location: IDs, zip, street
                 
				 , while also keeping track of the tables connecting each of the tables listed 
				 above.  This data base is keeping records of each tables inner contents 
                 (stuff procceding a colon).
                 Connecting each table =
                 
                 Wineries_Wine
                 Wineries_Location
                 Wineries_specialty
                 Wineries_Tasting_Room
                 Wineries_companies: start_date, end_date, Amount bought
                 Wines_Tasting_Room
                 Tasting_Room_Member: Member?
                 companies_Location
                 


*/

-- All Tables being created

create table Wineries(Wineries_ID int auto_increment primary key, name varchar(50) unique,
						symbol varchar(25));

create table specialty(specialty_ID int auto_increment primary key, 
						specialty_name varchar(25) unique, Description varchar(100));

create table Wines(Wines_ID int auto_increment primary key, wines_age int, 
					wines_name varchar(25), vine_age int, grape_blend varchar(100),
					unique(wines_age, wines_name, vine_age, grape_blend), 
					color_of_wine varchar(25), Amount_made int, Wineries_ID int,
                    foreign key(Wineries_ID) references Wineries(Wineries_ID));
                        
create table Location(Location_ID int auto_increment primary key, 
						zip_code varchar(25),  street varchar(50));


create table Tasting_Room(Tasting_Room_ID int auto_increment primary key, 
							Amount_sold int, Wineries_ID int,
							foreign key(Wineries_ID) references Wineries(Wineries_ID));
                                                                                                                                            
create table Member(Member_ID int auto_increment primary key, email varchar(25) unique, 
						First_name varchar(25), Last_name varchar(25), Birthday timestamp,
						Payment varchar(50));

create table companies(companies_ID int auto_increment primary key,
						companies_name varchar(50) unique);

create table Tasting_Room_Member(Tasting_Room_ID int, Member_ID int, Is_Member bool,
									primary key(Tasting_Room_ID, Member_ID),
									foreign key(Tasting_Room_ID) references Tasting_Room(Tasting_Room_ID), 
                                    foreign key(Member_ID)references Member(Member_ID));

create table Wine_Tasting_Room(Wines_ID int, Tasting_Room_ID int, 
								primary key(Wines_ID, Tasting_Room_ID),
								foreign key(Wines_ID) references Wines(Wines_ID), 
                                foreign key(Tasting_Room_ID) references Tasting_Room(Tasting_Room_ID));

create table Wineries_Tasting_Room(Wineries_ID int, Tasting_Room_ID int, 
									primary key(Wineries_ID, Tasting_Room_ID),
									foreign key (Wineries_ID) references Wineries(Wineries_ID), 
                                    foreign key (Tasting_Room_ID) references Tasting_Room(Tasting_Room_ID));


create table Wineries_Wine(Wineries_ID int, Wines_ID int, 
								primary key(Wineries_ID, Wines_ID),
								foreign key(Wineries_ID) references Wineries(Wineries_ID), 
                                foreign key (Wines_ID) references Wines(Wines_ID)); -- No need for table Wines has
																					-- the Wineries_ID

create table Wineries_specialty(Wineries_ID int, specialty_ID int, 
									primary key(Wineries_ID, specialty_ID),
									foreign key(Wineries_ID) references Wineries(Wineries_ID), 
                                    foreign key(specialty_ID) references specialty(specialty_ID));

create table Wineries_Location(Wineries_ID int , Location_ID int , 
								primary key(Wineries_ID, Location_ID),
                                foreign key(Wineries_ID) references Wineries(Wineries_ID)on delete cascade,
								foreign key(Location_ID) references Location(Location_ID)on delete cascade);

create table Wineries_companies(Wineries_ID int, companies_ID int, start_date timestamp, 
								end_date timestamp, Amount_Bought int, 
								foreign key (Wineries_ID) references Wineries(Wineries_ID), 
                                foreign key (companies_ID) references companies(companies_ID));

create table companies_Location(companies_ID int , Location_ID int , 
								primary key(companies_ID, Location_ID),
                                foreign key(companies_ID) references companies(companies_ID)on delete cascade,
								foreign key(Location_ID) references Location(Location_ID)on delete cascade);


                 
-- End of Table creation

-- Begin Table insertion ----------------------------------------------------------------------------


           /* Wineries insert */

insert into Wineries(name, symbol) values ('Soto Winery','Phoenix');

insert into Wineries(name, symbol) values('Landeros Wines','Tower');

insert into Wineries(name, symbol) values('Flores-Abrego Winery','Falcon');

insert into Wineries(name, symbol) values('Tazzer Winery','Tasmanian Devil');


			/* specialty insert */

insert into specialty(specialty_name, Description) values ('Spanish Wine',
											'Wine is produced in Spain and is a red wine');

insert into specialty(specialty_name, Description) values ('Portugal Wine',
											'Red wine that has been made through many 
												traditions passed down the generations');

insert into specialty(specialty_name, Description) values ('Flori Wine', 
											'Red wine with cinnamon that is aged for 
												in the 2 years in an oak bottle');

insert into specialty(specialty_name, Description) values ('Midnight Taz', 
											'Red wine that has a bit of spice to go 
												well with red meats');

			/* Wines insert */

insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Sunlit Kiss', 'Pinot Noir', 'White', 150, 1);
					
-- new wine START here

insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Dusk Kiss', 'Pinot Noir', 'White', 150, 1); 
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Sauvignon de Soto', 'Sauvignon Blanc', 'White', 250, 1); 
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Grigo de Spaina', 'Pinot Grigo', 'White', 100, 1); 
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Spanish Kiss', 'Zinfadel', 'Red', 150, 2);
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Landeros Blend', 'Pinoy Grigo & Sauvignon Blanc', 'White', 100, 2);
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Red Falcon', 'Zinfadel', 'Red', 150, 3);
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (2, 'Midnight Spain', 'Malbec & Cabernet Franc', 'Red', 200, 4);
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Shiraz Tasmania', 'Malbec & Shiraz', 'Red', 175, 4);
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (2, 'Zinfadel Franc', 'Zinfadel & Cabernet Franc', 'Red', 50, 4);
					
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (2, 'Tasmania Sang', 'Tannat & Sanglovese', 'Red', 275, 4);
					

					
-- new wine END here NOTE: Remember to put into respected places so it looks nice
                    
insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (1, 'Landeros Zin', 'Zinfadel', 'Red', 100, 2);

insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (0, 'White Falcon', 'Sauvignon Blanc & Sélmillon', 'White', 50, 3);

insert into Wines(wines_age, wines_name, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					values (2, 'Taz Midnight', 'Malbec & Cabernet Franc', 'Red', 200, 4);

			/* Location insert */

insert into Location (street, zip_code) values ('67890 Soto St.', '12345');

insert into Location(zip_code, street) values ('13579', '52637 Landero Ln.');

insert into Location(zip_code, street) values ('27346', '35677 Abrego Hill');

insert into Location(zip_code, street) values ('82937', '15167 Tasmania Rd.');


			/* Tasting_Room insert */
            
insert into Tasting_Room(Amount_sold, Wineries_ID) values (59 , 1);

insert into Tasting_Room(Amount_sold, Wineries_ID) values (48 , 2);

insert into Tasting_Room(Amount_sold, Wineries_ID) values (24 , 3);

insert into Tasting_Room(Amount_sold, Wineries_ID) values (40 , 4);

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`jsoto`.`Tasting_Room`, CONSTRAINT `Tasting_Room_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `Location` (`Location_ID`))


			/* Member insert */ 

insert into Member(email, First_name, Last_name, Birthday, Payment) 
				values ('wineTaster@gmail.com', 'Jeff', 'Smith', '1970-01-25', 'Chase 4567');

insert into Member(email, First_name, Last_name, Birthday, Payment) 
				values ('ZinLover@gmail.com', 'Stephanie', 'Lee', '1980-02-16', 'BofA 3456');

insert into Member(email, First_name, Last_name, Birthday, Payment) 
				values ('GeekWineO@gmail.com', 'David', 'Flori', '1974-07-28', 'USAA 9876');

insert into Member(email, First_name, Last_name, Birthday, Payment) 
				values ('TexWine@gmail.com', 'Brenda', 'Esparza', '1974-11-15', 'Bitcoin 4680');

			/* companies insert */ 

insert into companies(companies_name) values ('Phoenix Indusries');

insert into companies(companies_name) values ('Eagle Incorporated');

insert into companies(companies_name) values ('Eastern Politio Resturants');

insert into companies(companies_name) values ('West Ocean Resturants');


			/* Tasting_Room_Member insert */
            
insert into Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) values (1, 1, true);

insert into Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) values (2, 1, false);

insert into Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) values (3, 3, true);

insert into Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) values (4, 4, true);


			/* Wineries_companies insert */

insert into Wineries_companies(start_date, end_date, Amount_Bought) 
							values ('2010-02-16', '2030-01-01', 700);

insert into Wineries_companies(start_date, end_date, Amount_Bought) 
							values ('2006-07-26','2030-01-01', 400);

insert into Wineries_companies(start_date, end_date, Amount_Bought) 
							values ('2000-01-01','2030-02-01', 345);

insert into Wineries_companies(start_date, end_date, Amount_Bought) 
							values ('2016-09-12','2040-01-01', 200);
			
            /* Wine_Tasting_Room insert */
            
insert into Wine_Tasting_Room(Wines_ID, Tasting_Room_ID) values(1,1);

insert into Wine_Tasting_Room(Wines_ID, Tasting_Room_ID) values(2,2);

insert into Wine_Tasting_Room(Wines_ID, Tasting_Room_ID) values(3,3);

insert into Wine_Tasting_Room(Wines_ID, Tasting_Room_ID) values(4,4);


            /* Wineries_Tasting_Room insert */

insert into Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) values (1,1);

insert into Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) values (2,2);

insert into Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) values (3,3);

insert into Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) values (4,4);


            /* Wineries_Wine insert */

insert into Wineries_Wine(Wineries_ID, Wines_ID) values (1,1);

insert into Wineries_Wine(Wineries_ID, Wines_ID) values (2,2);

insert into Wineries_Wine(Wineries_ID, Wines_ID) values (3,3);

insert into Wineries_Wine(Wineries_ID, Wines_ID) values (4,4);


            /* Wineries_specialty insert */
            
insert into Wineries_specialty(Wineries_ID, specialty_ID) values (1,1);

insert into Wineries_specialty(Wineries_ID, specialty_ID) values (2,2);

insert into Wineries_specialty(Wineries_ID, specialty_ID) values (3,3);

insert into Wineries_specialty(Wineries_ID, specialty_ID) values (4,4);


            /* Wineries_Location insert */ -- err

insert into Wineries_Location(Wineries_ID, Location_ID) values (1,1);

insert into Wineries_Location(Wineries_ID, Location_ID) values (2,2);

insert into Wineries_Location(Wineries_ID, Location_ID) values (3,3);

insert into Wineries_Location(Wineries_ID, Location_ID) values (4,4);


            /* companies_Location insert */ -- err

insert into companies_Location(companies_ID, Location_ID) values (1,1);

insert into companies_Location(companies_ID, Location_ID) values (2,2);

insert into companies_Location(companies_ID, Location_ID) values (3,3);

insert into companies_Location(companies_ID, Location_ID) values (4,4);


-- End of Inserts -----------------------------------------------------------------------------------


-- Beginning of SQL Queries -------------------------------------------------------------------------


			/* A query utilizing a JOIN between at least three different tables. */
	
select wines_name, Wines.Amount_made, Wineries.name as Wineries_Name, Wineries_companies.Amount_Bought, companies_name
from Wines
left join Wineries on Wines.Wineries_ID = Wineries.Wineries_ID
left join Wineries_companies on Wineries.Wineries_ID = Wineries_companies.Wineries_ID
left join companies on Wineries_companies.companies_ID = companies.companies_ID
group by Wineries.Wineries_ID;

            
            /* A query using a subquery. */
            
select Wineries_ID, name
from Wineries
where name in (select name
				from Wineries
				where symbol = 'Phoenix');

            
            /* a query using GROUP BY */
            
select 
    Wines_ID, wines_name, sum(Amount_made)
from
    Wines
group by Wines_ID;
            
            
            /* A query utilizing a JOIN, GROUP BY, HAVING and an aggregate function. */
            
select Wineries.name, Is_Member, Member.Member_ID, concat(First_name, ' ', Last_name), Birthday
from Wineries
right join Tasting_Room on Wineries.Wineries_ID = Tasting_Room.Wineries_ID
right join Tasting_Room_Member on Tasting_Room.Tasting_Room_ID = Tasting_Room_Member.Tasting_Room_ID
right join Member on Tasting_Room_Member.Member_ID = Member.Member_ID
group by Wineries.Wineries_ID
having count(Member.Member_ID) >= 1;  


        
            
            /* A query using ORDER BY */
            
select Wineries.name, specialty_name, Description
from Wineries
right join Wineries_specialty on Wineries.Wineries_ID = Wineries_specialty.Wineries_ID
right join specialty on Wineries_specialty.specialty_ID = specialty.specialty_ID
order by Wineries.name;            
		

-- Specialty malfunction
            
            /* A query using WHERE EXISTS or WHERE NOT EXISTS */
            
select Wineries.name
from Wineries
where exists (select wines_name, wines_age 
				from Wines
                where Wines.Wineries_ID = Wineries.Wineries_ID and wines_age < 2);
		
            
            
            /* A query using a UNION */
            
select wines_name, Wineries.Wineries_ID      
from Wines
left join Wineries on Wines.Wineries_ID = Wineries.Wineries_ID
WHERE Wines_ID > 2
union
select wines_name, Wineries.Wineries_ID
from Wines
right join Wineries on Wines.Wineries_ID = Wineries.Wineries_ID
WHERE Wines_ID < 3;        

            
            /* A query using DISTINCT */
            
select distinct Wineries.name, Amount_sold
from Wineries
left join Wineries_Tasting_Room on Wineries.Wineries_ID = Wineries_Tasting_Room.Wineries_ID
left join Tasting_Room on Wineries_Tasting_Room.Tasting_Room_ID = Tasting_Room.Tasting_Room_ID
left join Tasting_Room_Member on Tasting_Room.Tasting_Room_ID = Tasting_Room_Member.Tasting_Room_ID
left join Member on Tasting_Room_Member.Member_ID = Member.Member_ID
order by Wineries.name;             
            
            
            /* At least one non-trivial data record modification other than INSERT VALUES.
            An example would be an UPDATE where the condition includes a query or an 
            INSERT that uses a SELECT. */
            
update Wineries
set Wineries.name = (select companies_name
				  from companies
                  left join Wineries_companies on companies.companies_ID = Wineries_companies.companies_ID
				  where Wineries_companies.Wineries_ID = Wineries_ID)
where Wineries_ID = 3;
            
            
            /* At least one VIEW which uses a GROUP BY, subquery or function not used in 
            any other steps. */
            
create or replace view Num_Wineries as
select Wineries.Wineries_ID, Wineries.name, count(Wineries.Wineries_ID) as WineriesAmount, count(wines_name) as WineName
from Wineries
left join Wines on Wineries.Wineries_ID = Wines.Wineries_ID
group by Wineries.Wineries_ID;             
            
            
            /* At least one function */
            
drop function if exists Count_Num_Wineries;
DELIMITER // 
create function Count_Num_Wineries(_Wineries_ID int) returns int
begin 
declare _numWineries int;

select (WineriesAmount) into _numWineries from Num_Wineries where Wineries_ID = _Wineries_ID;

return _numWineries;
end//
DELIMITER ;

select Wineries_ID, count_num_wineries(Wineries_ID) as Total_Wineries   
from Wineries
group by Wineries_ID;        
            
            
            /* At least one stored procedure. */
            
create or replace view Amount_Of_Wines as
select wines_name, Wines_ID, count(Wines_ID) as WineTotal
from Wines
group by Wines_ID;
            
            
drop procedure if exists Total_Wines;
DELIMITER //
				create procedure Total_Wines(_Wines_ID int)
                 begin
					select (WineTotal) from Amount_Of_Wines where Wines_ID = _Wines_ID;
				 end //
                
DELIMITER ;
                 
call Total_Wines(2);



			/* Query to get companies and Wineries name and Location, start date, and end date of contract */
/*   WORK ON THIS         
select Wineries.name, concat(street, Zip_code)
from Wineries
left join Wineries_Location on Wineries.Wineries_ID = Wineries_Location.Wineries_ID
left join Location on Wineries_Location.Location_ID = Location.Location_ID
union 
select companies_name, concat(street, Zip_code)
from companies
left join companies_Location on companies.companies_ID = companies_Location.companies_ID   
left join Location on companies_Location.Location_ID = Location.Location_ID
union
select start_date, end_date
from Wineries
left join Wineries_companies on Wineries.Wineries_ID = Wineries_companies.Wineries_ID
left join companies on Wineries_companies.companies_ID = companies.companies_ID
order by start_date; 

*/
            

-- End of SQL Queries -------------------------------------------------------------------------------

