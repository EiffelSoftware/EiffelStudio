indexing

	description: "General row column implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class ROW_COLUMN_I 

inherit

	MANAGER_I
	
feature 

	is_row_layout: BOOLEAN is
			-- Is current row column layout items preferably in row ?
		deferred
		end; -- is_row_layout

	margin_height: INTEGER is
			-- Amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column
		deferred
		ensure
			Result >= 0
		end; -- margin_height

	margin_width: INTEGER is
			-- Amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row
		deferred
		ensure
			Result >= 0
		end; -- margin_width

	set_free_size is
			-- Set size of items to be free, in vertical layout mode
			-- only width is set to be the same as the widest one, in
			-- horizontal layout mode only height is set to be the same
			-- as the tallest one.
		deferred
		end; -- set_free_size

	set_margin_height (new_margin_height: INTEGER) is
			-- Set amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column.
		require
			not_negative_margin_height: new_margin_height >= 0
		deferred
		ensure
			margin_height = new_margin_height
		end; -- set_margin_height

	set_margin_width (new_margin_width: INTEGER) is
			-- Set amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row.
		require
			not_negative_margin_width: new_margin_width >= 0
		deferred
		ensure
			margin_width = new_margin_width
		end; -- set_margin_width

	set_preferred_count (a_number: INTEGER) is
			-- Set preferably count of row or column, according to
			-- row layout mode or column layout mode, to `a_number'.
		require
			not_negative_number: not (a_number < 0);
			not_nul_number: not (a_number = 0)
		deferred
		end; -- set_preferred_count

	set_row_layout (flag: BOOLEAN) is
			-- Set row column to layout items preferably in row if `flag',
			-- in column otherwise.
		deferred
		ensure
			flag_correctly_set: is_row_layout = flag
		end; -- set_row_layout

	set_same_size is
			-- Set width of items to be the same as the widest one
			-- and height as the tallest one.
		deferred
		end; -- set_same_size

	set_spacing (new_spacing: INTEGER) is
			-- Set spacing between items to `new_spacing'.
		require
			not_spacing_negative: new_spacing >= 0
		deferred
		ensure
			spacing = new_spacing
		end; -- set_spacing

	spacing: INTEGER is
			-- Spacing between items
		deferred
		ensure
			Result >= 0
		end -- spacing

end -- class ROW_COLUMN_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
