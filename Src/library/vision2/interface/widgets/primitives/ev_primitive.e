indexing
	description:
		"[
			Base class for simple, non container widgets.
		]"
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

