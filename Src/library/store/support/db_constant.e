indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class DB_CONSTANT

feature {NONE} -- Status report
	
	name_table_size: INTEGER is
			-- Shared hash table size 
			-- used to hold stored procedure names
		do
			Result := name_table_size_ref.item
		end

	selection_string_size: INTEGER is
			-- Shared allocated size of passed SQL string
			-- with bind variables
		do
			Result := selection_string_size_ref.item
		end

	parsed_string_size: INTEGER is
			-- Shared allocated size of passed SQL string
			-- with bind variables all expanded
		do
			Result := parsed_string_size_ref.item
		end

feature {NONE} -- Status setting

	set_name_table_size (n: INTEGER) is
			-- Set shared `name_table_size_ref' with `n'.
		require
			n_positive: n > 0
		do
			name_table_size_ref.set_item (n)
		ensure
			name_table_size_set: name_table_size = n
		end

	set_selection_string_size (n: INTEGER) is
			-- Set shared `selection_string_size' with `n'.
		require
			n_positive: n > 0
		do
			selection_string_size_ref.set_item (n)
		ensure
			selection_string_size_set: selection_string_size = n
		end

	set_parsed_string_size (n: INTEGER) is
			-- Set shared `parsed_string_size' with `n'.
		require
			n_positive: n > 0
		do
			parsed_string_size_ref.set_item (n)
		ensure
			parsed_string_set: parsed_string_size = n
		end

feature {NONE} -- Status report

	Default_name_table_size: INTEGER is 20

	Default_selection_string_size: INTEGER is 2048

	Default_parsed_string_size: INTEGER is 4096

	name_table_size_ref: INTEGER_REF is
			-- Shared integer object holding a value
		once
			create Result
			Result.set_item (Default_name_table_size)
		end

	selection_string_size_ref: INTEGER_REF is
			-- Shared integer reference object holding a value
		once
			create Result
			Result.set_item (Default_selection_string_size)
		end

	parsed_string_size_ref: INTEGER_REF is
			-- Shared integer object holding a value
		once
			create Result
			Result.set_item (Default_parsed_string_size)
		end

end -- class DB_CONSTANT



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

