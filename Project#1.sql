use jsoto;

/*
	Programmer: Johnathan Soto
    Program: Project#1.sql -- wineryDatabase
    Language: SQL
    Date: Fall 2017
    description: A winery database that keeps track of various 
    
				 wineries: IDs, names, & symbol
                 specialty: IDs, name, description
                 wines: IDs, color, wine Age, wine name, vine age, Grape blend, Amount made
                 Tasting Rooms: IDs, Amount sold
                 Member: IDs, first name, last name, email, birthday, payment
                 companies: IDs, name
                 location: IDs, zip, street
                 
				 , while also keeping track of the TABLE connecting each of the TABLE listed 
				 above.  This data base is keeping records of each TABLE inner contents 
                 (stuff procceding a colon).
                 Connecting each table =
                 
                 wineries_wine
                 wineries_location
                 wineries_specialty
                 wineries_Tasting_Room
                 wineries_companies: start_date, end_date, Amount bought
                 wines_Tasting_Room
                 Tasting_Room_Member: Member?
                 companies_location
                 
				  NOTE: wineries_wine & wineries_Tasting_Room TABLE are backup TABLE in case the relatiON to 
						wineries, wines, or Tasting_Rooms become comprimised in some way.  These are just
						in case TABLE so the REFERENCES and the FOREIGN KEYS can be stored if a glitch
						or unforeseen circumstance were to occur and comprimise the connectiON between each table.


*/

-- All TABLE being CREATEd


CREATE TABLE wineries(wineries_id INT auto_increment PRIMARY KEY, name VARCHAR(50) UNIQUE,
						symbol VARCHAR(25));

CREATE TABLE specialty(specialty_id INT auto_increment PRIMARY KEY, 
						specialty_name VARCHAR(25) UNIQUE, description VARCHAR(100));


CREATE TABLE wines(wines_id INT auto_increment PRIMARY KEY, wines_age INT, 
					wines_name VARCHAR(25), vine_age INT, grape_blend VARCHAR(100),
					UNIQUE(wines_age, wines_name, vine_age, grape_blend), 
					color_of_wine VARCHAR(25), amount_made INT, amount_sold INT, wineries_id INT,
                    FOREIGN KEY(wineries_id) REFERENCES wineries(wineries_id) ON DELETE CASCADE ON UPDATE CASCADE);
                        
CREATE TABLE location(location_id INT auto_increment PRIMARY KEY, 
						zip_code VARCHAR(25), street VARCHAR(50));


CREATE TABLE Tasting_Room(Tasting_Room_id INT auto_increment PRIMARY KEY, 
							Amount_sold INT, wineries_id INT,
							FOREIGN KEY(wineries_id) REFERENCES wineries(wineries_id)ON DELETE CASCADE ON UPDATE CASCADE);
                                                                                                                                            
CREATE TABLE Member(Member_id INT auto_increment PRIMARY KEY, email VARCHAR(25) UNIQUE, 
						First_name VARCHAR(25), Last_name VARCHAR(25), Birthday timestamp,
						Payment VARCHAR(50));

CREATE TABLE companies(companies_id INT auto_increment PRIMARY KEY,
						companies_name VARCHAR(50) UNIQUE);

CREATE TABLE Tasting_Room_Member(Tasting_Room_id INT, Member_id INT, Is_Member bool,
									PRIMARY KEY(Tasting_Room_id, Member_id),
									FOREIGN KEY(Tasting_Room_id) REFERENCES Tasting_Room(Tasting_Room_id)ON DELETE CASCADE ON UPDATE CASCADE, 
                                    FOREIGN KEY(Member_id)REFERENCES Member(Member_id)ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE wineries_Tasting_Room(wineries_id INT, Tasting_Room_id INT, 
									PRIMARY KEY(wineries_id, Tasting_Room_id),
									FOREIGN KEY (wineries_id) REFERENCES wineries(wineries_id)ON DELETE CASCADE ON UPDATE CASCADE, 
                                    FOREIGN KEY (Tasting_Room_id) REFERENCES Tasting_Room(Tasting_Room_id)ON DELETE CASCADE ON UPDATE CASCADE);



CREATE TABLE wineries_wine(wineries_id INT, wines_id INT, 
								PRIMARY KEY(wineries_id, wines_id),
								FOREIGN KEY(wineries_id) REFERENCES wineries(wineries_id)ON DELETE CASCADE ON UPDATE CASCADE, 
                                FOREIGN KEY (wines_id) REFERENCES wines(wines_id)ON DELETE CASCADE ON UPDATE CASCADE); 
																					

CREATE TABLE wineries_specialty(wineries_id INT, specialty_id INT, 
									PRIMARY KEY(wineries_id, specialty_id),
									FOREIGN KEY(wineries_id) REFERENCES wineries(wineries_id)ON DELETE CASCADE ON UPDATE CASCADE, 
                                    FOREIGN KEY(specialty_id) REFERENCES specialty(specialty_id)ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE wineries_location(wineries_id INT , location_id INT , 
								PRIMARY KEY(wineries_id, location_id),
                                FOREIGN KEY(wineries_id) REFERENCES wineries(wineries_id)ON DELETE CASCADE ON UPDATE CASCADE,
								FOREIGN KEY(location_id) REFERENCES location(location_id)ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE wineries_companies(wineries_id INT, companies_id INT, start_date timestamp, 
								end_date timestamp, Amount_Bought INT, 
								FOREIGN KEY (wineries_id) REFERENCES wineries(wineries_id)ON DELETE CASCADE ON UPDATE CASCADE, 
                                FOREIGN KEY (companies_id) REFERENCES companies(companies_id)ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE companies_location(companies_id INT , location_id INT , 
								PRIMARY KEY(companies_id, location_id),
                                FOREIGN KEY(companies_id) REFERENCES companies(companies_id)ON DELETE CASCADE ON UPDATE CASCADE,
								FOREIGN KEY(location_id) REFERENCES location(location_id)ON DELETE CASCADE ON UPDATE CASCADE);


                 
-- End of Table creation

-- Begin Table INSERTiON ----------------------------------------------------------------------------


           /* wineries INSERT */

INSERT INTO wineries(name, symbol) VALUES ('Soto winery','Phoenix');

INSERT INTO wineries(name, symbol) VALUES('Landeros wines','Tower');

INSERT INTO wineries(name, symbol) VALUES('Flores-Abrego winery','Falcon');

INSERT INTO wineries(name, symbol) VALUES('Tazzer winery','Tasmanian Devil');



			/* specialty INSERT */

INSERT INTO specialty(specialty_name, description) VALUES ('Spanish wine',
											'wine is produced in Spain and is a red wine');

INSERT INTO specialty(specialty_name, description) VALUES ('Portugal wine',
											'Red wine that has been made through many 
												traditions passed down the generations');

INSERT INTO specialty(specialty_name, description) VALUES ('Flori wine', 
											'Red wine with cinnamON that is aged for 
												in the 2 years in an oak bottle');

INSERT INTO specialty(specialty_name, description) VALUES ('Midnight Taz', 
											'Red wine that has a bit of spice to go 
												well with red meats');

			/* wines INSERT */


INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Sunlit Kiss', 100, 'Pinot Noir', 'White', 150, 1, 50);
                    
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Landeros Zin', 100, 'Zinfadel', 'Red', 100, 2, 70);

INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (0, 'White Falcon', 100, 'Sauvignon Blanc & Sélmillon', 'White', 50, 3, 10);

INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (2, 'Taz Midnight', 100, 'Malbec & Cabernet Franc', 'Red', 200, 4, 150);

		/* Fluff data for the database in wines */

INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Dusk Kiss', 100, 'Pinot Noir', 'White', 150, 1, 60); 
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Sauvignon de Soto', 50, 'Sauvignon Blanc', 'White', 250, 1, 180); 

delete from wines where wines_id = 6;
select * from wines;
update wines set wines_id = 6 where wines_id =19;
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Grigo de Spaina', 50, 'Pinot Grigo', 'White', 100, 1, 40);  

					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Spanish Kiss', 50, 'Zinfadel', 'Red', 150, 2, 40);
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Landeros Blend', 70, 'Pinoy Grigo & Sauvignon Blanc', 'White', 100, 2, 36);
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Red Falcon', 70, 'Zinfadel', 'Red', 150, 3, 100);
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (2, 'Midnight Spain', 160, 'Malbec & Cabernet Franc', 'Red', 200, 4, 156);
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (1, 'Shiraz Tasmania', 150, 'Malbec & Shiraz', 'Red', 175, 4, 146);
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (2, 'Zinfadel Franc', 120, 'Zinfadel & Cabernet Franc', 'Red', 50, 4, 38);
					
INSERT INTO wines(wines_age, wines_name, vine_age, grape_blend, color_of_wine, amount_made, wineries_id, amount_sold) 
					VALUES (2, 'Tasmania Sang', 60, 'Tannat & Sanglovese', 'Red', 275, 4, 275);



			/* location INSERT */

INSERT INTO location (street, zip_code) VALUES ('67890 Soto St.', '12345');

INSERT INTO location(zip_code, street) VALUES ('13579', '52637 Landero Ln.');

INSERT INTO location(zip_code, street) VALUES ('27346', '35677 Abrego Hill');

INSERT INTO location(zip_code, street) VALUES ('31535', '15167 Tasmania Rd.');

INSERT INTO location(zip_code, street) VALUES ('53521', '31583 Cotati Rd.');

INSERT INTO location(zip_code, street) VALUES ('36267', '36712 HuntingtON Rd.');

INSERT INTO location(zip_code, street) VALUES ('73514', '84820 Del Rio Rd.');

INSERT INTO location(zip_code, street) VALUES ('13753', '63518 Virginia Rd.');


			/* Tasting_Room INSERT */
            
INSERT INTO Tasting_Room(Amount_sold, wineries_id) VALUES (59 , 1);

INSERT INTO Tasting_Room(Amount_sold, wineries_id) VALUES (48 , 2);

INSERT INTO Tasting_Room(Amount_sold, wineries_id) VALUES (24 , 3);

INSERT INTO Tasting_Room(Amount_sold, wineries_id) VALUES (40 , 4);



			/* Member INSERT */ 

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('wineTaster@gmail.com', 'Jeff', 'Smith', '1970-01-25', 'Chase 4567');

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('ZinLover@gmail.com', 'Stephanie', 'Lee', '1980-02-16', 'BofA 3456');

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('GeekwineO@gmail.com', 'David', 'Flori', '1974-07-28', 'USAA 9876');

INSERT INTO Member(email, First_name, Last_name, Birthday, Payment) 
				VALUES ('Texwine@gmail.com', 'Brenda', 'Esparza', '1974-11-15', 'Bitcoin 4680');

			/* companies INSERT */ 

INSERT INTO companies(companies_name) VALUES ('Phoenix Indusries');

INSERT INTO companies(companies_name) VALUES ('Eagle Incorporated');

INSERT INTO companies(companies_name) VALUES ('Eastern Politio Resturants');

INSERT INTO companies(companies_name) VALUES ('West Ocean Resturants');


			/* Tasting_Room_Member INSERT */
            
INSERT INTO Tasting_Room_Member(Tasting_Room_id, Member_id, Is_Member) VALUES (1, 1, TRUE);

INSERT INTO Tasting_Room_Member(Tasting_Room_id, Member_id, Is_Member) VALUES (2, 1, FALSE);

INSERT INTO Tasting_Room_Member(Tasting_Room_id, Member_id, Is_Member) VALUES (3, 3, TRUE);

INSERT INTO Tasting_Room_Member(Tasting_Room_id, Member_id, Is_Member) VALUES (4, 4, TRUE);


			/* wineries_companies INSERT */

INSERT INTO wineries_companies(wineries_id, companies_id, start_date, end_date, Amount_Bought) 
							VALUES (1, 1, '2010-02-16', '2030-01-01', 700);

INSERT INTO wineries_companies(wineries_id, companies_id, start_date, end_date, Amount_Bought) 
							VALUES (2, 2, '2006-07-26','2030-01-01', 400);

INSERT INTO wineries_companies(wineries_id, companies_id, start_date, end_date, Amount_Bought) 
							VALUES (3, 3, '2000-01-01','2030-02-01', 345);

INSERT INTO wineries_companies(wineries_id, companies_id, start_date, end_date, Amount_Bought) 
							VALUES (4, 4, '2016-09-12','2030-01-01', 200);


            /* wineries_Tasting_Room INSERT */

INSERT INTO wineries_Tasting_Room(wineries_id, Tasting_Room_id) VALUES (1,1);

INSERT INTO wineries_Tasting_Room(wineries_id, Tasting_Room_id) VALUES (2,2);

INSERT INTO wineries_Tasting_Room(wineries_id, Tasting_Room_id) VALUES (3,3);

INSERT INTO wineries_Tasting_Room(wineries_id, Tasting_Room_id) VALUES (4,4);



            /* wineries_wine INSERT */

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (1,1);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (2,2);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (3,3);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (4,4);

	/* Fluff data for wineries_wine */

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (1, 5);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (1, 6);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (1, 7);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (2, 8);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (2, 9);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (3, 15); 

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (4, 16); 

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (4, 12);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (4, 17);

INSERT INTO wineries_wine(wineries_id, wines_id) VALUES (4, 18);

select * from wines;

            /* wineries_specialty INSERT */
            
INSERT INTO wineries_specialty(wineries_id, specialty_id) VALUES (1,1);

INSERT INTO wineries_specialty(wineries_id, specialty_id) VALUES (2,2);

INSERT INTO wineries_specialty(wineries_id, specialty_id) VALUES (3,3);

INSERT INTO wineries_specialty(wineries_id, specialty_id) VALUES (4,4);


            /* wineries_location INSERT */ 

INSERT INTO wineries_location(wineries_id, location_id) VALUES (1,1);

INSERT INTO wineries_location(wineries_id, location_id) VALUES (2,2);

INSERT INTO wineries_location(wineries_id, location_id) VALUES (3,3);

INSERT INTO wineries_location(wineries_id, location_id) VALUES (4,4);



            /* companies_location INSERT */

INSERT INTO companies_location(companies_id, location_id) VALUES (1,5);

INSERT INTO companies_location(companies_id, location_id) VALUES (2,6);

INSERT INTO companies_location(companies_id, location_id) VALUES (3,7);

INSERT INTO companies_location(companies_id, location_id) VALUES (4,8);


-- End of INSERTs -----------------------------------------------------------------------------------


-- Beginning of SQL Queries -------------------------------------------------------------------------


			/* A query utilizing a JOIN between at least three different TABLE. */
	
SELECT wines_id, wines_name, wines.amount_made, wineries.name AS wineries_Name, wineries_companies.Amount_Bought, companies_name
FROM wines
LEFT JOIN wineries ON wines.wineries_id = wineries.wineries_id
LEFT JOIN wineries_companies ON wineries.wineries_id = wineries_companies.wineries_id
LEFT JOIN companies ON wineries_companies.companies_id = companies.companies_id
GROUP BY wineries.wineries_id;


            
            /* A query using a subquery. */
            
SELECT wineries.wineries_id, name, symbol, Amount_sold, SUM(Member.Member_id) AS NumMembers
FROM wineries
LEFT JOIN wineries_Tasting_Room ON wineries.wineries_id = wineries_Tasting_Room.wineries_id
LEFT JOIN Tasting_Room ON wineries_Tasting_Room.Tasting_Room_id = Tasting_Room.Tasting_Room_id
LEFT JOIN Tasting_Room_Member ON Tasting_Room.Tasting_Room_id = Tasting_Room_Member.Tasting_Room_id
LEFT JOIN Member ON Tasting_Room_Member.Member_id = Member.Member_id
WHERE name IN (SELECT name
				FROM wineries
				WHERE symbol = 'Phoenix');

            
            /* a query using GROUP BY */
            
 
SELECT wines.wines_id, wines_name, amount_made, wineries.name AS wineriesName, specialty_name 
FROM wines
LEFT JOIN wineries_wine ON wines.wines_id = wineries_wine.wines_id
LEFT JOIN wineries ON wineries_wine.wineries_id = wineries.wineries_id
LEFT JOIN wineries_specialty ON wineries.wineries_id = wineries_specialty.wineries_id
LEFT JOIN specialty ON wineries_specialty.specialty_id = specialty.specialty_id
GROUP BY wines_id;


            
            /* A query utilizing a JOIN, GROUP BY, HAVING and an aggregate function. */
            
SELECT wineries.name, Is_Member, Member.Member_id, CONCAT(First_name, ' ', Last_name) AS MembersName, Birthday
FROM wineries
RIGHT JOIN Tasting_Room ON wineries.wineries_id = Tasting_Room.wineries_id
RIGHT JOIN Tasting_Room_Member ON Tasting_Room.Tasting_Room_id = Tasting_Room_Member.Tasting_Room_id
RIGHT JOIN Member ON Tasting_Room_Member.Member_id = Member.Member_id
WHERE Is_Member != 0
GROUP BY wineries.wineries_id
HAVING COUNT(Member.Member_id) >= 1;  



            
            /* A query using ORDER BY */
            
SELECT wineries.name AS winerysName, specialty_name, description
FROM wineries
RIGHT JOIN wineries_specialty ON wineries.wineries_id = wineries_specialty.wineries_id
RIGHT JOIN specialty ON wineries_specialty.specialty_id = specialty.specialty_id
ORDER BY wineries.name;            
		


            /* A query using WHERE EXISTS or WHERE NOT EXISTS */
            
SELECT wineries.name AS wineriesName, CONCAT(street, ', ', zip_code) AS Address
FROM wineries
LEFT JOIN wineries_location ON wineries.wineries_id = wineries_location.wineries_id
LEFT JOIN location ON wineries_location.location_id = location.location_id
WHERE EXISTS (SELECT * 
				FROM wineries_wine 
				LEFT JOIN wines ON wineries_wine.wines_id = wines.wines_id
				WHERE wineries.wineries_id = wineries_wine.wineries_id);
            
            
            /* A query using a UNION */
            
SELECT wines_name, wineries.wineries_id   
FROM wines
LEFT JOIN wineries ON wines.wineries_id = wineries.wineries_id
WHERE wines.wineries_id >= 7
UNION
SELECT wines_name, wineries.wineries_id
FROM wines
RIGHT JOIN wineries ON wines.wineries_id = wineries.wineries_id
WHERE wines.wineries_id < 7;
  

            
            /* A query using DISTINCT */
            
SELECT DISTINCT wineries.name, Amount_Bought + Amount_sold AS AmountPurchased
FROM wineries
LEFT JOIN wineries_Tasting_Room ON wineries.wineries_id = wineries_Tasting_Room.wineries_id
LEFT JOIN Tasting_Room ON wineries_Tasting_Room.Tasting_Room_id = Tasting_Room.Tasting_Room_id
LEFT JOIN wineries_companies ON wineries.wineries_id = wineries_companies.wineries_id
ORDER BY wineries.name;             
            


            /* At least one non-trivial data record modificatiON other than INSERT VALUES.
            An example would be an UPDATE WHERE the conditiON includes a query or an 
            INSERT that uses a SELECT. */
            
UPDATE wineries
SET wineries.name = (SELECT companies_name
						FROM companies
						WHERE companies_id = 3)
WHERE wineries_id = 3;

select * from companies;

            /* At least one VIEW which uses a GROUP BY, subquery or functiON not used in 
            any other steps. */
            
CREATE OR REPLACE VIEW Num_wineries as
SELECT wineries.wineries_id, wineries.name, COUNT(wineries.wineries_id) AS wineriesAmount, COUNT(wines_name) AS wineNameAmount
FROM wineries
LEFT JOIN wines ON wineries.wineries_id = wines.wineries_id
GROUP BY wineries.wineries_id;             
            


            /* At least one function */         

DROP FUNCTION IF EXISTS COUNT_Num_TypeOf_wine;
DELIMITER // 
CREATE FUNCTION COUNT_Num_TypeOf_wine(_wineries_id INT) returns INT
BEGIN 
DECLARE _numwineries INT;

SELECT (wineriesAmount) INTO _numwineries FROM Num_wineries WHERE wineries_id = _wineries_id;

RETURN _numwineries;
END//
DELIMITER ;


SELECT wineries_id, name, COUNT_Num_TypeOf_wine(wineries_id) as Total_TypeOf_wines   
FROM wineries
GROUP BY wineries_id;  



            /* At least one stored procedure. */
            
CREATE or replace view Amount_Of_wines AS
SELECT wines_name, wines_id, sum(amount_made) AS wineTotal, wineries.name AS Name_Of_winery
FROM wines
LEFT JOIN wineries ON wines.wineries_id = wineries.wineries_id
GROUP BY wines_id;
            
            
DROP PROCEDURE IF EXISTS Total_wines;
DELIMITER //
				CREATE PROCEDURE Total_wines(_wineries_id INT)
                 begin
					SELECT (Name_Of_winery), _wineries_id, wines_name, (wineTotal) FROM Amount_Of_wines WHERE wines_id = _wineries_id;
				 end //
                
DELIMITER ;
                 
CALL Total_wines(3);



			/* Query to get companies and wineries name and location, start date, and end date of contract */

SELECT companies_name AS Company, Amount_Bought, wineries.name AS winery, 
						COUNT_Num_TypeOf_wine(wineries.wineries_id) AS NumberOfTypesOfwine, 
						start_date, end_date, CONCAT(street, ', ', Zip_code) AS Company_location
FROM wineries
LEFT JOIN wineries_companies ON wineries.wineries_id = wineries_companies.wineries_id
LEFT JOIN companies ON wineries_companies.companies_id = companies.companies_id
LEFT JOIN companies_location ON companies.companies_id = companies_location.companies_id
LEFT JOIN location ON companies_location.location_id = location.location_id
WHERE companies.companies_id != 0 AND wineries.wineries_id != 0 AND location.location_id != 0
GROUP BY wineries.wineries_id
ORDER BY companies.companies_id;
 

-- End of SQL Queries -------------------------------------------------------------------------------



-- WEBSTORM PROCEDURES ------------------------------------------------------------------------------


--         companies Get info

CREATE OR REPLACE VIEW companiesGetById AS
SELECT c.*, a.street, a.zip_code FROM companies c 
        LEFT JOIN companies_location ca on ca.companies_id = c.companies_id 
        LEFT JOIN location a on a.location_id = ca.location_id;


DROP PROCEDURE IF EXISTS companies_getinfo;

DELIMITER //
CREATE PROCEDURE companies_getinfo (_companies_id int)
BEGIN

SELECT * FROM companies WHERE companies_id in (SELECT companies_id FROM companies
												WHERE companies_id = _companies_id);

SELECT a.*, s.companies_id FROM location a
LEFT JOIN companies_location s on s.location_id = a.location_id AND companies_id = _companies_id;

END //
DELIMITER ;


--         wines get info

DROP PROCEDURE IF EXISTS wines_getinfo;

DELIMITER // 
CREATE PROCEDURE wines_getinfo(_wines_id INT)
BEGIN

SELECT * FROM wines WHERE wines_id = _wines_id;

SELECT ws.name, ww.wines_id FROM wineries ws
LEFT JOIN wines ww ON ww.wineries_id = ws.wineries_id 
WHERE wines_id = _wines_id;

END //
DELIMITER ;



--         All wineries in table

DROP PROCEDURE IF EXISTS all_wineries;

DELIMITER //
CREATE PROCEDURE all_wineries()
BEGIN 

SELECT w.wineries_id, w.name FROM wineries w;

END //
DELIMITER ;
SELECT w.wineries_id, w.name FROM wineries w;



--        wineries get info


DROP PROCEDURE IF EXISTS wineries_getinfo;

DELIMITER //
CREATE PROCEDURE wineries_getinfo(_wineries_id int)
BEGIN

SELECT * FROM wineries w WHERE w.wineries_id = _wineries_id;

SELECT wc.wineries_id, wc.companies_id, c.companies_name FROM wineries_companies wc
JOIN companies c ON c.companies_id = wc.companies_id
WHERE wc.wineries_id = _wineries_id;

SELECT wl.*, l.* FROM wineries_location wl
JOIN location l ON l.location_id = wl.location_id
WHERE wl.wineries_id = _wineries_id;

SELECT ws.*, s.specialty_name FROM wineries_specialty ws
JOIN specialty s ON s.specialty_id = ws.specialty_id
WHERE ws.wineries_id = _wineries_id;

END //
DELIMITER ;




--  Get the location, companies, and specialty table info

CREATE OR REPLACE VIEW companiesView AS
SELECT wc.wineries_id, wc.companies_id, c.companies_name FROM wineries_companies wc
JOIN companies c ON c.companies_id = wc.companies_id
GROUP BY c.companies_name;


DROP PROCEDURE IF EXISTS all_companies_location_specialty;

DELIMITER //
CREATE PROCEDURE all_companies_location_specialty()
BEGIN 

SELECT * FROM companiesView;

SELECT wl.*, l.* FROM wineries_location wl
JOIN location l ON l.location_id = wl.location_id;

SELECT ws.*, s.specialty_name FROM wineries_specialty ws
JOIN specialty s ON s.specialty_id = ws.specialty_id
GROUP BY s.specialty_name;

END //
DELIMITER ; 


-- User input to wine age testing for in use in webstorm getALL

SELECT w.wines_name, w.amount_made, SUM(amount_made-amount_sold) AS TotalWine, 
		wr.name, wr.symbol, s.specialty_name, s.description, CONCAT(l.street, ', ', l.zip_code) AS Wlocation
FROM wines w
JOIN wineries wr ON wr.wineries_id = w.wineries_id
JOIN wineries_specialty ws ON ws.wineries_id = wr.wineries_id
JOIN specialty s ON s.specialty_id = ws.specialty_id
JOIN wineries_location wl ON wl.wineries_id = wr.wineries_id
JOIN location l ON l.location_id = wl.location_id
GROUP BY w.wines_id
HAVING w.wines_id = 1;
		












