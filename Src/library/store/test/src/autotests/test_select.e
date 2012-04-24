note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_SELECT

inherit
	TEST_BASIC_DATABASE

feature -- Test routines

	test_basic_select
			-- Test select using non extended type.
		do
			establish_connection

			if not session_control.is_connected then
				assert ("Could not connect to database", False)
			else
				basic_select_load_data
				basic_select_make_selection
			end
			disconnect
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
			Result.force (create {BOOK2}.make, basic_select_table_name)
		end

feature {NONE} -- Basic select

	basic_select_create_data: BOOK2
			-- Filled book to put into database
		do
			create Result.make
			Result.set_author ("Paul")
			Result.set_price (4.0)
			Result.set_quantity (50)
			Result.set_title ("%"Yangzi River\'")
			Result.set_double_value (2.3)
			Result.set_year (1980)
		end

	basic_select_data: BOOK2

	basic_select_load_data
			-- Create table in database with same structure as 'book'
		local
			l_book: like basic_select_create_data
		do
			prepare_repository (basic_select_table_name)

			if attached base_stores.item (basic_select_table_name) as l_db_store then
				l_book := basic_select_create_data
				l_db_store.put (l_book)
				basic_select_data := l_book
			end

				-- Put more data using direct SQL
			if is_mysql then
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, str_to_date('1973', '%%Y'), 3.5)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Libraries', 'Bertrand Meyer', 11, 20, str_to_date('1994', '%%Y'), 435.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Language', 'Bertrand Meyer', 9, 51, str_to_date('1992', '%%Y'), 3254.6767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Development', 'Grady Booch', 5, 40.50, str_to_date('1986', '%%Y'), 456)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Programming', 'Brad J. Cox', 2, 38.25, str_to_date('1984', '%%Y'), 45.675)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('The C++ Programming Language', 'Bjarne Stroustrup', 19, 60.50, str_to_date('1984', '%%Y'), 412.786)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Special issue on Smalltalk-80', 'Adele Golberg et al.', 2, 0.0, str_to_date('1981', '%%Y'), 376.867667)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Data Models for Object-Oriented Applications', 'Banergie et al.', 2, 0.0, str_to_date('1987', '%%Y'), 323.767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Programming in Modula-2', 'N. Wirth', 2, 6.34, str_to_date('1982', '%%Y'), 32.665)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Common Objects an overview', 'A. Snyder', 17, 33.95, str_to_date('1986', '%%Y'), 435.66)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Smalltalk-80 Bits of history', 'G. Krasner', 2, 0.0, str_to_date('1983', '%%Y'), 34.665)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('OO programming with Flavors', 'D.A. Moon', 4, 17.45, str_to_date('1986', '%%Y'), 44.656)")
			end

			if is_odbc then
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, {d '1973-01-01'}, 23.767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Libraries', 'Bertrand Meyer', 11, 20, {d '1994-01-02'}, 435.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Language', 'Bertrand Meyer', 9, 51, {d '1992-02-03'}, 3254.6767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Development', 'Grady Booch', 5, 40.50, {d '1986-08-09'}, 345.665)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Programming', 'Brad J. Cox', 2, 38.25, {d '1984-04-05'}, 3443.65)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('The C++ Programming Language', 'Bjarne Stroustrup', 19, 60.50, {d '1984-04-05'}, 5.65)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Special issue on Smalltalk-80', 'Adele Golberg et al.', 2, 0.0, {d '1981-01-02'}, 343.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Data Models for Object-Oriented Applications', 'Banergie et al.', 2, 0.0, {d '1987-07-08'}, 34.65)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Programming in Modula-2', 'N. Wirth', 2, 6.34, {d '1982-02-03'}, 344.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Common Objects an overview', 'A. Snyder', 17, 33.95, {d '1986-06-07'}, 346.5)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Smalltalk-80 Bits of history', 'G. Krasner', 2, 0.0, {d '1983-03-04'}, 34543)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('OO programming with Flavors', 'D.A. Moon', 4, 17.45, {d '1986-06-07'}, 7898.3423)")
			end

			if is_oracle then
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, to_date('1973', 'YYYY'), 3.5)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Libraries', 'Bertrand Meyer', 11, 20, to_date('1994', 'YYYY'), 435.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Language', 'Bertrand Meyer', 9, 51, to_date('1992', 'YYYY'), 3254.6767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Development', 'Grady Booch', 5, 40.50, to_date('1986', 'YYYY'), 456)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Programming', 'Brad J. Cox', 2, 38.25, to_date('1984', 'YYYY'), 45.675)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('The C++ Programming Language', 'Bjarne Stroustrup', 19, 60.50, to_date('1984', 'YYYY'), 412.786)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Special issue on Smalltalk-80', 'Adele Golberg et al.', 2, 0.0, to_date('1981', 'YYYY'), 376.867667)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Data Models for Object-Oriented Applications', 'Banergie et al.', 2, 0.0, to_date('1987', 'YYYY'), 323.767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Programming in Modula-2', 'N. Wirth', 2, 6.34, to_date('1982', 'YYYY'), 32.665)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Common Objects an overview', 'A. Snyder', 17, 33.95, to_date('1986', 'YYYY'), 435.66)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Smalltalk-80 Bits of history', 'G. Krasner', 2, 0.0, to_date('1983', 'YYYY'), 34.665)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('OO programming with Flavors', 'D.A. Moon', 4, 17.45, to_date('1986', 'YYYY'), 44.656)")
			end

			if is_sybase then
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, '01/01/1973', 23.767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Libraries', 'Bertrand Meyer', 11, 20, '01/01/1994', 435.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Eiffel The Language', 'Bertrand Meyer', 9, 51, '01/01/1992', 3254.6767)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Development', 'Grady Booch', 5, 40.50, '01/01/1986', 345.665)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('ObjectOriented Programming', 'Brad J. Cox', 2, 38.25, '01/01/1984', 3443.65)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('The C++ Programming Language', 'Bjarne Stroustrup', 19, 60.50, '01/01/1984', 1345.65)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Special issue on Smalltalk-80', 'Adele Golberg et al.', 2, 0.0, '01/01/1981', 343.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Data Models for Object-Oriented Applications', 'Banergie et al.', 2, 0.0, '01/01/1987', 34.65)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Programming in Modula-2', 'N. Wirth', 2, 6.34, '01/01/1982', 344.6)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Common Objects an overview', 'A. Snyder', 17, 33.95, '01/01/1986', 346.5)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('Smalltalk-80 Bits of history', 'G. Krasner', 2, 0.0, '01/01/1983', 34543)")
				execute_query ("insert into DB_BASIC_SELECT (title, author, quantity, price, year, double_value) values ('OO programming with Flavors', 'D.A. Moon', 4, 17.45, '01/01/1986', 7898.3423)")
			end
		end

	basic_select_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like basic_select_create_data]
		do
			db_selection.set_map_name ("Bertrand Meyer", "author_name")
			l_list := load_list_with_select (basic_select_select_data, basic_select_create_data)
			if l_list.count = 2 then
				assert ("Result is not expected", l_list.i_th (1).title ~ "Eiffel The Language" and then
													l_list.i_th (1).author ~ "Bertrand Meyer" and then
													l_list.i_th (1).quantity = 9 and then
													l_list.i_th (1).price = 51 and then
													l_list.i_th (1).year.date.year = 1992 and then
													l_list.i_th (1).double_value = 3254.6767
													)

				assert ("Result is not expected", l_list.i_th (2).title ~ "Eiffel The Libraries" and then
													l_list.i_th (2).author ~ "Bertrand Meyer" and then
													l_list.i_th (2).quantity = 11 and then
													l_list.i_th (2).price = 20 and then
													l_list.i_th (2).year.date.year = 1994 and then
													l_list.i_th (2).double_value = 435.6
													)
			else
				assert ("Number of results is not expected", False)
			end
		end

	basic_select_select_data: STRING =
		"select * from DB_BASIC_SELECT where author = :author_name order by quantity"

	basic_select_table_name: STRING = "DB_BASIC_SELECT"

end
