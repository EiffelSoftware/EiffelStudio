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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.4  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.3  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.6.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/02/25 21:28:15  brendel
--| Formatting.
--|
--| Revision 1.1  2000/02/24 18:11:44  oconnor
--| New inheritance structure for buttons with state.
--| New class EV_SELECT_BUTTON provides `is_selected' and `enable_select'.
--| RADIO_BUTTON inherits this, as does TOGGLE_BUTTON which adds
--| `disable_select' and `toggle'.
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
