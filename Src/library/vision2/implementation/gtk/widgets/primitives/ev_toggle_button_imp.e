indexing
	description: "EiffelVision toggle button, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EV_TOGGLE_BUTTON_IMP
	
inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end
	
	EV_BUTTON_IMP
		redefine
			make,
			interface
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk toggle button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_toggle_button_new)
		end

feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			C.gtk_toggle_button_set_active (button_widget, True)
		end

	disable_select is
				-- Set `is_selected' `False'.
		do
			C.gtk_toggle_button_set_active (button_widget, False)
		end

	toggle is
			-- Change the state of the toggle button.
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := C.gtk_toggle_button_get_active (button_widget)
		end 

feature {EV_ANY_I}

	interface: EV_TOGGLE_BUTTON

end -- class EV_TOGGLE_BUTTON_IMP

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
--| Revision 1.22  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.2.9  2000/10/27 16:54:44  manus
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
--| Revision 1.16.2.8  2000/09/06 23:18:48  king
--| Reviewed
--|
--| Revision 1.16.2.7  2000/09/04 18:21:42  oconnor
--| simplify toggle implementation
--|
--| Revision 1.16.2.6  2000/08/14 16:32:43  king
--| Workaround for gtk bug when calling toggled function on init
--|
--| Revision 1.16.2.5  2000/08/08 00:03:16  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.16.2.4  2000/06/15 21:20:27  king
--| Removed needless setting of button_widget as it isnow a function in button_imp
--|
--| Revision 1.16.2.3  2000/06/15 19:11:50  king
--| routines now using button_widget instead of c_object
--|
--| Revision 1.16.2.2  2000/05/09 20:31:07  king
--| Integrated selectable/deselectable
--|
--| Revision 1.16.2.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.20  2000/04/05 17:07:02  king
--| Removed is_select and enable_select in to select_button
--|
--| Revision 1.19  2000/02/24 18:13:43  oconnor
--| updated to use enable_select/disable_select instead of set_state (BOOLEAN)
--|
--| Revision 1.18  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.17  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.4.5  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.16.4.4  2000/01/27 19:29:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.4.3  2000/01/19 17:23:45  oconnor
--| removed call to old ev_textable_imp_initialize
--|
--| Revision 1.16.4.2  1999/12/23 01:35:28  king
--| Removed redundant event commands
--| Implemented to fit in with new structure
--|
--| Revision 1.16.4.1  1999/11/24 17:29:59  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.3  1999/11/17 01:53:06  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.15.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
