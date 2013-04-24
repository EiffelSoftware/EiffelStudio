note
	description: "Abstract interface with a database.%
			%It caters needs of DB_TABLE_COMPONENT class%
			%and descendants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_DB_TABLE_MANAGER

inherit
	DB_TABLES_ACCESS_USE

feature -- Access

	database_result_list: ARRAYED_LIST [DB_TABLE]
			-- Database result list.
		require
			no_error: not has_error
		deferred
		ensure
			result_not_void: Result /= Void
		end

	Equals_type: INTEGER = 0
			-- Attribute equals value.

	Greater_type: INTEGER = 1
			-- Attribute is greater than value.

	Lower_type: INTEGER = 2
			-- Attribute is lower than value.

	Prefix_type: INTEGER = 3
			-- Value is prefix of attribute.

	Suffix_type: INTEGER = 4
			-- Value is suffix of attribute.

	Contains_type: INTEGER = 5
			-- Attribute contains value.

	Max_type: INTEGER = 5
			-- Maximum type.

	Case_sensitive: BOOLEAN = True
			-- Selection is case sensitive.

	Case_insensitive: BOOLEAN = False
			-- Selection is case insensitive.

feature -- Status report

	has_error: BOOLEAN
			-- Has an error occurred during last database operation?
		deferred
		end

	error_message: detachable STRING
			-- Error message if an error occurred during last
			-- database operation.
		deferred
		end

	select_query_prepared: BOOLEAN
			-- Is a select query prepared?
		deferred
		end

	valid_type (type: INTEGER): BOOLEAN
			-- Is `type' a valid qualifying type?
		do
			Result := type >= 0 and then type <= Max_type
		end

	has_id (tablerow: DB_TABLE): BOOLEAN
			-- Does `tablerow' have an ID and can it be found?
		require
			tablerow_not_void: tablerow /= Void
		deferred
		end

feature -- Basic operations: selection

	load_result
			-- Load result. Set `has_error'. Result is available in
			-- `database_result' if result is unique, `database_result_list' otherwise.
		require
			select_query_prepared: select_query_prepared
		deferred
		end

	prepare_select_with_table (tablecode: INTEGER)
			-- Prepare a simple select query on table with code `tablecode'.
			-- Execute it with `load_result_list'.
		require
			is_valid_tablecode: is_valid_code (tablecode)
		deferred
		end

	add_value_qualifier (column: INTEGER; value: STRING)
			-- Add qualifier `column' = `value' to prepared select query.
		require
			select_query_prepared: select_query_prepared
			not_void: value /= Void
		deferred
		end

	add_specific_qualifier (column: INTEGER; value: STRING; type: INTEGER; case: BOOLEAN)
			-- Add qualifier `column' related to `value' with `type' and `case'.
		require
			select_query_prepared: select_query_prepared
			not_void: value /= Void
			valid_type: valid_type (type)
		deferred
		end

feature -- Basic operations: update

	update_tablerow (description: DB_TABLE)
			-- Update object with `description' in the database.
			-- Object should already exist and should have kept
			-- same ID.
		require
			not_void: description /= Void
			has_id: has_id (description)
		deferred
		end

	set_id_and_create_tablerow (a_tablerow: DB_TABLE)
			-- Store in the DB object `a_tablerow' after giving it
			-- a valid ID.
		require
			not_void: a_tablerow /= Void
			has_id: has_id (a_tablerow)
		deferred
		end

	delete_tablerow (a_tablerow: DB_TABLE)
			-- Delete `tablerow' in the database,
			-- i.e. the table row of `an_obj' table with `an_obj' ID.
			--| Warning: delete all dependent table rows.
		require
			not_void: a_tablerow /= Void
			has_id: has_id (a_tablerow)
		deferred
		end

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




end -- class ABSTRACT_DB_TABLE_MANAGER


