indexing
	description: "Description of database tables."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLES_ACCESS

feature -- Initialization

	make is
			-- Ensure object unicity.
		require
			not_created: not created
		do
			created_impl.set_item (True)
		ensure
			created: created
		end

feature -- Status report

	created: BOOLEAN is
			-- Is the class object created?
		do
			Result := created_impl.item
		end

feature -- Access

	Table_number: INTEGER is deferred end
			-- Number of database tables.

	code_list: ARRAYED_LIST [INTEGER] is
			-- Table code list.
		deferred
		end

	name_list: ARRAYED_LIST [STRING] is
			-- Table name list. Can be interpreted as a list
			-- or a hash-table.
		deferred
		end

	obj (i: INTEGER): DB_TABLE is
			-- Return instance of table with code `i'.
		require
			in_range: is_valid (i)
		deferred
		end

	description (i: INTEGER): DB_TABLE_DESCRIPTION is
			-- Return description of table with code `i'.
		require
			in_range: is_valid (i)
		deferred
		end

feature -- Facilities

	is_valid (code: INTEGER): BOOLEAN is
			-- Is `code' a valid table code?
		do
			Result := code > 0 and then code <= Table_number
		end

feature {NONE} -- Implementation

	created_impl: BOOLEAN_REF is
			-- Shared object to avoid multiplicity.
		once
			create Result
		end
 
end -- class DB_TABLES_ACCESS


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

