indexing
	description: "EiffelVision toolbar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I

	EV_PRIMITIVE_IMP
		undefine
			set_default_options
		end

	EV_ITEM_HOLDER_IMP

creation
	make,
	make_with_size

feature {NONE} -- Implementation

	make is
			-- Create the tool-bar.
		do
		end

	make_with_size (w, h: INTEGER) is
			-- Create the tool-bar with `par' as parent.
		do
		end

	count: INTEGER is
			-- Number of direct children of the holder.
		do
		end

	get_item (index: INTEGER): EV_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		do
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
		end

feature -- Basic operations

	find_item_by_data (data: ANY): EV_ITEM is
			-- Find a child with data equal to `data'.
		do
		end

end -- class EV_TOOL_BAR_IMP

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
