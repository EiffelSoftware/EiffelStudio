
-- Area which arranges children in rows or column.

indexing

	date: "$Date$";
	revision: "$Revision$"

class ROW_COLUMN 

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a row column with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.row_column (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name);
			Not_row_layout: not is_row_layout
		end;

	
feature -- Layout

	set_preferred_count (a_number: INTEGER) is
			-- Set number of columns if column
			-- layout, or number of rows if row
			-- layout.
		require
			Not_negative_number: not (a_number < 0);
			Not_nul_number: not (a_number = 0)
		do
			implementation.set_preferred_count (a_number)
		end;

	is_row_layout: BOOLEAN is
			-- Are children laid out in rows?
		do
			Result := implementation.is_row_layout
		end;

	set_row_layout is
			-- Lay the children out in rows.
		do
			implementation.set_row_layout (True)
		ensure
			Row_layout: is_row_layout
		end;

	set_column_layout is
			-- Lay the children out in columns.
		do
			implementation.set_row_layout (False)
		ensure
			Column_layout: not is_row_layout
		end;

feature -- Margin

	margin_height: INTEGER is
			-- Amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column
		do
			Result:= implementation.margin_height
		ensure
			Result >= 0
		end;

	margin_width: INTEGER is
			-- Amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row
		do
			Result:= implementation.margin_width
		ensure
			Result >= 0
		end;

	set_margin_height (new_margin_height: INTEGER) is
			-- Set amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column.
		require
			not_negative_margin_height: new_margin_height >= 0
		do
			implementation.set_margin_height (new_margin_height)
		ensure
			margin_height = new_margin_height
		end;

	set_margin_width (new_margin_width: INTEGER) is
			-- Set amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row.
		require
			not_negative_margin_width: new_margin_width >= 0
		do
			implementation.set_margin_width (new_margin_width)
		ensure
			margin_width = new_margin_width
		end;

feature  -- Children widgets manipulation

	set_free_size is
			-- Set size of items to be free, in vertical layout mode
			-- only width is set to be the same as the widest one, in
			-- horizontal layout mode only height is set to be the same
			-- as the tallest one.
		do
			implementation.set_free_size
		end;

	set_same_size is
			-- Set width of items to be the same as the widest one
			-- and height as the tallest one.
		do
			implementation.set_same_size
		end; 

	set_spacing (new_spacing: INTEGER) is
			-- Set spacing between items to `new_spacing'.
		require
			Not_spacing_negative: new_spacing >= 0
		do
			implementation.set_spacing (new_spacing)
		ensure
			Spacing_set: spacing = new_spacing
		end;

	spacing: INTEGER is
			-- Spacing between items
		do
			Result:= implementation.spacing
		ensure
			Greater_that_zero: Result >= 0
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: ROW_COLUMN_I;
			-- Implementation of row column

feature {NONE}

	set_default is
			-- Set default values to current row column.
		do
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
