indexing 
	description:
		"Eiffel Vision vertical range. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_RANGE_IMP

inherit
	EV_VERTICAL_RANGE_I
		redefine
			interface
		end

	EV_RANGE_IMP
		redefine
			set_default_minimum_size,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create as vertical range.
		do
			base_make (an_interface)
			make_vertical (default_parent, 0, 0, 0, 0, 0)
		end

feature -- Status setting

   	set_default_minimum_size is
   			-- Plateform dependant initializations.
   		do
			ev_set_minimum_width (30)
			ev_set_minimum_height (10)
 		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_RANGE

end -- class EV_VERTICAL_RANGE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

