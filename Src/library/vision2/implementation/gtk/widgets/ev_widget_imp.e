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
			is_displayed
		end

	EV_ANY_IMP
		redefine
			interface
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

	Gdk_events_mask: INTEGER is
			-- Mask of all the gdk events the gdkwindow shall receive.
		once
			Result := feature {EV_GTK_EXTERNALS}.GDK_EXPOSURE_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_BUTTON_RELEASE_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_KEY_PRESS_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_KEY_RELEASE_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_ENTER_NOTIFY_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_LEAVE_NOTIFY_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_FOCUS_CHANGE_MASK_ENUM +
			feature {EV_GTK_EXTERNALS}.GDK_VISIBILITY_NOTIFY_MASK_ENUM
		end

	initialize_events is
			-- Initialize the gtk events received by `Current'
		do
			if not feature {EV_GTK_EXTERNALS}.gtk_widget_no_window (c_object) then
				feature {EV_GTK_EXTERNALS}.gtk_widget_add_events (c_object, Gdk_events_mask)
			end
			if not feature {EV_GTK_EXTERNALS}.gtk_widget_no_window (visual_widget) and then c_object /= visual_widget then
				feature {EV_GTK_EXTERNALS}.gtk_widget_add_events (visual_widget, Gdk_events_mask)
			end
		end

	initialize is
			-- Show non window widgets.
			-- Initialize default options, colors and sizes.
			-- Connect action sequences to GTK signals.
		local
			connect_button_press_switch_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE[]]
			on_key_event_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
		do
			if feature {EV_GTK_EXTERNALS}.gtk_is_widget (c_object) and not feature {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
				feature {EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			end
			
				-- Reset the initial internal sizes, once set they should not be reset to -1
			internal_minimum_width := -1
			internal_minimum_height := -1
			
			initialize_events	
				--| "configure-event" only happens for windows,
				--| so we connect to the "size-allocate" function.
			if feature {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
				real_signal_connect (c_object, "configure-event", agent (App_implementation.gtk_marshal).on_size_allocate_intermediate (c_object, ?, ?, ?, ?), size_allocate_translate_agent)
			else
				real_signal_connect (c_object, "size-allocate", agent (App_implementation.gtk_marshal).on_size_allocate_intermediate (c_object, ?, ?, ?, ?), size_allocate_translate_agent)
			end
	
			on_key_event_intermediary_agent := agent (App_implementation.gtk_marshal).on_key_event_intermediary (c_object, ?, ?, ?)
			real_signal_connect (visual_widget, "key_press_event", on_key_event_intermediary_agent, key_event_translate_agent)
			real_signal_connect (visual_widget, "key_release_event", on_key_event_intermediary_agent, key_event_translate_agent)
				--| "button-press-event" is a special case, see below.
				
			real_signal_connect (visual_widget, "focus-in-event", agent (App_implementation.gtk_marshal).widget_focus_in_intermediary (c_object), Void)
			real_signal_connect (visual_widget, "focus-out-event", agent (App_implementation.gtk_marshal).widget_focus_out_intermediary (c_object), Void)
				
			connect_button_press_switch_agent := agent (App_implementation.gtk_marshal).connect_button_press_switch_intermediary (c_object)
			pointer_button_press_actions.not_empty_actions.extend (connect_button_press_switch_agent)
			pointer_double_press_actions.not_empty_actions.extend (connect_button_press_switch_agent)
			if not pointer_button_press_actions.is_empty or not pointer_double_press_actions.is_empty then
				connect_button_press_switch
			end
			is_initialized := True
		end

	button_press_switch_is_connected: BOOLEAN
			-- Is `button_press_switch' connected to its event source.
		
feature {EV_WINDOW_IMP, EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		local
			temp_key_string: STRING
			a_capture_widget_imp: EV_WIDGET_IMP
		do
			if App_implementation.is_in_transport and then a_key_press and then a_key /= Void and then a_key.code = feature {EV_KEY_CONSTANTS}.Key_escape then
					-- If a PND is in action and the Esc key is pressed then cancel it
				a_capture_widget_imp ?= App_implementation.capture_widget.implementation
				a_capture_widget_imp.end_transport (0, 0, 0, 0, 0 ,0 ,0 ,0)
			else
				if a_key_press then
						-- The event is a key press event.
					if a_key /= Void and then key_press_actions_internal /= Void then
						key_press_actions_internal.call ([a_key])
					end
					if key_press_string_actions_internal /= Void then
						temp_key_string := a_key_string
						if a_key /= Void then
							if a_key.out.count /= 1 and not a_key.is_numpad then
								temp_key_string := ""
							end
							if a_key.code = app_implementation.Key_constants.Key_space then
								temp_key_string := " "
							end
						end
						key_press_string_actions_internal.call ([temp_key_string])
					end
				else
						-- The event is a key release event.
					if a_key /= Void and then key_release_actions_internal /= Void then
						key_release_actions_internal.call ([a_key])
					end
				end
			end
		end
		
	connect_button_press_switch is
			-- Connect `button_press_switch' to its event sources.
			--| See comment in `button_press_switch' above.
		do
			if not button_press_switch_is_connected then
				signal_connect ("button-press-event", agent (App_implementation.gtk_marshal).button_press_switch_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?), App_implementation.default_translate)
				button_press_switch_is_connected := True
			end
		end
	
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
		require
			valid_button_press:
				a_type = feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM or
				a_type = feature {EV_GTK_EXTERNALS}.GDK_2BUTTON_PRESS_ENUM or
				a_type = feature {EV_GTK_EXTERNALS}.GDK_3BUTTON_PRESS_ENUM
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			mouse_wheel_delta: INTEGER
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
				
			if not has_focus and then (a_button = 1 or a_button = 3) then
					-- We explicitly set the focus for both left and right mouse buttons if not set already
				feature {EV_GTK_EXTERNALS}.gtk_widget_grab_focus (visual_widget)
			else
					-- Mouse Wheel implementation.
				if a_type = feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM then
					mouse_wheel_delta := 1
				elseif a_type = feature {EV_GTK_EXTERNALS}.GDK_2BUTTON_PRESS_ENUM then
					mouse_wheel_delta := 1
				elseif a_type = feature {EV_GTK_EXTERNALS}.GDK_3BUTTON_PRESS_ENUM then
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
			end
			
			if a_button >= 1 and then a_button <= 3 then
				if a_type = feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM and not is_transport_enabled then
					if pointer_button_press_actions_internal /= Void then
						pointer_button_press_actions_internal.call (t)
					end
				elseif a_type = feature {EV_GTK_EXTERNALS}.GDK_2BUTTON_PRESS_ENUM then
					if pointer_double_press_actions_internal /= Void then
						pointer_double_press_actions_internal.call (t)
					end
				end			
			end
       end
       
	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER) is
			-- Gtk_Widget."size-allocate" happened.
		do
			if not in_resize_event then
				in_resize_event := True
				if last_width /= a_width or else last_height /= a_height then
					if resize_actions_internal /= Void then
						resize_actions_internal.call ([a_x, a_y, a_width, a_height])
					end
					if parent_imp /= Void then
						parent_imp.child_has_resized (Current)
					end
					last_width := a_width
					last_height := a_height
				end
				in_resize_event := False
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
			child := feature {EV_GTK_EXTERNALS}.gdk_window_get_pointer (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), $x, $y, $s)
			create Result.set (x, y)
		end

	pointer_style: EV_CURSOR
			-- Cursor displayed when the pointer is over this widget.

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		local
			wind: EV_WINDOW_IMP
		do 
			if parent_imp /= Void then
				wind ?= parent_imp
				if wind /= Void then
					Result := wind.client_screen_x
				else
					Result := parent_imp.screen_x
				end
				Result := Result + x_position
			end
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen. 
		local 
			wind: EV_WINDOW_IMP 
		do 
			if parent_imp /= Void then
				wind ?= parent_imp
				if wind /= Void then
					Result := wind.client_screen_y
				else
					Result := parent_imp.screen_y
				end
				Result := Result + y_position
			end
		end
	
feature -- Status report

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := has_struct_flag (c_object, feature {EV_GTK_EXTERNALS}.GTK_VISIBLE_ENUM)
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
		do
			Result := has_struct_flag (c_object, feature {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM)
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := gtk_widget_has_focus (visual_widget)
		end
		
	has_capture: BOOLEAN is
			-- Has capture?
		do
			Result := has_struct_flag (c_object, feature {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM)
		end

feature -- Status setting

	hide is
			-- Request that `Current' not be displayed even when its parent is.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (c_object)
		end
	
	show is
			-- Request that `Current' be displayed when its parent is.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
		end

	set_focus is
			-- Grab keyboard focus.
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_grab_focus (visual_widget)
		end

	enable_capture is
			-- Grab all the mouse and keyboard events.
			--| Used by pick and drop.
		local
			i: INTEGER
		do
			disable_debugger
			App_implementation.set_capture_widget (interface)
			feature {EV_GTK_EXTERNALS}.gtk_grab_add (c_object)
			i := feature {EV_GTK_EXTERNALS}.gdk_pointer_grab (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				1, -- gint owner_events
				feature {EV_GTK_EXTERNALS}.GDK_BUTTON_RELEASE_MASK_ENUM +
				feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_MASK_ENUM +
				feature {EV_GTK_EXTERNALS}.GDK_BUTTON_MOTION_MASK_ENUM +
				feature {EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_MASK_ENUM,
				NULL,						-- GdkWindow* confine_to 
				NULL,						-- GdkCursor *cursor
				0)							-- guint32 time
			i := feature {EV_GTK_EXTERNALS}.gdk_keyboard_grab (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				True, -- gint owner events
				0) -- guint32 time
		end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			App_implementation.set_capture_widget (Void)
			feature {EV_GTK_EXTERNALS}.gtk_grab_remove (c_object)
			feature {EV_GTK_EXTERNALS}.gdk_pointer_ungrab (
				0 -- guint32 time
			)
			feature {EV_GTK_EXTERNALS}.gdk_keyboard_ungrab (0) -- guint32 time
			enable_debugger
		end

feature -- Element change

	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		do
			pointer_style := clone (a_cursor)
			internal_set_pointer_style (a_cursor)
		end
		
	internal_set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style', used for PND
		local
			a_cursor_imp: EV_PIXMAP_IMP
			bitmap_data: ARRAY [CHARACTER]
			cur_pix, a_cursor_ptr, fg, bg: POINTER
			a_cur_data: ANY
		do
			fg := App_implementation.fg_color
			bg := App_implementation.bg_color
			a_cursor_imp ?= a_cursor.implementation
			check
				a_cursor_imp_not_void: a_cursor_imp /= Void
			end
			bitmap_data := a_cursor_imp.bitmap_array
			a_cur_data := bitmap_data.to_c
			cur_pix := feature {EV_GTK_EXTERNALS}.gdk_pixmap_create_from_data (NULL, $a_cur_data,  a_cursor_imp.width, a_cursor_imp.height, 1, fg, bg)

			--| FIXME IEK If a_cursor_imp has no mask then routine seg faults.
			a_cursor_ptr := feature {EV_GTK_EXTERNALS}.gdk_cursor_new_from_pixmap (cur_pix, a_cursor_imp.mask, fg, bg, a_cursor.x_hotspot, a_cursor.y_hotspot)
			set_composite_widget_pointer_style (a_cursor_ptr)
			feature {EV_GTK_EXTERNALS}.gdk_cursor_destroy (a_cursor_ptr)
		end
		
	set_composite_widget_pointer_style (a_cursor_ptr: POINTER) is
			-- Used to set the gdkcursor for composite widgets.
		do
			feature {EV_GTK_EXTERNALS}.gdk_window_set_cursor (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget), a_cursor_ptr)
			feature {EV_GTK_EXTERNALS}.gdk_window_set_cursor (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), a_cursor_ptr)
		end
	
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
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_x (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			a_aux_info := aux_info_struct
			if a_aux_info /= NULL then
				tmp_struct_x := feature {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_x (a_aux_info)
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
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_y (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object))
			a_aux_info := aux_info_struct
			if a_aux_info /= NULL then
				tmp_struct_y := feature {EV_GTK_EXTERNALS}.gtk_widget_aux_info_struct_y (a_aux_info)
				if tmp_struct_y >= 0 then
					Result := tmp_struct_y
				end
			end
			Result := Result.max (0)
		end	

	width: INTEGER is
			-- Horizontal size measured in pixels.
		do
			update_request_size
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_width (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)
			).max (minimum_width)
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		do
			update_request_size
			Result := feature {EV_GTK_EXTERNALS}.gtk_allocation_struct_height (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_allocation (c_object)
			).max (minimum_height)
		end
		
	minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		local
			gr: POINTER
		do	
			if internal_minimum_width /= -1 then
				Result := internal_minimum_width
			elseif not is_destroyed then
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
			if internal_minimum_height /= -1 then
				Result := internal_minimum_height
			elseif not is_destroyed then
				update_request_size
				gr := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object)
				Result := feature {EV_GTK_EXTERNALS}.gtk_requisition_struct_height (gr)
			end
		end

feature {EV_ANY_I} -- Implementation

	reset_minimum_size is
			-- Reset all values to defaults.
			-- Called by EV_FIXED and EV_VIEWPORT implementations.
		do
			internal_set_minimum_size (internal_minimum_width, internal_minimum_height)
		end
				
feature {NONE} -- Implementation

	has_struct_flag (a_gtk_object: POINTER; a_flag: INTEGER): BOOLEAN is
			-- Has this widget the flag `a_flag' in struct_flags?
		do
				--| Shift to put bit in least significant place then take mod 2.
			if a_gtk_object /= NULL then
				Result := (((feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (a_gtk_object) // a_flag) \\ 2)) = 1
			end
		end

	cursor_signal_tag: INTEGER
			-- Tag returned from Gtk used to disconnect `enter-notify' signal
			
	enable_debugger is
			-- 
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
#ifdef WORKBENCH
			extern int debug_mode;
			debug_mode = 1;
#endif
			]"
		end

	disable_debugger is
			-- 
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
#ifdef WORKBENCH
			extern int debug_mode;
			debug_mode = 0;
#endif
			]"
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
		
feature {EV_ANY_IMP} -- Implementation

	parent_imp: EV_CONTAINER_IMP
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)

	aux_info_struct: POINTER is
			-- Pointer to the auxillary information struct used for retrieving when widget is unmapped
		local
			a_cs: C_STRING
		do
			create a_cs.make ("gtk-aux-info")
			Result := feature {EV_GTK_EXTERNALS}.gtk_object_get_data (
				c_object,
				a_cs.item
			)
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation
		
	top_level_window_imp: EV_WINDOW_IMP is
			-- Window that `Current' is contained within (if any)
		local
			wind_ptr: POINTER
		do
			wind_ptr := feature {EV_GTK_EXTERNALS}.gtk_widget_get_toplevel (c_object)
			if wind_ptr /= NULL then
				Result ?= eif_object_from_c (wind_ptr)
			end
		end

feature {NONE} -- Agent functions.

	key_event_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for key events
		once
			Result := agent (App_implementation.gtk_marshal).key_event_translate
		end
		
	size_allocate_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for size allocation events
		once
			Result := agent (App_implementation.gtk_marshal).size_allocate_translate
		end

feature {EV_CONTAINER_IMP} -- Implementation

	update_request_size is
			-- Force the requisition struct to be updated.
		do
			if not is_displayed then
				feature {EV_GTK_EXTERNALS}.gtk_widget_size_request (c_object, feature {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (c_object))
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
			-- Abstracted implementation for minumum size setting.
		do
			if a_minimum_width /= -1 then
				internal_minimum_width := a_minimum_width
			end
			if a_minimum_height /= -1 then
				internal_minimum_height := a_minimum_height
			end
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, a_minimum_width, a_minimum_height)
			update_request_size
		end

	gtk_widget_has_focus (a_c_object: POINTER): BOOLEAN is
			-- Does `a_c_object' have the focus.
		do
				--| Shift to put bit in least significant place then take mod 2.
			if a_c_object /= NULL then
				Result := has_struct_flag (a_c_object, feature {EV_GTK_EXTERNALS}.GTK_HAS_FOCUS_ENUM)
				check
					Result = ((((feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (a_c_object) // feature {EV_GTK_EXTERNALS}.GTK_HAS_FOCUS_ENUM) \\ 2)) = 1)
				end
			end
		end

	propagate_foreground_color_internal (a_color: EV_COLOR; a_c_object: POINTER) is
			-- Propagate `a_color' to the foreground color of `a_c_object's children.
		local
			l: POINTER
			child: POINTER
			fg: EV_COLOR
			a_child_list: POINTER
		do
			if feature {EV_GTK_EXTERNALS}.gtk_is_container (a_c_object) then
				from
					fg := a_color
					a_child_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (a_c_object) 
					l := a_child_list
				until
					l = NULL
				loop
					child := feature {EV_GTK_EXTERNALS}.glist_struct_data (l)
					real_set_foreground_color (child, fg)
					if feature {EV_GTK_EXTERNALS}.gtk_is_container (child) then
						propagate_foreground_color_internal (fg, child)
					end
					l := feature {EV_GTK_EXTERNALS}.glist_struct_next (l) 
				end
				feature {EV_GTK_EXTERNALS}.g_list_free (a_child_list)
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
				feature {EV_GTK_EXTERNALS}.gtk_is_container (a_c_object)
			then
				from
					bg := a_color
					a_child_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (a_c_object)
					l := a_child_list
				until
					l = NULL
				loop
					child := feature {EV_GTK_EXTERNALS}.glist_struct_data (l)
					real_set_background_color (child, bg)
					if feature {EV_GTK_EXTERNALS}.gtk_is_container (child) then
						propagate_background_color_internal (bg, child)
					end
					l := feature {EV_GTK_EXTERNALS}.glist_struct_next (l) 
				end
				feature {EV_GTK_EXTERNALS}.g_list_free (a_child_list)
			else
				real_set_background_color (a_c_object, bg)
			end
		end
		
	last_width, last_height: INTEGER
			-- Dimenions during last "size-allocate".

	in_resize_event: BOOLEAN
			-- Is `interface.resize_actions' being executed?

feature {EV_ANY_I} -- Contract Support

	parent_is_sensitive: BOOLEAN is
			-- Is the parent sensitive?
		local
			a_par: EV_CONTAINER_IMP
		do
			a_par := parent_imp
			Result := a_par.is_sensitive
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			Result := parent_imp /= Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

end -- class EV_WIDGET_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

