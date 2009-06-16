note
	description: "Eiffel Vision radio peer. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RADIO_PEER_IMP

inherit
	EV_RADIO_PEER_I

feature -- Initialization

	make
		do
			create radio_group.make
			radio_group.put_front (current)
		end

feature -- Status setting

	enable_select
			-- Select `Current'.
		local
			button_imp: like Current
		do
			if not radio_group.is_empty then
				button_imp ?= peers.first.implementation
				button_imp.disable_select
				radio_group.start
				radio_group.prune (current)
				radio_group.put_front (current)
				-- First element of 'radio_group' is the one that is selected
			end
		end

	disable_select
			-- Unselect 'Current'
		do
			radio_group.start
			radio_group.prune (current)
			radio_group.extend (current)
		end

feature -- Status report

	peers: LINKED_LIST [like interface]
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

	selected_peer: like interface
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

	set_radio_group (a_list: like radio_group)
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

	remove_from_radio_group
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

	internal_set_radio_group (a_list: like radio_group)
			-- Assign `a_list' to `radio_group'.
		do
			radio_group := a_list
		end

	has_duplicated_items: BOOLEAN
		local
			l: like radio_group
		do
			l := radio_group
			from
				l.start
			until
				l.off or Result
			loop
				if radio_group.occurrences (l.item) > 1 then
					Result := True
				end
				l.forth
			end
		end

invariant
	is_usable implies not has_duplicated_items
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
