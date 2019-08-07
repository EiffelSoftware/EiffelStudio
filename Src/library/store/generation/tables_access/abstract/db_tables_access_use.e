note
	description: "Access to the class DB_TABLES_ACCESS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLES_ACCESS_USE

feature -- Status report

	is_valid_code (code: INTEGER): BOOLEAN
			-- Does `code' represents a database table?
		do
			Result := attached tables_cell.item as l_tables and then l_tables.is_valid (code)
		end

	tables_set: BOOLEAN
			-- Is abstract description of database tables
			-- set?
		do
			Result := tables_cell.item /= Void
		end

feature {NONE} -- Access

	tables: DB_TABLES_ACCESS
			-- Abstract description of database tables.
		require
			tables_set: tables_set
		do
			check attached tables_cell.item as l_item then
				Result := l_item
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Basic operations

	set_tables (t: DB_TABLES_ACCESS)
			-- Set `t' to `tables'.
		require
			not_void: t /= Void
		do
			tables_cell.put (t)
		ensure
			tables_set: tables_set
		end

feature {NONE} -- Implementation

	tables_cell: CELL [detachable DB_TABLES_ACCESS]
			-- `tables' cell.
		once
			create Result.put (Void)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DB_TABLES_ACCESS_USE


