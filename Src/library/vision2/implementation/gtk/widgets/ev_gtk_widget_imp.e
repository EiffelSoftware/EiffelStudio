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

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN; call_application_events: BOOLEAN) is
			-- Used for key event actions sequences, redefined by descendants
		do

		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	Gdk_events_mask: INTEGER is
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

feature {NONE} -- Implementation

	initialize is
			-- Initialize `c_object'
		do
			{EV_GTK_EXTERNALS}.gtk_widget_add_events (visual_widget, gdk_events_mask)
			if {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
				{EV_GTK_EXTERNALS}.gtk_widget_realize (c_object)
			else
				{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			end
			set_is_initialized (True)
		end

feature {EV_ANY_I, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Position retrieval

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

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- Widget implementation at current mouse pointer position (if any)
		do
			Result ?= app_implementation.gtk_widget_imp_at_pointer_position
		end

	width_request_string: EV_GTK_C_STRING is
			-- Once string to pass to gtk.
		do
			Result := once "width-request"
		end

	height_request_string: EV_GTK_C_STRING is
			-- Once string to pass to gtk.
		do
			Result := once "height-request"
		end

	minimum_width, real_minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
			a_cs: EV_GTK_C_STRING
		do
			if not is_destroyed then
				a_cs := width_request_string
				{EV_GTK_EXTERNALS}.g_object_get_integer (c_object, a_cs.item, $Result)
				if Result = -1 then
					gr := reusable_requisition_struct.item
					{EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, gr)
					Result := {EV_GTK_EXTERNALS}.gtk_requisition_struct_width (gr)
				end
			end
		end

	reusable_requisition_struct: MANAGED_POINTER is
			-- Reusable GtkRequisition struct.
		once
			create Result.make ({EV_GTK_EXTERNALS}.c_gtk_requisition_struct_size)
		end

	minimum_height, real_minimum_height: INTEGER is
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
			a_cs: EV_GTK_C_STRING
		do
			if not is_destroyed then
				a_cs := height_request_string
				{EV_GTK_EXTERNALS}.g_object_get_integer (c_object, a_cs.item, $Result)
				if Result = -1 then
					gr := reusable_requisition_struct.item
					{EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, gr)
					Result := {EV_GTK_EXTERNALS}.gtk_requisition_struct_height (gr)
				end
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

	set_pointer_style (a_pointer: EV_POINTER_STYLE) is
			-- Assign `a_pointer' to `pointer_style'.
		do
			if a_pointer /= pointer_style then
				pointer_style := a_pointer
				internal_set_pointer_style (a_pointer)
			end
		end

	internal_set_pointer_style (a_cursor: EV_POINTER_STYLE) is
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_ptr: POINTER
			a_window: POINTER
			a_cursor_imp: EV_POINTER_STYLE_IMP
		do
			a_cursor_imp ?= a_cursor.implementation
			a_cursor_ptr := a_cursor_imp.gdk_cursor_from_pointer_style
			a_window := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget)
			if a_window /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_window_set_cursor (a_window, a_cursor_ptr)
			end
		end

	pointer_style: EV_POINTER_STYLE
			-- Cursor displayed when the pointer is over this widget.
			-- Position retrieval.

	set_focus is
			-- Grab keyboard focus.
		do
			if not has_focus then
				internal_set_focus
			end
		end

	internal_set_focus is
			-- Grab keyboard focus.
		local
			l_window, l_widget: POINTER
		do
				-- If any previous widget has the capture then disable it.
			if app_implementation.captured_widget /= Void then
				app_implementation.captured_widget.disable_capture
			end
			if {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
				l_window := c_object
--					l_widget := default_pointer -- This will unset any previous focused widget.
			else
				l_window := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
				l_widget := visual_widget
			end
			{EV_GTK_EXTERNALS}.gtk_window_set_focus (l_window, l_widget)
			{EV_GTK_EXTERNALS}.gtk_window_present (l_window)
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		local
			l_window, l_widget: POINTER
			l_widget_imp: EV_WIDGET_IMP
		do
			l_window := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
				-- This will return `c_object' if not toplevel window is found in hierarchy.
			if l_window /= default_pointer and then {EV_GTK_EXTERNALS}.gtk_widget_toplevel (l_window) and then {EV_GTK_EXTERNALS}.gtk_window_has_toplevel_focus (l_window) then
				l_widget := {EV_GTK_EXTERNALS}.gtk_window_get_focus (l_window)
				if l_widget /= default_pointer then
					l_widget_imp ?= app_implementation.eif_object_from_gtk_object (l_widget)
					Result := l_widget_imp = Current
				end
			end
		end

	width: INTEGER is
			-- Horizontal size measured in pixels.
		local
			l_minimum_width: like real_minimum_width
			l_allocated_width: INTEGER
		do
			l_minimum_width := real_minimum_width
			l_allocated_width := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			if is_displayed and then {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object) /= default_pointer and then l_allocated_width < l_minimum_width then
				{EV_GTK_EXTERNALS}.gtk_container_check_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object))
				l_allocated_width := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			end
			Result := l_minimum_width.max (l_allocated_width)
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		local
			l_minimum_height: like real_minimum_height
			l_allocated_height: INTEGER
		do
			l_minimum_height := real_minimum_height
			l_allocated_height := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			if is_displayed and then {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object) /= default_pointer and then l_allocated_height < l_minimum_height then
				{EV_GTK_EXTERNALS}.gtk_container_check_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object))
				l_allocated_height := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			end
			Result := l_minimum_height.max (l_allocated_height)
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

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_object_struct_flags (c_object) & {EV_GTK_EXTERNALS}.GTK_VISIBLE_ENUM = {EV_GTK_EXTERNALS}.GTK_VISIBLE_ENUM
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
		local
			l_win: EV_WINDOW_IMP
		do
			Result := {EV_GTK_EXTERNALS}.gtk_object_struct_flags (c_object) & {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM = {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM
				-- If Current is shown, let's check that it's top parent window is shown too.
			if Result then
				l_win := top_level_window_imp
				if l_win /= Void then
					Result := {EV_GTK_EXTERNALS}.gtk_object_struct_flags (l_win.c_object) & {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM = {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	top_level_window_imp: EV_WINDOW_IMP is
			-- Window implementation that `Current' is contained within (if any)
		local
			wind_ptr: POINTER
		do
			wind_ptr := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
			if wind_ptr /= NULL then
				Result ?= eif_object_from_c (wind_ptr)
			end
		end

	top_level_window: EV_WINDOW is
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
