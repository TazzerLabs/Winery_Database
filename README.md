# Winery_Database
A small Winery database made in SQL that is part of a project that will include a web application later on.
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
