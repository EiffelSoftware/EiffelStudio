indexing
	description:
		"Base class for simple, non container widgets."
	status: "See notice at end of class"
	keywords: "widget, primitive"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_PRIMITIVE

inherit
	EV_WIDGET
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_TOOLTIPABLE
		redefine
			implementation,
			is_in_default_state
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_WIDGET} and Precursor {EV_TOOLTIPABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_PRIMITIVE_I
	
end -- class EV_PRIMITIVE

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
