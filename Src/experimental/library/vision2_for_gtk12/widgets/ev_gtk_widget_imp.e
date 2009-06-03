note
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

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN; call_application_events: BOOLEAN)
			-- Used for key event actions sequences, redefined by descendants
		do

		end

feature {NONE} -- Implementation

	Gdk_events_mask: INTEGER
			-- Mask of all the gdk events the gdkwindow shall receive.
		once
			Result :=
				{EV_GTK_EXTERNALS}.GDK_EXPOSURE_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_BUTTON_RELEASE_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_KEY_PRESS_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_KEY_RELEASE_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_ENTER_NOTIFY_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_LEAVE_NOTIFY_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_FOCUS_CHANGE_MASK_ENUM
				| {EV_GTK_EXTERNALS}.GDK_VISIBILITY_NOTIFY_MASK_ENUM
--				| {EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_HINT_MASK_ENUM
		end

	initialize
			-- Initialize `c_object'.
		local
			l_c_object: POINTER
		do
			l_c_object := c_object
			{EV_GTK_EXTERNALS}.gtk_widget_add_events (l_c_object, gdk_events_mask)
			if {EV_GTK_EXTERNALS}.gtk_is_window (l_c_object) then
				{EV_GTK_EXTERNALS}.gtk_widget_realize (l_c_object)
			else
				{EV_GTK_EXTERNALS}.gtk_widget_show (l_c_object)
			end
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Implementation

	minimum_width: INTEGER
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

	minimum_height: INTEGER
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

	event_widget: POINTER
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

	eif_object_from_gtk_object (a_gtk_object: POINTER): EV_ANY_IMP
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

	gtk_widget_imp_at_pointer_position: EV_GTK_WIDGET_IMP
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

	widget_imp_at_pointer_position: EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		do
			Result ?= gtk_widget_imp_at_pointer_position
		end

	set_focus
			-- Grab keyboard focus.
		do
			if not has_focus then
				internal_set_focus
			end
		end

	internal_set_focus
			-- Grab keyboard focus.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_grab_focus (visual_widget)
		end

	set_pointer_style (a_pointer: EV_POINTER_STYLE)
			-- Assign `a_pointer' to `pointer_style'.
		do
			if a_pointer /= pointer_style then
				pointer_style := a_pointer
				internal_set_pointer_style (a_pointer)
			end
		end

	internal_set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_ptr: POINTER
			a_window: POINTER
			a_cursor_imp: EV_POINTER_STYLE_IMP
		do
			if a_cursor /= Void then
				a_cursor_imp ?= a_cursor.implementation
				a_cursor_ptr := a_cursor_imp.gdk_cursor_from_pointer_style
				a_window := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget)
				if a_window /= default_pointer then
					{EV_GTK_EXTERNALS}.gdk_window_set_cursor (a_window, a_cursor_ptr)
				end
			end
			if previous_gdk_cursor /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_cursor_destroy (previous_gdk_cursor)
			end
			previous_gdk_cursor := a_cursor_ptr
		end

	previous_gdk_cursor: POINTER
			-- Pointer to the previously create GdkCursor.

	pointer_style: EV_POINTER_STYLE
			-- Cursor displayed when the pointer is over this widget.

	frozen has_struct_flag (a_gtk_object: POINTER; a_flag: INTEGER): BOOLEAN
			-- Has this widget the flag `a_flag' set in struct_flags?
		external
			"C inline use <gtk/gtk.h>"
		alias
			"((GtkObject*) $a_gtk_object)->flags & $a_flag"
		end

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		local
			l_window, l_widget: POINTER
			l_widget_imp: EV_WIDGET_IMP
		do
			l_window := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
				-- This will return `c_object' if not toplevel window is found in hierarchy.
			if l_window /= default_pointer and then {EV_GTK_EXTERNALS}.gtk_widget_toplevel (l_window) then--and then {EV_GTK_EXTERNALS}.gtk_window_has_toplevel_focus (l_window) then
				l_widget := {EV_GTK_EXTERNALS}.gtk_window_get_focus (l_window)
				if l_widget /= default_pointer then
					l_widget_imp ?= app_implementation.eif_object_from_gtk_object (l_widget)
					Result := l_widget_imp = Current
				end
			end
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		local
			a_min_width: INTEGER
		do
			update_parent_size
			a_min_width := minimum_width
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (a_min_width)
		end

	update_parent_size
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

	height: INTEGER
			-- Vertical size measured in pixels.
		local
			a_min_height: INTEGER
		do
			update_parent_size
			a_min_height := minimum_height
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (a_min_height)
		end

	update_request_size
			-- Force the requisition struct to be updated.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, default_pointer)
		end

	aux_info_struct: POINTER
			-- Pointer to the auxillary information struct used for retrieving when widget is unmapped
		do
			Result := {EV_GTK_EXTERNALS}.gtk_object_get_data (
				c_object,
				aux_info_string.item
			)
		end

	show
			-- Request that `Current' be displayed when its parent is.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
		end

feature -- Status report

	screen_x: INTEGER
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

	screen_y: INTEGER
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

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := has_struct_flag (c_object, {EV_GTK_EXTERNALS}.GTK_VISIBLE_ENUM)
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
		do
			Result := has_struct_flag (c_object, {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM)
		end

feature {EV_ANY_I} -- Implementation

	top_level_window_imp: EV_WINDOW_IMP
			-- Window implementation that `Current' is contained within (if any)
		local
			wind_ptr: POINTER
		do
			wind_ptr := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
			if wind_ptr /= NULL then
				Result ?= eif_object_from_c (wind_ptr)
			end
		end

	top_level_window: EV_WINDOW
			-- Window the current is contained within (if any)
		local
			a_window_imp: EV_WINDOW_IMP
		do
			a_window_imp := top_level_window_imp
			if a_window_imp /= Void then
				Result := a_window_imp.interface
			end
		end

feature {NONE} -- Implementation

	aux_info_string: EV_GTK_C_STRING
			-- String optimization for  "gtk-aux-info"
		once
			Result := "gtk-aux-info"
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




end -- class EV_GTK_WIDGET_IMP
