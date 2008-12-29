note
	description:
		"Action sequences for EV_WIDGET_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES_IMP

inherit
	EV_WIDGET_ACTION_SEQUENCES_I

	EV_ANY_IMP
		 undefine
		 	dispose,
		 	destroy
		 end

	EV_CARBON_EVENTABLE
		redefine
			on_event
		end

	HIVIEW_FUNCTIONS_EXTERNAL

feature -- Event handling

	initialize_events
		local
			target: POINTER
			h_ret: POINTER
			ret: INTEGER
		do
			event_id := app_implementation.get_id (current)
			target := get_control_event_target_external( c_object )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseDown )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.keventmouseup )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseMoved )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseDragged )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseWheelMoved )

			ret := hiview_new_tracking_area_external (c_object, null, 0, $tracking_area)
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseExited )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseEntered )

		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_button_press action sequence.
		do
			create Result
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_double_press action sequence.
		do
			create Result
		end

	create_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_button_release action sequence.
		do
			create Result
		end

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a pointer_enter action sequence.
		do
			create Result
		end

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a pointer_leave action sequence.
		do
			create Result
		end

	create_key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Create a key_press action sequence.
		do
			create Result
		end

	create_key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Create a key_press_string action sequence.
		do
			create Result
		end

	create_key_release_actions: EV_KEY_ACTION_SEQUENCE
			-- Create a key_release action sequence.
		do
			create Result
		end

	create_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a focus_in action sequence.
		do
			create Result
		end

	create_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a focus_out action sequence.
		do
			create Result
		end

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Create a resize action sequence.
		do
			create Result
		end

	create_mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE
			-- Create a mouse_wheel action sequence.
		do
			create Result
		end

	create_file_drop_actions: like file_drop_actions_internal
			-- Create a file_drop action sequence.
		do
			create Result
		end

feature --access
	tracking_area: POINTER

feature {EV_APPLICATION_IMP} -- Implementation

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
			where, wherewin : CGPOINT_STRUCT
			ret: INTEGER
			button: NATURAL_32
			actual_type, actual_size : NATURAL_32
			event_data: TUPLE [x: INTEGER_32; y: INTEGER_32; button: INTEGER_32; x_tilt: REAL_64; y_tilt: REAL_64; pressure: REAL_64; screen_x: INTEGER_32; screen_y: INTEGER_32]
			motion_data: TUPLE [x: INTEGER_32; y: INTEGER_32; x_tilt: REAL_64; y_tilt: REAL_64; pressure: REAL_64; screen_x: INTEGER_32; screen_y: INTEGER_32]
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)
				create event_data.default_create
				create motion_data.default_create

				if event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventMouseDown and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					create where.make_new_unshared
					create wherewin.make_new_unshared
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, where.sizeof, $actual_size, where.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamwindowmouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, wherewin.sizeof, $actual_size, wherewin.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammousebutton,  {AEDATA_MODEL_ANON_ENUMS}.typeWildCard, $actual_type, 4, $actual_size, $button)



					event_data.put_integer_32 (where.x.rounded, 1)
					event_data.put_integer_32 (where.y.rounded, 2)
					event_data.put_integer_32 (button.as_integer_32, 3)

					--don't know how to get them
					event_data.put_integer_32 (0, 4)
					event_data.put_integer_32 (0, 5)
					event_data.put_integer_32 (1, 6)

					event_data.put_integer_32 (where.x.rounded, 7)
					event_data.put_integer_32 (where.y.rounded, 8)
					pointer_button_press_actions.call ( event_data )
					Result := noErr -- event handled

				elseif event_kind = {CARBONEVENTS_ANON_ENUMS}.keventmouseup and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					create where.make_new_unshared
					create wherewin.make_new_unshared
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, where.sizeof, $actual_size, where.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamwindowmouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, wherewin.sizeof, $actual_size, wherewin.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammousebutton,  {AEDATA_MODEL_ANON_ENUMS}.typeWildCard, $actual_type, 4, $actual_size, $button)


					event_data.put_integer_32 (where.x.rounded, 1)
					event_data.put_integer_32 (where.y.rounded, 2)
					event_data.put_integer_32 (button.as_integer_32, 3)

					--don't know how to get them
					event_data.put_integer_32 (0, 4)
					event_data.put_integer_32 (0, 5)
					event_data.put_integer_32 (1, 6)

					event_data.put_integer_32 (where.x.rounded, 7)
					event_data.put_integer_32 (where.y.rounded, 8)
					pointer_button_release_actions.call ( event_data )
					Result := noErr -- event handled
				elseif event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventMouseEntered and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					create where.make_new_unshared
					create wherewin.make_new_unshared
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, where.sizeof, $actual_size, where.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamwindowmouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, wherewin.sizeof, $actual_size, wherewin.item )



					event_data.put_integer_32 (where.x.rounded, 1)
					event_data.put_integer_32 (where.y.rounded, 2)
					event_data.put_integer_32 (button.as_integer_32, 3)

					--don't know how to get them
					event_data.put_integer_32 (0, 4)
					event_data.put_integer_32 (0, 5)
					event_data.put_integer_32 (1, 6)

					event_data.put_integer_32 (where.x.rounded, 7)
					event_data.put_integer_32 (where.y.rounded, 8)
					-- don't know which Event data are needed for enter_actions
					pointer_enter_actions.call ( event_data )
					Result := noErr -- event handled

				elseif event_kind = {CARBONEVENTS_ANON_ENUMS}.keventmouseexited and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					create where.make_new_unshared
					create wherewin.make_new_unshared
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, where.sizeof, $actual_size, where.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamwindowmouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, wherewin.sizeof, $actual_size, wherewin.item )



					event_data.put_integer_32 (where.x.rounded, 1)
					event_data.put_integer_32 (where.y.rounded, 2)
					event_data.put_integer_32 (button.as_integer_32, 3)

					--don't know how to get them
					event_data.put_integer_32 (0, 4)
					event_data.put_integer_32 (0, 5)
					event_data.put_integer_32 (1, 6)

					event_data.put_integer_32 (where.x.rounded, 7)
					event_data.put_integer_32 (where.y.rounded, 8)
					-- don't know which Event data are needed for enter_actions
					pointer_leave_actions.call ( event_data )
					Result := noErr -- event handled

				elseif event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventMouseDragged and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					create where.make_new_unshared
					create wherewin.make_new_unshared
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, where.sizeof, $actual_size, where.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamwindowmouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, wherewin.sizeof, $actual_size, wherewin.item )
					ret := get_event_parameter_external (a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammousebutton,  {AEDATA_MODEL_ANON_ENUMS}.typeWildCard, $actual_type, 4, $actual_size, $button)



					motion_data.put_integer_32 (where.x.rounded, 1)
					motion_data.put_integer_32 (where.y.rounded, 2)

					--don't know how to get them
					motion_data.put_integer_32 (0, 3)
					motion_data.put_integer_32 (0, 4)
					motion_data.put_integer_32 (1, 5)

					motion_data.put_integer_32 (where.x.rounded, 6)
					motion_data.put_integer_32 (where.y.rounded, 7)
					pointer_motion_actions.call ( motion_data )
					Result := noErr -- event handled
				else
					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
				end
		end



note
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end
