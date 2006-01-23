indexing
	description: "Access to the class DB_TABLES_ACCESS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLES_ACCESS_USE

feature -- Status report

	is_valid_code (code: INTEGER): BOOLEAN is
			-- Does `code' represents a database table?
		do
			Result := tables.is_valid (code)
		end

	tables_set: BOOLEAN is
			-- Is abstract description of database tables
			-- set?
		do
			Result := tables_cell.item /= Void
		end

feature {NONE} -- Access

	tables: DB_TABLES_ACCESS is
			-- Abstract description of database tables.
		require
			tables_set: tables_set
		do
			Result := tables_cell.item
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Basic operations

	set_tables (t: DB_TABLES_ACCESS) is
			-- Set `t' to `tables'.
		require
			not_void: t /= Void
		do
			tables_cell.put (t)
		ensure
			tables_set: tables_set
		end

feature {NONE} -- Implementation

	tables_cell: CELL [DB_TABLES_ACCESS] is
			-- `tables' cell.
		once
			create Result.put (Void)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_TABLES_ACCESS_USE


