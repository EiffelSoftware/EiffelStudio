indexing
	description: 
		"EiffelVision multi-column-list. Contains a list of items%
		% from which the user can select."
	note: "The list start at the index 1, the titles are not count among%
		%the rows."	
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST

inherit
	EV_LIST
		rename
			count as row_count
		redefine
			implementation
		end

creation
	make_with_size

feature {NONE} -- Initialization

	make_with_size (par: EV_CONTAINER; col_nb: INTEGER) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		do
			!EV_MULTI_COLUMN_LIST_IMP!implementation.make_with_size (par, col_nb)
			widget_make (par)
		end

feature -- Access

	column_count: INTEGER is
			-- Nimber of columns in the list.
		require
			exists: not destroyed
		do
			Result := implementation.column_count
		end

feature -- Status setting

	show_title_row is
			-- Show the row of the titles.
		require
			exists: not destroyed
		do
			implementation.show_title_row
		end

	hide_title_row is
			-- Hide the row of the titles.
		require
			exists: not destroyed
		do
			implementation.hide_title_row
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the column number
			-- `number'.
		require
			exists: not destroyed
--			column_exists: column >= 1 and column <= column_count
		do
			implementation.set_column_title (txt, column)
		end

	set_column_width (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the column number
			-- `column'.
		require
			exists: not destroyed
--			column_exists: column >= 1 and column <= column_count
		do
			implementation.set_column_width (value, column)
		end

	set_rows_height (value: INTEGER) is
			-- Make`value' the new height of all the rows.
		require
			exists: not destroyed
--			row_exists: row >= 0 and row <= row_count
		do
			implementation.set_rows_height (value)
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation
	
	implementation: EV_MULTI_COLUMN_LIST_I	

end -- class EV_MULTI_COLUMN_LIST

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|---------------------------------------------------------------
