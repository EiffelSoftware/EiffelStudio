indexing	
	description: "Eiffel Vision radio peer. GTK+ implementation."
	status: "See notice at end of class"
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
		redefine
			interface
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is this radio item checked?
		do
		end

	peers: LINKED_LIST [like interface] is
			-- List of all radio items in the group `Current' is in.
		do
		end

	selected_peer: like interface is
			-- Radio item that is currently selected.
		do
		end

feature -- Status setting

	enable_select is
			-- Select this radio item.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_PEER

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
--| Revision 1.2  2000/02/24 20:48:54  brendel
--| Changed in compliance with interface.
--|
--| Revision 1.1  2000/02/24 20:27:21  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------


