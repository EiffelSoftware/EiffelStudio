note
	description: "Thread to load data and perform a selection."
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_LOAD_AND_SELECT_THREAD

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

	RDB_HANDLE

create
	make_thread

feature {NONE} -- Init

	make_thread (a_login: like global_login)
			-- Init with thread
		do
			thread_make
			global_login := a_login
			set_base

				-- Create usefull classes
				-- 'session_control' provides informations control access and
				--  the status of the database.
				-- 'base_selection' provides a SELECT query mechanism.
			create session_control.make
			create base_selection.make
			create book.make
		end

feature -- Execution

	execute
		local
			l_repository: like repository
		do
				-- Setup login for current session.
			manager.current_session.set_session_login (global_login.twin)

				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
			set_base

				-- Establishes connection to database
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
				thread_print ("Loading and updating database ...%N")

					-- Load data into database
				load_data

				l_repository.load
					-- Do a SELECT query
				make_selection

					-- Disconnect from database
				session_control.disconnect
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

					-- Start a transaction
				session_control.begin

				l_repository.load
				create l_store.make
				l_store.set_repository (l_repository)
				l_store.put (create_filled_book)

					-- Commit work
				session_control.commit
			end
		end

	make_selection
			-- Select books from database
		do
			thread_print ("Books in storage:%N")

				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			base_selection.set_action (Current)

				-- Query database.
			base_selection.query (Select_author)
				-- Iterate through resulting data, and display them
			base_selection.load_result
			base_selection.terminate
		end

	execute_action
			-- This method is executed after each
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
		end

feature {NONE} -- Constants

	Select_author: STRING = "select * from DB_BOOK"
			-- SQL to select book object from database

	Table_name: STRING = "DB_BOOK"
			-- Table name for book objects

feature {NONE} -- Implementation

	base_selection: DB_SELECTION
			-- Facility to perform SELECT query

	repository: detachable DB_REPOSITORY
			-- Database repository

	session_control: DB_CONTROL
			-- Facility to control database session

	book: BOOK2
			-- Book object

	global_login: LOGIN [DATABASE]
			-- Login information

end
