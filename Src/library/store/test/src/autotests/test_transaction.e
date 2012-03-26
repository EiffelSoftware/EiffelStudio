note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TRANSACTION

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

	TESTING_HELPER
		undefine
			default_create
		end

	ACTION
		undefine
			default_create
		redefine
			execute
		end

	RDB_HANDLE
		undefine
			default_create
		end

feature {NONE} -- Prepare

	on_prepare
		do
			perform_login

			set_base
			create book.make
			create session_control.make
			create base_selection.make
			create base_update.make
			create base_store.make
			create base_change.make

			create authors.make (10)
		end

feature -- Test routines

	test
		local
			l_host: like host
			l_repository: like repository
		do
			session_control.connect
			if not session_control.is_connected then
				assert ("Could not connect to database", False)
			else
				load_data

				make_selection

				session_control.disconnect
			end

			assert ("Data in database is not correct.", authors.item ("Paul") = True)
			assert ("Data in database is not correct.", authors.item ("Mike") = True)
			assert ("Data in database is not correct.", authors.item ("Neal") = False)
			assert ("Data in database is not correct.", authors.item ("Lily") = False)
			assert ("Data in database is not correct.", authors.item ("Linda") = True)
			assert ("Data in database is not correct.", authors.item ("Olive") = True)
		end

feature {NONE} -- Implementation

	base_selection: DB_SELECTION

	base_update: DB_CHANGE

	base_store: DB_STORE

	base_change: DB_CHANGE

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	data_file: detachable PLAIN_TEXT_FILE

	book: BOOK2

	filled_book: BOOK2
			-- Filled book to put into database
		do
			create Result.make
			Result.set_author ("Paul")
			Result.set_price (4.0)
			Result.set_quantity (50)
			Result.set_title ("Yangzi River")
			Result.set_double_value (2.3)
		end

	authors: HASH_TABLE [BOOLEAN, STRING]
			-- Authors of the result of execution

feature {NONE}

	perform_login
		local
			tmp_string: STRING
			l_laststring: detachable STRING
		do
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				set_data_source (database_name)
			end

			if db_spec.database_handle_name.is_case_insensitive_equal ("mysql") then
				set_application (database_name)
			end
			login (user_login, user_password)
		end

	load_data
			-- Create table in database with same structure as 'book'
		local
			l_repository: like repository
			l_data_file: like data_file
			l_book: like filled_book
		do
				-- Create the table for book-objects.
				-- The name of this table has already been set to "DB_BOOK_TRANSACTION"
			create l_repository.make (table_name)
			repository := l_repository

			l_repository.load
			if not l_repository.exists then
				l_repository.allocate (book)
				l_repository.load
			end

			reset_data

			base_store.set_repository (l_repository)

				-- Without transaction
			l_book := filled_book
			l_book.set_author ("Paul")
			base_store.put (l_book)
			l_book := filled_book
			l_book.set_author ("Mike")
			base_store.put (l_book)

				-- Transaction, Rollback
			session_control.begin
			l_book := filled_book
			l_book.set_author ("Neal")
			base_store.put (l_book)
			l_book := filled_book
			l_book.set_author ("Lily")
			base_store.put (l_book)
			session_control.rollback

				-- Transaction
			session_control.begin
			l_book := filled_book
			l_book.set_author ("Linda")
			base_store.put (l_book)
			l_book := filled_book
			l_book.set_author ("Olive")
			base_store.put (l_book)
			session_control.commit
		end

	reset_data
		do
			base_change.modify ("DELETE FROM " + Table_name)
			assert ("Reset data failed: " + base_change.error_message_32, base_change.is_ok)
		end

	make_selection
			-- Select books whose author's name match
			-- a specific name.
			-- The name must be written in upper-case letters, and
			-- enclosed in '%' (This caracter is used by SQL to match
			-- any string of zero or more character)
		do
				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			base_selection.set_action (Current)

				-- Query database.
				-- The reference ":author_name" will be changed to the value of
				-- the Eiffel object referred to by the key "author_name".
			base_selection.query (Select_data)
				-- Iterate through resulting data, and display them
			base_selection.load_result

			base_selection.terminate
		end

	execute
			-- This method is also  used by the class RDB_SELECTION, and is executed after each
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
			-- In this example, it converts a tuple in an eiffel object of type 'book' and
			-- display it using a method of its own class.
		do
			base_selection.object_convert (book)
			base_selection.cursor_to_object

			authors.force (True, book.author)
		end


feature {NONE} -- Constants

	Select_data: STRING =
		"select * from DB_BOOK_TRANSACTION"

	Table_name: STRING =
		"DB_BOOK_TRANSACTION"

end
