indexing
	description: 
		"Widget that contains other widgets.%N%
		%Base class for all containers."
	status: "See notice at end of class"
	keywords: "container, pack"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_CONTAINER

inherit
	EV_WIDGET
		redefine
			implementation
		end

	BOX [EV_WIDGET]
		export
			{NONE}
				changeable_comparison_criterion,
				compare_references,
				compare_objects,
				object_comparison
		undefine
			default_create,
			copy
		redefine
			changeable_comparison_criterion
		end

	COLLECTION [EV_WIDGET]
		rename
			extend as cl_extend,
			put as cl_put
		export
			{NONE}
				changeable_comparison_criterion,
				compare_references,
				compare_objects,
				object_comparison
		undefine
			default_create,
			copy
		redefine
			changeable_comparison_criterion
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item.
		require
			not_destroyed: not is_destroyed
			readable: readable
		do
			Result := implementation.item
		ensure
			bridge_ok: Result = implementation.item
		end
		
	count: INTEGER is
			-- Number of elements in `Current'.
		require
			not_destroyed: not is_destroyed	
		deferred
		end
		

	has_recursive (an_item: like item): BOOLEAN is
			-- Does structure include `an_item' or
			-- does any structure recursively included by structure,
			-- include `an_item'.
		require
			not_destroyed: not is_destroyed
		local
			l: LINEAR [EV_WIDGET]
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			c: CURSOR
			ct: EV_CONTAINER
		do
			Result := has (an_item)
			l := linear_representation
			cs ?= l
			if cs /= Void then
				c := cs.cursor
			end
			from
				l.start
			until
				l.after or Result
			loop
				ct ?= l.item
				if ct /= Void then
					Result := ct.has_recursive (an_item)
				end
				l.forth
			end
			if cs /= Void then
				cs.go_to (c)
			end
		end

feature -- Status setting

	merge_radio_button_groups (other: EV_CONTAINER) is
			-- Merge `Current' radio button group with that of `other'.
		require
			not_destroyed: not is_destroyed
			other_not_void: other /= Void
		do
			implementation.connect_radio_grouping (other)
		end
	
feature -- Status report

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		require
			not_destroyed: not is_destroyed
		deferred
		end

	readable: BOOLEAN is
			-- Is there a current item that may be accessed?
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature -- Element change

	extend (v: like item) is
			-- Ensure that structure includes `v'.
			-- Do not move cursor.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: v /= Current
			v_not_parent_of_current: not is_parent_recursive (v)
			v_not_window: not v.conforms_to (create {EV_WINDOW})
		do
			implementation.extend (v)
		ensure
			has_v: has (v)
		end

	put, replace (v: like item) is
			-- Replace `item' with `v'.
		require
			not_destroyed: not is_destroyed
			writable: writable
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: v /= Current
			v_not_parent_of_current: not is_parent_recursive (v)
			v_not_window: not v.conforms_to (create {EV_WINDOW})
		do
			implementation.replace (v)
		ensure
			has_v: has (v)
		end

feature -- Measurement

	client_width: INTEGER is
			-- Width of the area available to children in pixels. 
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.client_width
		ensure
			bridge_ok: Result = implementation.client_width
		end
	
	client_height: INTEGER is
			-- Height of the area available to children in pixels. 
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.client_height
		ensure
			bridge_ok: Result = implementation.client_height
		end
		
feature -- Basic operations

	propagate_foreground_color is
			-- Propagate `foreground_color' to all children.
		require
			not_destroyed: not is_destroyed
		do
			implementation.propagate_foreground_color
		ensure
			foreground_color_propagated: foreground_color_propagated
		end

	propagate_background_color is
			-- Propagate `background_color' to all children.
		require
			not_destroyed: not is_destroyed
		do
			implementation.propagate_background_color
		ensure
			background_color_propagated: background_color_propagated
		end

feature {EV_CONTAINER, EV_CONTAINER_I} -- Contract support

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
			l := linear_representation
			cs ?= l
			if cs /= Void then
				c := cs.cursor
			end
			from
				l.start
			until
				l.after or Result = False
			loop
				if l.item.parent /= Current then
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
			l := linear_representation
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
			l := linear_representation
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
			l := linear_representation
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
			l ?= linear_representation
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
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_CONTAINER_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	changeable_comparison_criterion: BOOLEAN is False
			-- May `object_comparison' be changed?
			-- (Answer: no by default.)

	cl_put (v: like item) is
			-- Replace `item' with `v'.
		do
			put (v)
		end

	cl_extend (v: like item) is
			-- Ensure that structure includes `v'.
		do
			extend (v)
		end

invariant
	client_width_within_bounds: is_usable implies
		client_width >= 0 and client_width <= width
	client_height_within_bounds: is_usable implies
		client_height >= 0 and client_height <= height

	all_radio_buttons_connected: is_usable implies all_radio_buttons_connected
	parent_of_items_is_current: is_usable implies parent_of_items_is_current
	items_unique: is_usable implies items_unique

end -- class EV_CONTAINER

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

