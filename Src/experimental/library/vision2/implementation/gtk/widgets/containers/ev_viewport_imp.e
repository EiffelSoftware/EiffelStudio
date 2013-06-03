note
	description: "Eiffel Vision viewport. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEWPORT_IMP

inherit
	EV_VIEWPORT_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			set_offset
		end

	EV_CELL_IMP
		redefine
			interface,
			container_widget,
			visual_widget,
			on_removed_item,
			needs_event_box,
			gtk_insert_i_th,
			gtk_container_remove,
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			if c_object = default_pointer then
					-- Only set c_object if not already set by a descendent.
				viewport := {GTK}.gtk_viewport_new ({GTK}.null_pointer, {GTK}.null_pointer)
				set_c_object (viewport)
				{GTK}.gtk_viewport_set_shadow_type (viewport, {GTK}.GTK_SHADOW_NONE_ENUM)
				{GTK2}.gtk_widget_set_minimum_size (viewport, 1, 1) -- Hack needed to prevent viewport resize on item resize.
				container_widget := viewport
			end
			Precursor
		end

	needs_event_box: BOOLEAN do end
			-- Does `a_widget' need an event box?

feature -- Access

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		do
			Result := internal_x_offset
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		do
			Result := internal_y_offset
		end

feature -- Element change

	block_resize_actions
			-- Block any resize actions that may occur.
		do
			if attached item as l_item then
				-- The blocking of resize actions is due to set uposition causing temporary resizing.
				if l_item.implementation.resize_actions_internal /= Void then
					l_item.implementation.resize_actions.block
				end
			end
		end

	unblock_resize_actions
			-- Unblock all resize actions.
		do
			if attached item as l_item then
				if l_item.implementation.resize_actions_internal /= Void then
					l_item.implementation.resize_actions.resume
				end
			end
		end

	set_x_offset (a_x: INTEGER)
			-- Set `x_offset' to `a_x'.
		do
			set_offset (a_x, internal_y_offset)
		end

	set_offset (a_x, a_y: INTEGER)
			-- Set viewport offset to `a_x', `a_y'.
		local
			l_null: POINTER
			l_x_offset_changed, l_y_offset_changed: BOOLEAN
		do
			l_x_offset_changed := a_x /= internal_x_offset
			l_y_offset_changed := a_y /= internal_y_offset
			if l_x_offset_changed or else l_y_offset_changed then
				block_resize_actions
				if l_x_offset_changed then
					internal_x_offset := a_x
					internal_set_value_from_adjustment (horizontal_adjustment, a_x)
				end
				if l_y_offset_changed then
					internal_y_offset := a_y
					internal_set_value_from_adjustment (vertical_adjustment, a_y)
				end

					-- Code below is to ensure that if the widget is visible then
					-- we only move the window, and not call the `expose_actions' on `item'
					-- as it is the case when calling `gtk_adjustment_value_changed'.
				if {GTK}.gtk_viewport_struct_bin_window (viewport) /= l_null then
					{GTK}.gdk_window_move (
						{GTK}.gtk_viewport_struct_bin_window (viewport), -a_x, -a_y)
				else
					if l_x_offset_changed then
						{GTK}.gtk_adjustment_value_changed (horizontal_adjustment)
					end
					if l_y_offset_changed then
						{GTK}.gtk_adjustment_value_changed (vertical_adjustment)
					end
				end
				unblock_resize_actions
			end
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
			set_offset (internal_x_offset, a_y)
		end

	set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp: detachable EV_WIDGET_IMP
			l_parent_box: POINTER
			l_c_object: POINTER
			l_item: like item
			l_alloc: POINTER
		do
			l_item := item
			check l_item /= Void then end
			w_imp ?= l_item.implementation
			check w_imp /= Void then end
			l_c_object := w_imp.c_object
			l_parent_box := {GTK}.gtk_widget_struct_parent (l_c_object)

			l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
			{GTK}.set_gtk_allocation_struct_x (l_alloc, internal_x_offset)
			{GTK}.set_gtk_allocation_struct_y (l_alloc, internal_y_offset)
			{GTK}.set_gtk_allocation_struct_width (l_alloc, a_width)
			{GTK}.set_gtk_allocation_struct_height (l_alloc, a_height)
			{GTK2}.gtk_widget_set_minimum_size (l_parent_box, a_width, a_height)
			{GTK2}.gtk_widget_size_allocate (l_parent_box, l_alloc)
			l_alloc.memory_free
		end

feature {NONE} -- Implementation

	gtk_insert_i_th (a_container, a_child: POINTER; a_position: INTEGER)
			-- Move `a_child' to `a_position' in `a_container'.
		local
			l_parent_box: POINTER
		do
				-- We add a parent box to `a_child' and control its size via this as
				-- GtkViewport updates the childs requisition upon allocation which
				-- affects the minimum size of the `a_child'.
			l_parent_box := {GTK}.gtk_event_box_new
			{GTK2}.gtk_event_box_set_visible_window (l_parent_box, False)
			{GTK}.gtk_widget_show (l_parent_box)
			{GTK}.gtk_container_add (l_parent_box, a_child)
			{GTK}.gtk_container_add (a_container, l_parent_box)
		end

	gtk_container_remove (a_container, a_child: POINTER)
			-- Remove `a_child' from `a_container'.
		local
			l_parent_box: POINTER
		do
			l_parent_box := {GTK}.gtk_widget_struct_parent (a_child)
			{GTK}.gtk_container_remove (l_parent_box, a_child)
			{GTK}.gtk_container_remove (a_container, l_parent_box)
		end

	container_widget: POINTER
			-- Pointer to the event box

	visual_widget: POINTER
			-- Pointer to the GtkViewport widget.
		do
			Result := viewport
		end

	on_removed_item (a_widget_imp: EV_WIDGET_IMP)
			-- Reset minimum size.
		do
			Precursor (a_widget_imp)
			set_offset (0, 0)
		end

	internal_x_offset, internal_y_offset: INTEGER
		-- X and Y offset values for viewport.

	horizontal_adjustment: POINTER
		do
			Result := {GTK}.gtk_viewport_get_hadjustment (viewport)
		end

	vertical_adjustment: POINTER
		do
			Result := {GTK}.gtk_viewport_get_vadjustment (viewport)
		end

	internal_set_value_from_adjustment (l_adj: POINTER; a_value: INTEGER)
			-- Set `value' of adjustment `l_adj' to `a_value'.
		require
			l_adj_not_null: l_adj /= default_pointer
		do
			if {GTK}.gtk_adjustment_struct_lower (l_adj) > a_value then
				{GTK}.set_gtk_adjustment_struct_lower (l_adj, a_value)
			elseif {GTK}.gtk_adjustment_struct_upper (l_adj) < a_value then
				{GTK}.set_gtk_adjustment_struct_upper (l_adj, a_value)
			end
			{GTK}.set_gtk_adjustment_struct_value (l_adj, a_value)
		ensure
			value_set: {GTK}.gtk_adjustment_struct_value (l_adj) = a_value
  		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VIEWPORT note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_VIEWPORT_IMP
