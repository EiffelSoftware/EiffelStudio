indexing
	description:
		"EiffelVision vertical scroll bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR

inherit
	EV_SCROLL_BAR
		redefine
			implementation
		end

create
	make,
	make_with_range

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a spin-button with 0 as minimum,
			-- 100 as maximum and `par' as parent.
		do
			create {EV_VERTICAL_SCROLL_BAR_IMP} implementation.make
			widget_make (par)
		end

	make_with_range (par: EV_CONTAINER; min: INTEGER; max: INTEGER) is
			-- Create a spin-button with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			create {EV_VERTICAL_SCROLL_BAR_IMP} implementation.make_with_range (min, max)
			widget_make (par)
		end

feature -- Implementation

	implementation: EV_VERTICAL_SCROLL_BAR_I
			-- Platform dependent access.

end -- class EV_VERTICAL_SCROLL_BAR

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
