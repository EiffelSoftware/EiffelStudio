note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SELECTOR

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
		local
			l_repository: like repository
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

				-- Start session: establishes connection to database
			session_control.connect
			if not session_control.is_connected then
				session_control.raise_error
					-- Something went wrong, and the connection failed
				io.putstring ("%NCan't connect to database.%N")
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
				if not l_repository.exists then
						-- There is no existing objects in the DB
					io.putstring ("Loading and updating database ...%N")
						-- Load some from file
					load_data
					l_repository.load
				end
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
			l_repository.allocate (book)
			session_control.begin

			from
				create l_data_file.make_open_read (Data_file_name)
				data_file := l_data_file
			until
				l_data_file.end_of_file
			loop
				l_data_file.readline
				if not l_data_file.end_of_file then
					l_laststring := l_data_file.laststring
					check l_laststring /= Void end -- implied by `readline' postcondition
					io.putstring (l_laststring)
					io.new_line
						-- Insert objects in the table "DB_BOOK"
					base_update.modify (l_laststring.twin)
				end
			end
			l_data_file.close

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
			base_selection.object_convert (book)
			base_selection.cursor_to_object
			print (book)
			io.new_line
		end

feature {NONE}

	Select_author: STRING =
		"select * from DB_BOOK where author = :author_name"

	Table_name: STRING =
		"DB_BOOK"

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
