indexing
	description:
		"Button for use with EV_TOOL_BAR that toggles between states each time%
		%it is pressed"
	status: "See notice at end of class."
	keywords: "tool, bar, toggle, button"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		redefine
			implementation,
			create_implementation
		end

	EV_DESELECTABLE
		redefine
			implementation
		end

create
	default_create,
	make_with_text

feature -- Status setting

	toggle is
			-- Change `is_selected'.
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		ensure
			toggled: is_selected /= old is_selected
		end

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TOOL_BAR_TOGGLE_BUTTON_IMP} implementation.make (Current)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_TOGGLE_BUTTON_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_TOOL_BAR_TOGGLE_BUTTON

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
--| Revision 1.10  2000/06/07 17:28:05  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.4.2.2  2000/05/09 21:12:43  king
--| Integrated changes to selectable/deselectable
--|
--| Revision 1.4.2.1  2000/05/03 19:09:58  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/04/04 17:00:09  rogers
--| Now inherits EV_TOOL_BAR_SELECT_BUTTON. Removed is_selected and
--| enable_select.
--|
--| Revision 1.8  2000/03/24 03:10:22  oconnor
--| formatting and comments
--|
--| Revision 1.7  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.6  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.4.6  2000/02/02 23:49:31  king
--| Removed has_parent preconds from state selection routines
--|
--| Revision 1.4.4.5  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.4.4.4  2000/01/28 18:55:50  king
--| Removed redundant features
--|
--| Revision 1.4.4.3  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.4.2  2000/01/26 19:44:42  rogers
--| altered to comply with the major vision2 changes. Remove command
--| associations. Removed make and make_with_text as they are now inherited
--| from ev_tool_bar_button. Added implementation and create_implementation.
--|
--| Revision 1.4.4.1  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:52  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
