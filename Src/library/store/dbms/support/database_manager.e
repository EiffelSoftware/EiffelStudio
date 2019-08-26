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
			-- It overrides the information set by `set_connection_string_information' when login.
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
				error_message_32 := unexpected_error (Connection_info_name)
			end
		rescue
			rescued := True
			retry
		end

	set_connection_string_information (a_connection_string: STRING_8)
			-- Set connection string required to connect to the database.
			-- It overrides the information set by `set_connection_information' when login.
		require
			not_void: a_connection_string /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				create database_appl.login_with_connection_string (a_connection_string)
			else
				has_error := True
				error_message_32 := unexpected_error (Connection_string_info_name)
			end
		rescue
			rescued := True
			retry
		end

	establish_connection
			-- Establish connection.
		require
			not_connected: not is_connected
		local
			rescued: BOOLEAN
			l_session_control: like session_control
		do
			if not rescued then
					-- Initialization of the Relational Database:
					-- This will set various informations to perform a correct
					-- connection to the Relational database.
					-- This will update the handle to link EiffelStore interface
					-- to the RDBMS represented by this class.
				if attached database_appl as l_database_appl then
					l_database_appl.set_base

						-- Start session
					create l_session_control.make
					session_control := l_session_control
					l_session_control.connect
					has_error := not l_session_control.is_ok
					error_message_32 := l_session_control.error_message_32
				else
					has_error := True
					error_message_32 := "Database handle not created"
				end
			else
				has_error := True
				error_message_32 := unexpected_error (Establish_connection_name)
			end
		rescue
			rescued := True
			retry
		end

	disconnect
			-- Disconnect from database.
		require
			is_connected: is_connected
		do
			if attached session_control as l_session_control then
				l_session_control.disconnect
			end
		end

feature -- Status report

	has_error: BOOLEAN
			-- Has an error occurred during last database operation?

	error_message: detachable STRING
			-- Error message if an error occurred during last
			-- database operation.
		obsolete
			"Use `error_message_32' instead  [2017-11-30]."
		do
			if attached error_message_32 as l_s then
				Result := l_s.as_string_8
			end
		end

	error_message_32: detachable STRING_32
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

	load_data_with_select (s: READABLE_STRING_GENERAL): detachable ANY
			-- Load directly a single data from the database.
			--| This can be used for instance to retrieve a table rows count or
			--| a minimum value.
		require
			meaningful_select: s /= Void
		local
			rescued: BOOLEAN
			tuple: DB_TUPLE
			l_db_selection: like db_selection
		do
			if not rescued then
				has_error := False
				if attached session_control as l_session_control then
					l_session_control.reset
					l_db_selection := db_selection
					l_db_selection.no_object_convert
					l_db_selection.unset_action
					l_db_selection.set_query (s)
					l_db_selection.execute_query
					if l_db_selection.is_ok then
						l_db_selection.load_result
						if l_db_selection.is_ok and attached l_db_selection.cursor as l_cursor then
							create tuple.copy (l_cursor)
							Result := tuple.item (1)
						end
					end
					l_db_selection.terminate
					if not l_db_selection.is_ok then
						has_error := True
						error_message_32 := l_session_control.error_message_32
					end
				else
					has_error := True
					error_message_32 := session_control_not_set_error (data_select_name)
				end
			else
				has_error := True
				error_message_32 := unexpected_error (data_select_name)
			end
		rescue
			rescued := True
			retry
		end

	load_list_with_select (s: READABLE_STRING_GENERAL; an_obj: ANY): ARRAYED_LIST [like an_obj]
			-- Load list of objects whose type are the same as `an_obj',
			-- following the SQL query `s'.
		require
			not_void: an_obj /= Void
			meaningful_select: s /= Void
		local
			db_actions: DB_ACTION [like an_obj]
			rescued: BOOLEAN
			l_result: detachable ARRAYED_LIST [like an_obj]
			l_db_selection: like db_selection
		do
			if not rescued then
				if attached session_control as l_session_control then
					has_error := False
					l_session_control.reset
					l_db_selection := db_selection
					l_db_selection.object_convert (an_obj)
					l_db_selection.set_query (s)
					create db_actions.make (l_db_selection, an_obj)
					l_db_selection.set_action (db_actions)
					l_db_selection.execute_query
					if l_db_selection.is_ok then
						l_db_selection.load_result
						if l_db_selection.is_ok then
							l_result := db_actions.list
						end
					end
					l_db_selection.terminate
					if not l_db_selection.is_ok then
						has_error := True
						error_message_32 := l_session_control.error_message_32
					end
				else
					has_error := True
					error_message_32 := session_control_not_set_error (list_select_name)
				end
			else
				has_error := True
				error_message_32 := unexpected_error (list_select_name)
			end
			if l_result /= Void then
				Result := l_result
			else
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		rescue
			rescued := True
			retry
		end

feature -- Queries without result to load.

	begin_transaction
			-- Start a transaction which will be terminated by a call to `rollback' or `commit'.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if attached session_control as l_session_control then
					if l_session_control.is_ok then
						l_session_control.begin
					else
						has_error := True
						error_message_32 := l_session_control.error_message_32
					end
				else
					has_error := True
					error_message_32 := session_control_not_set_error (Execute_query_name)
				end
			else
				has_error := True
				error_message_32 := unexpected_error (Commit_name)
			end
		rescue
			rescued := True
			retry
		end

	execute_query (a_query: READABLE_STRING_GENERAL)
			-- Execute `a_query' and commit changes.
		require
			not_void: a_query /= Void
		do
			execute_query_without_commit (a_query)
			commit
		end

	execute_query_without_commit (a_query: READABLE_STRING_GENERAL)
			-- Execute `a_query' in the database.
			-- Warning: query executed is not committed.
			-- Note: Commit is still performed if `auto-commit' is enabled, use
			-- `begin_transaction' to disable `auto-commit'.
		require
			not_void: a_query /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				has_error := False
				if attached session_control as l_session_control then
					l_session_control.reset
					db_change.set_query (a_query)
					db_change.execute_query
					if not l_session_control.is_ok then
						has_error := True
						error_message_32 := l_session_control.error_message_32
					end
				else
					has_error := True
					error_message_32 := session_control_not_set_error (Execute_query_name)
				end
			else
				has_error := True
				error_message_32 := unexpected_error (Execute_query_name)
			end
		rescue
			rescued := True
			retry
		end

	commit
			-- Commit updates in the database.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if attached session_control as l_session_control then
					if l_session_control.is_ok then
						l_session_control.commit
					else
						has_error := True
						error_message_32 := l_session_control.error_message_32
					end
				else
					has_error := True
					error_message_32 := session_control_not_set_error (Commit_name)
				end
			else
				has_error := True
				error_message_32 := unexpected_error (Commit_name)
			end
		rescue
			rescued := True
			retry
		end

	rollback
			-- Rollback updates in the database.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if attached session_control as l_session_control then
					if l_session_control.is_ok then
						l_session_control.rollback
					else
						has_error := True
						error_message_32 := l_session_control.error_message_32
					end
				else
					has_error := True
					error_message_32 := session_control_not_set_error (Commit_name)
				end
			else
				has_error := True
				error_message_32 := unexpected_error (Commit_name)
			end
		rescue
			rescued := True
			retry
		end

	insert_with_repository (an_obj: ANY; rep: DB_REPOSITORY)
			--	Store in the database object `an_obj' with `db_repository'.
		require
			repository_loaded: rep.loaded
		local
			rescued: BOOLEAN
			store_objects: DB_STORE
		do
			if not rescued then
				if attached session_control as l_session_control then
					has_error := False
					l_session_control.reset
					create store_objects.make
					store_objects.set_repository (rep)
					store_objects.put (an_obj)
					commit
				else
					has_error := True
					error_message_32 := session_control_not_set_error (insert_name)
				end
			else
				has_error := True
				error_message_32 := unexpected_error (insert_name)
			end
		rescue
			rescued := True
			retry
		end

feature -- Access

	database_handle_name: STRING
			-- Database handle name
		do
			if attached database_appl as l_database_appl then
				Result := l_database_appl.db_spec.database_handle_name
			else
				create Result.make_empty
			end
		ensure
			not_void: Result /= Void
		end

	string_format (s: READABLE_STRING_GENERAL): STRING
			-- String representation in SQL of `s'.
		require
			s_not_void: s /= Void
		local
			s32: STRING_32
		do
			s32 := string_format_32 (s)

			if s32.is_valid_as_string_8 then
				Result := s32.to_string_8
			else
				Result := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s32)
				--TODO: Report data loss, or utf-8 encoding.
			end
		end

	string_format_32 (s: READABLE_STRING_GENERAL): STRING_32
			-- String representation in SQL of `s'.
		require
			s_not_void: s /= Void
		do
			if attached database_appl as l_database_appl then
				Result := l_database_appl.db_spec.string_format_32 (s)
			else
				create Result.make_empty
			end
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

	session_control_not_set_error (action: STRING_32): STRING_32
			-- Unexpected error message.
		require
			action_not_void: action /= Void
		do
			Result := {STRING_32} "The session_control is not created in " + action
		end

	unexpected_error (action: STRING_32): STRING_32
			-- Unexpected error message.
		require
			action_not_void: action /= Void
		do
			Result := {STRING_32} "Unexpected error in " + action
		end

	Connection_info_name: STRING = "set_connection_information"
			-- `set_connection_information' feature name.

	Connection_string_info_name: STRING = "set_connection_string_information"
			-- `set_connection_string_information' feature name.

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
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
