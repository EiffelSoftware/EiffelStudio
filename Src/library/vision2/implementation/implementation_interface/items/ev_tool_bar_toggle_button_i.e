--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision toggle tool bar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_TOGGLE_BUTTON_I

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

	EV_DESELECTABLE_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_I

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
--| Revision 1.10  2000/06/07 17:27:41  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.6.2.2  2000/05/09 21:12:42  king
--| Integrated changes to selectable/deselectable
--|
--| Revision 1.6.2.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/04/04 17:08:59  rogers
--| Now inherits EV_TOOL_BAR_sELECT_BUTTON_I. Removed is_selected and
--| enable_select.
--|
--| Revision 1.8  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.4.5  2000/02/04 04:02:41  oconnor
--| released
--|
--| Revision 1.6.4.4  2000/02/02 23:46:33  king
--| Removed has_parent preconds from state selection routines
--|
--| Revision 1.6.4.3  2000/01/28 18:54:18  king
--| Removed redundant features, changed to generic structure of ev_item_list
--|
--| Revision 1.6.4.2  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.4.1  1999/11/24 17:30:03  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.5.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
