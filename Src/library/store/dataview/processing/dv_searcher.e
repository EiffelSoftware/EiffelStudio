indexing
	description: "Objects that enable to perform a database selection."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_SEARCHER

inherit
	DV_COMPONENT

	DB_TABLES_ACCESS_USE

feature -- Status report

	user_component_set: BOOLEAN is
			-- Is component user set?
		do
			Result := db_table_component /= Void
		end

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		do
			Result := table_code /= 0
		end

feature {DV_COMPONENT} -- Basic operations

	set_table_code (tcode: INTEGER) is
			-- Set `tcode' as code of database table from which table rows
			-- will be selected.
			-- This can be changed during activation phase.
		require
			valid_code: is_valid_code (tcode)
		do
			table_code := tcode
		end

	set_user_component (db_table_comp: DV_TABLE_COMPONENT) is
			-- Set `db_table_comp' to component user.
		require
			not_activated: not is_activated
			db_table_component_not_void: db_table_comp /= Void
		do
			db_table_component := db_table_comp
		end

	refresh: ARRAYED_LIST [DB_TABLE] is
			-- Return tablerows corresponding to last database reading, i.e.
			-- table rows may have changed but query is the same.
		require
			is_activated: is_activated
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	table_code: INTEGER
			-- Code of table to read.

	db_table_component: DV_TABLE_COMPONENT;
			-- Component user.

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_SEARCHER
