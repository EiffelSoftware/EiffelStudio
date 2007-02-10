indexing
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
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			initialize,
			gtk_container_remove
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the fixed container.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_fixed_new)
		end

	initialize is
			-- Initialize `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_fixed_set_has_window (container_widget, True)
			Precursor
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			w_imp: EV_WIDGET_IMP
			l_parent_box: POINTER
		do
			w_imp ?= a_widget.implementation
			l_parent_box := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (w_imp.c_object)
			{EV_GTK_EXTERNALS}.gtk_fixed_move (container_widget, l_parent_box, an_x, a_y)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp: EV_WIDGET_IMP
			l_parent_box: POINTER
			l_c_object: POINTER
		do
			w_imp ?= a_widget.implementation
			l_c_object := w_imp.c_object
			l_parent_box := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (l_c_object)
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (l_parent_box, a_width, a_height)
			{EV_GTK_EXTERNALS}.gtk_container_check_resize (container_widget)
		end

feature {EV_ANY_I} -- Implementation

	i_th_fixed_child (i: INTEGER): POINTER is
			-- `i-th' fixed child of `Current'.
		local
			glist: POINTER
		do
			glist := {EV_GTK_EXTERNALS}.gtk_fixed_struct_children (container_widget)
			Result := {EV_GTK_EXTERNALS}.g_list_nth_data (glist, i - 1)
		end

	x_position_of_child (a_widget_imp: EV_WIDGET_IMP): INTEGER is
			-- X position of `a_widget_imp' within `Current'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_fixed_child_struct_x (i_th_fixed_child (index_of (a_widget_imp.interface, 1)))
		end

	y_position_of_child (a_widget_imp: EV_WIDGET_IMP): INTEGER is
			-- Y position of `a_widget_imp' within `Current'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_fixed_child_struct_y (i_th_fixed_child (index_of (a_widget_imp.interface, 1)))
		end

	gtk_insert_i_th (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		local
			glist, fixlist, fixitem: POINTER
			temp_index: INTEGER
			l_requisition: POINTER
			l_parent_box: POINTER
		do
				-- We add a parent box to `a_child' and control its size via this as
				-- GtkFixed updates the childs requisition upon allocation which
				-- affects the minimum size of the `a_child'.

			l_parent_box := {EV_GTK_EXTERNALS}.gtk_event_box_new
			{EV_GTK_EXTERNALS}.gtk_event_box_set_visible_window (l_parent_box, False)
			{EV_GTK_EXTERNALS}.gtk_widget_show (l_parent_box)
			{EV_GTK_EXTERNALS}.gtk_container_add (l_parent_box, a_child)

			{EV_GTK_EXTERNALS}.gtk_container_add (a_container, l_parent_box)
			l_requisition := {EV_GTK_EXTERNALS}.c_gtk_allocation_struct_allocate
			{EV_GTK_EXTERNALS}.gtk_widget_get_child_requisition (a_child, l_requisition)
			if a_position < count then
				glist := {EV_GTK_EXTERNALS}.gtk_container_children (a_container)
				temp_index := {EV_GTK_EXTERNALS}.g_list_index (glist, l_parent_box)
				fixlist := {EV_GTK_EXTERNALS}.gtk_fixed_struct_children (a_container)
				fixitem := {EV_GTK_EXTERNALS}.g_list_nth_data (fixlist, temp_index)
				fixlist := {EV_GTK_EXTERNALS}.g_list_remove (fixlist, fixitem)
				fixlist := {EV_GTK_EXTERNALS}.g_list_insert (fixlist, fixitem, a_position)
				{EV_GTK_EXTERNALS}.set_gtk_fixed_struct_children (a_container, fixlist)
				{EV_GTK_EXTERNALS}.gtk_widget_queue_resize (c_object)
				{EV_GTK_EXTERNALS}.g_list_free (glist)
			end
		end

	gtk_container_remove (a_container, a_child: POINTER)
			-- Remove `a_child' from `a_container'.
		local
			l_parent_box: POINTER
		do
			l_parent_box := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (a_child)
			{EV_GTK_EXTERNALS}.gtk_container_remove (l_parent_box, a_child)
			{EV_GTK_EXTERNALS}.gtk_container_remove (a_container, l_parent_box)
		end

	interface: EV_FIXED;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_FIXED

