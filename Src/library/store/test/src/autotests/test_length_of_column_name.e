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

	test
		do
			establish_connection

			if not session_control.is_connected then
				assert ("Could not connect to database", False)
			else
				load_data
				make_selection
			end
			disconnect
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

	book1, book2: BOOK3

	authors: HASH_TABLE [BOOLEAN, STRING]
			-- Authors of the result of execution

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

	Select_data: STRING =
		"select * from DB_LONG_COLUMN_NAME"

	Table_name: STRING =
		"DB_LONG_COLUMN_NAME"

end
