indexing
	description	: "Eiffel Vision container. Implementation interface."
	status		: "See notice at end of class"
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

	item: EV_WIDGET is
			-- Current item.
		deferred
		end

	client_width: INTEGER is
			-- Width of the client area of container.
		deferred
		ensure
			positive: Result >= 0
		end
	
	client_height: INTEGER is
			-- Height of the client area of container.
		deferred
		ensure
			positive: Result >= 0
		end
		
	merged_radio_button_groups: ARRAYED_LIST [EV_CONTAINER] is
			-- `Result' is all other radio button groups
			-- merged with `Current'.
		do
			Result := clone (internal_merged_radio_button_groups)
			if Result /= Void then
				Result.prune_all (interface)	
			end
		ensure
			current_not_included: Result /= Void implies not Result.has (interface)
		end

feature -- Element change

	extend (v: like item) is
			-- Ensure that structure includes `v'.
		require
			v_not_void: v /= Void
		deferred
		end

	replace (v: like item) is
			-- Replace `item' with `v'.
		deferred
		end

feature -- Status setting

	merge_radio_button_groups (other: EV_CONTAINER) is
			-- Merge `Current' radio button group with that of `other'.
		local
			counter, original_count: INTEGER
			container_i: EV_CONTAINER_I
		do
			connect_radio_grouping (other)
			container_i ?= other.implementation
			
					-- If internal groups for both containers are empty, then create the internal, share
					-- between the two objects, and fill with both of them.
			if internal_merged_radio_button_groups = Void and container_i.internal_merged_radio_button_groups = Void then
				create internal_merged_radio_button_groups.make (0)
				container_i.set_internal_merged_radio_button_group (internal_merged_radio_button_groups)
				internal_merged_radio_button_groups.extend (interface)
				internal_merged_radio_button_groups.extend (other)
				
					-- If `other' has no internal_group then set others group to `point' to that of `Current',
					-- and add `other' to group.
			elseif container_i.internal_merged_radio_button_groups = Void then
				container_i.set_internal_merged_radio_button_group (internal_merged_radio_button_groups)
				internal_merged_radio_button_groups.extend (other)
			
					-- If `Current' has no internal_group then set goup of `Current' to point to that of `other',
					-- and add `Current' to group.
			elseif internal_merged_radio_button_groups = Void then
				set_internal_merged_radio_button_group (container_i.internal_merged_radio_button_groups)
				container_i.internal_merged_radio_button_groups.extend (interface)
				
					-- If `Current' and `other' both have individual groups of their own, then merge groups,
					-- and update references, all to point to same group.
			elseif internal_merged_radio_button_groups /= Void and container_i.internal_merged_radio_button_groups /= Void then
					-- Store the original count so we only need to update as few groups as possible.
				original_count := internal_merged_radio_button_groups.count
				internal_merged_radio_button_groups.append (container_i.internal_merged_radio_button_groups)
					-- Now update all references are correct for all members.
				from
					counter := original_count
				until
					counter > internal_merged_radio_button_groups.count
				loop
					container_i ?= (internal_merged_radio_button_groups @ counter).implementation
					container_i.set_internal_merged_radio_button_group (internal_merged_radio_button_groups)
					counter := counter + 1
				end
			else
					check
						logical_error_in_cases: False
					end
			end
		end
			
	unmerge_radio_button_groups (other: EV_CONTAINER) is
			-- Remove `other' from radio button group of `Current'.
		local
			container_i: EV_CONTAINER_I
		do
			container_i ?= other.implementation
				-- `other' is now no longer part of a group, so
				-- set the internal group to Void
			container_i.set_internal_merged_radio_button_group (Void)
			
				-- Now remove `other' from internal group of `Current'.
			internal_merged_radio_button_groups.prune_all (other)
			
				-- If the group of `Current', is only now containing
				-- `interface', then set group to `Void'.
			if internal_merged_radio_button_groups.count = 1 then
				check
					container_must_be_interface: internal_merged_radio_button_groups @ 1 = interface
				end
				internal_merged_radio_button_groups := Void
			end
			
			unconnect_radio_grouping (other)
		end
		
feature -- Basic operations

	propagate_foreground_color is
			-- Propagate the current foreground color of the
			-- container to the children.
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			cur: CURSOR
			fg: EV_COLOR
		do
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
				fg := foreground_color
			until
				l.after
			loop
				l.item.set_foreground_color (fg)
				c ?= l.item
				if c /= Void then
					c.propagate_foreground_color
				end
				l.forth
			end
			if cs /= Void then
				cs.go_to (cur)
			end
		ensure
			foreground_color_propagated: interface.foreground_color_propagated
		end

	propagate_background_color is
			-- Propagate the current background color of the
			-- container to the children.
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			cur: CURSOR
			bg: EV_COLOR
		do
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
				bg := background_color
			until
				l.after
			loop
				l.item.set_background_color (bg)
				c ?= l.item
				if c /= Void then
					c.propagate_background_color
				end
				l.forth
			end
			if cs /= Void then
				cs.go_to (cur)
			end
		ensure
			background_color_propagated: interface.background_color_propagated
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
	
feature {EV_CONTAINER_I} -- Implementation

	internal_merged_radio_button_groups: ARRAYED_LIST [EV_CONTAINER]
			-- Internal representation of all radio button groups
			-- merged to `Current'.
			-- This contains `interface', and this is removed by implementation
			-- of `merged_radio_button_groups'. We need to include `interface', as
			-- this object is shared between all linked containers.
			
	set_internal_merged_radio_button_group (new_group: ARRAYED_LIST [EV_CONTAINER]) is
			-- Assign `new_group' to `internal_merged_radio_button_group'.
		do
			internal_merged_radio_button_groups := new_group
		end
		
	select_first_radio_button is
			-- Ensure that first radio button in `Current',
			-- `Is_selected'.
		local
			children: linear [EV_WIDGET]
			radio_button: EV_RADIO_BUTTON
		do
			children := interface.linear_representation
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

	first_radio_button_selected: BOOLEAN is
			-- Is first radio button contained in `Current',
			-- selected?
		local
			children: linear [EV_WIDGET]
			radio_button: EV_RADIO_BUTTON
		do
			children := interface.linear_representation
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
		
	has_selected_radio_button: BOOLEAN is
			-- Does `Current' contain a selected radio button?
		local
			children: linear [EV_WIDGET]
			radio_button: EV_RADIO_BUTTON
		do
			children := interface.linear_representation
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
		
	has_radio_button: BOOLEAN is
			-- 	Does `Current' contain one or more radio buttons?
		local
			children: linear [EV_WIDGET]
			radio_button: EV_RADIO_BUTTON
		do
			children := interface.linear_representation
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

	all_radio_buttons_connected: BOOLEAN is
			-- Are all radio buttons in this container connected?
		require
			not_destroyed: not is_destroyed
		local
			cur: CURSOR
			l: DYNAMIC_LIST [EV_WIDGET]
			peer: EV_RADIO_BUTTON
			peers: LINKED_LIST [EV_RADIO_PEER]
		do
			l ?= interface.linear_representation
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
		
	parent_of_items_is_current: BOOLEAN is
			-- Do all items have parent `Current'?
		require
			not_destroyed: not is_destroyed
		local
			c: CURSOR
			l: LINEAR [EV_WIDGET]
			cs: CURSOR_STRUCTURE [EV_WIDGET]
		do
			Result := True
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				c := cs.cursor
			end
			from
				l.start
			until
				l.after or Result = False
			loop
				if l.item.parent /= interface then
					Result := False
				end
				l.forth
			end
			if cs /= Void then
				cs.go_to (c)
			end
		end

	items_unique: BOOLEAN is
			-- Are all items unique?
			-- (ie Are there no duplicates?)
		require
			not_destroyed: not is_destroyed
		local
			c: CURSOR
			l: LINEAR [EV_WIDGET]
			ll: LINKED_LIST [EV_WIDGET]
			cs: CURSOR_STRUCTURE [EV_WIDGET]
		do
			create ll.make
			Result := True
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				c := cs.cursor
			end
			from
				l.start
			until
				l.after or Result = False
			loop
				if ll.has (l.item) then
					Result := False
				end
				ll.extend (l.item)
				l.forth
			end
			if cs /= Void then
				cs.go_to (c)
			end
		end

	foreground_color_propagated: BOOLEAN is
			-- Do all children have same foreground color as `Current'?
		require
			not_destroyed: not is_destroyed
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			cur: CURSOR
		do
			Result := True
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
			until	
				l.after or not Result
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
				cs.go_to (cur)
			end
		end

	background_color_propagated: BOOLEAN is
			-- Do all children have same background color as `Current'?
		require
			not_destroyed: not is_destroyed
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			cur: CURSOR
		do
			Result := True
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
			until	
				l.after or not Result
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
				cs.go_to (cur)
			end
		end

feature {NONE} -- Implementation
		
	connect_radio_grouping (a_container: EV_CONTAINER) is
			-- Join radio grouping of `a_container' to Current.
		require
			a_container_not_void: a_container /= Void
		deferred
		end
		
	unconnect_radio_grouping (a_container: EV_CONTAINER) is
			-- Unconnect radio grouping of `a_container' from `Current'.
		require
			a_container /= Void
		deferred
		end

	Key_constants: EV_KEY_CONSTANTS is
		once
			create Result
		end

end -- class EV_CONTAINER_I

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

