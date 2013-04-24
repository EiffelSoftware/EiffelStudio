note
	description: "Contains all the handles"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DB [reference G -> DATABASE create default_create end]

inherit
	ANY

	DB_CONSTANT
		export
			{NONE} all
		end

	HANDLE_USE

feature -- Status report

	db_control: DATABASE_CONTROL [G]
			-- DATABASE_CONTROL handle
		do
			create Result
		end

	db_status: DATABASE_STATUS [G]
			-- DATABASE_STATUS handle
		do
			create Result
		end

	db_selection: DATABASE_SELECTION [G]
			-- DATABASE_SELECTION handle
		do
			create Result.make (parsed_string_size)
		end

	db_change: DATABASE_CHANGE [G]
			-- DATABASE_CHANGE handle
		do
			create Result.make (parsed_string_size)
		end

	db_repository: DATABASE_REPOSITORY [G]
			-- DATABASE_REPOSITORY handle
		do
			create Result.make
		end

	db_result: DATABASE_TUPLE [G]
			-- DATABASE_TUPLE handle
		do
			create Result.make
		end

	db_store: DATABASE_STORE [G]
			-- DATABASE_STORE handle
		do
			create Result.make (parsed_string_size)
		end

	db_format: DATABASE_FORMAT [G]
			-- DATABASE_FORMAT handle
		do
			create Result
		end

	db_proc: DATABASE_PROC [G]
			-- DATABASE_PROC handle
		do
			create Result.make
		end

	db_all_types: DATABASE_ALL_TYPES [G]
			-- DATABASE_ALL_TYPES handle
		do
			create Result.make
		end

	db_dyn_selection: DATABASE_DYN_SELECTION [G]
			-- DATABASE_DYN_SELECTION handle
		do
			create Result.make (parsed_string_size)
		end

	db_dyn_change: DATABASE_DYN_CHANGE [G]
			-- DATABASE_DYN_CHANGE handle
		do
			create Result.make (parsed_string_size)
		end

	name: STRING
			-- Database name
		require
			database_set: is_database_set
		do
			Result := handle.database.generator
		end

feature {NONE} -- Status report

	sql_struct: DATABASE_DATA [G]
			-- Implementation of the data.
		do
			create Result
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




end -- class DB



