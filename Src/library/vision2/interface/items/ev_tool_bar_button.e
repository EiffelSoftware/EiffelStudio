--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision Toolbar button, a specific button that goes%
		% in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON

inherit

	EV_TOOL_BAR_ITEM
		redefine
			implementation,
			create_action_sequences,
			parent
		end

	EV_SIMPLE_ITEM
		redefine
			implementation,
			create_action_sequences,
			parent
		end

	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			create_action_sequences
		end

create
	default_create,
	make_with_text

feature -- Access

	parent: EV_TOOL_BAR is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is the current button sensitive?
		require
			has_parent: parent /= Void
		do
			Result := implementation.is_sensitive
		end

feature -- Status setting

	enable_sensitive is
			-- Enable sensitivity to user input events.
		do
			implementation.enable_sensitive
		ensure
			is_sensitive: is_sensitive
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		do
			implementation.disable_sensitive
		ensure
			not_is_sensitive: not is_sensitive
		end

feature -- Event handling

	press_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when button is pressed.

feature -- Implementation

	implementation: EV_TOOL_BAR_BUTTON_I
			-- Platform dependent access.

	create_implementation is
			-- Create implementation of tool bar button.
		do
			create {EV_TOOL_BAR_BUTTON_IMP} implementation.make (Current)
		end

	create_action_sequences is
			-- Create action sequences for tool bar button.
		do
			{EV_SIMPLE_ITEM} Precursor
			{EV_PICK_AND_DROPABLE} Precursor
			create press_actions
		end

invariant
	press_actions_not_void: press_actions /= Void

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
--| Revision 1.8  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.9  2000/02/04 21:16:35  king
--| Now calling create_action_sequence precursor from pnd
--|
--| Revision 1.7.4.8  2000/02/01 20:14:05  king
--| Now descendant of ev_tool_bar_item
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
