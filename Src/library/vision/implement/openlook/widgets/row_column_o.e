
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ROW_COLUMN_O 

inherit

	ROW_COLUMN_I
		export
			{NONE} all
		end;

	ROW_COLUMN_R_O
		export
			{NONE} all
		end;

	MANAGER_O

creation

	make
	
feature 

	make (a_row_column: ROW_COLUMN) is
			-- Create a openlook row_column.
		
		local
			ext_name: ANY;
		do
			ext_name := a_row_column.identifier.to_c;		
			screen_object := create_row_column ($ext_name, a_row_column.parent.implementation.screen_object)
		end; 

	is_row_layout: BOOLEAN is
			-- Is current row column layout items preferably in row ?
		do
			Result := xt_unsigned_char (screen_object, Oorientation) = OHORIZONTAL
		end; 

	margin_height: INTEGER is
			-- Amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column
		do
			Result := xt_dimension (screen_object, OmarginHeight)
		ensure then
			Result >= 0
		end; 

	margin_width: INTEGER is
			-- Amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row
		do
			Result := xt_dimension (screen_object, OmarginWidth)
		ensure then
			Result >= 0
		end; 

	set_free_size is
			-- Set size of items to be free, in vertical layout mode
			-- only width is set to be the same as the widest one, in
			-- horizontal layout mode only height is set to be the same
			-- as the tallest one.
		do
			set_xt_unsigned_char (screen_object, OPACK_TIGHT, Opacking)
		end; 

	set_margin_height (new_margin_height: INTEGER) is
			-- Set the amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column.
		require else
			not_margin_height_negative: new_margin_height >= 0
		do
			set_xt_dimension (screen_object, new_margin_height, OmarginHeight)
		ensure then
			margin_height = new_margin_height
		end; 

	set_margin_width (new_margin_width: INTEGER) is
			-- Set the amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row.
		require else
			not_margin_width_negative: new_margin_width >= 0
		do
			set_xt_dimension (screen_object, new_margin_width, OmarginWidth)
		ensure then
			margin_width = new_margin_width
		end; 

	set_preferred_count (a_number: INTEGER) is
			-- Set preferably count of row or column, according to
			-- row layout mode or column layout mode, to `a_number'.
		require else
			not_negative_number: not (a_number < 0);
			not_nul_number: not (a_number = 0)
		do
			set_xt_short (screen_object, a_number, OnumColumns)
		end; 

	set_row_layout (flag: BOOLEAN) is
			-- Set row column to layout items preferably in row if `flag',
			-- in column otherwise.
		do
			if flag then
				set_xt_int (screen_object, OHORIZONTAL, Oorientation);
			else
				set_xt_int (screen_object, OVERTICAL, Oorientation)
			end
		ensure then
			flag_correctly_set: is_row_layout = flag
		end; 

	set_same_size is
			-- Set width of items to be the same as the widest one
			-- and height as the tallest one.
		do
			set_xt_unsigned_char (screen_object, OPACK_COLUMN, Opacking)
		end; 

	set_spacing (new_spacing: INTEGER) is
			-- Set spacing between items to `new_spacing'.
		require else
			not_spacing_negative: new_spacing >= 0
		do
			set_xt_dimension (screen_object, new_spacing, OhSpacing);
			set_xt_dimension (screen_object, new_spacing, OvSpacing)
		ensure then
			spacing = new_spacing
		end; 

	spacing: INTEGER is
			-- Spacing between items
		do
			Result := xt_dimension (screen_object, OhSpacing)
		ensure then
			Result >= 0
		end

feature {NONE} -- External features

	create_row_column (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
