indexing
	description: "Eiffel Vision radio peer. Implementation interface."
	status: "See notice at end of class"
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

	interface: EV_RADIO_PEER

end -- class EV_RADIO_PEER_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

