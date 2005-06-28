indexing
	description:
		"Eiffel Vision widget. GTK implementation.%N%
		%See ev_widget.e"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WIDGET_IMP 
        
inherit
	EV_WIDGET_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface,
			initialize,
			button_press_switch,
			destroy,
			minimum_width,
			minimum_height,
			enable_capture,
			disable_capture,
			on_key_event
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_COLORIZABLE_IMP
		redefine
			interface
		end

	EV_WIDGET_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} 
				focus_in_actions_internal,
				focus_out_actions_internal,
				pointer_motion_actions_internal,
				pointer_button_release_actions,
				pointer_leave_actions,
				pointer_leave_actions_internal,
				pointer_enter_actions_internal
		redefine
			interface
		end
		
	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	initialize is
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
			-- Connect action sequences to GTK signals.
		local
			connect_button_press_switch_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE[]]
			on_key_event_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
			a_event_widget: POINTER
			a_c_object: POINTER
			app_imp: like app_implementation
		do
			Precursor {EV_PICK_AND_DROPABLE_IMP}
			app_imp := app_implementation
			a_event_widget := event_widget
			a_c_object := c_object
			
				-- Reset the initial internal sizes, once set they should not be reset to -1
			internal_minimum_width := -1
			internal_minimum_height := -1
	
			on_key_event_intermediary_agent := agent (app_imp.gtk_marshal).on_key_event_intermediary (a_c_object, ?, ?, ?)
			real_signal_connect (a_event_widget, app_imp.key_press_event_string, on_key_event_intermediary_agent, key_event_translate_agent)
			real_signal_connect (a_event_widget, app_imp.key_release_event_string, on_key_event_intermediary_agent, key_event_translate_agent)
				--| "button-press-event" is a special case, see below.
				
			real_signal_connect_after (a_event_widget, app_imp.focus_in_event_string, agent (App_imp.gtk_marshal).widget_focus_in_intermediary (a_c_object), Void)
			real_signal_connect_after  (a_event_widget, app_imp.focus_out_event_string, agent (App_imp.gtk_marshal).widget_focus_out_intermediary (a_c_object), Void)
				
			connect_button_press_switch_agent := agent (App_imp.gtk_marshal).connect_button_press_switch_intermediary (a_c_object)
			pointer_button_press_actions.not_empty_actions.extend (connect_button_press_switch_agent)
			pointer_double_press_actions.not_empty_actions.extend (connect_button_press_switch_agent)
			if not pointer_button_press_actions.is_empty or not pointer_double_press_actions.is_empty then
				connect_button_press_switch
			end
			set_is_initialized (True)
		end
		
feature {EV_WINDOW_IMP, EV_INTERMEDIARY_ROUTINES, EV_ANY_I} -- Implementation

	on_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Used for pointer button release events
		do
			if a_button >= 1 and a_button <= 3 and then pointer_button_release_actions /= Void then
				pointer_button_release_actions.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		local
			temp_key_string: STRING
			a_capture_widget_imp: EV_WIDGET_IMP
		do
			if App_implementation.is_in_transport and then a_key_press and then a_key /= Void and then a_key.code = {EV_KEY_CONSTANTS}.Key_escape then
					-- If a PND is in action and the Esc key is pressed then cancel it
				if App_implementation.captured_widget /= Void then
						-- We are definitely in PND so we set a_capture_widget_imp for start_transport to be executed on it
					a_capture_widget_imp ?= App_implementation.captured_widget.implementation
				end
			end	
			if a_capture_widget_imp /= Void then
				a_capture_widget_imp.end_transport (0, 0, 0, 0, 0 ,0 ,0 ,0)
			elseif has_struct_flag (visual_widget, {EV_GTK_EXTERNALS}.gtk_has_focus_enum) or else has_struct_flag (event_widget, {EV_GTK_EXTERNALS}.gtk_has_grab_enum) then
					-- We make sure that only the widget with either the focus or the keyboard capture receives key events
				if a_key_press then
						-- The event is a key press event.
					if a_key /= Void and then key_press_actions_internal /= Void then
						key_press_actions_internal.call ([a_key])
					end
					if key_press_string_actions_internal /= Void then
						temp_key_string := a_key_string
						if a_key /= Void then
							if a_key.out.count /= 1 and not a_key.is_numpad then
									-- The key pressed is an action key, we only want
								inspect
									a_key.code
								when {EV_KEY_CONSTANTS}.Key_space then
									temp_key_string := once  " "
								when {EV_KEY_CONSTANTS}.Key_enter then
									temp_key_string := once "%N"
								when {EV_KEY_CONSTANTS}.Key_tab then
									temp_key_string := once "%T"
								else
										-- The action key pressed has no printable value
									temp_key_string := Void
								end
							end
						end
						if temp_key_string /= Void then
							key_press_string_actions_internal.call ([temp_key_string])
						end
					end
				else
						-- The event is a key release event.
					if a_key /= Void and then key_release_actions_internal /= Void then
						key_release_actions_internal.call ([a_key])
					end
				end
			end
		end

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER) is
			-- Gtk_Widget."size-allocate" happened.
		do
			if last_width /= a_width or else last_height /= a_height then
				last_width := a_width
				last_height := a_height
				if resize_actions_internal /= Void then
					resize_actions_internal.call (app_implementation.gtk_marshal.dimension_tuple (a_x, a_y, a_width, a_height))
				end
				if parent_imp /= Void then
					parent_imp.child_has_resized (Current)
				end
			end
		end
		
	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Called from focus intemediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			if a_has_focus then
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.call (Void)
				end
			else
				if focus_out_actions_internal /= Void then
					focus_out_actions_internal.call (Void)
				end
			end				
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
			--| GTK sends both GDK_BUTTON_PRESS and GDK_2BUTTON_PRESS events
			--| when a handler is attached to "button-press-event".
			--| We attach the signal to this switching feature to look at the
			--| event type and pass the event data to the appropriate action
			--| sequence.
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			mouse_wheel_delta: INTEGER
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
				-- Mouse Wheel implementation.
			if a_type = {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM then
				mouse_wheel_delta := 1
			elseif a_type = {EV_GTK_EXTERNALS}.GDK_2BUTTON_PRESS_ENUM then
				mouse_wheel_delta := 1
			elseif a_type = {EV_GTK_EXTERNALS}.GDK_3BUTTON_PRESS_ENUM then
				mouse_wheel_delta := 1
			end
			if a_button = 4 and mouse_wheel_delta > 0 then
					-- This is for scrolling up
				if mouse_wheel_actions_internal /= Void then
					mouse_wheel_actions_internal.call ([mouse_wheel_delta])
				end
			elseif a_button = 5 and mouse_wheel_delta > 0 then
					-- This is for scrolling down
				if mouse_wheel_actions_internal /= Void then
					mouse_wheel_actions_internal.call ([- mouse_wheel_delta])
				end
			end
			
			if a_button >= 1 and then a_button <= 3 then
				if a_type = {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM then
					if pointer_button_press_actions_internal /= Void then
						pointer_button_press_actions_internal.call (t)
					end
				elseif a_type = {EV_GTK_EXTERNALS}.GDK_2BUTTON_PRESS_ENUM then
					if pointer_double_press_actions_internal /= Void then
						pointer_double_press_actions_internal.call (t)
					end
				end			
			end
       end

feature -- Access

	parent: EV_CONTAINER is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
			--| Search back up through GtkWidget->parent to find a GtkWidget
			--| with an EV_ANY_IMP attached.
		local
			a_par_imp: EV_CONTAINER_IMP
		do
			a_par_imp := parent_imp
			if a_par_imp /= Void then
				Result := a_par_imp.interface
			end
		end

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer relative to `Current'.
		local
			x, y, s: INTEGER
			child: POINTER
		do
			child := {EV_GTK_EXTERNALS}.gdk_window_get_pointer ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), $x, $y, $s)
			create Result.set (x, y)
		end

feature {EV_WIDGET_IMP, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Position retrieval

	screen_x: INTEGER is
			-- Horizontal position of the client area on screen, 
		local
			a_x: INTEGER
			a_aux_info: POINTER
			i: INTEGER
		do
			if is_displayed then	
					i := {EV_GTK_EXTERNALS}.gdk_window_get_origin (
						{EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget),
				    	$a_x, NULL)
					Result := a_x
			else
				a_aux_info := aux_info_struct
				if a_aux_info /= NULL then
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
		do
			if is_displayed then
					i := {EV_GTK_EXTERNALS}.gdk_window_get_origin (
						{EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget),
				    	NULL, $a_y)
					Result := a_y
			else
				a_aux_info := aux_info_struct
				if a_aux_info /= NULL then
					Result := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
				end
			end
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed even when its parent is.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_hide (c_object)
		end

	enable_capture is
			-- Grab all the mouse and keyboard events.
		do
			App_implementation.set_captured_widget (interface)
			Precursor {EV_PICK_AND_DROPABLE_IMP}
		end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			App_implementation.set_captured_widget (Void)
			Precursor {EV_PICK_AND_DROPABLE_IMP}				
		end

feature -- Element change
	
	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			internal_set_minimum_size (a_minimum_width, internal_minimum_height)
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			internal_set_minimum_size (internal_minimum_width, a_minimum_height)
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			internal_set_minimum_size (a_minimum_width, a_minimum_height)
		end

feature -- Measurement
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		local
			a_aux_info: POINTER
			tmp_struct_x: INTEGER
		do
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_x ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			a_aux_info := aux_info_struct
			if a_aux_info /= NULL then
				tmp_struct_x := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
				if tmp_struct_x >= 0 then
					Result := tmp_struct_x
				end
			end
			Result := Result.max (0)
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		local
			a_aux_info: POINTER
			tmp_struct_y: INTEGER
		do
			Result := {EV_GTK_EXTERNALS}.gtk_allocation_struct_y ({EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			a_aux_info := aux_info_struct
			if a_aux_info /= NULL then
				tmp_struct_y := {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
				if tmp_struct_y >= 0 then
					Result := tmp_struct_y
				end
			end
			Result := Result.max (0)
		end	
		
	minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		do	
			if internal_minimum_width /= -1 then
				Result := internal_minimum_width
			else
				Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
			end
		end
		
	minimum_height: INTEGER is
			-- Minimum width that the widget may occupy.
		do
			if internal_minimum_height /= -1 then
				Result := internal_minimum_height
			else
				Result := Precursor {EV_PICK_AND_DROPABLE_IMP}
			end
		end

feature {EV_ANY_I} -- Implementation

	reset_minimum_size is
			-- Reset all values to defaults.
			-- Called by EV_FIXED and EV_VIEWPORT implementations.
		do
			internal_set_minimum_size (internal_minimum_width, internal_minimum_height)
		end
	
feature {EV_FIXED_IMP, EV_VIEWPORT_IMP} -- Implementation

	store_minimum_size is
			-- Called when size is explicitly set, ie: from fixed or viewport
		do
			internal_minimum_width := minimum_width
			internal_minimum_height := minimum_height		
		end

	internal_minimum_width: INTEGER	
			-- Minimum width for the widget.

	internal_minimum_height: INTEGER
			-- Minimum height for the widget.

feature {EV_WINDOW_IMP} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
			-- Used for drawing area to keep focus on all keys.
		do
			Result := False
		end

feature {EV_CONTAINER_IMP} -- Implementation

	set_parent_imp (a_container_imp: EV_CONTAINER_IMP) is
			-- Set `parent_imp' to `a_container_imp'.
		do
			parent_imp := a_container_imp
		end
		
feature {EV_ANY_IMP, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	destroy is
			-- Destroy `Current'
		do
			if parent_imp /= Void then
				parent_imp.interface.prune_all (interface)
			end
			Precursor {EV_PICK_AND_DROPABLE_IMP}
		end

	parent_imp: EV_CONTAINER_IMP
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation
		
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

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_widget_mapped is
			-- `Current' has been mapped on to the screen.
		do
			-- By default do nothing as this is redefined by descendants such as window and split area that need it.
		end

feature {NONE} -- Implementation

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Abstracted implementation for minimum size setting.
		do
			if a_minimum_width /= -1 then
				internal_minimum_width := a_minimum_width
			end
			if a_minimum_height /= -1 then
				internal_minimum_height := a_minimum_height
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_minimum_size (c_object, a_minimum_width, a_minimum_height)
			update_request_size
		end

	propagate_foreground_color_internal (a_color: EV_COLOR; a_c_object: POINTER) is
			-- Propagate `a_color' to the foreground color of `a_c_object's children.
		local
			l: POINTER
			child: POINTER
			fg: EV_COLOR
			a_child_list: POINTER
		do
			if {EV_GTK_EXTERNALS}.gtk_is_container (a_c_object) then
				from
					fg := a_color
					a_child_list := {EV_GTK_EXTERNALS}.gtk_container_children (a_c_object) 
					l := a_child_list
				until
					l = NULL
				loop
					child := {EV_GTK_EXTERNALS}.glist_struct_data (l)
					real_set_foreground_color (child, fg)
					if {EV_GTK_EXTERNALS}.gtk_is_container (child) then
						propagate_foreground_color_internal (fg, child)
					end
					l := {EV_GTK_EXTERNALS}.glist_struct_next (l) 
				end
				{EV_GTK_EXTERNALS}.g_list_free (a_child_list)
			else
				real_set_foreground_color (a_c_object, fg)
			end
		end
		
	propagate_background_color_internal (a_color: EV_COLOR; a_c_object: POINTER) is
			-- Propagate `a_color' to the background color of `a_c_object's children.
		local
			l: POINTER
			child: POINTER
			bg: EV_COLOR
			a_child_list: POINTER
		do
			if
				{EV_GTK_EXTERNALS}.gtk_is_container (a_c_object)
			then
				from
					bg := a_color
					a_child_list := {EV_GTK_EXTERNALS}.gtk_container_children (a_c_object)
					l := a_child_list
				until
					l = NULL
				loop
					child := {EV_GTK_EXTERNALS}.glist_struct_data (l)
					real_set_background_color (child, bg)
					if {EV_GTK_EXTERNALS}.gtk_is_container (child) then
						propagate_background_color_internal (bg, child)
					end
					l := {EV_GTK_EXTERNALS}.glist_struct_next (l) 
				end
				{EV_GTK_EXTERNALS}.g_list_free (a_child_list)
			else
				real_set_background_color (a_c_object, bg)
			end
		end
		
	last_width, last_height: INTEGER
			-- Dimenions during last "size-allocate".

	in_resize_event: BOOLEAN
			-- Is `interface.resize_actions' being executed?

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

end -- class EV_WIDGET_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

