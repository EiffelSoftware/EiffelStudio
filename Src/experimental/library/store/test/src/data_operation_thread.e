note
	description: "Thread to load data and perform a selection."
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_OPERATION_THREAD

inherit
	THREAD
		rename
			make as thread_make
		end

	ACTION
		rename
			execute as execute_action,
			status as action_status
		redefine
			execute_action
		end

	DATABASE_SESSION_MANAGER_ACCESS

	TEST_DATABASE_MANAGER

	HANDLE

	SPEC_TESTING_SETTINGS


create
	make_thread

feature {NONE} -- Init

	make_thread (a_login: like global_login)
			-- Init with thread
		do
			thread_make
			global_login := a_login

			create book.make
		end

feature -- Execution

	execute
		local
			l_repository: like repository
		do
				-- Setup login for current session.
			manager.current_session.set_session_login (global_login.twin)

			if is_odbc then
				if is_trusted then
					set_connection_string_information ("Driver={SQL Server Native Client 10.0};Server=" + host + ";Database=" + database_name + ";Trusted_Connection=Yes;")
				else
					set_connection_string_information ("Driver={SQL Server Native Client 10.0};Server=" + host + ";Database=" + database_name + ";Uid=" + user_login + ";Pwd=" + user_password)
				end
			else
				set_connection_information (user_login, user_password, database_name)
			end
			if attached Manager.current_session.session_login as l_login then
				l_login.set_application (database_name)	-- For MySQL
			end
				-- Default to non extended type, change in descendants if needed.
			(create {GLOBAL_SETTINGS}).set_use_extended_types (False)

			establish_connection
			if attached session_control as l_control then

					-- Establishes connection to database
				if not l_control.is_connected then
					l_control.raise_error
						-- Something went wrong, and the connection failed
					check could_not_connect_database: False end
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

						-- Load data into database
					load_data

					l_repository.load
						-- Do a SELECT query
					make_selection

						-- Disconnect from database
					l_control.disconnect
				end
			end
		end

feature {NONE} -- Implementation

	load_data
			-- Create table in database with same structure as 'book'
		require
			repository_attached: repository /= Void
		local
			l_store: DB_STORE
		do
				-- Create the table for book-objects.
				-- The name of this table has already been set to "DB_BOOK"
			check attached repository as l_repository then -- implied by precondition `repostory_attached'
				if not l_repository.exists then
					l_repository.allocate (book)
				end

				if attached session_control as l_control then
						-- Start a transaction
					l_control.begin

					l_repository.load
					create l_store.make
					l_store.set_repository (l_repository)
					l_store.put (create_filled_book)

						-- Commit work
					l_control.commit
				end
			end
		end

	make_selection
			-- Select books from database
		do
				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			db_selection.set_action (Current)

				-- Query database.
			db_selection.query (Select_author)
				-- Iterate through resulting data, and display them
			db_selection.load_result
			db_selection.terminate
		end

	execute_action
			-- This method is executed after each
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
			-- In this example, it converts a tuple in an eiffel object of type 'book' and
			-- display it using a method of its own class.
		local
			l_book, l_book1: like create_filled_book
		do
			create l_book1.make
			db_selection.object_convert (l_book1)
			db_selection.cursor_to_object

			l_book := create_filled_book
			check result_expected: l_book ~ l_book1 end
		end

feature {NONE} -- Factory

	create_filled_book: BOOK2
			-- Create filled book to put into database
		do
			create Result.make
			Result.set_author ("Paul")
			Result.set_price (4.0)
			Result.set_quantity (50)
			Result.set_title ("Yangzi River")
			Result.set_double_value (2.3)
			Result.set_year (1980)
		end

feature -- Constants

	Select_author: STRING = "select * from DB_MULTI_THREAD"
			-- SQL to select book object from database

	Table_name: STRING = "DB_MULTI_THREAD"
			-- Table name for book objects

feature {NONE} -- Implementation

	repository: detachable DB_REPOSITORY
			-- Database repository

	book: BOOK2
			-- Book object

	global_login: LOGIN [DATABASE]
			-- Login information

end
