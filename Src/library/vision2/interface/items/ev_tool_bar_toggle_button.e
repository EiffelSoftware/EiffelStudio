--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision tool-bar toggle button. A two state%
		% button for the tool-bar."
	status: "See notice at end of class."
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

create
	default_create,
	make_with_text

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the current button selected?
		do
			Result := implementation.is_selected
		end

feature -- Status setting

	enable_select is
			-- Select the current button.
		do
			implementation.enable_select
		ensure
			selected: is_selected
		end

	disable_select is
			-- Unselect the current_button.
		do
			implementation.disable_select
		ensure
			unselected: not is_selected
		end

	toggle is
			-- Toggle the state of the current button.
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		ensure
			toggled: is_selected /= old is_selected
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_TOGGLE_BUTTON_I
			-- Platform dependent access.

	create_implementation is
			-- Create implementation of tool bar toggle button.
		do
			create {EV_TOOL_BAR_TOGGLE_BUTTON_IMP} implementation.make (Current)
		end

end -- class EV_TOOL_BAR_TOGGLE_BUTTON

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--| altered to comply with the major vision2 changes. Remove command associations. Removed make and make_with_text as they are now inherited from ev_tool_bar_button. Added implementation and create_implementation.
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
