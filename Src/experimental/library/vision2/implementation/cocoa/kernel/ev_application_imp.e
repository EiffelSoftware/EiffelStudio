note
	description: "EiffelVision application, Cocoa implementation."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	todo: "[

	]"

class
	EV_APPLICATION_IMP

inherit
	EV_APPLICATION_I
		export
			{EV_PICK_AND_DROPABLE_IMP}
				captured_widget
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
			copy as copy_cocoa,
			process_events as process_events_cocoa
		undefine
			is_equal
		redefine
			dispose
		end

	NS_ENVIRONEMENT

	NS_STRING_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Set up the callback marshalL.... TODO
		local
			menu: NS_MENU
		do
			Precursor {EV_APPLICATION_I}
			if {PLATFORM}.is_thread_capable then
				create idle_action_mutex.make
			end
			create windows_imp.make
			make_application_cocoa
			set_is_initialized (True)

			-- Fix the menu because we are not loading from a nib
			create menu.make
			menu.insert_item_at_index (default_application_menu, 0)
			set_main_menu (menu)
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
				if attached windows_imp.item.interface as window then
					Result.extend (window)
				end
				windows_imp.forth
			end
		end

feature -- Basic operation

	process_underlying_toolkit_event_queue
			-- Process Cocoa events
		local
			event: detachable NS_EVENT
			view: detachable NS_VIEW
			l_window: detachable NS_WINDOW
			pointer_button_action: TUPLE [x: INTEGER; y: INTEGER; button: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			pointer_motion_action: TUPLE [x: INTEGER; y: INTEGER; x_tilt: DOUBLE; y_tilt: DOUBLE; pressure: DOUBLE; screen_x: INTEGER; screen_y: INTEGER]
			point: NS_POINT
			l_loop_pool: NS_AUTORELEASE_POOL
		do
			create l_loop_pool.make
			from
				event := next_event ({NS_APPLICATION_API}.ns_any_event_mask, Void, default_run_loop_mode, true)
			until
				event = Void
			loop

				-- We are translating and forwarding the Cocoa events to Vision events here, but this way of doing it has its problems.
				-- (E.g. because modal windows have their own event loop)
				-- We already hanlde things better in EV_DRAWING_AREA_IMP and this is how all widgets should wirk in the future.
--				if event.type = {NS_EVENT}.left_mouse_down or event.type = {NS_EVENT}.right_mouse_down or event.type = {NS_EVENT}.other_mouse_down
--					or event.type = {NS_EVENT}.left_mouse_up or event.type = {NS_EVENT}.right_mouse_up or event.type = {NS_EVENT}.other_mouse_up then
--					view := event.window.content_view.hit_test (event.location_in_window)
--					--io.output.put_string ("MouseDown event at " + event.location_in_window.out + " in object of type " + view.class_.name + "  " + view.generating_type + "%N")

--					if attached {EV_WIDGET_IMP} view as widget then
--						create pointer_button_action
--						point := event.window.content_view.convert_point_to_view (event.location_in_window, widget.cocoa_view)
--						pointer_button_action.x := point.x.rounded
--						pointer_button_action.y := point.y.rounded
--						point := event.window.convert_base_to_screen_top_left (event.location_in_window)
--						pointer_button_action.screen_x := point.x.rounded
--						pointer_button_action.screen_y := point.y.rounded
--						pointer_button_action.button :=	event.button_number + 1
--						if event.type = {NS_EVENT}.left_mouse_up or event.type = {NS_EVENT}.right_mouse_up or event.type = {NS_EVENT}.other_mouse_up then
--							widget.pointer_button_release_actions.call (pointer_button_action)
--						else
--							widget.pointer_button_press_actions.call (pointer_button_action)
--						end
--					end
--				elseif event.type = {NS_EVENT}.mouse_moved then
--					view := event.window.content_view.hit_test (event.location_in_window)
--					--io.output.put_string ("Move event at " + event.location_in_window.out + " in object of type " + view.class_.name + "  " + view.generating_type + "%N")

--					if attached {EV_WIDGET_IMP} view as widget then
--						create pointer_motion_action
--						point := event.window.content_view.convert_point_to_view (event.location_in_window, widget.cocoa_view)
--						pointer_motion_action.x := point.x.rounded
--						pointer_motion_action.y := point.y.rounded
----						point := event.window.convert_base_to_screen_top_left (event.location_in_window)
----						pointer_button_action.screen_x := point.x
----						pointer_button_action.screen_y := point.y
--						widget.pointer_motion_actions.call (pointer_motion_action)
--					end
--				end
				send_event (event)
				update_windows
				event := next_event ({NS_APPLICATION_API}.ns_any_event_mask, Void, default_run_loop_mode, true)
			end
			l_loop_pool.release
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
			stop
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

feature {NONE} -- Implementation

	wait_for_input (msec: INTEGER)
			-- Wait for at most `msec' milliseconds for an event.
		local
			event: detachable NS_EVENT
			until_time: NS_DATE
		do
			create until_time.make_with_time_interval_since_now (msec / 1000.0)
			event := next_event ({NS_APPLICATION_API}.ns_any_event_mask, until_time, default_run_loop_mode, false)
		end

	is_in_transport: BOOLEAN
		-- Is application currently in transport (either PND or docking)?

	pick_and_drop_source: detachable EV_PICK_AND_DROPABLE_IMP
			-- Source of pick and drop if any.
		do
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
--			if attached idle_action_mutex then
--				idle_action_mutex.lock
--			end
-- DEADLOCK in TEXT_PANEL.update_scroll_agent because the agent is an idle action (lock acquired before execution) and calls remove_idle_action which tries to acquire the lock again
-- FIXME: This is because MUTEX is reentrant on windows, but not so on Unix
		end

	try_lock: BOOLEAN
			-- Try to see if we can lock, False means no lock could be attained
		do
			if idle_action_mutex /= Void then
				Result := idle_action_mutex.try_lock
			else
				-- Return true if mono-threaded.
				Result := True
			end
		end

	unlock
			-- Unlock the Mutex.
		do
			if idle_action_mutex /= Void then
				idle_action_mutex.unlock
			end
		end

feature {NONE} -- Thread implementation

	idle_action_mutex: detachable MUTEX note option: stable attribute end
			-- Mutex used to access idle_actions.

feature {NONE} -- Implementation

	dispose
		do
			Precursor {EV_APPLICATION_I}
			Precursor {NS_APPLICATION}
		end

invariant
	idle_action_mutex_valid: {PLATFORM}.is_thread_capable implies idle_action_mutex /= Void
end -- class EV_APPLICATION_IMP
