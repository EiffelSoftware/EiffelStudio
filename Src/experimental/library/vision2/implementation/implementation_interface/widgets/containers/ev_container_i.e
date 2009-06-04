note
	description	: "Eiffel Vision container. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "container"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EV_CONTAINER_I

inherit
	EV_WIDGET_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		rename
			set_pixmap as set_background_pixmap,
			remove_pixmap as remove_background_pixmap,
			pixmap as background_pixmap
		redefine
			interface
		end

	EV_CONTAINER_ACTION_SEQUENCES_I

feature -- Access

	interface_item: EV_WIDGET
			-- Current item but guaranteed attached for calling from interface only
		local
			l_item: like item
		do
			l_item := item
			check l_item /= Void end
			Result := l_item
		end

	count: INTEGER_32
			-- Number of elements in `Current'.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	has (v: like item): BOOLEAN
			-- Does structure include `v'?
		deferred
		end

	item: detachable EV_WIDGET
			-- Current item.
		deferred
		end

	client_width: INTEGER
			-- Width of the client area of container.
		deferred
		ensure
			positive: Result >= 0
		end

	client_height: INTEGER
			-- Height of the client area of container.
		deferred
		ensure
			positive: Result >= 0
		end

	merged_radio_button_groups: detachable ARRAYED_LIST [EV_CONTAINER]
			-- `Result' is all other radio button groups
			-- merged with `Current'.
		do
			if attached internal_merged_radio_button_groups as l_internal_merged_radio_button_groups then
				Result := l_internal_merged_radio_button_groups.twin
				Result.prune_all (attached_interface)
			end
		ensure
			current_not_included: Result /= Void implies not Result.has (attached_interface)
		end

feature -- Element change

	extend (v: like item)
			-- Ensure that structure includes `v'.
		require
			v_not_void: v /= Void
		deferred
		end

	replace (v: detachable like item)
			-- Replace `item' with `v'.
		deferred
		end

feature -- Status setting

	merge_radio_button_groups (other: EV_CONTAINER)
			-- Merge `Current' radio button group with that of `other'.
		local
			counter, original_count: INTEGER
			container_i: EV_CONTAINER_I
			l_internal_merged_radio_button_groups: like internal_merged_radio_button_groups
		do
			connect_radio_grouping (other)
			container_i := other.implementation

					-- If internal groups for both containers are empty, then create the internal, share
					-- between the two objects, and fill with both of them.
			if internal_merged_radio_button_groups = Void and container_i.internal_merged_radio_button_groups = Void then
				create l_internal_merged_radio_button_groups.make (0)
				container_i.set_internal_merged_radio_button_group (l_internal_merged_radio_button_groups)
				l_internal_merged_radio_button_groups.extend (attached_interface)
				l_internal_merged_radio_button_groups.extend (other)
				internal_merged_radio_button_groups := l_internal_merged_radio_button_groups

					-- If `other' has no internal_group then set others group to `point' to that of `Current',
					-- and add `other' to group.
			elseif container_i.internal_merged_radio_button_groups = Void then
				l_internal_merged_radio_button_groups := internal_merged_radio_button_groups
				check l_internal_merged_radio_button_groups /= Void end
				container_i.set_internal_merged_radio_button_group (l_internal_merged_radio_button_groups)
				l_internal_merged_radio_button_groups.extend (other)

					-- If `Current' has no internal_group then set goup of `Current' to point to that of `other',
					-- and add `Current' to group.
			elseif internal_merged_radio_button_groups = Void then
				set_internal_merged_radio_button_group (container_i.internal_merged_radio_button_groups)
				l_internal_merged_radio_button_groups := container_i.internal_merged_radio_button_groups
				check l_internal_merged_radio_button_groups /= Void end
				l_internal_merged_radio_button_groups.extend (attached_interface)

					-- If `Current' and `other' already share the same list, they must be already
					-- merged, and therefore, nothing is to be performed.
			elseif internal_merged_radio_button_groups /= Void and container_i.internal_merged_radio_button_groups /= Void and
				internal_merged_radio_button_groups = container_i.internal_merged_radio_button_groups then
					-- Nothing to perform here, as the groups are already merged.

					-- If `Current' and `other' both have individual groups of their own, then merge groups,
					-- and update references, all to point to same group.
			elseif internal_merged_radio_button_groups /= Void and container_i.internal_merged_radio_button_groups /= Void then
				check
					internal_merged_radio_button_groups /= container_i.internal_merged_radio_button_groups
				end
					-- Store the original count so we only need to update as few groups as possible.
				l_internal_merged_radio_button_groups := internal_merged_radio_button_groups
				check l_internal_merged_radio_button_groups /= Void end
				original_count := l_internal_merged_radio_button_groups.count
				check l_internal_merged_radio_button_groups /= Void end
				if attached container_i.internal_merged_radio_button_groups as l_container_merged_radio_groups then
					l_internal_merged_radio_button_groups.append (l_container_merged_radio_groups)
				end

					-- Now update all references are correct for all members.
				from
					counter := original_count
				until
					counter > l_internal_merged_radio_button_groups.count
				loop
					container_i := (l_internal_merged_radio_button_groups @ counter).implementation
					container_i.set_internal_merged_radio_button_group (l_internal_merged_radio_button_groups)
					counter := counter + 1
				end
			else
					check
						logical_error_in_cases: False
					end
			end
		end

	unmerge_radio_button_groups (other: EV_CONTAINER)
			-- Remove `other' from radio button group of `Current'.
		local
			container_i: detachable EV_CONTAINER_I
			l_internal_merged_radio_button_groups: like internal_merged_radio_button_groups
		do
			container_i ?= other.implementation
			check container_i /= Void end
				-- `other' is now no longer part of a group, so
				-- set the internal group to Void
			container_i.set_internal_merged_radio_button_group (Void)

			l_internal_merged_radio_button_groups := internal_merged_radio_button_groups
			check l_internal_merged_radio_button_groups /= Void end

				-- Now remove `other' from internal group of `Current'.
			l_internal_merged_radio_button_groups.prune_all (other)

				-- If the group of `Current', is only now containing
				-- `interface', then set group to `Void'.
			if l_internal_merged_radio_button_groups.count = 1 then
				check
					container_must_be_interface: l_internal_merged_radio_button_groups @ 1 = interface
				end
				internal_merged_radio_button_groups := Void
			end

			unconnect_radio_grouping (other)
		end

feature -- Basic operations

	propagate_foreground_color
			-- Propagate the current foreground color of the
			-- container to the children.
		local
			l: LINEAR [EV_WIDGET]
			c: detachable EV_CONTAINER
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
			cur: detachable CURSOR
			fg: EV_COLOR
		do
			l := attached_interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
				fg := foreground_color
			until
				l.off
			loop
				l.item.set_foreground_color (fg)
				c ?= l.item
				if c /= Void then
					c.propagate_foreground_color
				end
				l.forth
			end
			if cs /= Void then
				check cur /= Void end
				cs.go_to (cur)
			end
		ensure
			foreground_color_propagated: attached_interface.foreground_color_propagated
		end

	propagate_background_color
			-- Propagate the current background color of the
			-- container to the children.
		local
			l: LINEAR [EV_WIDGET]
			c: detachable EV_CONTAINER
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
			cur: detachable CURSOR
			bg: EV_COLOR
		do
			l := attached_interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
				bg := background_color
			until
				l.off
			loop
				l.item.set_background_color (bg)
				c ?= l.item
				if c /= Void then
					c.propagate_background_color
				end
				l.forth
			end
			if cs /= Void then
				check cur /= Void end
				cs.go_to (cur)
			end
		ensure
			background_color_propagated: attached_interface.background_color_propagated
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_CONTAINER note option: stable attribute end

feature {EV_CONTAINER_I} -- Implementation

	internal_merged_radio_button_groups: detachable ARRAYED_LIST [EV_CONTAINER]
			-- Internal representation of all radio button groups
			-- merged to `Current'.
			-- This contains `interface', and this is removed by implementation
			-- of `merged_radio_button_groups'. We need to include `interface', as
			-- this object is shared between all linked containers.

	set_internal_merged_radio_button_group (new_group: detachable ARRAYED_LIST [EV_CONTAINER])
			-- Assign `new_group' to `internal_merged_radio_button_group'.
		do
			internal_merged_radio_button_groups := new_group
		end

	select_first_radio_button
			-- Ensure that first radio button in `Current',
			-- `Is_selected'.
		local
			children: linear [EV_WIDGET]
			radio_button: detachable EV_RADIO_BUTTON
		do
			children := attached_interface.linear_representation
			from
				children.start
			until
				children.off or radio_button /= Void
			loop
				radio_button ?= children.item
				if radio_button /= Void then
					radio_button.enable_select
				end
				children.forth
			end
		ensure
			first_selected: first_radio_button_selected
		end

feature {EV_CONTAINER, EV_CONTAINER_I} -- Implementation

	first_radio_button_selected: BOOLEAN
			-- Is first radio button contained in `Current',
			-- selected?
		local
			children: linear [EV_WIDGET]
			radio_button: detachable EV_RADIO_BUTTON
		do
			children := attached_interface.linear_representation
			from
				children.start
			until
				children.off or radio_button /= Void
			loop
				radio_button ?= children.item
				if radio_button /= Void then
					Result := radio_button.is_selected
				end
				children.forth
			end
		end

	has_selected_radio_button: BOOLEAN
			-- Does `Current' contain a selected radio button?
		local
			children: linear [EV_WIDGET]
			radio_button: detachable EV_RADIO_BUTTON
		do
			children := attached_interface.linear_representation
			from
				children.start
			until
				children.off or Result = True
			loop
				radio_button ?= children.item
				if radio_button /= Void and then radio_button.is_selected then
					Result := True
				end
				children.forth
			end
		end

	has_radio_button: BOOLEAN
			-- 	Does `Current' contain one or more radio buttons?
		local
			children: linear [EV_WIDGET]
			radio_button: detachable EV_RADIO_BUTTON
		do
			children := attached_interface.linear_representation
			from
				children.start
			until
				children.off or Result = True
			loop
				radio_button ?= children.item
				if radio_button /= Void then
					Result := True
				end
				children.forth
			end
		end

feature {EV_CONTAINER, EV_CONTAINER_I} -- Contract support

	all_radio_buttons_connected: BOOLEAN
			-- Are all radio buttons in this container connected?
		require
			not_destroyed: not is_destroyed
		local
			cur: CURSOR
			l: detachable DYNAMIC_LIST [EV_WIDGET]
			peer: detachable EV_RADIO_BUTTON
			peers: detachable LINKED_LIST [EV_RADIO_PEER]
		do
			l ?= attached_interface.linear_representation
			if l /= Void then
				from
					cur := l.cursor
					l.start
				until
					l.off or else not Result
				loop
					peer ?= item
					if peer /= Void then
						if peers = Void then
							peers := peer.peers
						else
							Result := peers.has (peer)
						end
					end
				l.forth
				end
				l.go_to (cur)
			end
			if peers = Void then
				Result := True
			end
		end

	parent_of_items_is_current: BOOLEAN
			-- Do all items have parent `Current'?
		require
			not_destroyed: not is_destroyed
		local
			c: detachable CURSOR
			l: LINEAR [EV_WIDGET]
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
		do
			Result := True
			l := attached_interface.linear_representation
			cs ?= l
			if cs /= Void then
				c := cs.cursor
			end
			from
				l.start
			until
				l.off or not Result
			loop
				if l.item.parent /= interface then
					Result := False
				end
				l.forth
			end
			if cs /= Void then
				check c /= Void end
				cs.go_to (c)
			end
		end

	items_unique: BOOLEAN
			-- Are all items unique?
			-- (ie Are there no duplicates?)
		require
			not_destroyed: not is_destroyed
		local
			c: detachable CURSOR
			l: LINEAR [EV_WIDGET]
			ll: LINKED_LIST [EV_WIDGET]
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
		do
			create ll.make
			Result := True
			l := attached_interface.linear_representation
			cs ?= l
			if cs /= Void then
				c := cs.cursor
			end
			from
				l.start
			until
				l.off or not Result
			loop
				if ll.has (l.item) then
					Result := False
				end
				ll.extend (l.item)
				l.forth
			end
			if cs /= Void then
				check c /= Void end
				cs.go_to (c)
			end
		end

	foreground_color_propagated: BOOLEAN
			-- Do all children have same foreground color as `Current'?
		require
			not_destroyed: not is_destroyed
		local
			l: detachable LINEAR [EV_WIDGET]
			c: detachable EV_CONTAINER
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
			cur: detachable CURSOR
		do
			Result := True
			l := attached_interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
			until
				l.off or not Result
			loop
				c ?= l.item
				if not foreground_color.is_equal (l.item.foreground_color) then
					Result := False
				elseif c /= Void and then not c.foreground_color_propagated then
					Result := False
				end
				l.forth
			end
			if cs /= Void then
				check cur /= Void end
				cs.go_to (cur)
			end
		end

	background_color_propagated: BOOLEAN
			-- Do all children have same background color as `Current'?
		require
			not_destroyed: not is_destroyed
		local
			l: LINEAR [EV_WIDGET]
			c: detachable EV_CONTAINER
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
			cur: detachable CURSOR
		do
			Result := True
			l := attached_interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
			until
				l.off or not Result
			loop
				c ?= l.item
				if not background_color.is_equal (l.item.background_color) then
					Result := False
				elseif c /= Void and then not c.background_color_propagated then
					Result := False
				end
				l.forth
			end
			if cs /= Void then
				check cur /= Void end
				cs.go_to (cur)
			end
		end

feature {NONE} -- Implementation

	connect_radio_grouping (a_container: EV_CONTAINER)
			-- Join radio grouping of `a_container' to Current.
		require
			a_container_not_void: a_container /= Void
		deferred
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER)
			-- Unconnect radio grouping of `a_container' from `Current'.
		require
			a_container /= Void
		deferred
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




end -- class EV_CONTAINER_I











