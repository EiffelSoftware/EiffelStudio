indexing
	description: "Abstract interface with a database.%
			%It blobbes needs of DB_TABLE_COMPONENT class%
			%and descendants."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_DB_TABLE_MANAGER

inherit
	DB_TABLES_ACCESS_USE

feature -- Access

	database_result_list: ARRAYED_LIST [DB_TABLE] is
			-- Database result list.
		require
			no_error: not has_error
		deferred
		end

feature -- Status report

	has_error: BOOLEAN is
			-- Has an error occured during last database operation?
		deferred
		end

	error_message: STRING is
			-- Error message if an error occured during last
			-- database operation.
		deferred
		end

	select_query_prepared: BOOLEAN is
			-- Is a select query prepared?
		deferred
		end

feature -- Status setting

feature -- Basic operations

	load_result is
			-- Load result. Set `has_error'. Result is available in
			-- `database_result' if result is unique, `database_result_list' otherwise.
		require
			select_query_prepared: select_query_prepared
		deferred
		end

	prepare_select_with_table (tablecode: INTEGER) is
			-- Prepare a simple select query on table with code `tablecode'.
			-- Execute it with `load_result_list'.
		require
			is_valid_tablecode: is_valid_code (tablecode)
		deferred
		end

	add_value_qualifier (column: INTEGER; value: STRING) is
			-- Add qualifier `column' = `value' to prepared select query.
		require
			select_query_prepared: select_query_prepared
		deferred
		end

	update_tablerow (description: DB_TABLE) is
			-- Update object with `description' in the database.
			-- Object should already exist and should have kept
			-- same ID.
		require
			not_void: description /= Void
		deferred
		end

	set_id_and_create_tablerow (a_tablerow: DB_TABLE) is
			-- Store in the DB object `a_tablerow' after giving it
			-- a valid ID.
		require
			not_void: a_tablerow /= Void
		deferred
		end

	delete_tablerow (a_tablerow: DB_TABLE) is
			-- Delete `tablerow' in the database,
			-- i.e. the table row of `an_obj' table with `an_obj' ID.
			--| Warning: delete all dependent table rows.
		require
			not_void: a_tablerow /= Void
		deferred
		end
		
end -- class ABSTRACT_DB_TABLE_MANAGER
