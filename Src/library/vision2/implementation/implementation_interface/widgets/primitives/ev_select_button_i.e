indexing
	description: "Eiffel Vision select button. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECT_BUTTON_I 

inherit
	EV_BUTTON_I
		redefine
			interface
		end
	
feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is button depressed?
		deferred
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		deferred
		ensure
			is_selected: is_selected
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SELECT_BUTTON

end -- class EV_TOGGLE_BUTTON_I

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

