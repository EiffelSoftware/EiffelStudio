note
	description:
		"[
			Widget that contains other widgets.
			Base class for all containers.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, pack"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER

inherit
	EV_WIDGET
		redefine
			implementation,
			is_in_default_state
		end

	EV_PIXMAPABLE
		rename
			set_pixmap as set_background_pixmap,
			remove_pixmap as remove_background_pixmap,
			pixmap as background_pixmap
		redefine
			implementation,
			is_in_default_state,
			background_pixmap
		end

	BOX [EV_WIDGET]
		export
			{NONE}
				changeable_comparison_criterion,
				compare_references,
				compare_objects,
				object_comparison
			{EV_ANY_HANDLER}
				default_create
		undefine
			default_create,
			copy
		redefine
			changeable_comparison_criterion
		end

	COLLECTION [EV_WIDGET]
		rename
			extend as cl_extend,
			put as cl_put,
			prune as cl_prune
		export
			{NONE}
				changeable_comparison_criterion,
				compare_references,
				compare_objects,
				object_comparison
			{EV_ANY_HANDLER}
				default_create
		undefine
			default_create,
			copy
		redefine
			changeable_comparison_criterion
		end

feature -- Access

	item: EV_WIDGET
			-- Current item.
		require
			not_destroyed: not is_destroyed
			readable: readable
		do
			Result := implementation.interface_item
		ensure
			bridge_ok: Result = implementation.interface_item
		end

	count: INTEGER
			-- Number of elements in `Current'.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	has_recursive (an_item: like item): BOOLEAN
			-- Does structure include `an_item' or
			-- does any structure recursively included by structure,
			-- include `an_item'.
		require
			not_destroyed: not is_destroyed
		local
			lst: LINEAR [EV_WIDGET]
			c: detachable CURSOR
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
		do
			Result := has (an_item)
			lst := linear_representation
			if attached {CURSOR_STRUCTURE [EV_WIDGET]} lst as l_cursor_structure then
				cs := l_cursor_structure
				c := l_cursor_structure.cursor
			end
			across
				lst as ic
			until
				Result
			loop
				if attached {EV_CONTAINER} ic as ct then
					Result := ct.has_recursive (an_item)
				end

			end
			if cs /= Void and then c /= Void then
					-- By security, restore previous cursor location
				cs.go_to (c)
			end
		end

	background_pixmap: detachable EV_PIXMAP
			-- `Result' is pixmap displayed on background of `Current'.
			-- It is tessellated and fills whole of `Current'.
		do
			Result := Precursor {EV_PIXMAPABLE}
		end

feature -- Status setting

	merge_radio_button_groups (other: EV_CONTAINER)
			-- Merge `Current' radio button group with that of `other'.
		require
			not_destroyed: not is_destroyed
			other_not_void: other /= Void
		do
			implementation.merge_radio_button_groups (other)
		end

	unmerge_radio_button_groups (other: EV_CONTAINER)
			-- Remove `other' from radio button group of `Current'.
			-- If no radio button of `other' was checked before removal
			-- then first radio button contained will be checked.
		require
			not_destroyed: not is_destroyed
			other_is_merged: attached merged_radio_button_groups as l_merged_r_b_groups and then l_merged_r_b_groups.has (other)
		do
			implementation.unmerge_radio_button_groups (other)
		ensure
			other_not_merged: other.merged_radio_button_groups = Void
			not_contained_in_this_group: attached merged_radio_button_groups as l_merged_r_b_groups implies
				not l_merged_r_b_groups.has (other)
			other_first_radio_button_now_selected: not old other.has_selected_radio_button and
				old other.has_radio_button implies
				other.first_radio_button_selected
			original_radio_button_still_selected: old has_selected_radio_button implies
				has_selected_radio_button
			other_first_radio_button_now_selected: not old has_selected_radio_button and
				old other.has_radio_button and (attached old merged_radio_button_groups as l_merged_r_b_groups and then l_merged_r_b_groups.count = 1) and has_radio_button implies
				first_radio_button_selected
			other_original_radio_button_still_selected: old other.has_selected_radio_button implies
				other.has_selected_radio_button
				-- old merged_radio_button_groups.count > 1 implies original selection from that group still selected.
		end

feature -- Status report

	merged_radio_button_groups: detachable ARRAYED_LIST [EV_CONTAINER]
			-- `Result' is all other radio button groups
			-- merged with `Current'. Void if no other containers
			-- are merged.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.merged_radio_button_groups
		ensure
			not_is_empty: Result /= Void implies not Result.is_empty
		end

	writable: BOOLEAN
			-- Is there a current item that may be modified?
		require
			not_destroyed: not is_destroyed
		deferred
		end

	readable: BOOLEAN
			-- Is there a current item that may be accessed?
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature -- Element change

	extend (v: like item)
			-- Ensure that structure includes `v'.
			-- Do not move cursor.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: v /= Current
			v_not_parent_of_current: not is_parent_recursive (v)
			v_containable: may_contain (v)
		do
			implementation.extend (v)
		ensure
			has_v: has (v)
		end

	put, replace (v: like item)
			-- Replace `item' with `v'.
		require
			not_destroyed: not is_destroyed
			writable: writable
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: v /= Current
			v_not_parent_of_current: not is_parent_recursive (v)
			v_containable: may_contain (v)
		do
			implementation.replace (v)
		ensure
			has_v: has (v)
			not_has_old_item: old readable implies (attached old implementation.item as l_item and then not has (l_item))
		end

	prune (v: like item)
			-- Replace `item' with `v'.
		require
			not_destroyed: not is_destroyed
			writable: prunable
			v_not_void: v /= Void
			v_parent_void: v.parent = Current
			v_not_current: v /= Current
		deferred
		ensure
			has_v: not has (v)
		end

feature -- Iteration

	new_cursor: ITERATION_CURSOR [EV_WIDGET]
			-- <Precursor>
		do
			Result := linear_representation.new_cursor
		end

feature -- Measurement

	client_width: INTEGER
			-- Width of the area available to children in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.client_width
		ensure
			bridge_ok: Result = implementation.client_width
		end

	client_height: INTEGER
			-- Height of the area available to children in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.client_height
		ensure
			bridge_ok: Result = implementation.client_height
		end

feature -- Basic operations

	propagate_foreground_color
			-- Propagate `foreground_color' recursively, to all children.
		require
			not_destroyed: not is_destroyed
		do
			implementation.propagate_foreground_color
		ensure
			foreground_color_propagated: foreground_color_propagated
		end

	propagate_background_color
			-- Propagate `background_color' recursively, to all children.
		require
			not_destroyed: not is_destroyed
		do
			implementation.propagate_background_color
		ensure
			background_color_propagated: background_color_propagated
		end

feature {EV_CONTAINER, EV_CONTAINER_I} -- Contract support

	parent_of_items_is_current: BOOLEAN
			-- Do all items have parent `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.parent_of_items_is_current
		end

	items_unique: BOOLEAN
			-- Are all items unique?
			-- (ie Are there no duplicates?)
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.items_unique
		end

	foreground_color_propagated: BOOLEAN
			-- Do all children have same foreground color as `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.foreground_color_propagated
		end

	background_color_propagated: BOOLEAN
			-- Do all children have same background color as `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.background_color_propagated
		end

	all_radio_buttons_connected: BOOLEAN
			-- Are all radio buttons in this container connected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.all_radio_buttons_connected
		end

	first_radio_button_selected: BOOLEAN
			-- Is first radio button contained in `Current',
			-- selected?
		do
			Result := implementation.first_radio_button_selected
		end
	has_selected_radio_button: BOOLEAN
			-- Does `Current' contain a selected radio button?
		do
			Result := implementation.has_selected_radio_button
		end

	has_radio_button: BOOLEAN
			-- Does `Current' contain one or more radio buttons?
		do
			Result := implementation.has_radio_button
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_WIDGET} and Precursor {EV_PIXMAPABLE}
		end

feature -- Contract support

	is_parent_recursive (a_widget: EV_WIDGET): BOOLEAN
			-- Is `a_widget' `parent', or recursivly, `parent' of `parent'.
		require
			not_destroyed: not is_destroyed
		do
			Result := attached parent as l_parent and then
				(l_parent = a_widget or else l_parent.is_parent_recursive (a_widget))
		end

	may_contain (v: EV_WIDGET): BOOLEAN
			-- May `v' be inserted in `Current'.
			-- Instances of EV_WINDOW may not be inserted
			-- in a container even though they are widgets.
		do
			Result := not attached {EV_WINDOW} v
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_CONTAINER_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	changeable_comparison_criterion: BOOLEAN = False
			-- May `object_comparison' be changed?
			-- (Answer: no by default.)

	cl_put (v: like item)
			-- Replace `item' with `v'.
		do
			put (v)
		end

	cl_extend (v: like item)
			-- Ensure that structure includes `v'.
		do
			extend (v)
		end

	cl_prune (v: like item)
		do
			prune (v)
		end

invariant
	client_width_non_negative: is_usable implies client_width >= 0
	client_width_within_limit: is_usable implies client_width <= width
	client_height_non_negative: is_usable implies client_height >= 0
	client_height_within_limit: is_usable implies client_height <= height

	all_radio_buttons_connected: is_usable implies all_radio_buttons_connected
	parent_of_items_is_current: is_usable implies parent_of_items_is_current
	items_unique: is_usable implies items_unique

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
