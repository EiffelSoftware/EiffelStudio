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
	EQA_TEST_SET
		redefine
			on_prepare
		end

	TESTING_HELPER
		undefine
			default_create
		end

	RDB_HANDLE
		undefine
			default_create
		end

	TEST_DATABASE_MANAGER
		undefine
			default_create
		end

feature {NONE} -- Prepare

	on_prepare
		local
			l_login: like Manager.current_session.session_login
		do
			set_connection_information (user_login, user_password, database_name)
			l_login := Manager.current_session.session_login
			l_login.set_application (database_name)	-- For MySQL
		end

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

	base_store: DB_STORE

	repository: detachable DB_REPOSITORY

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

feature {NONE}

	load_data
			-- Create table in database with same structure as 'book'
		local
			l_repository: like repository
			l_book: like filled_book
		do
				-- Create the table for book-objects.
			create l_repository.make (table_name)
			repository := l_repository

			l_repository.load

			if l_repository.exists then
				reset_data
				l_repository.load
			end

			l_repository.allocate (filled_book)
			l_repository.load

			create base_store.make
			base_store.set_repository (l_repository)

				-- Without transaction
			l_book := filled_book
			l_book.set_author ("Paul")
			l_book.set_very_long_boolean (True)
			base_store.put (l_book)
			book1 := l_book

			l_book := filled_book
			l_book.set_author ("Mike")
			l_book.set_very_long_boolean (False)
			base_store.put (l_book)
			book2 := l_book
		end

	reset_data
		do
			db_change.modify ("DROP TABLE " + Table_name)
			assert ("Reset data failed: " + db_change.error_message_32, db_change.is_ok)
		end

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
