indexing
	description:
		"EiffelVision toggle tool bar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
		-- Create the tool-bar toggle button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_toggle_button_new)
			C.gtk_button_set_relief (c_object, C.gtk_relief_none_enum)
		end

feature -- Status setting

	disable_select is
			-- Unselect `Current'.
		do
			C.gtk_toggle_button_set_active (c_object, False)
		end

	enable_select is
			-- Select `Current'.
		do
			C.gtk_toggle_button_set_active (c_object, True)
		end	

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected.
		do
			Result := C.gtk_toggle_button_get_active (c_object)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

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
--| Revision 1.13  2001/06/07 23:08:02  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.2.4  2000/09/06 23:18:39  king
--| Reviewed
--|
--| Revision 1.8.2.3  2000/05/10 18:47:34  king
--| Corrected make procedure
--|
--| Revision 1.8.2.2  2000/05/09 21:12:41  king
--| Integrated changes to selectable/deselectable
--|
--| Revision 1.8.2.1  2000/05/03 19:08:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.11  2000/04/05 17:02:51  king
--| Moved make, is_selected and enable_select in to tb select button imp
--|
--| Revision 1.10  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.9  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.4.4  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.8.4.3  2000/01/28 18:41:57  king
--| Implemented to fit in with new structure, removed redundant features
--|
--| Revision 1.8.4.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.4.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
