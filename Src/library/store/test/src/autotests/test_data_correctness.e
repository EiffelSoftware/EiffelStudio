note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_DATA_CORRECTNESS

inherit
	TEST_BASIC_DATABASE

feature -- Test routines

	test_quotes_in_string
			-- Test `"' appears in a string.
		do
			reset_database
			establish_connection

			if attached session_control as l_control and then not l_control.is_connected then
				assert ("Could not connect to database", False)
			else
				quotes_in_string_load_data
				quotes_in_string_make_selection
			end
			disconnect
		end

	test_trailing_blanks
			-- Test trailing `%U'
		do
			if is_odbc then
				reset_database
				establish_connection

				if attached session_control as l_control and then not l_control.is_connected then
					assert ("Could not connect to database", False)
				else
					trailing_blanks_load_data
					trailing_blanks_make_selection
				end
				disconnect
			end
		end

feature {NONE} -- Implementation

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
			Result.force (quotes_in_string_create_data, quotes_in_string_table_name)
		end

feature {NONE} -- Quotes in string

	quotes_in_string_create_data: BOOK2
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

	quotes_in_string_data: detachable BOOK2

	quotes_in_string_load_data
			-- Create table in database with same structure as 'book'
		local
			l_book: like quotes_in_string_create_data
		do
			prepare_repository (quotes_in_string_table_name)

			if attached base_stores.item (quotes_in_string_table_name) as l_db_store then
				l_book := quotes_in_string_create_data
				l_db_store.put (l_book)
				quotes_in_string_data := l_book
			end
		end

	quotes_in_string_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like quotes_in_string_create_data]
		do
			l_list := load_list_with_select (quotes_in_string_select_data, quotes_in_string_create_data)
			if l_list.count = 1 then
				assert ("Book1 is not expected", l_list.i_th (1) ~ quotes_in_string_data)
			else
				assert ("Number of result is not expected", False)
			end
		end

	quotes_in_string_select_data: STRING
		do
			Result := "select * from " + sql_table_name (quotes_in_string_table_name)
		end

	quotes_in_string_table_name: STRING = "DB_SYMBOLS_TABLE"

feature {NONE} -- Trailing blanks

	trailing_blanks_create_data: IMAGE_DATA
		do
			create Result.make
		end

	trailing_blanks_load_data
			-- Create table in database with same structure as 'book'
		local
			l_repository: DB_REPOSITORY
		do
				-- Remove the table
			create l_repository.make (trailing_blanks_table_name)
			repositories.force (l_repository, trailing_blanks_table_name)
			l_repository.load

			if l_repository.exists then
				reset_data (trailing_blanks_table_name)
				l_repository.load
			end
				-- Create the table
			execute_query (trailing_blanks_create_table)
			assert ("DB Error occurred" + Db_change.utf_8_error_message, Db_change.is_ok)

				-- Insert data
			execute_query (trailing_blanks_insert_data)
			assert ("DB Error occurred" + Db_change.utf_8_error_message, Db_change.is_ok)
		end

	trailing_blanks_make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like trailing_blanks_create_data]
		do
			l_list := load_list_with_select (trailing_blanks_select_data, trailing_blanks_create_data)
			if l_list.count = 1 then
				assert ("Result is not expected", l_list.i_th (1).my_image.starts_with (bm_data))
			else
				assert ("Number of result is not expected", False)
			end
		end

	trailing_blanks_select_data: STRING =
		"select * from DB_TRAILING_BLANKS_TABLE"

	trailing_blanks_table_name: STRING = "DB_TRAILING_BLANKS_TABLE"

	trailing_blanks_create_table: STRING = "CREATE TABLE DB_TRAILING_BLANKS_TABLE ([id] [int] IDENTITY(1,1) NOT NULL, [my_image] [image] NULL)"

	trailing_blanks_insert_data: STRING = "INSERT INTO DB_TRAILING_BLANKS_TABLE (my_image) VALUES (CAST('BM¶[1]%U%U%U%U%U%U6' as binary))"

	bm_data: STRING = "BM¶[1]%U%U%U%U%U%U6"

end


