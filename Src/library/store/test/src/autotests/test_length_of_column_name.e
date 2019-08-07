note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_LENGTH_OF_COLUMN_NAME

inherit
	TEST_BASIC_DATABASE

feature -- Test routines

	test_length_of_column_name
		do
				-- We don't do the test for Oracle, because the limit of identifiers is 30 bytes.
				-- See: http://docs.oracle.com/cd/B28359_01/server.111/b28286/sql_elements008.htm#SQLRF00223
			if not is_oracle then
				reset_database
				establish_connection

				if attached session_control as l_control and then not l_control.is_connected then
					assert ("Could not connect to database", False)
				else
					load_data
					make_selection
				end
				disconnect
			end
		end

feature {NONE} -- Implementation

	filled_book: BOOK3
			-- Filled book to put into database
		do
			create Result.make
			Result.set_author ("Paul")
			Result.set_title ("Book Name")
			Result.set_very_long_boolean (True)
		end

	book1, book2: detachable BOOK3

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
		once
			create Result.make (1)
			Result.force (filled_book, Table_name)
		end

feature {NONE} -- Load data

	load_data
			-- Create table in database with same structure as 'book'
		local
			l_book: like filled_book
		do
			prepare_repository (table_name)

			if attached base_stores.item (table_name) as l_db_store then
					-- Without transaction
				l_book := filled_book
				l_book.set_author ("Paul")
				l_book.set_very_long_boolean (True)
				l_db_store.put (l_book)
				book1 := l_book

				l_book := filled_book
				l_book.set_author ("Mike")
				l_book.set_very_long_boolean (False)
				l_db_store.put (l_book)
				book2 := l_book
			end
		end

feature {NONE} -- Selection

	make_selection
			-- Select books
		local
			l_list: ARRAYED_LIST [like filled_book]
		do
			l_list := load_list_with_select (Select_data, filled_book)
			if l_list.count = 2 then
				assert ("Book1 is not expected", l_list.i_th (1) ~ book1)
				assert ("Book2 is not expected", l_list.i_th (2) ~ book2)
			else
				assert ("NUmber of result is not expected", False)
			end
		end

feature {NONE} -- Constants

	Select_data: STRING
		do
			Result := "select * from " + sql_table_name (Table_name)
		end

	Table_name: STRING
		once
			if is_mysql then
					-- In MySQL Server, there is a hard limit of 64 character for the name of a table.
				Result := "DB_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_LONG_COLUMN_NAME"
			else
					-- In ODBC SQL Server, there is a hard limit of 128 character for the name of a table.
				Result := "DB_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_VERY_LONG_COLUMN_NAME"
			end
		end

end
