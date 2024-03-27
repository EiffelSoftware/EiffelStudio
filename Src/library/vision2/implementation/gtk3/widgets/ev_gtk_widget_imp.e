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
				{GDK}.GDK_EXPOSURE_MASK_ENUM
				| {GDK}.GDK_POINTER_MOTION_MASK_ENUM
				| {GDK}.GDK_BUTTON_PRESS_MASK_ENUM
				| {GDK}.GDK_BUTTON_RELEASE_MASK_ENUM
				| {GDK}.GDK_KEY_PRESS_MASK_ENUM
				| {GDK}.GDK_KEY_RELEASE_MASK_ENUM
				| {GDK}.GDK_ENTER_NOTIFY_MASK_ENUM
				| {GDK}.GDK_LEAVE_NOTIFY_MASK_ENUM
				| {GDK}.GDK_FOCUS_CHANGE_MASK_ENUM
				| {GDK}.GDK_VISIBILITY_NOTIFY_MASK_ENUM
				| {GDK}.GDK_POINTER_MOTION_HINT_MASK_ENUM
				| {GDK}.GDK_SCROLL_MASK_ENUM
				| {GDK}.GDK_STRUCTURE_MASK_ENUM
		end

feature {NONE} -- Implementation

	make
			-- Initialize `c_object'.
		local
			l_visual_widget, l_c_object: POINTER
		do
			l_visual_widget := visual_widget
			l_c_object := c_object
			{GTK}.gtk_widget_add_events (l_visual_widget, gdk_events_mask)
			if l_visual_widget /= l_c_object then
				{GTK}.gtk_widget_add_events (l_c_object, gdk_events_mask)
			end
			if {GTK}.gtk_is_window (l_c_object) then
				{GTK}.gtk_widget_realize (l_c_object)
			else
				{GTK}.gtk_widget_show (l_c_object)
			end
			set_is_initialized (True)
		end

feature {EV_ANY_I, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Position retrieval

	screen_x: INTEGER
			-- Horizontal position of the client area on screen,
		local
			a_x: INTEGER
			i: INTEGER
			l_null: POINTER
		do
			if is_displayed then
					i := {GDK}.gdk_window_get_origin (
						{GTK}.gtk_widget_get_window (visual_widget),
				    	$a_x, l_null)
					Result := a_x
			end
			Result := Result + app_implementation.screen_virtual_x
		end

	screen_y: INTEGER
			-- Vertical position of the client area on screen,
		local
			a_y: INTEGER
			i: INTEGER
			l_null: POINTER
		do
			if is_displayed then
					i := {GDK}.gdk_window_get_origin (
						{GTK}.gtk_widget_get_window (visual_widget),
				    	l_null, $a_y)
					Result := a_y
			end
			Result := Result + app_implementation.screen_virtual_y
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		local
			l_alloc: POINTER
		do
			l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
			{GTK}.gtk_widget_get_allocation (c_object, l_alloc)
			Result := {GTK}.gtk_allocation_struct_x (l_alloc)
			l_alloc.memory_free
			Result := Result.max (0)
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		local
			l_alloc: POINTER
		do
			l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
			{GTK}.gtk_widget_get_allocation (c_object, l_alloc)
			Result := {GTK}.gtk_allocation_struct_y (l_alloc)
			l_alloc.memory_free
			Result := Result.max (0)
		end

	widget_imp_at_pointer_position: detachable EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		do
			Result ?= app_implementation.gtk_widget_imp_at_pointer_position
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation: size		

	minimum_width: INTEGER
		do
			Result := real_minimum_width
		end

	minimum_height: INTEGER
		do
			Result := real_minimum_height
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation: size				

	real_minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		local
			pw: INTEGER
		do
			if not is_destroyed then
				Result := width_request
				pw := preferred_minimum_width
				if pw > Result then
					Result := pw
				end
				if Result < 0 then
					Result := 0
				end
			end
		end

	real_minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		local
			ph: INTEGER
		do
			if not is_destroyed then
				Result := height_request
				ph := preferred_minimum_height
				if ph > Result then
					Result := ph
				end
				if Result < 0 then
					Result := 0
				end
			end
		end

	width_request: INTEGER
			-- Requested width of `Current' from gtk.
		do
			{GTK2}.gtk_widget_get_size_request (c_object, $Result, default_pointer)
		end

	height_request: INTEGER
			-- Requested height of `Current' from gtk.
		do
			{GTK2}.gtk_widget_get_size_request (c_object, default_pointer, $Result)
		end

	preferred_minimum_width: INTEGER
			-- Preferred width of `Current' from gtk.
		local
			p_min_width, p_natural_width: POINTER
		do
			p_min_width := reusable_requisition_struct.item
--			p_natural_width := reusable_requisition_struct.item
			{GTK}.gtk_widget_get_preferred_size (c_object, p_min_width, p_natural_width)
			Result := {GTK}.gtk_requisition_struct_width (p_min_width)
		end

	preferred_minimum_height: INTEGER
			-- Preferred height of `Current' from gtk.
		local
			p_min_height, p_natural_height: POINTER
		do
			p_min_height := reusable_requisition_struct.item
--			p_natural_height := reusable_requisition_struct.item
			{GTK}.gtk_widget_get_preferred_size (c_object, p_min_height, p_natural_height)
			Result := {GTK}.gtk_requisition_struct_height (p_min_height)
		end

	preferred_natural_width: INTEGER
			-- Preferred width of `Current' from gtk.
		local
			p_min_width, p_natural_width: POINTER
		do
--			p_min_width := reusable_requisition_struct.item
			p_natural_width := reusable_requisition_struct.item
			{GTK}.gtk_widget_get_preferred_size (c_object, p_min_width, p_natural_width)
			Result := {GTK}.gtk_requisition_struct_width (p_natural_width)
		end

	preferred_natural_height: INTEGER
			-- Preferred height of `Current' from gtk.
		local
			p_min_height, p_natural_height: POINTER
		do
--			p_min_height := reusable_requisition_struct.item
			p_natural_height := reusable_requisition_struct.item
			{GTK}.gtk_widget_get_preferred_size (c_object, p_min_height, p_natural_height)
			Result := {GTK}.gtk_requisition_struct_height (p_natural_height)
		end

feature {NONE} -- Implementation: size

	reusable_requisition_struct: MANAGED_POINTER
			-- Reusable GtkRequisition struct.
		once
			create Result.make ({GTK}.c_gtk_requisition_struct_size)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	event_widget: POINTER
			-- Pointer to the widget handling the widget events
		local
			a_visual_widget: POINTER
		do
			a_visual_widget := visual_widget
			if not {GTK}.gtk_widget_get_has_window (a_visual_widget) then
				Result := a_visual_widget
			else
				Result := c_object
			end
		end

	set_pointer_style (a_pointer: EV_POINTER_STYLE)
			-- Assign `a_pointer' to `pointer_style'.
		do
			if a_pointer /= pointer_style then
				if is_displayed then
					internal_set_pointer_style (a_pointer)
						-- `internal_set_pointer_style' will get called in `on_widget_mapped'				
				end
				pointer_style := a_pointer
			end
		end

	internal_set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_ptr: POINTER
			a_window: POINTER
		do
			if a_cursor /= previously_set_pointer_style then
				check attached {EV_POINTER_STYLE_IMP} a_cursor.implementation as a_cursor_imp then
					a_window := {GTK}.gtk_widget_get_window (c_object)
					if not a_window.is_default_pointer then
						a_cursor_ptr := a_cursor_imp.gdk_cursor_from_pointer_style
						{GDK}.gdk_window_set_cursor (a_window, a_cursor_ptr)
						{GOBJECT}.g_object_unref (a_cursor_ptr)
						previously_set_pointer_style := a_cursor
					end
				end
			end
		end

	previously_set_pointer_style: detachable EV_POINTER_STYLE
			-- Previously set pointer style, separate from `pointer_style' to incorporate Pick and Drop handling.

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
			if {GTK}.gtk_is_window (c_object) then
				l_window := c_object
--					l_widget := default_pointer -- This will unset any previous focused widget.
			else
				l_window := {GTK}.gtk_widget_get_toplevel (c_object)
				l_widget := visual_widget
				if not {GTK}.gtk_widget_get_can_focus (l_widget) then
					l_widget := default_pointer
				end
			end
			{GTK}.gtk_window_set_focus (l_window, l_widget)
			if l_widget /= default_pointer and then not {GTK}.gtk_widget_is_focus (l_widget) then
				{GTK}.gtk_widget_grab_focus (l_widget)
			end
		end

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do
			Result := has_focus_internal (True)
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		local
			l_minimum_width: like real_minimum_width
			l_allocated_width: INTEGER
			l_alloc: POINTER
		do
			l_minimum_width := real_minimum_width
			if is_show_requested or not {GTK}.gtk_is_window (c_object) then
				l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
				{GTK}.gtk_widget_get_allocation (c_object, l_alloc)
				l_allocated_width := {GTK}.gtk_allocation_struct_width (l_alloc)
				if {GTK}.gtk_widget_get_parent (c_object) /= default_pointer and then l_allocated_width < l_minimum_width then
					{GTK}.gtk_widget_get_allocation (c_object, l_alloc)
					l_allocated_width := {GTK}.gtk_allocation_struct_width (l_alloc)
				end
				l_alloc.memory_free
			end
			Result := l_minimum_width.max (l_allocated_width)
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		local
			l_minimum_height: like real_minimum_height
			l_allocated_height: INTEGER
			l_alloc: POINTER
		do
			l_minimum_height := real_minimum_height
			if is_show_requested or not {GTK}.gtk_is_window (c_object) then
					-- Temporarily allocate a GtkAllocation struct.
				l_alloc := l_alloc.memory_alloc ({GTK}.c_gtk_allocation_struct_size)
				{GTK}.gtk_widget_get_allocation (c_object, l_alloc)
				l_allocated_height := {GTK}.gtk_allocation_struct_height (l_alloc)
				if {GTK}.gtk_widget_get_parent (c_object) /= default_pointer and then l_allocated_height < l_minimum_height then
					{GTK}.gtk_widget_get_allocation (c_object, l_alloc)
					l_allocated_height := {GTK}.gtk_allocation_struct_height (l_alloc)
				end
				l_alloc.memory_free
			end
			Result := l_minimum_height.max (l_allocated_height)
		end

	aux_info_struct: POINTER
			-- Pointer to the auxillary information struct used for retrieving when widget is unmapped
		do
			Result := {GTK}.g_object_get_data (
				c_object,
				aux_info_string.item
			)
		end

	show
			-- Request that `Current' be displayed when its parent is.
		do
			{GTK}.gtk_widget_show (c_object)
		end

feature -- Status report

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := {GTK}.gtk_widget_get_visible (c_object)
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
		local
			l_win: detachable EV_WINDOW_IMP
		do
			Result := c_object /= default_pointer and then {GTK2}.gtk_widget_get_mapped (c_object)
				-- If Current is shown, let's check that it's top parent window is shown too.
			if Result then
				l_win := top_level_window_imp
				if l_win /= Void then
					Result := {GTK2}.gtk_widget_get_mapped (l_win.c_object)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	top_level_gtk_window_imp: detachable EV_GTK_WINDOW_IMP
			-- Window implementation that `Current' is contained within (if any)
		local
			wind_ptr: POINTER
		do
			wind_ptr := {GTK}.gtk_widget_get_toplevel (c_object)
			if not wind_ptr.is_default_pointer then
				Result := {EV_GTK_WINDOW_IMP} / eif_object_from_c (wind_ptr)
			end
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Window implementation that `Current' is contained within (if any)
		do
			Result := {EV_WINDOW_IMP} / top_level_gtk_window_imp
		end

	top_level_window: detachable EV_WINDOW
			-- Window the current is contained within (if any)
		do
			if attached {EV_WINDOW_IMP} top_level_gtk_window_imp as w then
				Result := w.interface
			end
		end

feature {NONE} -- Implementation

	has_focus_internal (a_toplevel_window_active: BOOLEAN): BOOLEAN
			-- Does widget have the keyboard focus?
			-- If `a_toplevel_window_active' only return True if `Current' has top-level window focus
			-- and the top level window is also active.
		local
			l_window, l_widget: POINTER
			l_widget_imp: detachable EV_WIDGET_IMP
		do
			l_window := {GTK}.gtk_widget_get_toplevel (c_object)
				-- This will return `c_object' if not toplevel window is found in hierarchy.
			if l_window /= default_pointer and then {GTK2}.gtk_widget_is_toplevel (l_window) and then (a_toplevel_window_active implies {GTK2}.gtk_window_is_active (l_window)) then
				l_widget := {GTK2}.gtk_window_get_focus (l_window)
				if l_widget /= default_pointer then
					l_widget_imp ?= app_implementation.eif_object_from_gtk_object (l_widget)
					if l_widget_imp /= Void then
						Result := l_widget_imp = Current
					end
				end
			end
		end

	aux_info_string: EV_GTK_C_STRING
			-- String optimization for  "gtk-aux-info"
		once
			Result := "gtk-aux-info"
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_WIDGET_IMP
