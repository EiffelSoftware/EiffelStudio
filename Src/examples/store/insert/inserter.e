class INSERTER

inherit

	RDB_HANDLE

create

	make

feature {NONE}

	base_store: DB_STORE

	session_control: DB_CONTROL

	repository: DB_REPOSITORY

feature 

	make is
		local
			-- The object that we will use is a book
			book: BOOK2
		do
			-- Initialize and start session
			init

			if not session_control.is_connected then

				-- Something went wrong, and the connection failed
				session_control.raise_error
				io.putstring ("Can't connect to the database.%N")

			else
				--  The Eiffel program is now connected to the database

				create book.make

				-- Does the table `db_book' exit?
				if not table_exists (Table_name) then
					io.putstring ("Table `DB_BOOK' does not exist...")
					repository.allocate (book)
					repository.load
					io.putstring ("Table created.%N")
				end

				-- What new book does the user want to add ?
				io.putstring ("What new book should I create?")
				io.new_line
				io.putstring ("Author? ")
				io.readline
				book.set_author (clone (io.laststring))
				io.putstring ("Title? ")
				io.readline
				book.set_title(clone (io.laststring))
				io.putstring ("Quantity? ")
				io.readint
				book.set_quantity(io.lastint)
				io.putstring ("Price? ")
				io.readreal
				book.set_price(io.lastreal)
				io.putstring ("Year? ")
				io.readint
				book.set_year (io.lastint)
				io.putstring ("Double value? ")
				io.readdouble
				book.set_double_value (io.lastdouble)

				base_store.set_repository (repository)
				base_store.put (book)

				if not session_control.is_ok then
					-- The attempt to insert a new object 
					-- failed
					io.putstring (session_control.error_message)
					io.new_line
				else
					io.putstring ("Object inserted%N")
				end
				-- Terminate session
				session_control.disconnect
			end
		end

feature {NONE}

	init is
			-- Init session.
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


			-- Create usefull classes
			-- 'session_control' provides informations control access and 
			--  the status of the database.
			-- 'base_store' provides updating facilities.
			create session_control.make
			create base_store.make

			-- Start session
			session_control.connect

		ensure
			not (session_control = Void)
			not (base_store = Void)
		end
	
	table_exists (table: STRING): BOOLEAN is
			-- Does table `table' exist in the database?
		require
			connected: session_control.is_connected
		do
			-- Create and load the DB_REPOSITORY named 'table'
			create repository.make (table)
			repository.load
			Result := repository.exists
		ensure
			Result = repository.exists
		end

feature {NONE}

        Table_name: STRING is
                "DB_BOOK"

end -- class INSERTER


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
