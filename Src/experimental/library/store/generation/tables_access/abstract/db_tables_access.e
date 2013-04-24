note
	description: "Description of database tables."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLES_ACCESS

feature -- Initialization

	make
			-- Ensure object unicity.
		require
			not_created: not created
		do
			created_impl.set_item (True)
		ensure
			created: created
		end

feature -- Status report

	created: BOOLEAN
			-- Is the class object created?
		do
			Result := created_impl.item
		end

feature -- Access

	Table_number: INTEGER deferred end
			-- Number of database tables.

	code_list: ARRAYED_LIST [INTEGER]
			-- Table code list.
		deferred
		end

	name_list: ARRAYED_LIST [STRING]
			-- Table name list. Can be interpreted as a list
			-- or a hash-table.
		deferred
		end

	obj (i: INTEGER): DB_TABLE
			-- Return instance of table with code `i'.
		require
			in_range: is_valid (i)
		deferred
		end

	description (i: INTEGER): DB_TABLE_DESCRIPTION
			-- Return description of table with code `i'.
		require
			in_range: is_valid (i)
		deferred
		end

feature -- Facilities

	is_valid (code: INTEGER): BOOLEAN
			-- Is `code' a valid table code?
		do
			Result := code > 0 and then code <= Table_number
		end

feature {NONE} -- Implementation

	created_impl: BOOLEAN_REF
			-- Shared object to avoid multiplicity.
		once
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




end -- class DB_TABLES_ACCESS


