--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision Toolbar button, a specific button that goes%
		% in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_ITEM

inherit
	EV_ITEM
		redefine
			parent
		end

feature -- Access

	parent: EV_TOOL_BAR is
			-- The parent of the Current widget
			-- Can be void.
		do
			Result ?= {EV_ITEM} Precursor
		end

end -- class EV_TOOL_BAR_BUTTON

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
--| Revision 1.2  2000/02/14 12:05:12  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.1  2000/02/01 23:29:17  king
--| TB item abstraction for separator and buttons
--|
--| Revision 1.7.4.7  2000/01/28 22:24:20  oconnor
--| released
--|
--| Revision 1.7.4.6  2000/01/28 18:58:43  king
--| Added press actions to tool bar button
--|
--| Revision 1.7.4.5  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.4  2000/01/26 23:19:15  king
--| Removed redundant features, changed set_sensitive to enable and disable
--|
--| Revision 1.7.4.3  2000/01/20 16:55:55  rogers
--| Implemented create_implementation, added some comments and created both pick_actions and drop_Actions in create_action_sequences.
--|
--| Revision 1.7.4.2  1999/12/17 21:11:02  rogers
--| Now inherits EV_PICK_AND_DROPABLE instead of EV_PND_SOURCE and EV_PND_TARGET. Make procedures have been removed, ready for re-implementation. The addition and removal of commands have been commented, ready for re-implementation.
--|
--| Revision 1.7.4.1  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:52  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
