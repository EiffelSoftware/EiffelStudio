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

	repository: DB_REPOSITORY
	
	session_control: DB_CONTROL

	data_file: PLAIN_TEXT_FILE

	book: BOOK2
	
feature 

	make is
		local
			tmp_string: STRING
		do
			-- Ask for user's name and password
			io.putstring ("Database user authentication:%N")
			io.putstring ("Name: ")
			io.readline
			tmp_string := clone (io.laststring)
			io.putstring ("Password: ")
			io.readline

			-- Set user's name and password
			login (tmp_string, io.laststring)

			-- Initialization of the Relational Database:
			-- This will set various informations to perform a correct
			-- connection to the Relational database
			set_base
			-- A 'repository' is used to store objects, and to access
			-- them as Eiffel objects, or DB tuples.
			-- The table used to store Eiffel book objects will be called
			-- "DB_BOOK".
			create repository.make (Table_name)

			-- Create usefull classes
			-- 'session_control' provides informations control access and 
			--  the status of the database.
			-- 'base_selection' provides a SELECT query mechanism.
			create session_control.make
			create base_selection.make
			create base_update.make

			-- An Eiffel object is created. It will be stored in the DB, 
			-- through the repository
			create book.make

			-- Start session: establishes connection to database
			session_control.connect

			if not session_control.is_connected then

				session_control.raise_error
				-- Something went wrong, and the connection failed
				io.putstring ("Can't connect to database.%N")

			else
				--  The Eiffel program is now connected to the database

				-- Try to load table from the DB
				repository.load

				if not repository.exists then
					-- There is no existing objects in the DB
					io.putstring ("Loading and updating database ...%N")
					-- Load some from file
					load_data

					repository.load
				end
			
				-- Ask the user for a SELECT statement, and execute it
				make_selection
	
				-- Terminate session
				session_control.disconnect
			end
		end

feature {NONE}

	load_data is
			-- Create table in database with same structure as 'book'
			-- and load data from file 'data.sql'.
		do
			-- Create the table for book-objects.
			-- The name of this table has already been set to "DB_BOOK"
			repository.allocate (book)
			session_control.begin

			from 
				create data_file.make_open_read (Data_file_name)
			until
				data_file.end_of_file
			loop
				data_file.readline
				if not data_file.end_of_file then
					io.putstring (data_file.laststring)
					io.new_line
					-- Insert objects in the table "DB_BOOK"
					base_update.modify (clone (data_file.laststring))
				end
			end
			data_file.close

			-- Commit work
			session_control.commit
		end

	make_selection is
			-- Select books whose author's name match
			-- a specific name.
			-- The name must be written in upper-case letters, and
			-- enclosed in '%' (This caracter is used by SQL to match 
			-- any string of zero or more character)

		local
			author: STRING
		do
			from
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			until
				-- Terminate?
				io.laststring.is_equal ("exit")
			loop
				author := clone (io.laststring)
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
	
	execute is

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

	Select_author: STRING is
		"select * from DB_BOOK where author = :author_name"

	Table_name: STRING is
		"DB_BOOK"

	Data_file_name: STRING is
		"data.sql"

end -- class SELECTOR


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

