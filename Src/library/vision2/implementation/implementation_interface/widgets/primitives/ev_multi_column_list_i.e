indexing
	description: 
		"EiffelVision multi-column-list, implementation interface."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_I

inherit
	EV_LIST_I
		rename
			count as row_count
		end

feature {NONE} -- Initialization

	make_with_size (par: EV_CONTAINER; col_nb: INTEGER) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		deferred
		end

feature -- Access

	column_count: INTEGER is
			-- Nimber of columns in the list.
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	show_title_row is
			-- Show the row of the titles.
		require
			exists: not destroyed
		deferred
		end

	hide_title_row is
			-- Hide the row of the titles.
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the column number
			-- `number'.
		require
			exists: not destroyed
--			column_exists: column <= column_count
		deferred
		end

	set_column_width (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the column number
			-- `column'.
		require
			exists: not destroyed
--			column_exists: column >= 1 and column <= column_count
		deferred
		end

	set_rows_height (value: INTEGER) is
			-- Make`value' the new height of all the rows.
		require
			exists: not destroyed
--			row_exists: row >= 0 and row <= row_count
		deferred
		end

end -- class EV_MULTI_COLUMN_LIST_I

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
