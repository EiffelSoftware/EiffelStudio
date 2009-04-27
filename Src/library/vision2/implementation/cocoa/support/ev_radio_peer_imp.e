indexing
	description: "Eiffel Vision radio peer. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RADIO_PEER_IMP

inherit
	EV_RADIO_PEER_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Status report

	peers: LINKED_LIST [like interface]
			-- List of all radio items in the group `Current' is in.
		do
			if
				radio_group.is_empty
			then
				Result.extend (interface)
			else
				from
					radio_group.start
				until
					radio_group.after
				loop
					Result.extend (radio_group.item.interface)
					radio_group.forth
				end
			end
		end

	selected_peer: like interface
			-- Radio item that is currently selected.
		do
			Result := peers.first
			-- First element of the peers list is the selected one
		end

feature {NONE} -- Implementation

	widget_object (a_list: POINTER): POINTER
			-- Returns c_object relative to a_list data.
		do
		end

feature {EV_ANY_I} -- Implementation

	radio_group: LINKED_LIST [like current]
			-- List of all radio item implementations
		deferred
		end

	interface: EV_RADIO_PEER;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_RADIO_PEER

