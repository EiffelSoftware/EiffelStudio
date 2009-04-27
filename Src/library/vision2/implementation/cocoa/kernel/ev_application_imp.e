indexing
	description:
		"EiffelVision application, Cocoa implementation."
	legal: "See notice at end of class."

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
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	EXECUTION_ENVIRONMENT
		rename
			sleep as nano_sleep,
			launch as ee_launch
		end

	PLATFORM

	EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Set up the callback marshalL
		do
			base_make (an_interface)
			create windows.make
			create application.init
		end

feature -- Access

	ctrl_pressed: BOOLEAN
			-- Is ctrl key currently pressed?
		do
		end

	alt_pressed: BOOLEAN
			-- Is alt key currently pressed?
		do
		end

	shift_pressed: BOOLEAN
			-- Is shift key currently pressed?
		do
		end

	caps_lock_on: BOOLEAN
			-- Is the Caps or Shift Lock key currently on?
		do
		end

	windows: LINKED_LIST [EV_WINDOW]
			-- Global list of windows.

feature -- Basic operation

	process_underlying_toolkit_event_queue is
			-- Process Cocoa events
		local
			event: POINTER
		do
			from
				event := application.next_event(0, {EV_ANY_IMP}.NULL, 0, true)
			until
				event = {EV_ANY_IMP}.NULL
			loop
				application.send_event (event)
				application.update_windows
				event := application.next_event(0, {EV_ANY_IMP}.NULL, 0, true)
			end
		end

	process_graphical_events
			-- Process all pending graphical events and redraws.
		do
		end

	motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			-- Tuple optimizations
		once
		end

	handle_dnd (a_event: POINTER)
			-- Handle drag and drop event.
		do
		end

	sleep (msec: INTEGER) is
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

	keyboard_modifier_mask: INTEGER
			-- Mask representing current keyboard modifiers state.
		do
		end

	enable_debugger
			-- Enable the Eiffel debugger.
		do
		end

	disable_debugger
			-- Disable the Eiffel debugger.
		do
		end

feature -- Thread Handling.

	initialize_threading
			-- Initialize thread support.
		do
		end

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

feature {NONE} -- Idle handling

	on_idle (a_intimer: POINTER; a_instate: INTEGER; a_inuserdata: POINTER)
			-- Callback target. This feature gets called when the application idles
		do
				idle_actions_internal.call (Void)
		end

feature {EV_ANY_I}

	application: NS_APPLICATION;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_APPLICATION_IMP

