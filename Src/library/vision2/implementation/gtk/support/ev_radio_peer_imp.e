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

	peers: LINKED_LIST [like interface] is
			-- List of all radio items in the group `Current' is in.
		local
			cur: POINTER
			peer_imp: like Current
		do
			create Result.make
			if gslist = Default_pointer then
				Result.extend (interface)
			else
				from
					cur := gslist
				until
					cur = Default_pointer
				loop
					peer_imp ?= eif_object_from_c (C.gslist_struct_data (cur))
					Result.extend (peer_imp.interface)
					cur := C.gslist_struct_next (cur)
				end
			end
		end

	selected_peer: like interface is
			-- Radio item that is currently selected.
		local
			cur: POINTER
			peer_imp: like Current
		do
			if gslist = Default_pointer then
				Result := interface
			else
				from
					cur := gslist
				until
					cur = Default_pointer or else Result /= void
				loop
					peer_imp ?= eif_object_from_c (C.gslist_struct_data (cur))
					if peer_imp.is_selected then
						Result := peer_imp.interface
					end
					cur := C.gslist_struct_next (cur)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	gslist: POINTER is
			-- Reference to front of radio group. *GSList.
		deferred
		end

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
--| Revision 1.5  2000/04/13 22:05:54  king
--| Corrected gslist equality statements from Void to Default_pointer
--|
--| Revision 1.4  2000/02/26 01:26:02  brendel
--| Removed annoying put_string.
--|
--| Revision 1.3  2000/02/25 01:48:52  brendel
--| Implemented.
--|
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


