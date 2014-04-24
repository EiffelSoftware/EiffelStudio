note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_LIMITS

inherit
	TEST_BASIC_DATABASE

feature -- Test routines

	test_many_open_selection
			-- Test select using non extended type.
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
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

	basic_select_load_data
			-- Create table in database with same structure as 'book'
		local
			l_book: like basic_select_create_data
			l_table_name: STRING
		do
			prepare_repository (basic_select_table_name)

			if attached base_stores.item (basic_select_table_name) as l_db_store then
				l_book := basic_select_create_data
				l_db_store.put (l_book)
			end

				-- Put more data using direct SQL
			if is_mysql then
				execute_query ("insert into DB_LIMITS (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, str_to_date('1973', '%%Y'), 3.5)")
			end

			if is_odbc then
				l_table_name := sql_table_name (basic_select_table_name)
				execute_query ("insert into " + l_table_name + " (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, " + sql_from_datetime (create {DATE_TIME}.make (1973, 1, 1, 0, 0, 0)) + ", 23.767)")
			end

			if is_oracle then
				execute_query ("insert into DB_LIMITS (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, to_date('1973', 'YYYY'), 3.5)")
			end

			if is_sybase then
				execute_query ("insert into DB_LIMITS (title, author, quantity, price, year, double_value) values ('Simula Begin', 'Birtwistle et al.', 12, 4, '01/01/1973', 23.767)")
			end
		end

	basic_select_make_selection
			-- Select books
		local
			l_selection: DB_SELECTION
			i: INTEGER
		do
			if attached session_control as l_session then
					-- Showing that repeating the same selection 1000 times is ok if
					-- we terminate it at each iteration.
				from
					l_selection := db_selection
					l_selection.set_query (basic_select_select_data)
				until
					i > 1000
				loop
					l_session.reset
					l_selection.execute_query
					l_selection.terminate
					i := i + 1
				end

					-- Now try again without calling terminate. Then `is_allocatable' should
					-- eventually be False but not before having done 10 selections at the very least.
				from
					l_selection := db_selection
					l_selection.set_query (basic_select_select_data)
					i := 0
				until
					i > 1000 or not l_selection.is_ok
				loop
					l_session.reset
					l_selection.execute_query
					i := i + 1
				end
				assert ("At least ten", i >= 10)
				assert ("No more descriptor", not l_selection.is_allocatable);
			end
		end

	basic_select_select_data: STRING
		do
			Result := "select * from " + sql_table_name (basic_select_table_name) + " where author = :author_name order by quantity"
		end

	basic_select_table_name: STRING = "DB_LIMITS"

end
