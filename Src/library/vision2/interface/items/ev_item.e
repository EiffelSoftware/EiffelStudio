indexing
	description:
		"Base class for all items that may be held in EV_ITEM_LISTs."
	status: "See notice at end of class."
	keywords: "item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM

inherit
	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			create_action_sequences
		end

	EV_PIXMAPABLE
		redefine
			implementation
		end

	EV_CONTAINABLE
		redefine
			implementation
		end

feature {NONE} -- Initialization

	create_action_sequences is
			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_PICK_AND_DROPABLE} Precursor
			create pointer_button_press_actions
			create pointer_double_press_actions
			create pointer_motion_actions
		end

feature -- Access

	parent: EV_ITEM_LIST [EV_ITEM] is
			-- Item list containing `Current'.
		do
			Result := implementation.parent
		ensure then
			bridge_ok: Result = implementation.parent
		end

	data: ANY
			-- Arbitrary user data may be stored here.

feature -- Element change

	set_data (some_data: like data) is
			-- Assign `some_data' to `data'.
		do
			data := some_data
		ensure
			data_assigned: data = some_data
		end

feature -- Event handling

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer button is pressed.

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is double clicked.

feature {EV_ANY_I} -- Implementation

	implementation: EV_ITEM_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_ITEM

--!-----------------------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--| Revision 1.15  2000/06/07 17:28:04  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.7.4.3  2000/06/05 23:48:02  oconnor
--| support double click
--|
--| Revision 1.7.4.2  2000/05/13 00:04:16  king
--| Converted to new EV_CONTAINABLE class
--|
--| Revision 1.7.4.1  2000/05/03 19:09:57  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/04/07 22:15:40  brendel
--| Removed EV_SIMPLE_ITEM from inheritance hierarchy.
--|
--| Revision 1.13  2000/03/22 23:49:37  oconnor
--| comments
--|
--| Revision 1.12  2000/03/13 19:11:46  king
--| Added feature tag
--|
--| Revision 1.11  2000/03/10 02:20:31  oconnor
--| Corrected export clause for implementation
--|
--| Revision 1.10  2000/03/09 21:38:30  king
--| Corrected export clause for implementation
--|
--| Revision 1.9  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.10  2000/02/01 20:13:10  king
--| Changed export clause of implementation so it includes ev_radio_group
--|
--| Revision 1.7.6.9  2000/01/28 20:00:08  oconnor
--| released
--|
--| Revision 1.7.6.8  2000/01/28 18:56:28  king
--| Changed to generic structure of items
--|
--| Revision 1.7.6.7  2000/01/27 19:30:36  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.6  2000/01/18 23:22:23  rogers
--| The interface is now exported to EV_ANY_I instead of EV_ITEM_I.
--|
--| Revision 1.7.6.5  2000/01/14 21:43:02  oconnor
--| removed empty require clause
--|
--| Revision 1.7.6.4  2000/01/14 21:12:59  oconnor
--| improved comments
--|
--| Revision 1.7.6.3  1999/12/17 21:16:48  rogers
--| index has been removed as it is now inherted. set_parent,
--| set_parent_with_index and set_index have been removed as they are now no
--| longer required.
--|
--| Revision 1.7.6.2  1999/11/30 22:42:07  oconnor
--| added create_action_sequences
--|
--| Revision 1.7.6.1  1999/11/24 17:30:41  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.7.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
