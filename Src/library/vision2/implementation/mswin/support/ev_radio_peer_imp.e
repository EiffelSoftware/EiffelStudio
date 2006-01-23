indexing	
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

	peers: LINKED_LIST [like interface] is
			-- List of all radio items in the group `Current' is in.
		local
			cur: CURSOR
		do
			create Result.make
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					Result.extend (radio_group.item.interface)
					radio_group.forth
				end
				radio_group.go_to (cur)
			else
					--| `radio_group' is void when `Current' is not parented in a container.
				check
					-- This item should be selected as enforced by
					-- other contracts.
					is_selected: is_selected
				end
				Result.extend (interface)
			end
		end

	selected_peer: like interface is
			-- Radio item that is currently selected.
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off or else Result /= Void
				loop
					if radio_group.item.is_selected then
						Result := radio_group.item.interface
					end
					radio_group.forth
				end
				radio_group.go_to (cur)
			else
					--| `radio_group' is void when `Current' is not parented in a container.
				check
					-- This item should be selected as enforced by
					-- other contracts.
					is_selected: is_selected
				end
				Result := interface
			end
		end

feature {EV_ANY_I} -- Implementation

	radio_group: LINKED_LIST [like Current]
			-- List this radio peer is in.
			-- This reference is shared with the other peers in the group.

	set_radio_group (a_list: like radio_group) is
			-- Remove `Current' from `radio_group'.
			-- Set `radio_group' to `a_list'.
			-- Extend `Current' in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_has_current: not a_list.has (Current)
		do
			if radio_group /= Void then
				remove_from_radio_group
			end
			internal_set_radio_group (a_list)
			if radio_group.is_empty then
				enable_select
			end
			radio_group.extend (Current)
		ensure
			assigned: radio_group = a_list
			in_it: radio_group.has (Current)
		end

	remove_from_radio_group is
			-- Remove `Current' from `radio_group'.
			-- Set `radio_group' to `Void'.
		require
			radio_group_not_void: radio_group /= Void
		do
			radio_group.start
			radio_group.prune (Current)
			check
				removed: not radio_group.has (Current)
			end
			if is_selected and then not radio_group.is_empty then
				radio_group.first.enable_select
			end
			radio_group := Void
		ensure
			radio_group_void: radio_group = Void
		end
		
feature {EV_CONTAINER_IMP} -- Implementation

	internal_set_radio_group (a_list: like radio_group) is
			-- Assign `a_list' to `radio_group'.
		do
			radio_group := a_list			
		end
	
invariant
	
	peers_not_void: peers /= Void

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

