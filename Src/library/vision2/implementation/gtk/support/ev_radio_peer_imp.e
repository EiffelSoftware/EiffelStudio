indexing	
	description: "Eiffel Vision radio peer. GTK+ implementation."
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
			needs_event_box,
			destroy
		redefine
			interface
		end
	
feature -- Status report

	peers: LINKED_LIST [like interface] is
			-- List of all radio items in the group `Current' is in.
		local
			cur, wid_obj: POINTER
			peer_imp: like Current
		do
			create Result.make
			if radio_group = NULL or else widget_object (radio_group) = NULL then
				Result.extend (interface)
			else
				from
					cur := radio_group
				until
					cur = NULL
				loop
					wid_obj := widget_object (cur)
					if wid_obj /= NULL then
						peer_imp ?= eif_object_from_c (wid_obj)
						if peer_imp /= Void then
							Result.extend (peer_imp.interface)
						end
					end		
					cur := {EV_GTK_EXTERNALS}.gslist_struct_next (cur)
				end
			end
		end

	selected_peer: like interface is
			-- Radio item that is currently selected.
		local
			cur, wid_obj: POINTER
			peer_imp: like Current
		do
			if radio_group = NULL or else widget_object (radio_group) = NULL then
				Result := interface
			else
				from
					cur := radio_group
				until
					cur = NULL or else Result /= void
				loop
					wid_obj := widget_object (cur)
					if wid_obj /= NULL then
						peer_imp ?= eif_object_from_c (widget_object (cur))
						if peer_imp /= Void and then peer_imp.is_selected then
							Result := peer_imp.interface
						end
					end
					cur := {EV_GTK_EXTERNALS}.gslist_struct_next (cur)
				end
			end
		end

feature {NONE} -- Implementation

	widget_object (a_list: POINTER): POINTER is
			-- Returns c_object relative to a_list data.
		do
			Result := {EV_GTK_EXTERNALS}.gslist_struct_data (a_list)
		end

feature {EV_ANY_I} -- Implementation

	radio_group: POINTER is
			-- Reference to front of radio group. *GSList.
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

