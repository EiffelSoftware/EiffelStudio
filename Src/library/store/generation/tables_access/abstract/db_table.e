indexing
	description: "Element representing a database table"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLE

inherit
	DB_TABLES_ACCESS_USE

feature -- Initialization

	make is
			-- Create all the attributes.
		do
			set_default
		end

	set_default is
			-- Sets object default values.
			-- WARNING: Default primary and foreign key values
			-- MUST NOT be valid database values!
		deferred
		end

feature -- Access

	table_description: DB_TABLE_DESCRIPTION is deferred end
			-- Description associated to the table.

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




end -- class DB_TABLE


