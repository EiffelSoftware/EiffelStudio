indexing
	description: "Element representing a database table"
	author: "Cedric Reduron"
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

end -- class DB_TABLE

