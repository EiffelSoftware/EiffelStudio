indexing 
	description:
		" EiffelVision vertical range, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_RANGE_IMP

inherit
	EV_HORIZONTAL_RANGE_I

	EV_RANGE_IMP
		undefine
			set_default_options
		redefine
			set_default_minimum_size
		end

create
	make,
	make_with_range

feature {NONE} -- Initialization

	make is
			-- Create a spin-button with 0 as minimum,
			-- 100 as maximum and `par' as parent.
		do
			make_horizontal (default_parent, 0, 0, 0, 0, 0)
			set_range (0, 100)
		end

	make_with_range (min: INTEGER; max: INTEGER) is
			-- Create a spin-button with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			make_horizontal (default_parent, 0, 0, 0, 0, 0)
			set_range (min, max)
		end

feature -- Status setting

   	set_default_minimum_size is
   			-- Plateform dependant initializations.
   		do
			internal_set_minimum_height (30)
 		end

end -- class EV_HORIZONTAL_RANGE_IMP

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
