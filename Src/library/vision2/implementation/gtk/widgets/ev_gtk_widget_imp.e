indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GTK_WIDGET_IMP

inherit
	EV_ANY_IMP

feature {NONE} -- Agent functions.

	key_event_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for key events
		once
			Result := agent (App_implementation.gtk_marshal).key_event_translate
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
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
			{EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_HINT_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_BUTTON_RELEASE_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_KEY_PRESS_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_KEY_RELEASE_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_ENTER_NOTIFY_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_LEAVE_NOTIFY_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_FOCUS_CHANGE_MASK_ENUM |
			{EV_GTK_EXTERNALS}.GDK_VISIBILITY_NOTIFY_MASK_ENUM
		end

	initialize_events is
			-- Initialize gtk events of `c_object'
		do
			if needs_event_box then
				{EV_GTK_EXTERNALS}.gtk_widget_set_events (c_object, gdk_events_mask)
			elseif not {EV_GTK_EXTERNALS}.gtk_widget_no_window (visual_widget) then
				{EV_GTK_EXTERNALS}.gtk_widget_add_events (visual_widget, gdk_events_mask)
			end
		end

	initialize is
			-- Initialize `c_object'
		do
			initialize_events
			if is_parentable then
				{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			else
				{EV_GTK_EXTERNALS}.gtk_widget_realize (c_object)
			end
			is_initialized := True
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

	gtk_widget_imp_at_pointer_position: EV_GTK_WIDGET_IMP is
			-- Gtk Widget implementation at current mouse pointer position (if any)
		local
			a_x, a_y: INTEGER
			gdkwin, gtkwid: POINTER
		do
			gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= null then
				from
					{EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $gtkwid)
				until
					Result /= Void or else gtkwid = null
				loop
					Result ?= eif_object_from_c (gtkwid)
					gtkwid := {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (gtkwid)
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
			pointer_style := a_cursor.twin
			internal_set_pointer_style (a_cursor)
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
			{EV_GTK_EXTERNALS}.gdk_cursor_destroy (a_cursor_ptr)
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
			-- Position retrieval

	has_struct_flag (a_gtk_object: POINTER; a_flag: INTEGER): BOOLEAN is
			-- Has this widget the flag `a_flag' in struct_flags?
			-- (export status {NONE})
		do
			Result := {EV_GTK_EXTERNALS}.gtk_object_struct_flags (a_gtk_object) & (a_flag) /= 0
		end

	gtk_widget_has_focus (a_c_object: POINTER): BOOLEAN is
			-- Does `a_c_object' have the focus.
		do
			if a_c_object /= null then
				Result := has_struct_flag (a_c_object, {EV_GTK_EXTERNALS}.gtk_has_focus_enum)
				check
					Result = (((({EV_GTK_EXTERNALS}.gtk_object_struct_flags (a_c_object) // {EV_GTK_EXTERNALS}.gtk_has_focus_enum) \\ 2)) = 1)
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
			if {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object) /= default_pointer then
				{EV_GTK_EXTERNALS}.gtk_container_check_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object))
			else
				update_request_size
			end
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_width ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (minimum_width)
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		do
			if {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object) /= default_pointer then
				{EV_GTK_EXTERNALS}.gtk_container_check_resize ({EV_GTK_EXTERNALS}.gtk_widget_struct_parent (c_object))
			else
				update_request_size
			end
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_height ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)).max (minimum_height)
		end

	update_request_size is
			-- Force the requisition struct to be updated.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object))
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

feature {NONE} -- Implementation

	aux_info_string: EV_GTK_C_STRING is
			-- String optimization for  "gtk-aux-info"
		once
			Result := "gtk-aux-info"
		end

end -- class EV_GTK_WIDGET_IMP
