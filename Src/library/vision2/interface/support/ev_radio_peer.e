indexing	
	description:
		"Facilities for managing peer relations between radio buttons.%N%
		%Base class for EV_RADIO_BUTTON, EV_RADIO_MENU_ITEM and%
		%EV_TOOL_BAR_RADIO_BUTTON."
	status: "See notice at end of class"
	keywords: "radio, item, menu, check, select"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_RADIO_PEER

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation,
			is_in_default_state
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is this radio item checked?
		deferred
		end

	peers: LINKED_LIST [like Current] is
			-- All radio items in the group `Current' is in.
			-- Includes `Current'.
		do
			Result := implementation.peers
		ensure
			not_void: Result /= Void
			bridge_ok: Result.count = implementation.peers.count
		end

	selected_peer: like Current is
			-- Item in `peers' that is currently selected.
		do
			Result := implementation.selected_peer
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.selected_peer)
		end

feature -- Status setting

	enable_select is
			-- Change selected peer to `Current'.
		deferred
		ensure
			selected_peer_is_current: selected_peer = Current
		end

feature -- Contract support

	selected_count: INTEGER is
			-- Number of selected radio items in `peers'.
		local
			l: like peers
		do
			l := peers
			from
				l.start
			until
				l.off
			loop
				if l.item.is_selected then
					Result := Result + 1
				end
				l.forth
			end
		end

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- Radio buttons are selected by default.
		do
			Result := Precursor and then is_selected
		end

feature {NONE} -- Implementation

	implementation: EV_RADIO_PEER_I
			-- Responsible for interaction with the native graphics toolkit.

invariant
	peers_not_void: peers /= Void
	selected_peer_not_void: selected_peer /= Void
	peers_returns_new_copy_of_list: peers /= peers
	peers_has_current: peers.has (Current)
	is_selected_equals_selected_peer_is_current:
		is_selected = (selected_peer = Current)
	one_radio_item_selected: selected_count = 1

end -- class EV_RADIO_PEER

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
--| Revision 1.4  2000/04/17 16:54:18  brendel
--| Added enable_select as deferred, so that a client does not have to cast
--| toolbar radio buttons, radio buttons or menu radio buttons.
--|
--| Revision 1.3  2000/03/17 01:23:34  oconnor
--| formatting and layout
--|
--| Revision 1.2  2000/02/25 01:47:39  brendel
--| Improved postcondition.
--|
--| Revision 1.1  2000/02/24 20:29:09  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

