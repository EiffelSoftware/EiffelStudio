indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GTK_WIDGET_IMP

inherit
	EV_ANY_IMP

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences, redefined by descendants
		do

		end

feature {NONE} -- Implementation

	is_parentable: BOOLEAN is
			-- May Current be parented?
		do
			Result := True
		end

	Gdk_events_mask: INTEGER is
			-- Mask of all the gdk events the gdkwindow shall receive.
		once
			Result := {EV_GTK_EXTERNALS}.GDK_EXPOSURE_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_BUTTON_RELEASE_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_KEY_PRESS_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_KEY_RELEASE_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_ENTER_NOTIFY_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_LEAVE_NOTIFY_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_FOCUS_CHANGE_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_VISIBILITY_NOTIFY_MASK_ENUM
		end

	initialize is
			-- Initialize `c_object'
		do
			{EV_GTK_EXTERNALS}.gtk_widget_add_events (visual_widget, gdk_events_mask)
			if is_parentable then
				{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			else
				{EV_GTK_EXTERNALS}.gtk_widget_realize (c_object)
			end
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Implementation

	minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
		do
			if not is_destroyed then
				update_request_size
				gr := {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object)
				Result := {EV_GTK_EXTERNALS}.gtk_requisition_struct_width (gr)
			end
		end

	minimum_height: INTEGER is
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
		do
			if not is_destroyed then
				update_request_size
				gr := {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object)
				Result := {EV_GTK_EXTERNALS}.gtk_requisition_struct_height (gr)
			end
		end

	event_widget: POINTER is
			-- Pointer to the widget handling the widget events
		local
			a_visual_widget: POINTER
		do
			a_visual_widget := visual_widget
			if not {EV_GTK_EXTERNALS}.gtk_widget_no_window (a_visual_widget) then
				Result := a_visual_widget
			else
				Result := c_object
			end
		end

	eif_object_from_gtk_object (a_gtk_object: POINTER): EV_ANY_IMP is
			-- Return the EV_ANY_IMP object from `a_gtk_object' if any.
		require
			a_gtk_object_not_null: a_gtk_object /= default_pointer
		local
			gtkwid: POINTER
		do
			from
				gtkwid := a_gtk_object
			until
				Result /= Void or else gtkwid = NULL
			loop
					Result := eif_object_from_c (gtkwid)
					gtkwid := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (gtkwid)
			end
		end

	gtk_widget_imp_at_pointer_position: EV_GTK_WIDGET_IMP is
			-- Gtk Widget implementation at current mouse pointer position (if any)
		local
			a_x, a_y: INTEGER
			gdkwin, gtkwid: POINTER
		do
			gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= null then
				{EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $gtkwid)
				if gtkwid /= default_pointer then
					Result ?= eif_object_from_gtk_object (gtkwid)
				end
			end
			if Result /= Void and then Result.is_destroyed then
				Result := Void
			end
		end

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- Widget implementation at current mouse pointer position (if any)
		do
			Result ?= gtk_widget_imp_at_pointer_position
		end

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		do
			if a_cursor /= pointer_style then
				pointer_style := a_cursor
				internal_set_pointer_style (a_cursor)
			end
		end

	set_focus is
			-- Grab keyboard focus.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_grab_focus (visual_widget)
		end

	internal_set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_ptr: POINTER
		do
			a_cursor_ptr := app_implementation.gdk_cursor_from_pixmap (a_cursor)
			set_composite_widget_pointer_style (a_cursor_ptr)
		end

	set_composite_widget_pointer_style (a_cursor_ptr: POINTER) is
			-- Used to set the gdkcursor for composite widgets.
		local
			a_window: POINTER
		do
			a_window := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget)
			if a_window /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_window_set_cursor (a_window, a_cursor_ptr)
			end
			a_window := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object)
			if a_window /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_window_set_cursor (a_window, a_cursor_ptr)
			end
		end

	pointer_style: EV_CURSOR
			-- Cursor displayed when the pointer is over this widget.
			-- Position retrieval.

	frozen has_struct_flag (a_gtk_object: POINTER; a_flag: INTEGER): BOOLEAN is
			-- Has this widget the flag `a_flag' set in struct_flags?
		external
			"C inline use <gtk/gtk.h>"
		alias
			"((GtkObject*) $a_gtk_object)->flags & $a_flag"
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := has_struct_flag (visual_widget, {EV_GTK_EXTERNALS}.gtk_has_focus_enum)
		end

	width: INTEGER is
			-- Horizontal size measured in pixels.
		local
			a_min_width: INTEGER
		do
			update_parent_size
			a_min_width := minimum_width
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (a_min_width)
		end

	update_parent_size is
			-- Check to see if `Current' needs resizing in parent.
		local
			a_toplevel: POINTER
		do
				-- If we are present in a GtkWindow structure then we force a container resize on the parent
			a_toplevel := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
			if a_toplevel /= default_pointer and then has_struct_flag (a_toplevel, {EV_GTK_ENUMS}.gtk_toplevel_enum) and then a_toplevel /= c_object then
				{EV_GTK_EXTERNALS}.gtk_container_check_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object))
			end
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		local
			a_min_height: INTEGER
		do
			update_parent_size
			a_min_height := minimum_height
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (a_min_height)
		end

	update_request_size is
			-- Force the requisition struct to be updated.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, default_pointer)
		end

	aux_info_struct: POINTER is
			-- Pointer to the auxillary information struct used for retrieving when widget is unmapped
		do
			Result := {EV_GTK_EXTERNALS}.gtk_object_get_data (
				c_object,
				aux_info_string.item
			)
		end

	show is
			-- Request that `Current' be displayed when its parent is.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
		end

feature -- Status report

	screen_x: INTEGER is
			-- Horizontal position of the client area on screen,
		local
			a_x: INTEGER
			a_aux_info: POINTER
			i: INTEGER
			l_null: POINTER
		do
			if is_displayed then
					i := {EV_GTK_EXTERNALS}.gdk_window_get_origin (
						{EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget),
				    	$a_x, l_null)
					Result := a_x
			else
				a_aux_info := aux_info_struct
				if a_aux_info /= l_null then
					Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
				end
			end
		end

	screen_y: INTEGER is
			-- Vertical position of the client area on screen,
		local
			a_y: INTEGER
			a_aux_info: POINTER
			i: INTEGER
			l_null: POINTER
		do
			if is_displayed then
					i := {EV_GTK_EXTERNALS}.gdk_window_get_origin (
						{EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget),
				    	l_null, $a_y)
					Result := a_y
			else
				a_aux_info := aux_info_struct
				if a_aux_info /= l_null then
					Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
				end
			end
		end

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := has_struct_flag (c_object, {EV_GTK_EXTERNALS}.GTK_VISIBLE_ENUM)
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
		do
			Result := has_struct_flag (c_object, {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM)
		end

feature {NONE} -- Implementation

	aux_info_string: EV_GTK_C_STRING is
			-- String optimization for  "gtk-aux-info"
		once
			Result := "gtk-aux-info"
		end

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




end -- class EV_GTK_WIDGET_IMP
