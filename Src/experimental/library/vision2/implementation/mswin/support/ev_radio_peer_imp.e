note
	description: "Eiffel Vision radio peer. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RADIO_PEER_IMP

inherit
	EV_RADIO_PEER_I

feature -- Status report

	peers: LINKED_LIST [attached like interface]
			-- List of all radio items in the group `Current' is in.
		local
			cur: CURSOR
		do
			create Result.make
			if attached radio_group as l_radio_group then
				cur := l_radio_group.cursor
				from
					l_radio_group.start
				until
					l_radio_group.off
				loop
					Result.extend (l_radio_group.item.attached_interface)
					l_radio_group.forth
				end
				l_radio_group.go_to (cur)
			else
					--| `radio_group' is void when `Current' is not parented in a container.
				check
					-- This item should be selected as enforced by
					-- other contracts.
					is_selected: is_selected
				end
				Result.extend (attached_interface)
			end
		end

	selected_peer: attached like interface
			-- Radio item that is currently selected.
		local
			cur: CURSOR
			l_result: detachable like interface
		do
			if attached radio_group as l_radio_group then
				cur := l_radio_group.cursor
				from
					l_radio_group.start
				until
					l_radio_group.off or else l_result /= Void
				loop
					if l_radio_group.item.is_selected then
						l_result := l_radio_group.item.interface
					end
					l_radio_group.forth
				end
				l_radio_group.go_to (cur)
			else
					--| `radio_group' is void when `Current' is not parented in a container.
				check
					-- This item should be selected as enforced by
					-- other contracts.
					is_selected: is_selected
				end
				l_result := interface
			end
			check l_result /= Void end
			Result := l_result
		end

feature {EV_ANY_I} -- Implementation

	radio_group: detachable LINKED_LIST [like Current]
			-- List this radio peer is in.
			-- This reference is shared with the other peers in the group.

	set_radio_group (a_list: like radio_group)
			-- Remove `Current' from `radio_group'.
			-- Set `radio_group' to `a_list'.
			-- Extend `Current' in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_has_current: not a_list.has (Current)
		local
			l_radio_group: like radio_group
		do
			if radio_group /= Void then
				remove_from_radio_group
			end
			internal_set_radio_group (a_list)
			l_radio_group := radio_group
			check l_radio_group /= Void end
			l_radio_group.extend (Current)
			if l_radio_group.count = 1 then
				enable_select
			end
		ensure
			assigned: radio_group = a_list
			in_it: attached radio_group as l_group and then l_group.has (Current)
		end

	remove_from_radio_group
			-- Remove `Current' from `radio_group'.
			-- Set `radio_group' to `Void'.
		require
			radio_group_not_void: radio_group /= Void
		local
			l_radio_group: like radio_group
		do
			l_radio_group := radio_group
			check l_radio_group /= Void end
			l_radio_group.start
			l_radio_group.prune (Current)
			check
				removed: not l_radio_group.has (Current)
			end
			if is_selected and then not l_radio_group.is_empty then
				l_radio_group.first.enable_select
			end
			radio_group := Void
		ensure
			radio_group_void: radio_group = Void
		end

feature {EV_CONTAINER_IMP} -- Implementation

	internal_set_radio_group (a_list: like radio_group)
			-- Assign `a_list' to `radio_group'.
		do
			radio_group := a_list
		end

note
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










