indexing
	description: "EiffelVision toolbar. Only bar items can be%
		% created into a tool-bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

creation
	make,
	make_with_size

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tool-bar with `par' as parent.
		do
			!EV_TOOL_BAR_IMP! implementation.make
 			widget_make (par)
		end

	make_with_size (par: EV_CONTAINER; w, h: INTEGER) is
			-- Create the tool-bar with `par' as parent, `w' and `h' as size of
			-- the buttons.
			-- On windows comparing to the pixmap inside the button, count 8 more
			-- pixels for the width, and 7 for the height. By default, the size is
			-- 24 on 22.
		require
			valid_width: w >= 0
			valid_height: h >= 0
		do
			!EV_TOOL_BAR_IMP! implementation.make_with_size (w, h)
 			widget_make (par)
		end

feature -- Implementation

	implementation: EV_TOOL_BAR_I

end -- class EV_TOOL_BAR

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
