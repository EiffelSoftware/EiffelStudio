indexing
	description: "Eiffel Vision select button. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SELECT_BUTTON_IMP

inherit
	EV_SELECT_BUTTON_I
		redefine
			interface
		end

	EV_BUTTON_IMP
		redefine
			interface
		end
	
feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := C.gtk_toggle_button_get_active (c_object)
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			C.gtk_toggle_button_set_active (c_object, True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SELECT_BUTTON

end -- class EV_SELECT_BUTTON_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.6.3  2000/10/27 16:54:44  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.2.6.2  2000/08/08 18:12:40  oconnor
--| undefined old implementation of set_default_colors
--|
--| Revision 1.2.6.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/02/25 01:49:28  brendel
--| Implemented.
--|
--| Revision 1.1  2000/02/24 20:27:21  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

