indexing 
	description: "EiffelVision horizontal Progress bar."
	note: "By default, the step is 10."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_PROGRESS_BAR

inherit
	EV_PROGRESS_BAR
		redefine
			implementation
		end

creation
	make,
	make_with_range

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a progress bar with `par' as parent.
		do
			!EV_HORIZONTAL_PROGRESS_BAR_IMP! implementation.make
			widget_make (par)
		end

	make_with_range (par: EV_CONTAINER; min: INTEGER; max: INTEGER) is
			-- Create a spin-button with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			!EV_HORIZONTAL_PROGRESS_BAR_IMP! implementation.make_with_range (min, max)
			widget_make (par)
		end

feature -- Implementation

	implementation: EV_HORIZONTAL_PROGRESS_BAR_I

end -- class EV_HORIZONTAL_PROGRESS_BAR

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
