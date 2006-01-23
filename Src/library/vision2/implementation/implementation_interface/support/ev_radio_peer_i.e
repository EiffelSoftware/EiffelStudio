indexing
	description: "Eiffel Vision radio peer. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_RADIO_PEER_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is this radio item checked?
		deferred
		end

	peers: LINKED_LIST [like interface] is
			-- List of all radio items in the group `interface' is in.
		deferred
		ensure
			not_void: Result /= Void
		end

	selected_peer: like interface is
			-- Radio item that is currently selected.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Status setting

	enable_select is
			-- Select this radio item.
		deferred
		end

feature {EV_ANY_I} -- Implementation

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




end -- class EV_RADIO_PEER_I

