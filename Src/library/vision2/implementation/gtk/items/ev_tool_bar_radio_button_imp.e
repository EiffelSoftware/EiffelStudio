indexing
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
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
			parent_imp,
			make,
			interface,
			initialize,
			create_select_actions
		end

	EV_RADIO_PEER_IMP
		undefine
			visual_widget
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make a radio button with a default of selected.
		do
			base_make (an_interface)
			set_c_object (C.gtk_toggle_button_new)
			C.gtk_button_set_relief (c_object, C.gtk_relief_none_enum)
			avoid_reselection := True
				-- Needed to prevent calling of action sequence.
			enable_select
			avoid_reselection := False
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Redefined to prevent unwanted signal connection.
		do
			create Result
		end

	initialize is
			-- Initialize default settings for radio item.
		do
			Precursor
			connect_signals
			align_text_left
		end

feature -- Status setting

	enable_select is
			-- Select `Current' in its grouping.
		do
			C.gtk_toggle_button_set_active (c_object, True)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected.
		do
			Result := C.gtk_toggle_button_get_active (c_object)
		end

feature {NONE} -- Implementation

	parent_imp: EV_TOOL_BAR_IMP is
		do
			Result ?= Precursor
		end

	connect_signals is
			-- Connect on_activate to toggled signal.
		do
			signal_connect ("toggled", ~on_activate, Void)
		end
		
	on_activate is
			-- The button has been activated by the user (pushed).
		local
			a_peers: like peers
			radio_imp: like Current
		do
			if is_selected and then not avoid_reselection then
				a_peers := peers
				from
					a_peers.start
				until
					a_peers.after
				loop
					radio_imp ?= a_peers.item.implementation
					if radio_imp.is_selected and radio_imp /= Current then
						radio_imp.disable_select
					end
					a_peers.forth
				end
				if select_actions_internal /= Void then
					select_actions_internal.call ([])
				end
			end

			if not avoid_reselection then
				avoid_reselection := True
				C.gtk_toggle_button_set_active (c_object, True)
				-- Calls on_activate callback immediately
				avoid_reselection := False
			end				
		end

feature {EV_ANY_I} -- Implementation

	disable_select is
			-- Unselect the radio button.
		do
			if is_selected then
				avoid_reselection := True
				C.gtk_toggle_button_set_active (c_object, False)
				-- Calls on_activate callback immediately
				avoid_reselection := False
			end
		end

	avoid_reselection: BOOLEAN

	radio_group: POINTER is
		do
			if parent_imp /= Void then
				Result := parent_imp.radio_group
			end
		end

	interface: EV_TOOL_BAR_RADIO_BUTTON

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

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
--| Revision 1.25  2001/06/07 23:08:02  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.2.7  2000/10/09 18:02:25  king
--| Made compilable
--|
--| Revision 1.7.2.6  2000/09/07 21:36:01  king
--| Corrected comment
--|
--| Revision 1.7.2.5  2000/09/06 23:18:39  king
--| Reviewed
--|
--| Revision 1.7.2.4  2000/08/01 21:32:34  king
--| Changed on_activate to prevent unnecessasy instantiation of A.S.
--|
--| Revision 1.7.2.3  2000/05/10 00:01:41  king
--| Corrected make to make toggle button instead of button
--|
--| Revision 1.7.2.2  2000/05/09 21:12:40  king
--| Integrated changes to selectable/deselectable
--|
--| Revision 1.7.2.1  2000/05/03 19:08:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.23  2000/05/03 18:19:42  king
--| made text left aligned
--|
--| Revision 1.22  2000/04/25 18:44:47  king
--| gslist->radio_group
--|
--| Revision 1.21  2000/04/20 16:34:37  king
--| Prevented action sequence from being called on initialization
--|
--| Revision 1.20  2000/04/17 23:39:30  king
--| Changed from press_actions -> select_actions
--|
--| Revision 1.19  2000/04/17 23:07:41  king
--| Implemented radio grouping with the use of a flag
--|
--| Revision 1.18  2000/04/13 22:01:06  king
--| Implemented radio grouping functionality
--|
--| Revision 1.17  2000/04/12 00:18:47  king
--| Initial implementation for radio grouping
--|
--| Revision 1.16  2000/04/11 23:17:52  king
--| Made compilable and invariant happy
--|
--| Revision 1.15  2000/04/11 17:07:26  brendel
--| Removed references to obsolete EV_RADIO.
--|
--| Revision 1.14  2000/04/10 17:38:29  king
--| Made compilable
--|
--| Revision 1.13  2000/04/07 23:19:52  brendel
--| Commented function that takes EV_RADIO (obsolete) as argument.
--|
--| Revision 1.12  2000/04/05 17:01:28  king
--| Updated to inherit from tb select button
--|
--| Revision 1.11  2000/04/04 20:50:19  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.10  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.9  2000/02/14 13:48:37  oconnor
--| release
--|
--| Revision 1.8  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.4  2000/02/02 00:42:06  king
--| Removed parent_imp as it is correctly implemented higher up in ev_item_imp
--|
--| Revision 1.7.4.3  2000/02/01 20:04:11  king
--| Implemented radio button to fit in with new structure
--|
--| Revision 1.7.4.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
