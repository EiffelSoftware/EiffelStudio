note
	description: "Object that enable basic database management."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_MANAGER [reference G -> DATABASE create default_create end]

feature -- Connection

	set_connection_information (user_name, password, data_source: STRING)
			-- Set information required to connect to the database.
		require
			not_void: user_name /= Void and password /= Void and data_source /= Void
		local
			rescued: BOOLEAN
			l_database_appl: like database_appl
		do
			if not rescued then
				create l_database_appl.login (user_name, password)
				database_appl := l_database_appl
				l_database_appl.set_data_source (data_source)
			else
				has_error := True
				error_message := unexpected_error (Connection_info_name)
			end
		rescue
			rescued := True
			retry
		end

	establish_connection
			-- Establish connection.
		require
			information_set: database_handle_created
			not_connected: not is_connected
		local
			rescued: BOOLEAN
			l_database_appl: like database_appl
			l_session_control: like session_control
		do
			if not rescued then
					-- Initialization of the Relational Database:
					-- This will set various informations to perform a correct
					-- connection to the Relational database.
					-- This will update the handle to link EiffelStore interface
					-- to the RDBMS represented by this class.
				l_database_appl := database_appl
				check l_database_appl /= Void end -- implied by precondition `information_set'
				l_database_appl.set_base

					-- Start session
				create l_session_control.make
				session_control := l_session_control
				l_session_control.connect
				has_error := not l_session_control.is_ok
				error_message := l_session_control.error_message
			else
				has_error := True
				error_message := unexpected_error (Establish_connection_name)
			end
		rescue
			rescued := True
			retry
		end

	disconnect
			-- Disconnect from database.
		require
			is_connected: is_connected
		local
			l_session_control: like session_control
		do
			l_session_control := session_control
			check l_session_control /= Void end -- implied by precondition
			l_session_control.disconnect
		end

feature -- Status report

	has_error: BOOLEAN
			-- Has an error occurred during last database operation?

	error_message: detachable STRING
			-- Error message if an error occurred during last
			-- database operation.

	session_control_created: BOOLEAN
			-- Is `session_control' created?
		do
			Result := session_control /= Void
		end

	is_connected: BOOLEAN
			-- Is the application connected to a database?
		local
			l_session_control: like session_control
		do
			l_session_control := session_control
			Result := l_session_control /= Void and then l_session_control.is_connected
		end

	database_handle_created: BOOLEAN
			-- Has the database handle been created?
		do
			Result := database_appl /= Void
		end

feature -- Queries

	load_data_with_select (s: STRING): detachable ANY
			-- Load directly a single data from the database.
			--| This can be used for instance to retrieve a table rows count or
			--| a minimum value.
		require
			meaningful_select: s /= Void
			created: session_control_created
		local
			rescued: BOOLEAN
			tuple: DB_TUPLE
			l_session_control: like session_control
			l_cursor: detachable DB_RESULT
		do
			if not rescued then
				has_error := False
				l_session_control := session_control
				check l_session_control /= Void end -- implied by precondition `created'
				l_session_control.reset
				db_selection.no_object_convert
				db_selection.unset_action
				db_selection.set_query (s)
				db_selection.execute_query
				if db_selection.is_ok then
					db_selection.load_result
					if db_selection.is_ok then
						l_cursor := db_selection.cursor
						check l_cursor /= Void end -- implied by `load_result''s postcondition
						create tuple.copy (l_cursor)
						Result := tuple.item (1)
					end
				end
				db_selection.terminate
				if not db_selection.is_ok then
					has_error := True
					error_message := l_session_control.error_message
				end
			else
				has_error := True
				error_message := unexpected_error (data_select_name)
			end
		rescue
			rescued := TRUE
			retry
		end

	load_list_with_select (s: STRING; an_obj: ANY): ARRAYED_LIST [like an_obj]
			-- Load list of objects whose type are the same as `an_obj',
			-- following the SQL query `s'.
		require
			not_void: an_obj /= Void
			meaningful_select: s /= Void
			created: session_control_created
		local
			db_actions: DB_ACTION [like an_obj]
			rescued: BOOLEAN
			l_session_control: like session_control
			l_result: detachable ARRAYED_LIST [like an_obj]
		do
			if not rescued then
				l_session_control := session_control
				check l_session_control /= Void end -- implied by preconditon `created'
				has_error := False
				l_session_control.reset
				db_selection.object_convert (an_obj)
				db_selection.set_query (s)
				create db_actions.make (db_selection, an_obj)
				db_selection.set_action (db_actions)
				db_selection.execute_query
				if db_selection.is_ok then
					db_selection.load_result
					if db_selection.is_ok then
						l_result := db_actions.list
					end
				end
				db_selection.terminate
				if not db_selection.is_ok then
					has_error := True
					error_message := l_session_control.error_message
					create l_result.make (0)
				end
			else
				has_error := True
				error_message := unexpected_error (list_select_name)
				create l_result.make (0)
			end
			check l_result /= Void end -- FIXME: implied by previous if caluse, bug here? `l_result' can be void if rescued
			Result := l_result
		ensure
			result_not_void: Result /= Void
		rescue
			rescued := TRUE
			retry
		end

feature -- Queries without result to load.

	execute_query (a_query: STRING)
			-- Execute `a_query' and commit changes.
		require
			not_void: a_query /= Void
		do
			execute_query_without_commit (a_query)
			commit
		end

	execute_query_without_commit (a_query: STRING)
				-- Execute `a_query' in the database.
				-- Warning: query executed is not committed.
		require
			not_void: a_query /= Void
			created: session_control_created
		local
			rescued: BOOLEAN
			l_session_control: like session_control
		do
			if not rescued then
				has_error := False
				l_session_control := session_control
				check l_session_control /= Void end -- implied by precondition
				l_session_control.reset
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

	commit
			-- Commit updates in the database.
		require
			session_control_created
		local
			rescued: BOOLEAN
			l_session_control: like session_control
		do
			if not rescued then
				l_session_control := session_control
				check l_session_control /= Void end -- implied by precondition
				if l_session_control.is_ok then
					l_session_control.commit
				else
					has_error := True
					error_message := l_session_control.error_message
				end
			else
				has_error := True
				error_message := unexpected_error (Commit_name)
			end
		rescue
			rescued := True
			retry
		end

	insert_with_repository (an_obj: ANY; rep: DB_REPOSITORY)
			--	Store in the database object `an_obj' with `db_repository'.
		require
			repository_loaded: rep.loaded
			created: session_control_created
		local
			rescued: BOOLEAN
			store_objects: DB_STORE
			l_session_control: like session_control
		do
			if not rescued then
				has_error := False
				l_session_control := session_control
				check l_session_control /= Void end -- implied by precondition
				l_session_control.reset
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

	database_handle_name: STRING
			-- Database handle name
		require
			created: database_handle_created
		local
			l_database_appl: like database_appl
		do
			l_database_appl := database_appl
			check l_database_appl /= Void end -- implied by precondition
			Result := l_database_appl.db_spec.database_handle_name
		ensure
			not_void: Result /= Void
		end

	string_format (s: STRING): STRING
			-- String representation in SQL of `s'.
		require
			created: database_handle_created
			s_not_void: s /= Void
		local
			l_database_appl: like database_appl
		do
			l_database_appl := database_appl
			check l_database_appl /= Void end -- implied by precondition
			Result := l_database_appl.db_spec.string_format (s)
		end

	session_control: detachable DB_CONTROL
			-- Session control.

	db_selection: DB_SELECTION
			-- Performs a selection in the database (i.e. a query).
		once
			create Result.make
		end

	db_change: DB_CHANGE
			-- Performs a change in the database (i.e. a command).
		once
			create Result.make
		end

feature {NONE} -- Implementation

	database_appl: detachable DATABASE_APPL [G]
			-- Database application.

	unexpected_error (action: STRING): STRING
			-- Unexpected error message.
		require
			action_not_void: action /= Void
		do
			Result := "Unexpected error in " + action
		end

	Connection_info_name: STRING = "set_connection_information"
			-- `set_connection_information' feature name.

	Establish_connection_name: STRING = "establish_connection"
			-- `establish_connection' feature name.

	Data_select_name: STRING = "load_data_with_select"
			-- `load_data_with_select' feature name.

	List_select_name: STRING = "load_list_with_select"
			-- `load_list_with_select' feature name.

	Execute_query_name: STRING = "execute_query_without_commit"
			-- `execute_query_without_commit' feature name.

	Commit_name: STRING = "commit"
			-- `commit' feature name.

	Insert_name: STRING = "insert_with_repository";
			-- `insert_with_repository' feature name.

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




end -- class DATABASE_MANAGER


