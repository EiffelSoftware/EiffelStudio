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

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.3  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.6.1  2000/05/03 19:09:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.1  2000/02/24 20:27:22  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
