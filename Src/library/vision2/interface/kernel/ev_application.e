note
	description:
		"Eiffel Vision Application.%N%
		%To start an Eiffel Vision application: create exactly one%
		%EV_APPLICATION object and call `launch' after setting up initial%
		%window(s)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_APPLICATION

inherit
	EV_ANY
		redefine
			implementation,
			initialize
		end

	EV_APPLICATION_ACTION_SEQUENCES

feature {NONE} -- Initialization is

	initialize
			-- Mark `Current' as initialized.
		local
			scoop_support: ISE_SCOOP_RUNTIME
		do
				-- Make sure that EV_APPLICATION, which contains the GUI elements
				-- and the event dispatching thread, is only accessed by one specific thread.
			create scoop_support
			scoop_support.pin_to_thread

			set_tooltip_delay (default_tooltip_delay)
			Precursor
				-- We need to create implementation here
		ensure then
			tooltip_delay_initialized: tooltip_delay = default_tooltip_delay
		end

feature -- Access

	windows: LINEAR [EV_WINDOW]
			-- All of the application's windows.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.windows
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.windows)
		end

	locked_window: detachable EV_WINDOW
			-- Window currently locked. Void if no window
			-- is currently locked.
			--
			-- See `{EV_WINDOW}.lock_update' for more details
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.locked_window
		end

	captured_widget: detachable EV_WIDGET
			-- Widget currently captured. Void if none.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.captured_widget
		end

	help_accelerator: EV_ACCELERATOR
			-- Accelerator that displays contextual help
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.help_accelerator
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.help_accelerator)
		end

	contextual_help_accelerator: EV_ACCELERATOR
			-- Accelerator that enables contextual help mode
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.contextual_help_accelerator
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal
				(implementation.contextual_help_accelerator)
		end

	help_engine: EV_HELP_ENGINE
			-- Object that handles contextual help display requests
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.help_engine
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.help_engine)
		end

	clipboard: EV_CLIPBOARD
			-- Native platform clipboard access.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.clipboard
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.clipboard)
		end

feature -- Element Change

	set_help_accelerator (an_accelerator: EV_ACCELERATOR)
			-- Assign `an_accelerator' to `help_accelerator'
		require
			not_destroyed: not is_destroyed
			an_accelerator_not_void: an_accelerator /= Void
		do
			implementation.set_help_accelerator (an_accelerator)
		ensure
			help_accelerator_assigned: help_accelerator = an_accelerator
		end

	set_contextual_help_accelerator (an_accelerator: EV_ACCELERATOR)
			-- Assign `an_accelerator' to `contextual_help_accelerator'
		require
			not_destroyed: not is_destroyed
			an_accelerator_not_void: an_accelerator /= Void
		do
			implementation.set_contextual_help_accelerator (an_accelerator)
		ensure
			contextual_help_accelerator_assigned:
				contextual_help_accelerator = an_accelerator
		end

	set_help_engine (an_engine:  EV_HELP_ENGINE)
			-- Assign `an_engine' to `help_engine'
		require
			not_destroyed: not is_destroyed
			an_engine_not_void: an_engine /= Void
		do
			implementation.set_help_engine (an_engine)
		ensure
			help_engine_set: help_engine = an_engine
		end

feature -- Basic operation

	launch
			-- Start the application.
			-- This begins the event processing loop.
		require
			not_destroyed: not is_destroyed
			not_already_launched: not is_launched
		local
			l_handler: like application_handler
		do
			is_launched := True
			create l_handler.make (Current)
			application_handler := l_handler
			internal_launch_application (l_handler)
		ensure
			is_launched: is_launched
		rescue
			is_launched := False
		end

	process_events
			-- Process any pending events.
			-- Pass control to the underlying native toolkit so that it can
			-- handle any events that may be in its queue.
			-- (Should be called from time to time during extended computation.)
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.process_events
		end

	process_events_until_stopped
			-- Process all events until 'stop_processing' is called.
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.process_events_until_stopped
		end

	process_graphical_events
			-- Process any pending paint events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any paint events that may be in its queue.
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.process_graphical_events
		end

	stop_processing
			--  Exit `process_events_until_stopped'.
		require
			not_destroyed: not is_destroyed
			is_launched: is_launched
		do
			implementation.stop_processing
		end

	sleep (msec: INTEGER)
			-- Wait for `msec' milliseconds and return.
		require
			not_destroyed: not is_destroyed
			msec_non_negative: msec >= 0
		do
			implementation.sleep (msec)
		end

	enable_contextual_help
			-- Change mouse cursor to help cursor.
			-- Capture mouse input.
			-- Send help context of widget being clicked to help engine for
			-- processing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_contextual_help
		end

	display_help_for_widget (a_widget: EV_WIDGET)
			-- Display contextual help for `a_widget', if any.
		require
			not_destroyed: not is_destroyed
			a_widget_not_void: a_widget /= Void
		do
			implementation.display_help_for_widget (a_widget)
		end

feature -- Status report

	is_launched: BOOLEAN
			-- Has `launch' been called?

	tooltip_delay: INTEGER
			-- Time in milliseconds which the pointer must be stationary over
			-- a widget before a tooltip appears.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tooltip_delay
		ensure
			bridge_ok: Result = implementation.tooltip_delay
		end

	default_tooltip_delay: INTEGER = 500
			-- Default delay in milleseconds for tooltips.

	focused_widget: detachable EV_WIDGET
			-- Widget that has keyboard focus.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.focused_widget
		ensure
			bridge_ok: Result = implementation.focused_widget
		end

	transport_in_progress: BOOLEAN
			-- Is a Pick and Drop transport currently in progress?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.transport_in_progress
		end

	ctrl_pressed: BOOLEAN
			-- Is ctrl key currently pressed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.ctrl_pressed
		end

	alt_pressed: BOOLEAN
			-- Is alt key currently pressed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.alt_pressed
		end

	shift_pressed: BOOLEAN
			-- Is shift key currently pressed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.shift_pressed
		end

	caps_lock_on: BOOLEAN
			-- Is caps lock key currently on?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.caps_lock_on
		end

	is_display_remote: BOOLEAN
			-- Is application display remote?
			-- This function is primarily to determine if drawing to the display is optimal.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_display_remote
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER)
			-- Assign `a_delay' to `tooltip_delay'.
		require
			not_destroyed: not is_destroyed
			a_delay_non_negative: a_delay >= 0
		do
			implementation.set_tooltip_delay (a_delay)
		ensure
			assigned: tooltip_delay = a_delay
		end

feature -- Event handling

	add_idle_action_kamikaze, do_once_on_idle (an_action: separate PROCEDURE)
			-- Perform `an_action' one time when the application is next idle.
			-- Thread safe
		require
			not_destroyed: not is_destroyed
		do
			implementation.do_once_on_idle (an_action)
		end

	add_idle_action (a_idle_action: PROCEDURE)
			-- Add `a_idle_actions' to `idle_actions' if not already present.
			-- Thread safe
		require
			a_idle_action_not_void: a_idle_action /= Void
		do
			implementation.add_idle_action (a_idle_action)
		end

	remove_idle_action (a_idle_action: PROCEDURE)
			-- Remove `a_idle_action' from `idle_actions'.
			-- Thread safe.
		require
			a_idle_action_not_void: a_idle_action /= Void
		do
			implementation.remove_idle_action (a_idle_action)
		end

feature {EV_WINDOW} -- Window registry

	register_window (w: EV_WINDOW)
			-- Register a window `w' to prevent it from being garbage-collected
			-- in case there is no reference to it in the system
			-- but the associated window is visible.
			-- Because of the last condition the recommended way to use the feature is
			-- to call it after the window is shown using `show' or similar feature
			-- to make sure after the call to it the window is still open.
			-- (The window may become closed as a result of processing of user interaction,
			-- e.g. this may happen with dialogs).
			-- See also: `unregister_window'.
		do
			if
				not registered_windows.has (w) and then
				not w.is_destroyed and then
				w.is_show_requested
			then
				registered_windows.extend (w)
			end
		ensure
			is_registered: (not w.is_destroyed and then w.is_show_requested) implies registered_windows.has (w)
		end

	unregister_window (w: EV_WINDOW)
			-- Unregister a window `w' to allow it for being garbage-collected
			-- if the corresponding window is hidden.
			-- Because of the last condition the recommended way to use the feature is
			-- to call it after the window is hidden using `hide' or similar feature
			-- to make sure after the call to it the window is closed.
			-- (The window may stay open as a result of processing of user interaction.)
			-- See also: `register_window'.
		do
			if w.is_destroyed or else not w.is_show_requested then
				registered_windows.start
				registered_windows.prune (w)
			end
		ensure
			is_unregistered: (w.is_destroyed or else not w.is_show_requested) implies not registered_windows.has (w)
		end

feature {NONE} -- Window registry

	registered_windows: ARRAYED_LIST [EV_WINDOW]
			-- A list of registered windows.

feature {EV_ANY, EV_ANY_I, EV_ABSTRACT_PICK_AND_DROPABLE, EV_SHARED_TRANSPORT_I, EXCEPTIONS, EV_ANY_HANDLER} -- Implementation

	implementation: EV_APPLICATION_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		local
			l_environment: EV_ENVIRONMENT
		do
				-- Set the application implementation object from the shared one in EV_ENVIRONMENT.
			create l_environment
			implementation := l_environment.implementation.application_i
			create registered_windows.make (1)
		end

	internal_launch_application (a_handler: separate EV_APPLICATION_HANDLER)
			-- Call launch on `a_handler'
		do
			implementation.call_post_launch_actions
			a_handler.launch
		end

	application_handler: detachable separate EV_APPLICATION_HANDLER
			-- A processor that will log calls to the current processor to process graphical events.
			-- This is required so that the main GUI processor can logged calls (i.e. its main creation
			-- procedure has exited).

invariant
	tooltip_delay_not_negative: tooltip_delay >= 0

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
