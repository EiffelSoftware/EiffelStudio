indexing
	description: "DATABASE Manager"
	author: "Davids"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_MANAGER [G -> DATABASE create default_create end]

feature -- Connection

	set_connection_information (a_name, a_psswd, data_source: STRING) is
			-- Try to connect the database
		require
			not_void: a_name /= Void and a_psswd /= Void
		local
			rescued: BOOLEAN
		do
			if not has_error then
				create database_appl.login (a_name, a_psswd)
				database_appl.set_data_source (data_source)
			end
		rescue
			has_error := True
			retry
		end

	establish_connection is
			-- Establish Connection
		local
			rescued: BOOLEAN
		do
			if not rescued then
				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
				database_appl.set_base
	
				-- create useful classes
				-- 'session_control' provides informations control access and 
				-- the status of the database.
				create session_control.make
	
	
				-- Start session
				session_control.connect
				has_error := not session_control.is_ok
				error_message := session_control.error_message
			end
		ensure
			not_void: session_control /= Void
		rescue
			rescued := True
			has_error := True
			retry
		end

	disconnect is
		require
			is_connected: is_connected
		do
			session_control.disconnect
		end

feature -- Status report

	has_error: BOOLEAN
			-- Has an error occured during last database operation?

	error_message: STRING
			-- Error message if an error occured during last
			-- database operation.

	is_connected: BOOLEAN is
			-- Is the application connected to a database?
		do
			Result := session_control /= Void and then session_control.is_connected
		end

feature -- Queries

	load_integer_with_select (s: STRING): INTEGER is
			-- Load directly an integer value from the database.
		require
			meaningful_select: s /= Void
		local
			int_sel: DB_INTEGER_SELECTION
		do
			create int_sel.make
			int_sel.set_query (s)
			int_sel.execute_query
			Result := int_sel.load_result
		end

	load_list_with_select (s: STRING; an_obj: ANY): ARRAYED_LIST [like an_obj] is
			-- Load list of objects whose type are the same as `an_obj',
			-- following the SQL query `s'.
			-- `Result' can be Void.
		require
			not_void: an_obj /= Void
			meaningful_select: s /= Void
		local
			db_actions: DB_ACTION [like an_obj]
			rescued: BOOLEAN
		do
			if not rescued then
				has_error := False
				create db_selection.make
				db_selection.object_convert (an_obj)
				db_selection.set_query (s)
				create db_actions.make (db_selection, an_obj)
				db_selection.set_action (db_actions)
				db_selection.execute_query
				db_selection.load_result

				db_selection.terminate
				Result := db_actions.list
			else
				has_error := True
				error_message := "An error occured while reading the database.%NQuery was: '" + s
		--FIXME				+ "'.%N Database error message is: " +
						+ "%NPlease keep this dialog open and contact your DBA."
			end
		rescue
			rescued := TRUE
			retry
		end

feature -- Queries without result to load.

	execute_query (a_query: STRING) is
			-- Execute `a_query' and commit changes.
		require
			not_void: a_query /= Void
		local
			s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				has_error := False
				session_control.begin
				create db_change.make
				db_change.set_query (a_query)
				db_change.execute_query
				updater_build := True
				session_control.commit		
			else
				has_error := True
				error_message := "Database query execution failure : " + s
			end
		rescue
			rescued := TRUE
			retry
		end

	build_updater is
			-- Build an updater to execute many update queries
		local
			rescued: BOOLEAN
		do
			if not rescued then
				session_control.begin
				create db_change.make
				updater_build := True
			else
				has_error := True
				error_message := "Failure preparing an update."
			end
		rescue
			rescued := TRUE
			retry
		end

	execute_query_from_updater (a_query: STRING) is
		require
			not_void: a_query /= Void
			updater_build: updater_build
		local
			s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				has_error := False
				db_change.set_query (a_query)
				db_change.execute_query				
			else
				has_error := True
				error_message := "Database query execution failure : " + s
			end
		rescue
			rescued := TRUE
			retry
		end

	commit_query is
			-- Commit updates in the database
		require
			updater_build: updater_build
		local
			rescued: BOOLEAN
		do
			if not rescued then
				session_control.commit		
			else
				has_error := True
				error_message := "Database commit failure."
			end
		rescue
			rescued := TRUE
			retry
		end

	insert_into_database (an_obj: ANY; tablename: STRING) is
			--	Store in the database object `an_obj'.
		local
			rescued: BOOLEAN
			store_objects: DB_STORE
			rep: DB_REPOSITORY
		do
			if not rescued then
				has_error := False
				create store_objects.make
				create rep.make (tablename)
				rep.load
				store_objects.set_repository (rep)
				store_objects.put (an_obj)
				session_control.commit
			else
				has_error := True
				error_message := "An error occured while creating a table row in the database.%NTable%
						% name is " + tablename + ".%N"
			end
		rescue
			rescued := TRUE
			retry
		end

feature -- Status report

	updater_build: BOOLEAN
		-- Is an update query prepared?

feature -- Fixme: exported?!

	session_control: DB_CONTROL
		-- Session Control

feature {NONE} -- Implementation

	database_appl: DATABASE_APPL [G]
		-- Database application.

	db_selection: DB_SELECTION
		-- Performs a selection in the database (i.e. a query).

	db_change: DB_CHANGE
		-- Performs a change in the database (i.e. a command).

end -- class DATABASE_MANAGER

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
