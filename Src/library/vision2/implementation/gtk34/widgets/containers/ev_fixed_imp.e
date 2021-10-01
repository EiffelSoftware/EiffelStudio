note
	description:
		"Eiffel Vision fixed. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			extend_with_position_and_size,
			set_item_position_and_size
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			make,
			gtk_container_remove,
			needs_event_box,
			internal_x_y_offset
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create the fixed container.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			set_c_object ({GTK}.gtk_layout_new (default_pointer, default_pointer))
			{GTK2}.gtk_widget_set_has_window (container_widget, True)
			Precursor
		end

	needs_event_box: BOOLEAN = True
			-- <Precursor>

	needs_child_event_box: BOOLEAN = False
			-- Wrap child item into an event box?

feature -- Status setting

	extend_with_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Add `a_widget' to `Current' with a position of `a_x', a_y' and a dimension of `a_width' and `a_height'.
		do
			extend (a_widget)
			set_item_position_and_size (a_widget, a_x, a_y, a_width, a_height)
		end

	set_item_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Assign `a_widget' with a position of `a_x' and a_y', and a dimension of `a_width' and `a_height'.
		local
			l_item_c_object,
			l_child_container: POINTER
			l_alloc: POINTER
			w,h: INTEGER
			l_size_smaller: BOOLEAN
		do
			debug ("gtk_sizing")
				print (attached_interface.debug_output + {STRING_32} ".set_item_position_and_size (" + a_widget.debug_output + ",x=" + a_x.out + ",y=" + a_y.out + ",w=" + a_width.out + ",h=" + a_height.out + ")%N")
			end

			check attached {EV_WIDGET_IMP} a_widget.implementation as w_imp then
				l_item_c_object := w_imp.c_object
			end
			if not l_item_c_object.is_default_pointer then
				if needs_child_event_box then
					l_child_container := {GTK}.gtk_widget_get_parent (l_item_c_object) -- The parent event box
				else
					l_child_container := l_item_c_object
				end
			end

			if not l_child_container.is_default_pointer then
				{GTK2}.gtk_layout_move (container_widget, l_child_container, a_x, a_y)

				{GTK2}.gtk_widget_set_minimum_size (l_child_container, a_width, a_height) -- unfortunately it seems to be REQUIRED

				l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
				{GTK}.gtk_widget_get_allocation (l_child_container, l_alloc)
				{GTK}.set_gtk_allocation_struct_x (l_alloc, a_x + internal_x_y_offset)
				{GTK}.set_gtk_allocation_struct_y (l_alloc, a_y + internal_x_y_offset)
				{GTK}.set_gtk_allocation_struct_width (l_alloc, {GTK}.gtk_widget_minimum_width (l_child_container))
				{GTK}.set_gtk_allocation_struct_height (l_alloc, {GTK}.gtk_widget_minimum_height (l_child_container))
				{GTK2}.gtk_widget_size_allocate (l_child_container, l_alloc)
				l_alloc.memory_free
			end
			if needs_child_event_box and not l_item_c_object.is_default_pointer then
				l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
				{GTK}.gtk_widget_get_allocation (l_item_c_object, l_alloc)
				{GTK}.set_gtk_allocation_struct_width (l_alloc, a_width)
				{GTK}.set_gtk_allocation_struct_height (l_alloc, a_height)
				{GTK2}.gtk_widget_set_minimum_size (l_item_c_object, a_width, a_height) -- unfortunately it seems to be REQUIRED
				{GTK2}.gtk_widget_size_allocate (l_item_c_object, l_alloc)
				l_alloc.memory_free
			end

			w := a_widget.x_position + a_widget.width
			h := a_widget.y_position + a_widget.height
			if w > minimum_width then
				set_real_minimum_size (w, real_minimum_height)
			else
				l_size_smaller := w < minimum_width
			end
			if h > minimum_height then
				set_real_minimum_size (real_minimum_width, h)
			else
				l_size_smaller := h < minimum_height
			end
			if l_size_smaller then
				update_minimum_size
			end
		end

	update_minimum_size
			-- Update minimum size by looking at all existing childs.
		local
			w,h: INTEGER
			l_widget_width, l_widget_height: INTEGER
		do
			if
				attached cursor as l_cursor
			then
					-- Update the minimum size by checking position and size of all childs.
				from
					start
				until
					off
				loop
					if attached {EV_WIDGET} item as l_widget then
						l_widget_width := l_widget.width
						if l_widget.minimum_width_set_by_user then
							l_widget_width := l_widget_width.max (l_widget.minimum_width)
						end
						l_widget_height := l_widget.height
						if l_widget.minimum_height_set_by_user then
							l_widget_height := l_widget_height.max (l_widget.minimum_height)
						end
						w := (l_widget.x_position + l_widget_width).max (w)
						h := (l_widget.y_position + l_widget_height).max (h)
					end
					forth
				end
				go_to (l_cursor)
					-- Set "real"_minimum size, instead of vision2 minimum size.
				if w /= minimum_width or h /= minimum_height then
					set_real_minimum_size (w, h)
				end
			end
		end

	set_item_position (a_widget: EV_WIDGET; a_x, a_y: INTEGER)
			-- Set `a_widget.x_position' to `a_x'.
			-- Set `a_widget.y_position' to `a_y'.
		do
			set_item_position_and_size (a_widget, a_x, a_y, a_widget.width, a_widget.height)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			debug ("gtk_sizing")
				print (generating_type.name_32 + {STRING_32} ".set_item_size ("+ a_widget.debug_output +",w=" + a_width.out + ",h=" + a_height.out + ")%N")
			end
			check attached {EV_WIDGET_IMP} a_widget.implementation as w_imp then
				set_item_position_and_size (a_widget, x_position_of_child (w_imp), y_position_of_child (w_imp), a_width, a_height)
			end
		end

feature {EV_ANY_I} -- Implementation

	internal_x_y_offset: INTEGER = 0--16384
		-- <Precursor>

	horizontal_adjustment: POINTER
			-- GtkAdjustment for GtkLayout container.
		do
			Result := {GTK}.gtk_scrollable_get_hadjustment (container_widget)
		end

	vertical_adjustment: POINTER
			-- GtkAdjustment for GtkLayout container.
		do
			Result := {GTK}.gtk_scrollable_get_vadjustment (container_widget)
		end

	i_th_fixed_child (i: INTEGER): POINTER
			-- `i-th' fixed child of `Current'.
		local
			glist: POINTER
		do
			glist := {GTK}.gtk_container_get_children (container_widget)
			Result := {GTK}.g_list_nth_data (glist, i - 1)
			{GTK}.g_list_free (glist)
		end

	x_position_of_child (a_widget_imp: EV_WIDGET_IMP): INTEGER
			-- X position of `a_widget_imp' within `Current'.
		local
			l_x: EV_GTK_C_STRING
			l_item, l_gvalue: POINTER
		do
			l_x := "x"
			l_item := i_th_fixed_child (index_of (a_widget_imp.interface, 1))
			l_gvalue := {GTK2}.c_g_value_struct_allocate
			{GTK2}.g_value_init_int (l_gvalue)
			{GTK2}.gtk_container_child_get_property (container_widget, l_item, l_x.item, l_gvalue)
			Result := {GTK2}.g_value_get_int (l_gvalue)
			l_gvalue.memory_free
		end

	y_position_of_child (a_widget_imp: EV_WIDGET_IMP): INTEGER
			-- Y position of `a_widget_imp' within `Current'.
		local
			l_y: EV_GTK_C_STRING
			l_item, l_gvalue: POINTER
		do
			l_y := "y"
			l_item := i_th_fixed_child (index_of (a_widget_imp.interface, 1))
			l_gvalue := {GTK2}.c_g_value_struct_allocate
			{GTK2}.g_value_init_int (l_gvalue)
			{GTK2}.gtk_container_child_get_property (container_widget, l_item, l_y.item, l_gvalue)
			Result := {GTK2}.g_value_get_int (l_gvalue)
			l_gvalue.memory_free
		end

	gtk_insert_i_th (a_container, a_child: POINTER; a_position: INTEGER)
			-- Move `a_child' to `a_position' in `a_container'.
		local
			l_parent_box: POINTER
		do
			if needs_child_event_box then
					-- We add a parent box to `a_child' and control its size via this as
					-- GtkFixed updates the childs requisition upon allocation which
					-- affects the minimum size of the `a_child'.

				l_parent_box := {GTK}.gtk_event_box_new
				{GTK2}.gtk_event_box_set_visible_window (l_parent_box, False)
				{GTK}.gtk_widget_show (l_parent_box)
				{GTK}.gtk_container_add (l_parent_box, a_child)
				{GTK}.gtk_layout_put (a_container, l_parent_box, internal_x_y_offset, internal_x_y_offset)
				{GTK}.gtk_widget_set_name (l_parent_box, {GTK}.gtk_widget_get_name (a_child))
			else
				{GTK}.gtk_layout_put (a_container, a_child, internal_x_y_offset, internal_x_y_offset)
			end

			{GTK}.gtk_container_check_resize (container_widget)
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
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FIXED note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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

end -- class EV_FIXED

