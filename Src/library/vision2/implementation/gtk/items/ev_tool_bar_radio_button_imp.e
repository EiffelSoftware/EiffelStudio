--| FIXME NOT_REVIEWED this file has not been reviewed
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

	EV_TOOL_BAR_SELECT_BUTTON_IMP
		redefine
			parent_imp,
			make,
			interface,
			connect_signals,
			enable_select
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make a radio button with a default of selected.
		do
			Precursor (an_interface)
			enable_select
		end

feature {NONE} -- Implementation

	parent_imp: EV_TOOL_BAR_IMP is
		do
			Result ?= Precursor
		end

	connect_signals is
			-- Connect on_activate to toggled signal
		do
			signal_connect ("toggled", ~on_activate, Void)
		end
		
	on_activate is
			-- The button has been activated by the user (pushed).
		local
			a_peers: like peers
			radio_imp: like Current
			gdk_event_mask: INTEGER
		do
			if is_selected and not just_selected then
				just_selected := True
				a_peers := peers
				from
					a_peers.start
				until
					a_peers.after
				loop
					radio_imp ?= a_peers.item.implementation
					if radio_imp /= Current and radio_imp.is_selected then
						radio_imp.disable_select
					end
					a_peers.forth
				end
				interface.press_actions.call ([])
			else
				if just_selected then
					gdk_event_mask := C.gdk_window_get_events (
						C.gtk_widget_struct_window (c_object)
					)
					C.gdk_window_set_events (
						C.gtk_widget_struct_window (c_object), 0
					)
					enable_select
					C.gdk_window_set_events (
						C.gtk_widget_struct_window (c_object),
						gdk_event_mask
					)
				end
			end			
		end

	just_selected: BOOLEAN
		-- Has the radio button just been selected by the user.

feature {EV_ANY_I} -- Implementation

	enable_select is
			-- Select the radio button.
		do
			just_selected := True
			Precursor
		end

	disable_select is
			-- Unselect the radio button.
		do
			just_selected := False
			C.gtk_toggle_button_set_active (c_object, False)
		end

	gslist: POINTER is
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
