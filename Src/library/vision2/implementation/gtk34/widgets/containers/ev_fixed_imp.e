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
			{GTK2}.gtk_layout_set_size (container_widget, 32768, 32768)
			Precursor
		end

	needs_event_box: BOOLEAN = True
		-- <Precursor>

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
			l_parent_box: POINTER
			w_imp: detachable EV_WIDGET_IMP
			l_alloc: POINTER
		do
			w_imp ?= a_widget.implementation
			check w_imp /= Void then end
			l_parent_box := {GTK}.gtk_widget_get_parent (w_imp.c_object)

			{GTK2}.gtk_layout_move (container_widget, l_parent_box, a_x, a_y)

			l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
			{GTK}.gtk_widget_get_allocation (l_parent_box, l_alloc)


			{GTK}.set_gtk_allocation_struct_x (l_alloc, a_x + internal_x_y_offset)
			{GTK}.set_gtk_allocation_struct_y (l_alloc, a_y + internal_x_y_offset)
			{GTK}.set_gtk_allocation_struct_width (l_alloc, a_width)
			{GTK}.set_gtk_allocation_struct_height (l_alloc, a_height)
			{GTK2}.gtk_widget_set_minimum_size (l_parent_box, a_width, a_height)
			{GTK2}.gtk_widget_size_allocate (l_parent_box, l_alloc)

			l_alloc.memory_free

			if (a_x + a_width > minimum_width) then
				set_minimum_width (a_x + a_width)
			end

			if (a_y + a_height > minimum_height) then
				set_minimum_height (a_y + a_height)
			end

			--{GTK}.gtk_container_check_resize (l_parent_box)
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
		local
			w_imp: detachable EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			check w_imp /= Void then end
			set_item_position_and_size (a_widget, x_position_of_child (w_imp), y_position_of_child (w_imp), a_width, a_height)
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
				-- We add a parent box to `a_child' and control its size via this as
				-- GtkFixed updates the childs requisition upon allocation which
				-- affects the minimum size of the `a_child'.

			l_parent_box := {GTK}.gtk_event_box_new
			{GTK2}.gtk_event_box_set_visible_window (l_parent_box, False)
			{GTK}.gtk_widget_show (l_parent_box)
			{GTK}.gtk_container_add (l_parent_box, a_child)
			{GTK}.gtk_layout_put (a_container, l_parent_box, internal_x_y_offset, internal_x_y_offset)
			{GTK}.gtk_container_check_resize (container_widget)
		end

	gtk_container_remove (a_container, a_child: POINTER)
			-- Remove `a_child' from `a_container'.
		local
			l_parent_box: POINTER
		do
			l_parent_box := {GTK}.gtk_widget_get_parent (a_child)
			{GTK}.gtk_container_remove (l_parent_box, a_child)
			{GTK}.gtk_container_remove (a_container, l_parent_box)
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

