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
			if radio_group = NULL then
				Result.extend (interface)
			else
				from
					cur := radio_group
				until
					cur = NULL
				loop
					peer_imp ?= eif_object_from_c (widget_object (cur))
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
			if radio_group = NULL then
				Result := interface
			else
				from
					cur := radio_group
				until
					cur = NULL or else Result /= void
				loop
					peer_imp ?= eif_object_from_c (widget_object (cur))
					if peer_imp.is_selected then
						Result := peer_imp.interface
					end
					cur := C.gslist_struct_next (cur)
				end
			end
		end

feature {NONE} -- Implementation

	widget_object (a_list: POINTER): POINTER is
			-- Returns c_object relative to a_list data.
		do
			Result := C.gslist_struct_data (a_list)
		end

feature {EV_ANY_I} -- Implementation

	radio_group: POINTER is
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.8  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.2.2  2000/06/15 22:15:00  king
--| Added widget_object to return c_object from radio_item in gslist
--|
--| Revision 1.7.2.1  2000/05/03 19:08:43  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/05/02 18:55:25  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.6  2000/04/25 18:46:40  king
--| Accounted for gslist name change
--|
--| Revision 1.5  2000/04/13 22:05:54  king
--| Corrected gslist equality statements from Void to NULL
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------


