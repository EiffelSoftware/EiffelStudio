indexing
	description: "String tools";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_STRING_EX [G -> DATABASE create default_create end]

inherit 

	STRING

	HANDLE_SPEC [G]
		undefine
			is_equal, out, copy, consistent, setup
		end

creation -- Creation procedure

	make

feature -- Status setting

	get_select_name (no_descriptor: INTEGER; index: INTEGER) is
			-- Put in `Current' name of the index-th column of selection.
		do
			count := db_spec.put_col_name (no_descriptor, index, area, capacity)
		ensure
			capacity_unchanged: capacity = old capacity
			not_change_area: area = old area
		end

	get_value (no_descriptor: INTEGER; index: INTEGER) is
			-- Put in `Current' value of index-th column of selection.
		do
			count := db_spec.put_data (no_descriptor, index, area, capacity) 
		ensure
			capacity_unchanged: capacity = old capacity
			not_change_area: area = old area
		end

end -- class DATABASE_STRING_EX


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

