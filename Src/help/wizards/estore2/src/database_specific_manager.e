indexing
	description: "Object that enable specific database management."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_SUBSET_SELECTION [G, H]

create
	make

feature -- Initialization

	make (dbm: DATABASE_MANAGER [DATABASE]) is
			-- Set `dbm' to manage database
			-- selections.
		require
			database_manager_not_void: dbm /= Void
		do
			database_manager := dbm
		end

feature -- Access

	object: G
			-- Type of object to retrieve from database.

	extract_function: FUNCTION [ANY, TUPLE [G], H]
			-- Function that extracts criterion value from object.

	valid_values: LIST [H]
			-- Valid values for the criterion.

	query: STRING
			-- SQL query to execute.

	database_result_list: ARRAYED_LIST [G]
			-- Result list.

feature -- Status report

	is_ok: BOOLEAN is
			-- Has last database transaction been successful?
		do
			Result := database_manager.session_control.is_ok
		end

	error_message: STRING is
			-- Error message is last database transaction has not been successful.
		do
			Result := database_manager.session_control.error_message
		end

feature -- Element change

	set_object (a_object: G) is
			-- Assign `a_object' to `object'.
		require
			not_void: a_object /= Void
		do
			object := a_object
		ensure
			object_assigned: object = a_object
		end

	set_extract_function (a_extract_function: FUNCTION [ANY, TUPLE [G], H]) is
			-- Assign `a_extract_function' to `extract_function'.
		require
			not_void: a_extract_function /= Void
		do
			extract_function := a_extract_function
		ensure
			extract_function_assigned: extract_function = a_extract_function
		end

	set_valid_values (a_valid_values: LIST [H]) is
			-- Assign `a_valid_values' to `valid_values'.
		require
			not_void: a_valid_values /= Void
		do
			valid_values := a_valid_values
		ensure
			valid_values_assigned: valid_values = a_valid_values
		end

	set_query (a_query: STRING) is
			-- Assign `a_query' to `query'.
		require
			not_void: a_query /= Void
		do
			query := a_query
		ensure
			query_assigned: query = a_query
		end

feature -- Basic operations

	load_result is
			-- Load result from SQL `query' from the database.
		require
			query_assigned: query /= Void
			valid_values_assigned: valid_values /= Void
			extract_function_assigned: extract_function /= Void
		local
			db_action: DB_SUBSET_ACTION [G, H]
			rescued: BOOLEAN
			db_selection: DB_SELECTION
		do
			if not rescued then
				database_manager.session_control.reset
				db_selection := database_manager.db_selection
				db_selection.object_convert (object)
				db_selection.set_query (query)
				create db_action.make (db_selection, object)
				db_action.set_extract_function (extract_function)
				db_action.set_valid_values (valid_values)
				db_selection.set_action (db_action)
				db_selection.execute_query
				if db_selection.is_ok then
					db_selection.load_result
					db_selection.terminate
					if db_selection.is_ok then
						database_result_list := db_action.list
					end
				end
			else
				create database_result_list.make (0)
			end
		ensure
			database_result_list_not_void: database_result_list /= Void
		rescue
			rescued := True
			retry
		end

feature {NONE} -- Implementation

	database_manager: DATABASE_MANAGER [DATABASE]
			-- Database manager.

invariant
	database_manager_assigned: database_manager /= Void

end -- class DB_SUBSET_SELECTION
