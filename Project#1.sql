use jsoto;

/*
	Programmer: Johnathan Soto
    Program: Project#1.sql -- WineryDatabase
    Language: SQL
    Date: Fall 2017
    Description: A winery database that keeps track of various 
    
				 Wineries: IDs, names, & symbol
                 specialty: IDs, name, Description
                 Wines: IDs, color, Wine Age, Wine name, vine age, Grape blend, Amount made
                 Tasting Rooms: IDs, Amount sold
                 Member: IDs, first name, last name, email, birthday, payment
                 companies: IDs, name
                 Location: IDs, zip, street
                 
				 , while also keeping track of the TABLE connecting each of the TABLE listed 
				 above.  This data base is keeping records of each TABLE inner contents 
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
                 
				  NOTE: Wineries_Wine & Wineries_Tasting_Room TABLE are backup TABLE in case the relatiON to 
						Wineries, Wines, or Tasting_Rooms become comprimised in some way.  These are just
						in case TABLE so the REFERENCES and the FOREIGN KEYS can be stored if a glitch
						or unforeseen circumstance were to occur and comprimise the connectiON between each table.


*/

-- All TABLE being CREATEd


CREATE TABLE Wineries(Wineries_ID INT auto_increment PRIMARY KEY, name VARCHAR(50) UNIQUE,
						symbol VARCHAR(25));

CREATE TABLE specialty(specialty_ID INT auto_increment PRIMARY KEY, 
						specialty_name VARCHAR(25) UNIQUE, DescriptiON VARCHAR(100));


CREATE TABLE Wines(Wines_ID INT auto_increment PRIMARY KEY, wines_age INT, 
					wines_name VARCHAR(25), vine_age INT, grape_blend VARCHAR(100),
					UNIQUE(wines_age, wines_name, vine_age, grape_blend), 
					color_of_wine VARCHAR(25), Amount_made INT, Wineries_ID INT,
                    FOREIGN KEY(Wineries_ID) REFERENCES Wineries(Wineries_ID) ON DELETE CASCADE ON UPDATE CASCADE);
                        
CREATE TABLE Location(Location_ID INT auto_increment PRIMARY KEY, 
						zip_code VARCHAR(25), street VARCHAR(50));


CREATE TABLE Tasting_Room(Tasting_Room_ID INT auto_increment PRIMARY KEY, 
							Amount_sold INT, Wineries_ID INT,
							FOREIGN KEY(Wineries_ID) REFERENCES Wineries(Wineries_ID)ON DELETE CASCADE ON UPDATE CASCADE);
                                                                                                                                            
CREATE TABLE Member(Member_ID INT auto_increment PRIMARY KEY, email VARCHAR(25) UNIQUE, 
						First_name VARCHAR(25), Last_name VARCHAR(25), Birthday timestamp,
						Payment VARCHAR(50));

CREATE TABLE companies(companies_ID INT auto_increment PRIMARY KEY,
						companies_name VARCHAR(50) UNIQUE);

CREATE TABLE Tasting_Room_Member(Tasting_Room_ID INT, Member_ID INT, Is_Member bool,
									PRIMARY KEY(Tasting_Room_ID, Member_ID),
									FOREIGN KEY(Tasting_Room_ID) REFERENCES Tasting_Room(Tasting_Room_ID)ON DELETE CASCADE ON UPDATE CASCADE, 
                                    FOREIGN KEY(Member_ID)REFERENCES Member(Member_ID)ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE Wineries_Tasting_Room(Wineries_ID INT, Tasting_Room_ID INT, 
									PRIMARY KEY(Wineries_ID, Tasting_Room_ID),
									FOREIGN KEY (Wineries_ID) REFERENCES Wineries(Wineries_ID)ON DELETE CASCADE ON UPDATE CASCADE, 
                                    FOREIGN KEY (Tasting_Room_ID) REFERENCES Tasting_Room(Tasting_Room_ID)ON DELETE CASCADE ON UPDATE CASCADE);



CREATE TABLE Wineries_Wine(Wineries_ID INT, Wines_ID INT, 
								PRIMARY KEY(Wineries_ID, Wines_ID),
								FOREIGN KEY(Wineries_ID) REFERENCES Wineries(Wineries_ID)ON DELETE CASCADE ON UPDATE CASCADE, 
                                FOREIGN KEY (Wines_ID) REFERENCES Wines(Wines_ID)ON DELETE CASCADE ON UPDATE CASCADE); 
																					

CREATE TABLE Wineries_specialty(Wineries_ID INT, specialty_ID INT, 
									PRIMARY KEY(Wineries_ID, specialty_ID),
									FOREIGN KEY(Wineries_ID) REFERENCES Wineries(Wineries_ID)ON DELETE CASCADE ON UPDATE CASCADE, 
                                    FOREIGN KEY(specialty_ID) REFERENCES specialty(specialty_ID)ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE Wineries_Location(Wineries_ID INT , Location_ID INT , 
								PRIMARY KEY(Wineries_ID, Location_ID),
                                FOREIGN KEY(Wineries_ID) REFERENCES Wineries(Wineries_ID)ON DELETE CASCADE ON UPDATE CASCADE,
								FOREIGN KEY(Location_ID) REFERENCES Location(Location_ID)ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Wineries_companies(Wineries_ID INT, companies_ID INT, start_date timestamp, 
								end_date timestamp, Amount_Bought INT, 
								FOREIGN KEY (Wineries_ID) REFERENCES Wineries(Wineries_ID)ON DELETE CASCADE ON UPDATE CASCADE, 
                                FOREIGN KEY (companies_ID) REFERENCES companies(companies_ID)ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE companies_Location(companies_ID INT , Location_ID INT , 
								PRIMARY KEY(companies_ID, Location_ID),
                                FOREIGN KEY(companies_ID) REFERENCES companies(companies_ID)ON DELETE CASCADE ON UPDATE CASCADE,
								FOREIGN KEY(Location_ID) REFERENCES Location(Location_ID)ON DELETE CASCADE ON UPDATE CASCADE);


                 
-- End of Table creation

-- Begin Table INSERTiON ----------------------------------------------------------------------------


           /* Wineries INSERT */

INSERT INTO Wineries(name, symbol) VALUES ('Soto Winery','Phoenix');

INSERT INTO Wineries(name, symbol) VALUES('Landeros Wines','Tower');

INSERT INTO Wineries(name, symbol) VALUES('Flores-Abrego Winery','Falcon');

INSERT INTO Wineries(name, symbol) VALUES('Tazzer Winery','Tasmanian Devil');



			/* specialty INSERT */

INSERT INTO specialty(specialty_name, Description) VALUES ('Spanish Wine',
											'Wine is produced in Spain and is a red wine');

INSERT INTO specialty(specialty_name, Description) VALUES ('Portugal Wine',
											'Red wine that has been made through many 
												traditions passed down the generations');

INSERT INTO specialty(specialty_name, Description) VALUES ('Flori Wine', 
											'Red wine with cinnamON that is aged for 
												in the 2 years in an oak bottle');

INSERT INTO specialty(specialty_name, Description) VALUES ('Midnight Taz', 
											'Red wine that has a bit of spice to go 
												well with red meats');

			/* Wines INSERT */

INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Sunlit Kiss', 100, 'Pinot Noir', 'White', 150, 1);
                    
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Landeros Zin', 100, 'Zinfadel', 'Red', 100, 2);

INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (0, 'White Falcon', 100, 'SauvignON Blanc & Sélmillon', 'White', 50, 3);

INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (2, 'Taz Midnight', 100, 'Malbec & Cabernet Franc', 'Red', 200, 4);

		/* Fluff data for the database in Wines */

INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Dusk Kiss', 100, 'Pinot Noir', 'White', 150, 1); 
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'SauvignON de Soto', 50, 'SauvignON Blanc', 'White', 250, 1); 
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Grigo de Spaina', 50, 'Pinot Grigo', 'White', 100, 1); 
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Spanish Kiss', 50, 'Zinfadel', 'Red', 150, 2);
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Landeros Blend', 70, 'Pinoy Grigo & SauvignON Blanc', 'White', 100, 2);
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Red Falcon', 70, 'Zinfadel', 'Red', 150, 3);
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (2, 'Midnight Spain', 160, 'Malbec & Cabernet Franc', 'Red', 200, 4);
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (1, 'Shiraz Tasmania', 150, 'Malbec & Shiraz', 'Red', 175, 4);
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (2, 'Zinfadel Franc', 120, 'Zinfadel & Cabernet Franc', 'Red', 50, 4);
					
INSERT INTO Wines(wines_age, wines_name, vines_age, grape_blend, color_of_wine, Amount_made, Wineries_ID) 
					VALUES (2, 'Tasmania Sang', 60, 'Tannat & Sanglovese', 'Red', 275, 4);



			/* LocatiON INSERT */

INSERT INTO LocatiON (street, zip_code) VALUES ('67890 Soto St.', '12345');

INSERT INTO Location(zip_code, street) VALUES ('13579', '52637 Landero Ln.');

INSERT INTO Location(zip_code, street) VALUES ('27346', '35677 Abrego Hill');

INSERT INTO Location(zip_code, street) VALUES ('31535', '15167 Tasmania Rd.');

INSERT INTO Location(zip_code, street) VALUES ('53521', '31583 Cotati Rd.');

INSERT INTO Location(zip_code, street) VALUES ('36267', '36712 HuntingtON Rd.');

INSERT INTO Location(zip_code, street) VALUES ('73514', '84820 Del Rio Rd.');

INSERT INTO Location(zip_code, street) VALUES ('13753', '63518 Virginia Rd.');


			/* Tasting_Room INSERT */
            
INSERT INTO Tasting_Room(Amount_sold, Wineries_ID) VALUES (59 , 1);

INSERT INTO Tasting_Room(Amount_sold, Wineries_ID) VALUES (48 , 2);

INSERT INTO Tasting_Room(Amount_sold, Wineries_ID) VALUES (24 , 3);

INSERT INTO Tasting_Room(Amount_sold, Wineries_ID) VALUES (40 , 4);



			/* Member INSERT */ 

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('wineTaster@gmail.com', 'Jeff', 'Smith', '1970-01-25', 'Chase 4567');

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('ZinLover@gmail.com', 'Stephanie', 'Lee', '1980-02-16', 'BofA 3456');

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('GeekWineO@gmail.com', 'David', 'Flori', '1974-07-28', 'USAA 9876');

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('TexWine@gmail.com', 'Brenda', 'Esparza', '1974-11-15', 'Bitcoin 4680');

			/* companies INSERT */ 

INSERT INTO companies(companies_name) VALUES ('Phoenix Indusries');

INSERT INTO companies(companies_name) VALUES ('Eagle Incorporated');

INSERT INTO companies(companies_name) VALUES ('Eastern Politio Resturants');

INSERT INTO companies(companies_name) VALUES ('West Ocean Resturants');


			/* Tasting_Room_Member INSERT */
            
INSERT INTO Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) VALUES (1, 1, TRUE);

INSERT INTO Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) VALUES (2, 1, FALSE);

INSERT INTO Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) VALUES (3, 3, TRUE);

INSERT INTO Tasting_Room_Member(Tasting_Room_ID, Member_ID, Is_Member) VALUES (4, 4, TRUE);


			/* Wineries_companies INSERT */

INSERT INTO Wineries_companies(Wineries_ID, companies_ID, start_date, end_date, Amount_Bought) 
							VALUES (1, 1, '2010-02-16', '2030-01-01', 700);

INSERT INTO Wineries_companies(Wineries_ID, companies_ID, start_date, end_date, Amount_Bought) 
							VALUES (2, 2, '2006-07-26','2030-01-01', 400);

INSERT INTO Wineries_companies(Wineries_ID, companies_ID, start_date, end_date, Amount_Bought) 
							VALUES (3, 3, '2000-01-01','2030-02-01', 345);

INSERT INTO Wineries_companies(Wineries_ID, companies_ID, start_date, end_date, Amount_Bought) 
							VALUES (4, 4, '2016-09-12','2030-01-01', 200);


            /* Wineries_Tasting_Room INSERT */

INSERT INTO Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) VALUES (1,1);

INSERT INTO Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) VALUES (2,2);

INSERT INTO Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) VALUES (3,3);

INSERT INTO Wineries_Tasting_Room(Wineries_ID, Tasting_Room_ID) VALUES (4,4);



            /* Wineries_Wine INSERT */

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (1,1);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (2,2);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (3,3);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (4,4);

	/* Fluff data for Wineries_Wine */

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (1, 5);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (1, 6);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (1, 7);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (2, 8);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (2, 9);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (3, 10);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (4, 11);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (4, 12);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (4, 13);

INSERT INTO Wineries_Wine(Wineries_ID, Wines_ID) VALUES (4, 14);



            /* Wineries_specialty INSERT */
            
INSERT INTO Wineries_specialty(Wineries_ID, specialty_ID) VALUES (1,1);

INSERT INTO Wineries_specialty(Wineries_ID, specialty_ID) VALUES (2,1);

INSERT INTO Wineries_specialty(Wineries_ID, specialty_ID) VALUES (3,3);

INSERT INTO Wineries_specialty(Wineries_ID, specialty_ID) VALUES (4,2);


            /* Wineries_LocatiON INSERT */ 

INSERT INTO Wineries_Location(Wineries_ID, Location_ID) VALUES (1,1);

INSERT INTO Wineries_Location(Wineries_ID, Location_ID) VALUES (2,2);

INSERT INTO Wineries_Location(Wineries_ID, Location_ID) VALUES (3,3);

INSERT INTO Wineries_Location(Wineries_ID, Location_ID) VALUES (4,4);



            /* companies_LocatiON INSERT */

INSERT INTO companies_Location(companies_ID, Location_ID) VALUES (1,5);

INSERT INTO companies_Location(companies_ID, Location_ID) VALUES (2,6);

INSERT INTO companies_Location(companies_ID, Location_ID) VALUES (3,7);

INSERT INTO companies_Location(companies_ID, Location_ID) VALUES (4,8);


-- End of INSERTs -----------------------------------------------------------------------------------


-- Beginning of SQL Queries -------------------------------------------------------------------------


			/* A query utilizing a JOIN between at least three different TABLE. */
	
SELECT Wines_ID, wines_name, Wines.Amount_made, Wineries.name AS Wineries_Name, Wineries_companies.Amount_Bought, companies_name
FROM Wines
LEFT JOIN Wineries ON Wines.Wineries_ID = Wineries.Wineries_ID
LEFT JOIN Wineries_companies ON Wineries.Wineries_ID = Wineries_companies.Wineries_ID
LEFT JOIN companies ON Wineries_companies.companies_ID = companies.companies_ID
GROUP BY Wineries.Wineries_ID;


            
            /* A query using a subquery. */
            
SELECT Wineries.Wineries_ID, name, symbol, Amount_sold, SUM(Member.Member_ID) AS NumMembers
FROM Wineries
LEFT JOIN Wineries_Tasting_Room ON Wineries.Wineries_ID = Wineries_Tasting_Room.Wineries_ID
LEFT JOIN Tasting_Room ON Wineries_Tasting_Room.Tasting_Room_ID = Tasting_Room.Tasting_Room_ID
LEFT JOIN Tasting_Room_Member ON Tasting_Room.Tasting_Room_ID = Tasting_Room_Member.Tasting_Room_ID
LEFT JOIN Member ON Tasting_Room_Member.Member_ID = Member.Member_ID
WHERE name IN (SELECT name
				FROM Wineries
				WHERE symbol = 'Phoenix');

            
            /* a query using GROUP BY */
            
 
SELECT Wines.Wines_ID, wines_name, Amount_made, Wineries.name AS WineriesName, specialty_name 
FROM Wines
LEFT JOIN Wineries_Wine ON Wines.Wines_ID = Wineries_Wine.Wines_ID
LEFT JOIN Wineries ON Wineries_Wine.Wineries_ID = Wineries.Wineries_ID
LEFT JOIN Wineries_specialty ON Wineries.Wineries_ID = Wineries_specialty.Wineries_ID
LEFT JOIN specialty ON Wineries_specialty.specialty_ID = specialty.specialty_ID
GROUP BY Wines_ID;


            
            /* A query utilizing a JOIN, GROUP BY, HAVING and an aggregate function. */
            
SELECT Wineries.name, Is_Member, Member.Member_ID, CONCAT(First_name, ' ', Last_name) AS MembersName, Birthday
FROM Wineries
RIGHT JOIN Tasting_Room ON Wineries.Wineries_ID = Tasting_Room.Wineries_ID
RIGHT JOIN Tasting_Room_Member ON Tasting_Room.Tasting_Room_ID = Tasting_Room_Member.Tasting_Room_ID
RIGHT JOIN Member ON Tasting_Room_Member.Member_ID = Member.Member_ID
WHERE Is_Member != 0
GROUP BY Wineries.Wineries_ID
HAVING COUNT(Member.Member_ID) >= 1;  



            
            /* A query using ORDER BY */
            
SELECT Wineries.name AS WinerysName, specialty_name, Description
FROM Wineries
RIGHT JOIN Wineries_specialty ON Wineries.Wineries_ID = Wineries_specialty.Wineries_ID
RIGHT JOIN specialty ON Wineries_specialty.specialty_ID = specialty.specialty_ID
ORDER BY Wineries.name;            
		


            /* A query using WHERE EXISTS or WHERE NOT EXISTS */
            
SELECT Wineries.name AS WineriesName, CONCAT(street, ', ', zip_code) AS Address
FROM Wineries
LEFT JOIN Wineries_Location ON Wineries.Wineries_ID = Wineries_Location.Wineries_ID
LEFT JOIN Location ON Wineries_Location.Location_ID = Location.Location_ID
WHERE EXISTS (SELECT * 
				FROM Wineries_Wine 
				LEFT JOIN Wines ON Wineries_Wine.Wines_ID = Wines.Wines_ID
				WHERE Wineries.Wineries_ID = Wineries_Wine.Wineries_ID);
            
            
            /* A query using a UNION */
            
SELECT wines_name, Wineries.Wineries_ID   
FROM Wines
LEFT JOIN Wineries ON Wines.Wineries_ID = Wineries.Wineries_ID
WHERE Wines.Wineries_ID >= 7
UNION
SELECT wines_name, Wineries.Wineries_ID
FROM Wines
RIGHT JOIN Wineries ON Wines.Wineries_ID = Wineries.Wineries_ID
WHERE Wines.Wineries_ID < 7;
  

            
            /* A query using DISTINCT */
            
SELECT DISTINCT Wineries.name, Amount_Bought + Amount_sold AS AmountPurchased
FROM Wineries
LEFT JOIN Wineries_Tasting_Room ON Wineries.Wineries_ID = Wineries_Tasting_Room.Wineries_ID
LEFT JOIN Tasting_Room ON Wineries_Tasting_Room.Tasting_Room_ID = Tasting_Room.Tasting_Room_ID
LEFT JOIN Wineries_companies ON Wineries.Wineries_ID = Wineries_companies.Wineries_ID
ORDER BY Wineries.name;             
            


            /* At least one non-trivial data record modificatiON other than INSERT VALUES.
            An example would be an UPDATE WHERE the conditiON includes a query or an 
            INSERT that uses a SELECT. */
            
UPDATE Wineries
SET Wineries.name = (SELECT companies_name
						FROM companies
						WHERE companies_ID = 3)
WHERE Wineries_ID = 3;

select * from companies;

            /* At least one VIEW which uses a GROUP BY, subquery or functiON not used in 
            any other steps. */
            
CREATE OR REPLACE VIEW Num_Wineries as
SELECT Wineries.Wineries_ID, Wineries.name, COUNT(Wineries.Wineries_ID) AS WineriesAmount, COUNT(wines_name) AS WineNameAmount
FROM Wineries
LEFT JOIN Wines ON Wineries.Wineries_ID = Wines.Wineries_ID
GROUP BY Wineries.Wineries_ID;             
            


            /* At least one function */         

DROP FUNCTION IF EXISTS COUNT_Num_TypeOf_Wine;
DELIMITER // 
CREATE FUNCTION COUNT_Num_TypeOf_Wine(_Wineries_ID INT) returns INT
BEGIN 
DECLARE _numWineries INT;

SELECT (WineriesAmount) INTO _numWineries FROM Num_Wineries WHERE Wineries_ID = _Wineries_ID;

RETURN _numWineries;
END//
DELIMITER ;


SELECT Wineries_ID, name, COUNT_Num_TypeOf_Wine(Wineries_ID) as Total_TypeOf_Wines   
FROM Wineries
GROUP BY Wineries_ID;  



            /* At least one stored procedure. */
            
CREATE or replace view Amount_Of_Wines AS
SELECT wines_name, Wines_ID, sum(Amount_made) AS WineTotal, Wineries.name AS Name_Of_Winery
FROM Wines
LEFT JOIN Wineries ON Wines.Wineries_ID = Wineries.Wineries_ID
GROUP BY Wines_ID;
            
            
DROP PROCEDURE IF EXISTS Total_Wines;
DELIMITER //
				CREATE PROCEDURE Total_Wines(_Wineries_ID INT)
                 begin
					SELECT (Name_Of_Winery), _Wineries_ID, wines_name, (WineTotal) FROM Amount_Of_Wines WHERE Wines_ID = _Wineries_ID;
				 end //
                
DELIMITER ;
                 
CALL Total_Wines(3);



			/* Query to get companies and Wineries name and Location, start date, and end date of contract */

SELECT companies_name AS Company, Amount_Bought, Wineries.name AS Winery, 
						COUNT_Num_TypeOf_Wine(Wineries.Wineries_ID) AS NumberOfTypesOfWine, 
						start_date, end_date, CONCAT(street, ', ', Zip_code) AS Company_Location
FROM Wineries
LEFT JOIN Wineries_companies ON Wineries.Wineries_ID = Wineries_companies.Wineries_ID
LEFT JOIN companies ON Wineries_companies.companies_ID = companies.companies_ID
LEFT JOIN companies_Location ON companies.companies_ID = companies_Location.companies_ID
LEFT JOIN Location ON companies_Location.Location_ID = Location.Location_ID
WHERE companies.companies_ID != 0 AND Wineries.Wineries_ID != 0 AND Location.Location_ID != 0
GROUP BY Wineries.Wineries_ID
ORDER BY companies.companies_ID;
 

-- End of SQL Queries -------------------------------------------------------------------------------

