indexing
	description: "Object that enable basic database management."
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_MANAGER [G -> DATABASE create default_create end]

feature -- Connection

	set_connection_information (user_name, password, data_source: STRING) is
			-- Set information required to connect to the database.
		require
			not_void: user_name /= Void and password /= Void and data_source /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				create database_appl.login (user_name, password)
				database_appl.set_data_source (data_source)
			else
				has_error := True
				error_message := unexpected_error (Connection_info_name)
			end
		rescue
			rescued := True
			retry
		end

	establish_connection is
			-- Establish connection.
		require
			information_set: database_handle_created
			not_connected: not is_connected
		local
			rescued: BOOLEAN
		do
			if not rescued then
					-- Initialization of the Relational Database:
					-- This will set various informations to perform a correct
					-- connection to the Relational database.
					-- This will update the handle to link EiffelStore interface
					-- to the RDBMS represented by this class.
				database_appl.set_base	
	
					-- Start session
				create session_control.make
				session_control.connect
				has_error := not session_control.is_ok
				error_message := session_control.error_message
			else
				has_error := True
				error_message := unexpected_error (Establish_connection_name)
			end
		rescue
			rescued := True
			retry
		end

	disconnect is
			-- Disconnect from database.
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

	database_handle_created: BOOLEAN is
			-- Has the database handle been created?
		do
			Result := database_appl /= Void
		end

feature -- Queries

	load_data_with_select (s: STRING): ANY is
			-- Load directly a single data from the database.
			--| This can be used for instance to retrieve a table rows count or
			--| a minimum value.
		require
			meaningful_select: s /= Void
		local
			rescued: BOOLEAN
			tuple: DB_TUPLE
		do
			if not rescued then
				has_error := False
				session_control.reset
				db_selection.no_object_convert
				db_selection.unset_action
				db_selection.set_query (s)
				db_selection.execute_query
				if db_selection.is_ok then
					db_selection.load_result
					db_selection.terminate
					if db_selection.is_ok then
						create tuple.copy (db_selection.cursor)
						Result := tuple.item (1)
					end
				end
				if not db_selection.is_ok then
					has_error := True
					error_message := session_control.error_message
				end
			else
				has_error := True
				error_message := unexpected_error (data_select_name)
			end
		rescue
			rescued := TRUE
			retry
		end

	load_list_with_select (s: STRING; an_obj: ANY): ARRAYED_LIST [like an_obj] is
			-- Load list of objects whose type are the same as `an_obj',
			-- following the SQL query `s'.
		require
			not_void: an_obj /= Void
			meaningful_select: s /= Void
		local
			db_actions: DB_ACTION [like an_obj]
			rescued: BOOLEAN
		do
			if not rescued then
				has_error := False
				session_control.reset
				db_selection.object_convert (an_obj)
				db_selection.set_query (s)
				create db_actions.make (db_selection, an_obj)
				db_selection.set_action (db_actions)
				db_selection.execute_query
				if db_selection.is_ok then
					db_selection.load_result
					db_selection.terminate
					if db_selection.is_ok then
						Result := db_actions.list
					end
				end
				if not db_selection.is_ok then
					has_error := True
					error_message := session_control.error_message
					create Result.make (0)
				end
			else
				has_error := True
				error_message := unexpected_error (list_select_name)
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		rescue
			rescued := TRUE
			retry
		end

feature -- Queries without result to load.

	execute_query (a_query: STRING) is
			-- Execute `a_query' and commit changes.
		require
			not_void: a_query /= Void
		do
			execute_query_without_commit (a_query)
			commit
		end

	execute_query_without_commit (a_query: STRING) is
				-- Execute `a_query' in the database.
				-- Warning: query executed is not committed.
		require
			not_void: a_query /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				has_error := False
				session_control.reset
				db_change.set_query (a_query)
				db_change.execute_query
			else
				has_error := True
				error_message := unexpected_error (Execute_query_name)
			end
		rescue
			rescued := TRUE
			retry
		end

	commit is
			-- Commit updates in the database.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if session_control.is_ok then
					session_control.commit
				else
					has_error := True
					error_message := session_control.error_message
				end
			else
				has_error := True
				error_message := unexpected_error (Commit_name)
			end
		rescue
			rescued := True
			retry
		end

	insert_with_repository (an_obj: ANY; rep: DB_REPOSITORY) is
			--	Store in the database object `an_obj' with `db_repository'.
		require
			repository_loaded: rep.loaded
		local
			rescued: BOOLEAN
			store_objects: DB_STORE
		do
			if not rescued then
				has_error := False
				session_control.reset
				create store_objects.make
				store_objects.set_repository (rep)
				store_objects.put (an_obj)
				commit
			else
				has_error := True
				error_message := unexpected_error (Insert_name)
			end
		rescue
			rescued := True
			retry
		end

feature -- Access

	database_handle_name: STRING is
			-- Database handle name
		do
			Result := database_appl.db_spec.database_handle_name
		ensure
			not_void: Result /= Void
		end

	string_format (s: STRING): STRING is
			-- String representation in SQL of `s'.
		do
			Result := database_appl.db_spec.string_format (s)
		end

	session_control: DB_CONTROL
			-- Session control.

	db_selection: DB_SELECTION is
			-- Performs a selection in the database (i.e. a query).
		once
			create Result.make
		end

	db_change: DB_CHANGE is
			-- Performs a change in the database (i.e. a command).
		once
			create Result.make
		end

feature {NONE} -- Implementation

	database_appl: DATABASE_APPL [G]
			-- Database application.

	unexpected_error (action: STRING): STRING is
			-- Unexpected error message.
		do
			Result := "Unexpected error in " + action
		end

	Connection_info_name: STRING is "set_connection_information"
			-- `set_connection_information' feature name.

	Establish_connection_name: STRING is "establish_connection"
			-- `establish_connection' feature name.

	Data_select_name: STRING is "load_data_with_select"
			-- `load_data_with_select' feature name.

	List_select_name: STRING is "load_list_with_select"
			-- `load_list_with_select' feature name.

	Execute_query_name: STRING is "execute_query_without_commit"
			-- `execute_query_without_commit' feature name.

	Commit_name: STRING is "commit"
			-- `commit' feature name.

	Insert_name: STRING is "insert_with_repository"
			-- `insert_with_repository' feature name.

end -- class DATABASE_MANAGER

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
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
