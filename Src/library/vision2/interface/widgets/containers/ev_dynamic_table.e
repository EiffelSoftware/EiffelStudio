indexing

	description: 
		" EiffelVision dynamic table. Invisible container that allows%
		% unlimited number of other widgets to be packed inside it.%
		% A dynamic table controls the children's location and size%
		% automatically."
	note: " In this table, each child fill one cell. The user choose the%
		% way to lay the children out. If the children are laid in%
		% rows, the number of colums must be finite and the one of%
		% rows is infinite; if they area laid out in columns, it's%
		% the contrary."
	note2: " By default, a dynamic table is the equivalent of an%
		% horizonatl box."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DYNAMIC_TABLE

inherit
	EV_TABLE
		export
			{NONE} set_child_position
		redefine
			make,
			implementation
		end

creation
	make

feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
			-- Create a table widget with `par' as
			-- parent.
		do
			!EV_DYNAMIC_TABLE_IMP!implementation.make (par)
			widget_make (par)
		end	

feature -- Status report

	is_row_layout: BOOLEAN is
			-- Are children laid out in rows?
			-- False by default
		require
			exists: not destroyed
		do
			Result := implementation.is_row_layout
		end

feature -- Status setting

	set_finite_dimension (a_number: INTEGER) is
			-- Set number of columns if row
			-- layout, or number of row if column
			-- layout.
		require
			exists: not destroyed
			positive_number: a_number > 0
		do
			implementation.set_finite_dimension (a_number)
		end

	set_row_layout is
			-- Lay the children out in rows.
		require
			exists: not destroyed
		do
			implementation.set_row_layout (True)
		ensure
			Row_layout: is_row_layout
		end

	set_column_layout is
			-- Lay the children out in columns.
		require
			exists: not destroyed
		do
			implementation.set_row_layout (False)
		ensure
			Column_layout: not is_row_layout
		end

--	set_free_size is
			-- Set size of items to be free, in vertical layout mode
			-- only width is set to be the same as the widest one, in
			-- horizontal layout mode only height is set to be the same
			-- as the tallest one.
--		require
--			exists: not destroyed
--		do
--			implementation.set_free_size
--		end

--	set_same_size is
--			-- Set width of items to be the same as the widest one
--			-- and height as the tallest one.
--		require
--			exists: not destroyed
--		do
--			implementation.set_same_size
--		end 
--
feature -- Measurement

--	margin_height: INTEGER is
--			-- Amount of blank space between the top edge
--			-- of row column and the first item in each column, and the
--			-- bottom edge of row column and the last item in each column
--		require
---			exists: not destroyed
--		do
--			Result:= implementation.margin_height
---		ensure
--			Result >= 0
--		end

--	margin_width: INTEGER is
--			-- Amount of blank space between the left edge
--			-- of row column and the first item in each row , and the
--			-- right edge of row column and the last item in each row
---		require
--			exists: not destroyed
--		do
--			Result:= implementation.margin_width
--		ensure
--			Result >= 0
--		end

--	spacing: INTEGER is
--			-- Spacing between items
--		require
--			exists: not destroyed
---		do
---			Result:= implementation.spacing
--		ensure
--			Greater_that_zero: Result >= 0
--		end

feature -- Resizing

--	set_margin_height (new_margin_height: INTEGER) is
--			-- Set amount of blank space between the top edge
--			-- of row column and the first item in each column, and the
--			-- bottom edge of row column and the last item in each column.
--		require
--			exists: not destroyed
--			not_negative_margin_height: new_margin_height >= 0
--		do
--			implementation.set_margin_height (new_margin_height)
--		ensure
--			margin_height = new_margin_height
--		end
--
--	set_margin_width (new_margin_width: INTEGER) is
--			-- Set amount of blank space between the left edge
--			-- of row column and the first item in each row , and the
--			-- right edge of row column and the last item in each row.
--		require
--			exists: not destroyed
--			not_negative_margin_width: new_margin_width >= 0
--		do
--			implementation.set_margin_width (new_margin_width)
--		ensure
--			margin_width = new_margin_width
--		end
--
--	set_spacing (new_spacing: INTEGER) is
--			-- Set spacing between items to `new_spacing'.
--		require
--			exists: not destroyed
--			Not_spacing_negative: new_spacing >= 0
--		do
--			implementation.set_spacing (new_spacing)
--		ensure
--			Spacing_set: spacing = new_spacing
--		end

feature {NONE} -- Implementation
	
	implementation: EV_DYNAMIC_TABLE_I

end -- class EV_DYNAMIC_TABLE

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--|----------------------------------------------------------------
