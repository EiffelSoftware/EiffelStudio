note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EXTENDED_SELECT

inherit
	TEST_BASIC_DATABASE
		redefine
			on_prepare
		end

feature {NONE} -- Prepare

	on_prepare
			-- Prepare
		do
			Precursor;
			(create {GLOBAL_SETTINGS}).set_use_extended_types (True)
		end

feature -- Test routines

	test_extended_select
			-- Test select using extended type
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				extended_select_load_data
				extended_select_make_selection
			end
			disconnect
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
			Result.force (create {BOOK4}.make, extended_select_table_name)
		end

feature {NONE} -- Basic select

	extended_select_create_data: BOOK4
			-- Filled book to put into database
		do
			create Result.make
			Result.set_author ("Paul")
			Result.set_price (4.0)
			Result.set_quantity (50)
			Result.set_title ({STRING_32} "长江")
			Result.set_double_value (2.3)
		end

	extended_select_load_data
			-- Create table in database with same structure as 'book'
		local
			l_book: like extended_select_create_data
			l_table_name: STRING
		do
			prepare_repository (extended_select_table_name)

			if attached base_stores.item (extended_select_table_name) as l_db_store then
				l_book := extended_select_create_data
				l_db_store.put (l_book)
			end

				-- Put more data using direct SQL
			if is_mysql then
				execute_query ({STRING_32} "insert into DB_EXTENDED_SELECT (title, author, quantity, price, year, double_value) values ('面向对象软件构造', 'Bertrand Meyer', 3, 200.00, {d '1986-06-07'}, 7898.3423)")
				execute_query ({STRING_32} "insert into DB_EXTENDED_SELECT (title, author, quantity, price, year, double_value) values ('Object-Oriented Software Construction', 'Bertrand Meyer', 4, 200.00, {d '1986-06-07'}, 7898.3423)")
			end

			if is_odbc then
				l_table_name := sql_table_name (extended_select_table_name)
				execute_query ({STRING_32} "insert into " + l_table_name + {STRING_32} " (title, author, quantity, price, year, double_value) values (N'面向对象软件构造', 'Bertrand Meyer', 3, 200.00, " + sql_from_datetime (create {DATE_TIME}.make (1986, 6, 7, 0, 0, 0)) + ", 7898.3423)")
				execute_query ({STRING_32} "insert into " + l_table_name + {STRING_32} " (title, author, quantity, price, year, double_value) values ('Object-Oriented Software Construction', 'Bertrand Meyer', 4, 200.00, " + sql_from_datetime (create {DATE_TIME}.make (1986, 6, 7, 0, 0, 0)) + ", 7898.3423)")
			end

			if is_oracle then
					-- Old set of Oracle OCI interface does not support Unicode well.
					-- To support Unicode, OCIEnvNlsCreate could be used.
				execute_query ({STRING_32} "insert into DB_EXTENDED_SELECT (title, author, quantity, price, year, double_value) values ('面向对象软件构造', 'Bertrand Meyer', 4, 200.00, to_date ('1986', 'YYYY'), 7898.3423)")
				execute_query ({STRING_32} "insert into DB_EXTENDED_SELECT (title, author, quantity, price, year, double_value) values ('Object-Oriented Software Construction', 'Bertrand Meyer', 4, 200.00, to_date ('1986', 'YYYY'), 7898.3423)")
			end

			if is_sybase then
				execute_query ({STRING_32} "insert into DB_EXTENDED_SELECT (title, author, quantity, price, year, double_value) values ('面向对象软件构造', 'Bertrand Meyer', 3, 200.00, '1986-06-07', 7898.3423)")
				execute_query ({STRING_32} "insert into DB_EXTENDED_SELECT (title, author, quantity, price, year, double_value) values ('Object-Oriented Software Construction', 'Bertrand Meyer', 4, 200.00, '1986-06-07', 7898.3423)")
			end
		end

	extended_select_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like extended_select_create_data]
		do
			db_selection.set_map_name ("Bertrand Meyer", "author_name")
			l_list := load_list_with_select (extended_select_select_data, extended_select_create_data)
			db_selection.unset_map_name ("author_name")
			if l_list.count = 2 then
				assert ("Result is not expected", l_list.i_th (1).title ~ {STRING_32} "面向对象软件构造")
				assert ("Result is not expected", l_list.i_th (1).author ~ "Bertrand Meyer")
				assert ("Result is not expected", l_list.i_th (1).quantity = 3)
				assert ("Result is not expected", l_list.i_th (1).price = 200)
				assert ("Result is not expected", l_list.i_th (1).year.date.year = 1986)
				assert ("Result is not expected", l_list.i_th (1).double_value = 7898.3423)

				assert ("Result is not expected", l_list.i_th (2).title ~ {STRING_32} "Object-Oriented Software Construction")
				assert ("Result is not expected", l_list.i_th (2).author ~ "Bertrand Meyer")
				assert ("Result is not expected", l_list.i_th (2).quantity = 4)
				assert ("Result is not expected", l_list.i_th (2).price = 200)
				assert ("Result is not expected", l_list.i_th (2).year.date.year = 1986)
				assert ("Result is not expected", l_list.i_th (2).double_value = 7898.3423)
			else
				assert ("Number of results is not expected", False)
			end
		end

	extended_select_select_data: STRING
		do
			Result := "select * from " + sql_table_name (extended_select_table_name) + " where author = :author_name order by quantity"
		end

	extended_select_table_name: STRING = "DB_EXTENDED_SELECT"

end
