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
			needs_event_box,
			gtk_insert_i_th,
			gtk_container_remove,
			make,
			internal_x_y_offset
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			if c_object = default_pointer then
					-- Only set c_object if not already set by a descendent.
				viewport := {GTK}.gtk_layout_new ({GTK}.null_pointer, {GTK}.null_pointer)
				set_c_object (viewport)
				{GTK2}.gtk_layout_set_size (viewport, internal_x_y_offset * 2, internal_x_y_offset * 2)
				container_widget := viewport
				reset_offset_to_origin
			end
			Precursor
		end

	needs_event_box: BOOLEAN do end
			-- Does `a_widget' need an event box?

	needs_child_event_box: BOOLEAN = True
			-- Wrap child item into an event box?

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
			l_x_offset_changed, l_y_offset_changed: BOOLEAN
		do
			l_x_offset_changed := a_x /= internal_x_offset
			l_y_offset_changed := a_y /= internal_y_offset
			if l_x_offset_changed or else l_y_offset_changed then
				block_resize_actions
				if l_x_offset_changed then
					internal_x_offset := a_x
					{GTK}.gtk_adjustment_set_value (horizontal_adjustment, a_x + internal_x_y_offset)
				end
				if l_y_offset_changed then
					internal_y_offset := a_y
					{GTK}.gtk_adjustment_set_value (vertical_adjustment, a_y + internal_x_y_offset)
				end
				--if l_x_offset_changed then
					-- GTK+ emits `value-changed` itself whenever the value changes.
					-- {GTK}.gtk_adjustment_value_changed (horizontal_adjustment)
				--end
				--if l_y_offset_changed then
					-- {GTK}.gtk_adjustment_value_changed (vertical_adjustment)
					-- GTK+ emits `value-changed` itself whenever the value changes.
					-- ie GTK do something like this g_signal_emit_by_name(container_widget, "value-changed")
					--|TODO double check in other case implement it in Eiffel like this.
					--|real_signal_connect (container_widget, once "value-changed", agent (app_implementation.gtk_marshal).y_offset_changed (internal_id), Void)
				--end
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
			l_child_item: POINTER
			l_c_object: POINTER
			l_alloc: POINTER
		do
			debug ("gtk_sizing")
				print (attached_interface.debug_output + {STRING_32} ".set_item_size (w=" + a_width.out + ",h=" + a_height.out + ")%N")
			end
			if
				attached item as l_item and then
				attached {EV_WIDGET_IMP} l_item.implementation as w_imp
			then
				l_c_object := w_imp.c_object
				if needs_child_event_box then
					l_child_item := {GTK}.gtk_widget_get_parent (l_c_object)
				else
					l_child_item := l_c_object
				end
				l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
				{GTK}.gtk_widget_get_allocation (l_child_item, l_alloc)
				{GTK}.set_gtk_allocation_struct_width (l_alloc, a_width)
				{GTK}.set_gtk_allocation_struct_height (l_alloc, a_height)
				{GTK2}.gtk_widget_size_allocate (l_child_item, l_alloc)
				l_alloc.memory_free

				{GTK2}.gtk_widget_set_minimum_size (l_child_item, a_width, a_height)
			end
		end

feature {NONE} -- Implementation

	internal_x_y_offset: INTEGER = 16384
		-- <Precursor>

	gtk_insert_i_th (a_container, a_child: POINTER; a_position: INTEGER)
			-- Move `a_child' to `a_position' in `a_container'.
		local
			l_parent_box: POINTER
		do
			if needs_child_event_box then
					-- We add a parent box to `a_child' and control its size via this as
					-- GtkViewport updates the childs requisition upon allocation which
					-- affects the minimum size of the `a_child'.
				l_parent_box := {GTK}.gtk_event_box_new
				{GTK2}.gtk_event_box_set_visible_window (l_parent_box, False)
				{GTK}.gtk_widget_show (l_parent_box)
				{GTK}.gtk_container_add (l_parent_box, a_child)
				{GTK2}.gtk_layout_put (a_container, l_parent_box, internal_x_y_offset, internal_x_y_offset)
				{GTK}.gtk_widget_set_name (l_parent_box, {GTK}.gtk_widget_get_name (a_child))
			else
				{GTK2}.gtk_layout_put (a_container, a_child, internal_x_y_offset, internal_x_y_offset)
			end

			reset_offset_to_origin
		end

	gtk_container_remove (a_container, a_child: POINTER)
			-- Remove `a_child' from `a_container'.
		local
			l_parent_box: POINTER
		do
			if needs_child_event_box then
				l_parent_box := {GTK}.gtk_widget_get_parent (a_child)
				{GTK}.gtk_container_remove (l_parent_box, a_child)
				{GTK}.gtk_container_remove (a_container, l_parent_box)
			else
				{GTK}.gtk_container_remove (a_container, a_child)
			end

			reset_offset_to_origin
		end

	reset_offset_to_origin
		do
			internal_x_offset := -1
			internal_y_offset := -1
			set_offset (0, 0)
		end

	container_widget: POINTER
			-- Pointer to the event box

	visual_widget: POINTER
			-- Pointer to the GtkViewport widget.
		do
			Result := viewport
		end

	internal_x_offset, internal_y_offset: INTEGER
		-- X and Y offset values for viewport.

	horizontal_adjustment: POINTER
		do
			Result := {GTK}.gtk_scrollable_get_hadjustment (viewport)
		end

	vertical_adjustment: POINTER
		do
			Result := {GTK}.gtk_scrollable_get_vadjustment (viewport)
		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VIEWPORT note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_VIEWPORT_IMP
