note
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

feature -- Status report

	peers: LINKED_LIST [attached like interface]
			-- List of all radio items in the group `Current' is in.
		local
			cur, wid_obj, l_null: POINTER
			peer_imp: detachable EV_RADIO_PEER_IMP
			l_interface: like interface
		do
			create Result.make
			if radio_group = l_null or else widget_object (radio_group) = l_null then
				Result.extend (attached_interface)
			else
				from
					cur := radio_group
				until
					cur = l_null
				loop
					wid_obj := widget_object (cur)
					if wid_obj /= default_pointer then
						peer_imp ?= eif_object_from_c (wid_obj)
						if peer_imp /= Void then
							l_interface ?= peer_imp.interface
							check l_interface /= Void then end
							Result.extend (l_interface)
						end
					end
					cur := {GDK}.gslist_struct_next (cur)
				end
			end
		end

	selected_peer: attached like interface
			-- Radio item that is currently selected.
		local
			cur, wid_obj, l_null: POINTER
			peer_imp: detachable EV_RADIO_PEER_IMP
			l_result: like interface
		do
			if radio_group = l_null or else widget_object (radio_group) = l_null then
				Result := attached_interface
			else
				from
					cur := radio_group
				until
					cur = l_null or else l_result /= void
				loop
					wid_obj := widget_object (cur)
					if wid_obj /= l_null then
						peer_imp ?= eif_object_from_c (widget_object (cur))
						if peer_imp /= Void and then peer_imp.is_selected then
							l_result ?= peer_imp.interface
						end
					end
					cur := {GDK}.gslist_struct_next (cur)
				end
				check l_result /= Void then end
				Result := l_result
			end
		end

feature {NONE} -- Implementation

	eif_object_from_c (a_c_object: POINTER): detachable EV_ANY_IMP
		deferred
		ensure
			is_class: class
		end

	c_object: POINTER
		deferred
		end

	visual_widget: POINTER
		deferred
		end

	widget_object (a_list: POINTER): POINTER
			-- Returns c_object relative to a_list data.
		do
			Result := {GDK}.gslist_struct_data (a_list)
		end

feature {EV_ANY_I} -- Implementation

	radio_group: POINTER
			-- Reference to front of radio group. *GSList.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RADIO_PEER note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
