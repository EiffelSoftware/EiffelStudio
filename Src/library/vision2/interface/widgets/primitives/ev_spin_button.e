indexing
	description:
		" EiffelVision spin button. A single line edit that%
		% displays only numbers. The user can increase or%
		% decrease this number by clicking on up or down%
		% arrow buttons."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON

inherit
	EV_GAUGE
		export
			{NONE} set_step
		redefine
			implementation,
			set_step
		end

	EV_TEXT_FIELD
		redefine
			make,
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
			create {EV_SPIN_BUTTON_IMP} implementation.make
			widget_make (par)
		end

	make_with_range (par: EV_CONTAINER; min: INTEGER; max: INTEGER) is
			-- Create a spin-button with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			create {EV_SPIN_BUTTON_IMP} implementation.make_with_range (min, max)
			widget_make (par)
		end

feature {NONE} -- Inapplicable

	set_step (val: INTEGER) is
			-- Make `val' the new step.
		do
			check
				Inapplicable: False
			end
		end

feature {NONE} -- Implementation

	implementation: EV_SPIN_BUTTON_I
			-- Platform dependant access.

end -- class EV_SPIN_BUTTON

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
