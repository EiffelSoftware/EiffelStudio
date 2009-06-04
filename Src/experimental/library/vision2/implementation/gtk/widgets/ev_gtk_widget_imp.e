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

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

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

feature {NONE} -- Implementation

	make
			-- Initialize `c_object'.
		local
			l_visual_widget, l_c_object: POINTER
		do
			l_visual_widget := visual_widget
			l_c_object := c_object
			{EV_GTK_EXTERNALS}.gtk_widget_add_events (l_visual_widget, gdk_events_mask)
			if l_visual_widget /= l_c_object then
				{EV_GTK_EXTERNALS}.gtk_widget_add_events (l_c_object, gdk_events_mask)
			end
			if {EV_GTK_EXTERNALS}.gtk_is_window (l_c_object) then
				{EV_GTK_EXTERNALS}.gtk_widget_realize (l_c_object)
			else
				{EV_GTK_EXTERNALS}.gtk_widget_show (l_c_object)
			end
			set_is_initialized (True)
		end

feature {EV_ANY_I, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Position retrieval

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

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		local
			a_aux_info, l_null: POINTER
			tmp_struct_x: INTEGER
		do
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_x ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			a_aux_info := aux_info_struct
			if a_aux_info /= l_null then
				tmp_struct_x := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
				if tmp_struct_x >= 0 then
					Result := tmp_struct_x
				end
			end
			Result := Result.max (0)
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		local
			a_aux_info, l_null: POINTER
			tmp_struct_y: INTEGER
		do
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_y ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			a_aux_info := aux_info_struct
			if a_aux_info /= l_null then
				tmp_struct_y := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
				if tmp_struct_y >= 0 then
					Result := tmp_struct_y
				end
			end
			Result := Result.max (0)
		end

	widget_imp_at_pointer_position: detachable EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		do
			Result ?= app_implementation.gtk_widget_imp_at_pointer_position
		end

	width_request_string: EV_GTK_C_STRING
			-- Once string to pass to gtk.
		once
			Result := "width-request"
		end

	height_request_string: EV_GTK_C_STRING
			-- Once string to pass to gtk.
		once
			Result := "height-request"
		end

	minimum_width, real_minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
		do
			if not is_destroyed then
				{EV_GTK_EXTERNALS}.g_object_get_integer (c_object, width_request_string.item, $Result)
				if Result = -1 then
					gr := reusable_requisition_struct.item
					{EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, gr)
					Result := {EV_GTK_EXTERNALS}.gtk_requisition_struct_width (gr)
				end
			end
		end

	reusable_requisition_struct: MANAGED_POINTER
			-- Reusable GtkRequisition struct.
		once
			create Result.make ({EV_GTK_EXTERNALS}.c_gtk_requisition_struct_size)
		end

	minimum_height, real_minimum_height: INTEGER
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
		do
			if not is_destroyed then
				{EV_GTK_EXTERNALS}.g_object_get_integer (c_object, height_request_string.item, $Result)
				if Result = -1 then
					gr := reusable_requisition_struct.item
					{EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, gr)
					Result := {EV_GTK_EXTERNALS}.gtk_requisition_struct_height (gr)
				end
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

	set_pointer_style (a_pointer: EV_POINTER_STYLE)
			-- Assign `a_pointer' to `pointer_style'.
		do
			if a_pointer /= pointer_style then
				pointer_style := a_pointer
				if is_displayed or else previous_gdk_cursor /= default_pointer then
					internal_set_pointer_style (a_pointer)
						-- `internal_set_pointer_style' will get called in `on_widget_mapped'				
				end
			end
		end

	internal_set_pointer_style (a_cursor: detachable EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_ptr: POINTER
			a_window: POINTER
			a_cursor_imp: detachable EV_POINTER_STYLE_IMP
		do
			if a_cursor /= Void then
				a_cursor_imp ?= a_cursor.implementation
				check a_cursor_imp /= Void end
				a_cursor_ptr := a_cursor_imp.gdk_cursor_from_pointer_style
			end
			a_window := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object)
			if a_window /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_window_set_cursor (a_window, a_cursor_ptr)
			end
			if previous_gdk_cursor /= default_pointer then
				{EV_GTK_EXTERNALS}.gdk_cursor_destroy (previous_gdk_cursor)
			end
			previous_gdk_cursor := a_cursor_ptr
		end

	previous_gdk_cursor: POINTER
			-- Pointer to the previously create GdkCursor.

	pointer_style: detachable EV_POINTER_STYLE
			-- Cursor displayed when the pointer is over this widget.
			-- Position retrieval.

	set_focus
			-- Grab keyboard focus.
		do
			if not has_focus then
				internal_set_focus
			end
		end

	internal_set_focus
			-- Grab keyboard focus.
		local
			l_window, l_widget: POINTER
			l_interface: EV_ANY
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
				-- If any previous widget has the capture then disable it.
				-- If a Pick and Drop is occurring we leave the capture as is.
			if attached l_app_imp.captured_widget as l_captured_widget and then not l_app_imp.is_in_transport then
				l_interface := attached_interface
				if l_interface /= l_captured_widget then
					l_captured_widget.disable_capture
				end
			end
			if {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
				l_window := c_object
--					l_widget := default_pointer -- This will unset any previous focused widget.
			else
				l_window := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
				l_widget := visual_widget
				if {EV_GTK_EXTERNALS}.gtk_object_struct_flags (l_widget) & {EV_GTK_EXTERNALS}.gtk_can_focus_enum /= {EV_GTK_EXTERNALS}.gtk_can_focus_enum then
					l_widget := default_pointer
				end
			end
			{EV_GTK_EXTERNALS}.gtk_window_set_focus (l_window, l_widget)
		end

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		local
			l_window, l_widget: POINTER
			l_widget_imp: detachable EV_WIDGET_IMP
		do
			l_window := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
				-- This will return `c_object' if not toplevel window is found in hierarchy.
			if l_window /= default_pointer and then {EV_GTK_EXTERNALS}.gtk_widget_toplevel (l_window) and then {EV_GTK_EXTERNALS}.gtk_window_is_active (l_window) then
				l_widget := {EV_GTK_EXTERNALS}.gtk_window_get_focus (l_window)
				if l_widget /= default_pointer then
					l_widget_imp ?= app_implementation.eif_object_from_gtk_object (l_widget)
					if l_widget_imp /= Void then
						Result := l_widget_imp = Current
					end
				end
			end
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		local
			l_minimum_width: like real_minimum_width
			l_allocated_width: INTEGER
		do
			l_minimum_width := real_minimum_width
			if is_show_requested or not {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
				l_allocated_width := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
				if is_displayed and then {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object) /= default_pointer and then l_allocated_width < l_minimum_width then
					{EV_GTK_EXTERNALS}.gtk_container_check_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object))
					l_allocated_width := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
				end
			end
			Result := l_minimum_width.max (l_allocated_width)
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		local
			l_minimum_height: like real_minimum_height
			l_allocated_height: INTEGER
		do
			l_minimum_height := real_minimum_height
			if is_show_requested or not {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
				l_allocated_height := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
				if is_displayed and then {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object) /= default_pointer and then l_allocated_height < l_minimum_height then
					{EV_GTK_EXTERNALS}.gtk_container_check_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object))
					l_allocated_height := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
				end
			end
			Result := l_minimum_height.max (l_allocated_height)
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

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_object_struct_flags (c_object) & {EV_GTK_EXTERNALS}.GTK_VISIBLE_ENUM = {EV_GTK_EXTERNALS}.GTK_VISIBLE_ENUM
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
		local
			l_win: detachable EV_WINDOW_IMP
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

	top_level_gtk_window_imp: detachable EV_GTK_WINDOW_IMP
			-- Window implementation that `Current' is contained within (if any)
		local
			wind_ptr: POINTER
		do
			wind_ptr := {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
			if wind_ptr /= NULL then
				Result ?= eif_object_from_c (wind_ptr)
			end
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Window implementation that `Current' is contained within (if any)
		do
			Result ?= top_level_gtk_window_imp
		end

	top_level_window: detachable EV_WINDOW
			-- Window the current is contained within (if any)
		local
			a_window_imp: detachable EV_WINDOW_IMP
		do
			a_window_imp ?= top_level_gtk_window_imp
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
