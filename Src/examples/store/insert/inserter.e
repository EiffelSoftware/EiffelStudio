note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INSERTER

inherit

	RDB_HANDLE

create

	make

feature {NONE}

	base_store: DB_STORE

	session_control: DB_CONTROL

	repository: detachable DB_REPOSITORY

feature {NONE} -- Initialization

	make
		local
			-- The object that we will use is a book
			book: BOOK2
			l_laststring: detachable STRING
			l_repository: like repository
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
					l_repository := repository
					check l_repository /= Void end -- implied by `table_exists' postcondition
					l_repository.allocate (book)
					l_repository.load
					io.putstring ("Table created.%N")
				end

					-- What new book does the user want to add ?
				io.putstring ("What new book should I create?")
				io.new_line
				io.putstring ("Author? ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				book.set_author (l_laststring.twin)
				io.putstring ("Title? ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				book.set_title(l_laststring.twin)
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

				l_repository := repository
				check l_repository /= Void end -- implied by `table_exists' postcondition
				base_store.set_repository (l_repository)
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

feature {NONE} -- Implementation

	init
			-- Init session.
		do
			io.putstring ("Database user authentication:%N")
			perform_login

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

				-- Ask for user's name and password
			io.putstring ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition			
			tmp_string := l_laststring.twin
			io.putstring ("Password: ")
			io.readline

			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
				-- Set user's name and password
			login (tmp_string, l_laststring)
		end

	table_exists (table: STRING): BOOLEAN
			-- Does table `table' exist in the database?
		require
			connected: session_control.is_connected
		local
			l_repository: like repository
		do
			-- Create and load the DB_REPOSITORY named 'table'
			create l_repository.make (table)
			repository := l_repository
			l_repository.load
			Result := l_repository.exists
		ensure
			repository_attached: attached repository as le_repository
			Result = le_repository.exists
		end

feature {NONE}

        Table_name: STRING =
                "DB_BOOK";

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

end
