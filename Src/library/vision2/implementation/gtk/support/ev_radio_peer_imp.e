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

