indexing
	description: "EiffelVision tool-bar radio button, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

creation
	make

feature {NONE} -- Initialization

	initialize is
			-- Post creation initialization.
		do
			Precursor
			enable_select
		end

feature -- Status report

	is_selected: BOOLEAN

	enable_select is
			-- Select `Current'.
		do
			update_radio_states
			if parent_imp /= Void then
					parent_imp.check_button (id)
			end
		end

	disable_select is
			-- Deselect `Current'
		do
			is_selected := False
			if parent_imp /= Void then
				parent_imp.uncheck_button (id)
			end
		end

feature -- Implementation

	update_radio_states is
			-- Unselect all members of `radio_group'
			-- and assign True to `checked'.
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					radio_group.item.disable_select
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			is_selected := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_RADIO_BUTTON

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.14  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.4.4  2000/08/11 19:16:29  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.2.4.3  2000/05/30 15:53:51  rogers
--| Removed unreferenced variables from enable_select.
--|
--| Revision 1.2.4.2  2000/05/09 21:23:41  king
--| Implemented to fit in with new selectable abstract class
--|
--| Revision 1.2.4.1  2000/05/03 19:09:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/04/26 22:20:20  rogers
--| Removed type as now redundent.
--|
--| Revision 1.11  2000/04/25 22:40:08  rogers
--| Removed FIXME NOT_REVIEWED.
--|
--| Revision 1.10  2000/04/07 00:48:00  rogers
--| Formatting and comments.
--|
--| Revision 1.9  2000/04/05 18:18:44  rogers
--| Removed disable_select, checked. Renamed internal_enable_select
--| to update_radio_states/
--|
--| Revision 1.8  2000/04/05 17:33:58  rogers
--| Inheritance changed from EV_TOOL_BAR_TOGGLE_BUTTON_IMP to
--| EV_TOOL_BAR_SELECT_BUTTON_IMP. Added checked, disable_select,
--| enable_select and internal_enable_select.
--|
--| Revision 1.7  2000/04/04 17:20:59  rogers
--| Now inherits EV_RADIO_PEER_IMP. Implemented initialize,
--| set_checked. Removed on_activate and on_unselect. Added interface.
--|
--| Revision 1.6  2000/04/03 18:48:18  rogers
--| Removed parent_imp as it can be inherited directly from
--| EV_TOGGLE_BUTTON_IMP.
--|
--| Revision 1.5  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.4  2000/02/19 04:35:44  oconnor
--| added deferred features
--|
--| Revision 1.3  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.5  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.4  2000/01/27 01:09:15  rogers
--| Commented out the old event execution and added a FIXME.
--|
--| Revision 1.2.6.3  2000/01/21 20:35:53  rogers
--| Minor formatting change.
--|
--| Revision 1.2.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
