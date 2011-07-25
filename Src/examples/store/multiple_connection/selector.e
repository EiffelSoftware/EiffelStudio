note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 86764 $"

class SELECTOR

inherit
	ACTION
		redefine
			execute
		end

	RDB_HANDLE

	DATABASE_SESSION_MANAGER_ACCESS

create
	make

feature {NONE}

	base_selection: DB_SELECTION

	base_update: DB_CHANGE

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	data_file: detachable PLAIN_TEXT_FILE

	book: BOOK2

	country: COUNTRY

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

	filled_country: COUNTRY
			-- Filled country to put into database
		do
			create Result.make (1, "China")
		end

	session_1, session_2: detachable DATABASE_SESSION
			-- Sessions

feature

	make
		local
			l_repository: like repository
		do
				-- An Eiffel object is created. It will be stored in the DB,
				-- through the repository
			book := filled_book
			country := filled_country

			session_1 := manager.current_session
			session_2 := manager.new_session

			io.putstring ("Database user authentication 1:%N")
			manager.set_current_session (session_1)
			setup_and_connect

				-- Setup the other sessoin, and perform some operation
			manager.set_current_session (session_2)
			io.putstring ("Database user authentication 2:%N")
			setup_and_connect
			create l_repository.make (country_table_name)
			repository := l_repository
				-- Try to load table from the DB
			l_repository.load
			load_data (country)
			select_country (country.c_no)
			session_control.disconnect	-- Don't need the session anymore.
			io.putstring ("Database connection 2 disconnected. Switching to connection 1.%N")

				-- Use the previous sessoin from now on.
			manager.set_current_session (session_1)
			session_2 := Void
			if not session_control.is_connected then
				session_control.raise_error
					-- Something went wrong, and the connection failed
				io.putstring ("%NCan't connect to database.%N")
			else
					-- A 'repository' is used to store objects, and to access
					-- them as Eiffel objects, or DB tuples.
					-- The table used to store Eiffel book objects will be called
					-- "DB_BOOK".
				create l_repository.make (book_table_name)
				repository := l_repository

					--  The Eiffel program is now connected to the database
					-- Try to load table from the DB
				l_repository.load
				if not l_repository.exists then
						-- There is no existing objects in the DB
					io.putstring ("Loading and updating database ...%N")
						-- Load some from file
					load_data (filled_book)
					l_repository.load
				end
					-- Ask the user for a SELECT statement, and execute it
				make_selection
					-- Terminate session
				session_control.disconnect
			end
		end

	setup_and_connect
			-- Setup and connect session
		do
			perform_login
				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
			set_base

			if not attached session_control then
					-- Create usefull classes
					-- 'session_control' provides informations control access and
					--  the status of the database.
					-- 'base_selection' provides a SELECT query mechanism.
				create session_control.make
				create base_selection.make
				create base_update.make
			end
			session_control.connect
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

	load_data (db_object: ANY)
			-- Create table in database with same structure as 'book'
			-- and load data from file 'data.sql'.
		require
			repository_attached: repository /= Void
			db_object_attached: db_object /= Void
		local
			l_repository: like repository
			l_store: DB_STORE
		do
				-- Create the table for book-objects.
				-- The name of this table has already been set to "DB_BOOK"
			l_repository := repository
			check l_repository /= Void end -- implied by precondition `repostory_attached'
			l_repository.allocate (db_object)
			session_control.begin

			l_repository.load
			create l_store.make
			l_store.set_repository (l_repository)
			l_store.put (db_object)

				-- Commit work
			session_control.commit
		end

	select_country (a_no: INTEGER)
			-- Select country
		do
			io.putstring ("Seeking for country with NO.: ")
			io.putstring (a_no.out)
			io.new_line
			io.new_line

				-- A mapped Eiffel object (author) is referred to by a key name
				-- "author_name" which can be used in a SQL statement prepended with ':'
			base_selection.set_map_name (a_no, "no")

				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			base_selection.set_action (Current)

				-- Query database.
				-- The reference ":author_name" will be changed to the value of
				-- the Eiffel object referred to by the key "author_name".
			base_selection.query (select_no)
				-- Iterate through resulting data, and display them
			base_selection.load_result

				-- Delete "author_name" from the map table
			base_selection.unset_map_name ("no")

			base_selection.terminate
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
			from
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			until
					-- Terminate?
				io.laststring ~ "exit"
			loop
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `read_line' postcondition
				author := l_laststring.twin
				io.putstring ("Seeking for books whose author's name match: ")
				io.putstring (author)
				io.new_line
				io.new_line

					-- A mapped Eiffel object (author) is referred to by a key name
					-- "author_name" which can be used in a SQL statement prepended with ':'
				base_selection.set_map_name (author, "author_name")


					-- Set action to be executed after each 'load_result' iteration step.
					-- 'init' and 'execute' method of the current class are to be used.
				base_selection.set_action (Current)

					-- Query database.
					-- The reference ":author_name" will be changed to the value of
					-- the Eiffel object referred to by the key "author_name".
				base_selection.query (Select_author)
					-- Iterate through resulting data, and display them
				base_selection.load_result

					-- Delete "author_name" from the map table
				base_selection.unset_map_name ("author_name")

				base_selection.terminate

				io.new_line
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			end
		end

	execute
			-- This method is also  used by the class RDB_SELECTION, and is executed after each
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
			-- In this example, it converts a tuple in an eiffel object of type 'book' and
			-- display it using a method of its own class.
		do
			if manager.current_session = session_1 then
				base_selection.object_convert (book)
				base_selection.cursor_to_object
				print (book)
				io.new_line
			else
				base_selection.object_convert (country)
				base_selection.cursor_to_object
				print (country)
				io.new_line
			end
		end

feature {NONE}

	Select_author: STRING =
		"select * from DB_BOOK where author = :author_name"

	Select_no: STRING =
		"select * from DB_COUNTRY_LIST where c_no = :no"

	book_table_name: STRING =
		"DB_BOOK"

	country_table_name: STRING =
		"DB_COUNTRY_LIST"

	Data_file_name: STRING
		once
			create Result.make_from_string ("data.sql.")
			Result.append (db_spec.database_handle_name.as_lower)
		end

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
