note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 86764 $"

class TRANSACTION

inherit
	ACTION
		redefine
			execute
		end

	RDB_HANDLE

create
	make

feature {NONE}

	base_selection: DB_SELECTION

	base_update: DB_CHANGE

	base_store: DB_STORE

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

feature

	make
		do
			io.putstring ("Database user authentication:%N")
			perform_login

				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
			set_base

				-- An Eiffel object is created. It will be stored in the DB,
				-- through the repository
			create book.make

				-- Create usefull classes
				-- 'session_control' provides informations control access and
				--  the status of the database.
				-- 'base_selection' provides a SELECT query mechanism.
			create session_control.make
			create base_selection.make
			create base_update.make
			create base_store.make

				-- Start session: establishes connection to database
			session_control.connect
			if not session_control.is_connected then
				session_control.raise_error
					-- Something went wrong, and the connection failed
				io.putstring ("%NCan't connect to database.%N")
			else
				load_data
					-- Ask the user for a SELECT statement, and execute it
				make_selection
					-- Terminate session
				session_control.disconnect
			end
		end

feature {NONE}

	perform_login
		local
			tmp_string: STRING
			l_laststring: detachable STRING
		do
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				io.putstring ("Data Source Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_data_source(l_laststring.twin)
			end

			if db_spec.database_handle_name.is_case_insensitive_equal ("mysql") then
				io.putstring ("Schema Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_application(l_laststring.twin)
			end

				-- Ask for user's name and password
			io.putstring ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			tmp_string := l_laststring.twin
			io.putstring ("Password: ")
			io.readline

				-- Set user's name and password
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			login (tmp_string, l_laststring)
		end

	load_data
			-- Create table in database with same structure as 'book'
		local
			l_repository: like repository
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

			base_store.set_repository (l_repository)

				-- Without transaction
			l_book := filled_book
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
			l_book.set_author ("Mike")
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

	make_selection
			-- Select books whose author's name match
			-- a specific name.
			-- The name must be written in upper-case letters, and
			-- enclosed in '%' (This caracter is used by SQL to match
			-- any string of zero or more character)
		do
			io.putstring ("Selecting data from database: %N")
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
			print (book)
			io.new_line
		end

feature {NONE}

	Select_data: STRING =
		"select * from DB_BOOK_TRANSACTION"

	Table_name: STRING =
		"DB_BOOK_TRANSACTION"

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SELECTOR
