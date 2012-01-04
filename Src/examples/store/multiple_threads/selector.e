note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 86764 $"

class SELECTOR

inherit
	ACTION
		rename
			execute as execute_action
		redefine
			execute_action
		end

	RDB_HANDLE

	THREAD

	THREAD_CONTROL

create
	make,
	make_thread

feature {NONE}

	base_selection: DB_SELECTION

	base_update: DB_CHANGE

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	data_file: detachable PLAIN_TEXT_FILE

	book: BOOK2

	login_cell: CELL [detachable LOGIN [DATABASE]]
		once ("process")
			create Result.put (Void)
		end

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
		local
			l_thread: SELECTOR
			i: INTEGER
		do
			thread_print ("Database user authentication:%N")
			perform_login
			login_cell.put (Manager.current_session.session_login)
			make_thread

			from
				i := 1
			until
				i > 5
			loop
				create l_thread.make_thread
				l_thread.launch
				i := i + 1
			end

			join_all
		end

	make_thread
			-- Init with thread
		do
				-- Create usefull classes
				-- 'session_control' provides informations control access and
				--  the status of the database.
				-- 'base_selection' provides a SELECT query mechanism.
			set_base
			create session_control.make
			create base_selection.make
			create base_update.make
			create book.make
		end

	execute
		local
			l_repository: like repository
			l_session: DATABASE_SESSION
		do
			if attached login_cell.item as l_login then
				manager.current_session.set_session_login (l_login.twin)
			end

				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
			set_base

				-- Start session: establishes connection to database
			session_control.connect
			if not session_control.is_connected then
				session_control.raise_error
					-- Something went wrong, and the connection failed
				thread_print ("%NCan't connect to database.%N")
			else
					-- A 'repository' is used to store objects, and to access
					-- them as Eiffel objects, or DB tuples.
					-- The table used to store Eiffel book objects will be called
					-- "DB_BOOK".
				create l_repository.make (Table_name)
				repository := l_repository

					--  The Eiffel program is now connected to the database
					-- Try to load table from the DB
				l_repository.load
					-- There is no existing objects in the DB
				thread_print ("Loading and updating database ...%N")
					-- Load some from file
				load_data
				l_repository.load
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
			l_dsn: detachable STRING
		do
			create l_dsn.make_empty
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				thread_print ("Data Source Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_data_source(l_laststring.twin)
				l_dsn := l_laststring.twin
			end

			if db_spec.database_handle_name.is_case_insensitive_equal ("mysql") then
				thread_print ("Schema Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_application(l_laststring.twin)
			end

				-- Ask for user's name and password
			thread_print ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			tmp_string := l_laststring.twin
			thread_print ("Password: ")
			io.readline

				-- Set user's name and password
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			login (tmp_string, l_laststring)
		end

	load_data
			-- Create table in database with same structure as 'book'
			-- and load data from file 'data.sql'.
		require
			repository_attached: repository /= Void
		local
			l_laststring: detachable STRING
			l_repository: like repository
			l_data_file: like data_file
			l_store: DB_STORE
		do
				-- Create the table for book-objects.
				-- The name of this table has already been set to "DB_BOOK"
			l_repository := repository
			check l_repository /= Void end -- implied by precondition `repostory_attached'
			if not l_repository.exists then
				l_repository.allocate (book)
			end
			session_control.begin

			l_repository.load
			create l_store.make
			l_store.set_repository (l_repository)
			l_store.put (filled_book)

				-- Commit work
			session_control.commit
		end

	make_selection
			-- Select books whose author's name match
			-- a specific name.
			-- The name must be written in upper-case letters, and
			-- enclosed in '%' (This caracter is used by SQL to match
			-- any string of zero or more character)

		local
			author: STRING
			l_laststring: detachable STRING
		do
			thread_print ("Books in storage:%N")

				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			base_selection.set_action (Current)

				-- Query database.
				-- The reference ":author_name" will be changed to the value of
				-- the Eiffel object referred to by the key "author_name".
			base_selection.query (Select_author)
				-- Iterate through resulting data, and display them
			base_selection.load_result
			base_selection.terminate
		end

	execute_action
			-- This method is also  used by the class RDB_SELECTION, and is executed after each
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
			-- In this example, it converts a tuple in an eiffel object of type 'book' and
			-- display it using a method of its own class.
		do
			base_selection.object_convert (book)
			base_selection.cursor_to_object
			thread_print (book)
		end

	thread_print (a_s: ANY)
			-- Print with thead id.
		do
			print ("(Thead #" + thread_id.out + ")")
			print (a_s)
		end

feature {NONE}

	Select_author: STRING =
		"select * from DB_BOOK"

	Table_name: STRING =
		"DB_BOOK"

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
