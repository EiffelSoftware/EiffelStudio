note
	description: "EiffelVision application, Cocoa implementation."
	author: "Daniel Furrer"

class
	EV_APPLICATION_IMP

inherit
	EV_APPLICATION_I
		export
			{EV_PICK_AND_DROPABLE_IMP}
				captured_widget
			{EV_INTERMEDIARY_ROUTINES}
				pointer_motion_actions_internal,
				pointer_button_press_actions_internal,
				pointer_double_press_actions_internal,
				pointer_button_release_actions_internal
		redefine
			make,
			dispose
		select
			copy
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	EXECUTION_ENVIRONMENT
		rename
			sleep as nano_sleep,
			launch as ee_launch
		end

	PLATFORM

	EXCEPTIONS

	NS_APPLICATION
		rename
			make as make_application_cocoa,
			launch as launch_cocoa,
			copy as copy_cocoa
		redefine
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Set up the callback marshalL.... TODO
		do
			Precursor
			create windows_imp.make
			make_application_cocoa
			set_is_initialized (True)
		end

feature -- Access

	ctrl_pressed: BOOLEAN
			-- Is ctrl key currently pressed?
		do
			-- This is low-level, not trivial in Cocoa (see HID manager)
		end

	alt_pressed: BOOLEAN
			-- Is alt key currently pressed?
		do
			-- This is low-level, not trivial in Cocoa (see HID manager)
		end

	shift_pressed: BOOLEAN
			-- Is shift key currently pressed?
		do
			-- This is low-level, not trivial in Cocoa (see HID manager)
		end

	caps_lock_on: BOOLEAN
			-- Is the Caps or Shift Lock key currently on?
		do
			-- This is low-level, not trivial in Cocoa (see HID manager)
		end

	windows_imp: LINKED_LIST [EV_WINDOW_IMP]
			-- Global list of windows.

	windows: LINKED_LIST [EV_WINDOW]
		do
			create Result.make
			from
				windows_imp.start
			until
				windows_imp.after
			loop
				Result.extend (windows_imp.item.interface)
				windows_imp.forth
			end
		end

feature -- Basic operation

	process_underlying_toolkit_event_queue
			-- Process Cocoa events
		local
			event: NS_EVENT
			view: NS_VIEW
			pointer_button_action: TUPLE [x: INTEGER; y: INTEGER; button: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			pointer_motion_action: TUPLE [x: INTEGER; y: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			point: NS_POINT
		do
			from
				event := next_event (0, default_pointer, 0, true)
			until
				event = void
			loop
				pool.release
				create pool.make

				if event.type = {NS_EVENT}.left_mouse_down or event.type = {NS_EVENT}.right_mouse_down or event.type = {NS_EVENT}.other_mouse_down
					or event.type = {NS_EVENT}.left_mouse_up or event.type = {NS_EVENT}.right_mouse_up or event.type = {NS_EVENT}.other_mouse_up then
					view := event.window.content_view.hit_test (event.location_in_window)
					--io.output.put_string ("MouseDown event at " + event.location_in_window.out + " in object of type " + view.class_.name + "  " + view.generating_type + "%N")

					if attached {EV_WIDGET_IMP} view as widget then
						create pointer_button_action
						point := event.window.content_view.convert_point_to_view (event.location_in_window, widget.cocoa_view)
						pointer_button_action.x := point.x
						pointer_button_action.y := point.y
						if event.type = {NS_EVENT}.left_mouse_down or event.type = {NS_EVENT}.left_mouse_up then
							pointer_button_action.button :=	1
						elseif event.type = {NS_EVENT}.right_mouse_down or event.type = {NS_EVENT}.right_mouse_up then
							pointer_button_action.button :=	2
						else
							pointer_button_action.button :=	3
						end
						if event.type = {NS_EVENT}.left_mouse_up or event.type = {NS_EVENT}.right_mouse_up or event.type = {NS_EVENT}.other_mouse_up then
							widget.pointer_button_release_actions.call (pointer_button_action)
						else
							widget.pointer_button_press_actions.call (pointer_button_action)
						end
					end
				elseif event.type = {NS_EVENT}.mouse_moved then
					view := event.window.content_view.hit_test (event.location_in_window)
					--io.output.put_string ("Move event at " + event.location_in_window.out + " in object of type " + view.class_.name + "  " + view.generating_type + "%N")

					if attached {EV_WIDGET_IMP} view as widget then
						create pointer_motion_action
						point := event.window.content_view.convert_point_to_view (event.location_in_window, widget.cocoa_view)
						pointer_motion_action.x := point.x
						pointer_motion_action.y := point.y
						widget.pointer_motion_actions.call (pointer_motion_action)
					end
				end
				send_event (event)
				update_windows
				event := next_event (0, default_pointer, 0, true)
			end
			pool.release
		end

	process_graphical_events
			-- Process all pending graphical events and redraws.
		do
		end

	sleep (msec: INTEGER)
			-- Wait for `msec' milliseconds and return.
		do
			nano_sleep ({INTEGER_64} 1000000 * msec)
		end

	destroy
			-- End the application.
		do
			if not is_destroyed then
				set_is_destroyed (True)
				destroy_actions.call (Void)
			end
			terminate
		end

feature -- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER)
			-- Set `tooltip_delay' to `a_delay'.
		do
			tooltip_delay := a_delay
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	on_pick (a_pebble: ANY)
			-- Called by EV_PICK_AND_DROPABLE_IMP.start_transport
		do
		end

	on_drop (a_pebble: ANY)
			-- Called by EV_PICK_AND_DROPABLE_IMP.end_transport
		do
		end

feature {EV_ANY} -- Implementation

	is_display_remote: BOOLEAN
			-- Is application display remote?
			-- This function is primarily to determine if drawing to the display is optimal.

feature -- Implementation

	wait_for_input (msec: INTEGER)
			-- Wait for at most `msec' milliseconds for an event.
		do
		end

	is_in_transport: BOOLEAN
		-- Is application currently in transport (either PND or docking)?

	pick_and_drop_source: EV_PICK_AND_DROPABLE_IMP
			-- Source of pick and drop if any.
		do
			--Result := internal_pick_and_drop_source
		end

	enable_is_in_transport
			-- Set `is_in_transport' to True.
		require
			not_in_transport: not is_in_transport
		do
		end

	disable_is_in_transport
			-- Set `is_in_transport' to False.
		require
			in_transport: is_in_transport
		do
		end

feature -- Thread Handling.

	lock
			-- Lock the Mutex.
		do
		end

	try_lock: BOOLEAN
			-- Try to see if we can lock, False means no lock could be attained
		do
			Result := True
			-- TODO: Uhhh, this could be dangerous
		end

	unlock
			-- Unlock the Mutex.
		do
		end

feature {NONE} -- Implementation

	dispose
		do
			Precursor {EV_APPLICATION_I}
			Precursor {NS_APPLICATION}
		end

end -- class EV_APPLICATION_IMP
