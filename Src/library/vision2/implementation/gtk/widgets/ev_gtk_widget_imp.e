indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GTK_WIDGET_IMP

inherit
	EV_ANY_IMP

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES}  -- Implementation

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		deferred
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
			Result := feature {EV_GTK_EXTERNALS}.GDK_EXPOSURE_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_BUTTON_RELEASE_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_KEY_PRESS_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_KEY_RELEASE_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_ENTER_NOTIFY_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_LEAVE_NOTIFY_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_FOCUS_CHANGE_MASK_ENUM |
			feature {EV_GTK_EXTERNALS}.GDK_VISIBILITY_NOTIFY_MASK_ENUM
		end

	initialize_events is
			-- Initialize gtk events of `c_object'
		do
			if needs_event_box then
				feature {EV_GTK_EXTERNALS}.gtk_widget_set_events (c_object, gdk_events_mask)
			end
			if not feature {EV_GTK_EXTERNALS}.gtk_widget_no_window (visual_widget) then
				feature {EV_GTK_EXTERNALS}.gtk_widget_add_events (visual_widget, gdk_events_mask)
			end
		end

	initialize is
			-- Initialize `c_object'
		do
			initialize_events
			if is_parentable then
				feature {EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			else
				feature {EV_GTK_EXTERNALS}.gtk_widget_realize (c_object)
			end
			is_initialized := True
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	connect_button_press_switch is
			-- Connect `button_press_switch' to its event sources.
		do
			if not button_press_switch_is_connected then
				real_signal_connect (event_widget, "button-press-event", agent (app_implementation.gtk_marshal).button_press_switch_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?), app_implementation.default_translate)
				button_press_switch_is_connected := True
			end
		end

	button_press_switch_is_connected: BOOLEAN
			-- Is `button_press_switch' connected to its event source.

feature {EV_ANY_I} -- Implementation

	minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
		do	
			if not is_destroyed then
				update_request_size
				gr := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object)
				Result := feature {EV_GTK_EXTERNALS}.gtk_requisition_struct_width (gr)
			end
		end
		
	minimum_height: INTEGER is
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
		do
			if not is_destroyed then
				update_request_size
				gr := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object)
				Result := feature {EV_GTK_EXTERNALS}.gtk_requisition_struct_height (gr)
			end
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			Result := parent_imp /= Void
		end

	parent_imp: EV_ANY_IMP is
			-- Parent of `Current'
		deferred
		end

	event_widget: POINTER is
			-- Pointer to the widget handling the widget events
		local
			a_visual_widget: POINTER
		do
			a_visual_widget := visual_widget
			if not feature {EV_GTK_EXTERNALS}.gtk_widget_no_window (a_visual_widget) then
				Result := a_visual_widget
			else
				Result := c_object
			end
		end

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- Widget implementation at current mouse pointer position (if any)
		local
			a_x, a_y: INTEGER
			gdkwin, gtkwid: POINTER
		do
			gdkwin := feature {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= null then
				from
					feature {EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $gtkwid)
				until
					Result /= Void or else gtkwid = null
				loop
					Result ?= eif_object_from_c (gtkwid)
					gtkwid := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (gtkwid)
				end
			end
			if Result /= Void and then Result.is_destroyed then
				Result := Void
			end
		end

	enable_capture is
			-- Grab all the mouse and keyboard events.
		local
			i: INTEGER
		do
			if not has_capture then
				App_implementation.disable_debugger
				set_focus
				feature {EV_GTK_EXTERNALS}.gtk_grab_add (event_widget)
				i := feature {EV_GTK_EXTERNALS}.gdk_pointer_grab (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget), 1, feature {EV_GTK_EXTERNALS}.gdk_button_release_mask_enum + feature {EV_GTK_EXTERNALS}.gdk_button_press_mask_enum + feature {EV_GTK_EXTERNALS}.gdk_pointer_motion_mask_enum, null, null, 0)
				i := feature {EV_GTK_EXTERNALS}.gdk_keyboard_grab (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget), True, 0)
			end
		end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			feature {EV_GTK_EXTERNALS}.gtk_grab_remove (event_widget)
			feature {EV_GTK_EXTERNALS}.gdk_pointer_ungrab (
				0 -- guint32 time
			)
			feature {EV_GTK_EXTERNALS}.gdk_keyboard_ungrab (0) -- guint32 time
			App_implementation.enable_debugger				
		end

	has_capture: BOOLEAN is
			-- Does Current have the keyboard and mouse event capture?
		do
			Result := has_struct_flag (event_widget, feature {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM)
		end

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		do
			pointer_style := a_cursor.twin
			internal_set_pointer_style (a_cursor)
		end

	set_focus is
			-- Grab keyboard focus.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_grab_focus (visual_widget)
		end

	internal_set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_ptr: POINTER
		do
			a_cursor_ptr := app_implementation.gdk_cursor_from_pixmap (a_cursor)
			set_composite_widget_pointer_style (a_cursor_ptr)
			feature {EV_GTK_EXTERNALS}.gdk_cursor_destroy (a_cursor_ptr)
		end

	set_composite_widget_pointer_style (a_cursor_ptr: POINTER) is
			-- Used to set the gdkcursor for composite widgets.
		do
			feature {EV_GTK_EXTERNALS}.gdk_window_set_cursor (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget), a_cursor_ptr)
			feature {EV_GTK_EXTERNALS}.gdk_window_set_cursor (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_cursor_ptr)
		end

	pointer_style: EV_CURSOR
			-- Cursor displayed when the pointer is over this widget.
			-- Position retrieval

	has_struct_flag (a_gtk_object: POINTER; a_flag: INTEGER): BOOLEAN is
			-- Has this widget the flag `a_flag' in struct_flags?
			-- (export status {NONE})
		do
			if a_gtk_object /= null then
				Result := (((feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (a_gtk_object) // a_flag) \\ 2)) = 1
			end
		end

	gtk_widget_has_focus (a_c_object: POINTER): BOOLEAN is
			-- Does `a_c_object' have the focus.
		do
			if a_c_object /= null then
				Result := has_struct_flag (a_c_object, feature {EV_GTK_EXTERNALS}.gtk_has_focus_enum)
				check
					Result = ((((feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (a_c_object) // feature {EV_GTK_EXTERNALS}.gtk_has_focus_enum) \\ 2)) = 1)
				end
			end
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := gtk_widget_has_focus (visual_widget)
		end

	width: INTEGER is
			-- Horizontal size measured in pixels.
		do
			if parent_imp /= Void then
				feature {EV_GTK_EXTERNALS}.gtk_container_check_resize (parent_imp.c_object)
			else
				update_request_size
			end
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_width (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (minimum_width)
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		do
			if parent_imp /= Void then
				feature {EV_GTK_EXTERNALS}.gtk_container_check_resize (parent_imp.c_object)
			else
				update_request_size
			end
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_height (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (minimum_height)
		end

	update_request_size is
			-- Force the requisition struct to be updated.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, feature {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object))
		end

end -- class EV_GTK_WIDGET_IMP
