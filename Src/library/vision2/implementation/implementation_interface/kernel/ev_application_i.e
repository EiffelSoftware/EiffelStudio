indexing
	description:
		"Eiffel Vision application. Implementation interface.%N%
		%See ev_application.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_APPLICATION_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_APPLICATION_ACTION_SEQUENCES_I

feature {EV_APPLICATION} -- Initialization

	initialize is
			-- Create pick and drop target list.
			-- Set F1 as default help key.
			-- Create default help engine.
		local
			f1_key: EV_KEY
			environment_imp: EV_ENVIRONMENT_IMP
		do
				-- We now set the application in EV_ENVIRONMENT.
			environment_imp ?= (create {EV_ENVIRONMENT}).implementation
			check
				environment_imp_not_void: environment_imp /= Void
			end
			environment_imp.set_application (interface)
			create f1_key.make_with_code ({EV_KEY_CONSTANTS}.Key_f1)
			set_help_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (f1_key, False, False, False))
			set_contextual_help_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (f1_key, False, False, True))
			create {EV_SIMPLE_HELP_ENGINE} help_engine
			create pnd_targets.make (8)
			create dockable_targets.make (8)
			create internal_idle_actions
			create once_idle_actions
			do_once_idle_actions_agent := agent do_once_idle_actions
			set_is_initialized (True)
		end

	launch is
			-- Start the event loop.
		deferred
		end

feature {EV_DOCKABLE_SOURCE_I, EV_DOCKABLE_TARGET_I, EV_SHARED_TRANSPORT_I} -- Access

	dockable_targets: ARRAYED_LIST [INTEGER]

feature -- Access

	pnd_targets: ARRAYED_LIST [INTEGER]
			-- Global list of pick and drop target object ids.

	windows: LINEAR [EV_WINDOW] is
			-- Global list of windows.
		deferred
		end

	locked_window: EV_WINDOW
			-- Window currently locked. Void if no window
			-- is currently locked.
			--
			-- See `{EV_WINDOW}.lock_update' for more details

	captured_widget: EV_WIDGET
			-- Widget currently captured. Void if none.

	help_accelerator: EV_ACCELERATOR
			-- Accelerator that displays contextual help

	contextual_help_accelerator: EV_ACCELERATOR
			-- Accelerator that enables contextual help mode

	help_engine: EV_HELP_ENGINE
			-- Object that handle contextual help display requests

	clipboard: EV_CLIPBOARD is
			-- Native platform clipboard access.
		do
			if clipboard_internal = Void then
				create clipboard_internal
			end
			Result := clipboard_internal
		end

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		deferred
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		deferred
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		deferred
		end

feature -- Element Change

	set_captured_widget (a_captured_widget: EV_WIDGET) is
			-- Set `captured_widget' to the widget that has the current capture 'a_capture_widget'.
		do
			captured_widget := a_captured_widget
		ensure
			captured_widget_set: captured_widget = a_captured_widget
		end

	set_help_accelerator (an_accelerator: EV_ACCELERATOR) is
			-- Assign `an_accelerator' to `help_accelerator'
		require
			an_accelerator_not_void: an_accelerator /= Void
		do
			help_accelerator := an_accelerator
			if not help_accelerator.actions.has (help_handler_procedure) then
				help_accelerator.actions.extend (help_handler_procedure)
			end
		ensure
			help_accelerator_assigned: help_accelerator = an_accelerator
			help_accelerator_complete: help_accelerator.actions.has (help_handler_procedure)
		end

	set_contextual_help_accelerator (an_accelerator: EV_ACCELERATOR) is
			-- Assign `an_accelerator' to `contextual_help_accelerator'
		require
			an_accelerator_not_void: an_accelerator /= Void
		do
			contextual_help_accelerator := an_accelerator
			if not contextual_help_accelerator.actions.has (contextual_help_handler_procedure) then
				contextual_help_accelerator.actions.extend (contextual_help_handler_procedure)
			end
		ensure
			contextual_help_accelerator_assigned: contextual_help_accelerator = an_accelerator
			contextual_help_accelerator_complete: contextual_help_accelerator.actions.has (contextual_help_handler_procedure)
		end

	set_help_engine (an_engine:  EV_HELP_ENGINE) is
			-- Assign `an_engine' to `help_engine'
		require
			an_engine_not_void: an_engine /= Void
		do
			help_engine := an_engine
		ensure
			help_engine_set: help_engine = an_engine
		end

	set_locked_window (a_window: EV_WINDOW) is
			-- Set `locked_window' to `a_window'.
			--
			-- See `{EV_WINDOW}.lock_update' for more details
		do
			locked_window := a_window
		end

feature -- Basic operation

	relinquish_cpu_slice is
			-- Give timeslice back to kernel so as to not take all CPU.
		do
			sleep (10)
		end

	process_events is
			-- Process any pending events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any events that may be in its queue.
		deferred
		end

	process_events_until_stopped is
			-- Process all events until 'stop_processing' is called.
		deferred
		end

	stop_processing is
			--  Exit `process_events_until_stopped'.
		deferred
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		require
			msec_non_negative: msec >= 0
		deferred
		end

	enable_contextual_help is
			-- Change mouse cursor to help cursor
			-- Capture mouse input
			-- Send help context of widget under mouse cursor when left mouse button is pressed to help engine.
			-- Cancel contextual help mode when right mouse button is pressed.
		do
			if focused_widget /= Void then
				captured_widget := focused_widget
				old_pointer_button_press_actions := captured_widget.pointer_button_press_actions
				captured_widget.pointer_button_press_actions.wipe_out
				captured_widget.pointer_button_press_actions.extend_kamikaze (contextual_help_procedure)
				old_pointer_style := captured_widget.pointer_style
				captured_widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).Help_cursor)
				captured_widget.enable_capture
			end
		end

	display_help_for_widget (a_widget: EV_WIDGET) is
			-- Display contextual help for `a_widget', if any.
		require
			a_widget_not_void: a_widget /= Void
		local
			an_help_context: FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT]
		do
			an_help_context := a_widget.help_context
			if an_help_context /= Void then
				help_engine.show (an_help_context.item (Void))
			end
		end

	add_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Extend `idle_actions' with `a_idle_action'.
			-- Thread safe
		require
			a_idle_action_not_void: a_idle_action /= Void
		do
			lock
			if not idle_actions.has (a_idle_action) then
				idle_actions.extend (a_idle_action)
			end
			unlock
		end

	remove_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Remove `a_idle_action' from `idle_actions'
			-- Thread safe
		require
			a_idle_action_not_void: a_idle_action /= Void
		do
			lock
			idle_actions.prune_all (a_idle_action)
			unlock
		end

	lock is
			-- Lock the Mutex.
		deferred
		end

	try_lock: BOOLEAN is
			-- Try to see if we can lock, False means no lock could be attained
		deferred
		end

	unlock is
			-- Unlock the Mutex.
		deferred
		end

feature -- Events

	internal_idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when no events are in queue.

	once_idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be preformed once when no events are in queue.
			-- Wiped out after being called.

	do_once_on_idle (an_action: PROCEDURE [ANY, TUPLE]) is
			-- Perform `an_action' one time only on idle.
		do
			lock
			once_idle_actions.extend (an_action)
			if not internal_idle_actions.has (do_once_idle_actions_agent) then
				internal_idle_actions.extend (do_once_idle_actions_agent)
			end
			unlock
		end

	do_once_idle_actions is
			-- Call `once_idle_actions' then wipe it out.
			-- Remove `do_once_idle_actions_agent' from `internal_idle_actions'.
		local
			snapshot: like once_idle_actions
		do
			snapshot := once_idle_actions.twin
			once_idle_actions.wipe_out
			internal_idle_actions.prune_all (do_once_idle_actions_agent)
			snapshot.call (Void)
		end

	do_once_idle_actions_agent: PROCEDURE [EV_APPLICATION_I, TUPLE]
			-- Agent for `do_once_idle_actions'.

feature -- Event handling

	accelerator_actions (an_accelerator: EV_ACCELERATOR): EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `an_accelerator' key sequence is
			-- pressed.
		do
			create Result
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	tooltip_delay: INTEGER is
			-- Time in milliseconds before tooltips pop up.
		deferred
		end

	focused_widget: EV_WIDGET is
			-- Widget with keyboard focus
		local
			current_windows: like windows
			current_window: EV_WINDOW
		do
			current_windows := windows
			from
				current_windows.start
			until
				current_windows.off or Result /= Void
			loop
				current_window := current_windows.item
				if current_window.has_focus then
					if current_window.full then
						Result := focused_widget_from_container (current_window.item)
					else
						Result := current_window
					end
				end
				current_windows.forth
			end
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		require
			a_delay_non_negative: a_delay >= 0
		deferred
		ensure
			assigned: tooltip_delay = a_delay
		end

feature -- Implementation

	interface: EV_APPLICATION
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	target_menu (a_pebble: ANY): EV_MENU is
			-- Menu of targets that accept `a_pebble'.
		local
			cur: CURSOR
			trg: EV_ABSTRACT_PICK_AND_DROPABLE
			i: EV_MENU_ITEM
			targets: like pnd_targets
			identified: IDENTIFIED
			sensitive: EV_SENSITIVE
		do
			targets := pnd_targets
			create Result
			create identified
			cur := targets.cursor
			from
				targets.start
			until
				targets.after
			loop
				trg ?= identified.id_object (targets.item)
				if trg /= Void then
					if
						trg.drop_actions.accepts_pebble (a_pebble)
					then
						sensitive ?= trg
						if not (sensitive /= Void and not sensitive.is_sensitive) then
							if trg.target_name /= Void then
								create i.make_with_text (
									trg.target_name
								)
								Result.extend (i)
								i.select_actions.extend (agent
									(trg.drop_actions).call ([a_pebble])
								)
							end
						end
					end
				end
				targets.forth
			end
			targets.go_to (cur)
		end

feature {NONE} -- Debug

	trace is
			-- Output all PND targets.
		local
			cur: CURSOR
			trg: EV_ABSTRACT_PICK_AND_DROPABLE
			identified: IDENTIFIED
		do
			cur := pnd_targets.cursor
			create identified
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				trg ?= identified.id_object (pnd_targets.item)
				if trg /= Void then
					io.error.put_string (trg.target_name.as_string_8)
				end
				pnd_targets.forth
			end
			pnd_targets.go_to (cur)
		end

feature -- Implementation

	call_post_launch_actions is
			-- Call the post launch actions.
		local
			retried: BOOLEAN
		do
			if not retried then
				post_launch_actions.call (Void)
			else
				on_exception_action (new_exception)
			end
		rescue
			retried := True
			retry
		end

	call_idle_actions is
			-- Call idle actions.
		local
			retried: BOOLEAN
			l_locked: BOOLEAN
		do
			if not retried then
					-- Call the opo idle actions only if there are actions available.
				if try_lock then
					l_locked := True
					if not internal_idle_actions.is_empty then
						internal_idle_actions.call (Void)
					elseif idle_actions_internal /= Void then
						idle_actions_internal.call (Void)
					end
					unlock
					l_locked := False
				end
			else
				on_exception_action (new_exception)
			end
		rescue
			if l_locked then
				unlock
				l_locked := False
			end
			retried := True
			retry
		end

	on_exception_action (an_exception: EXCEPTION) is
			-- Call exception actions.
		require
			an_exception_not_void: an_exception /= Void
		do
			if uncaught_exception_actions_internal /= Void and then not uncaught_exception_actions_called then
				uncaught_exception_actions_called := True
				uncaught_exception_actions_internal.call ([an_exception])
				uncaught_exception_actions_called := False
			end
		end

	uncaught_exception_actions_called: BOOLEAN
			-- Are the `uncaught_exceptions_actions' currently being called?
			-- This is used to prevent infinite looping should an exception be raised as part of calling `uncaught_exception_actions'.

	new_exception: EXCEPTION is
			-- New exception object representating the last exception caught in Current
		local
			l_exceptions: EXCEPTIONS
			l_tag: STRING
			l_trace: STRING
		do
			create l_exceptions
			l_tag := l_exceptions.tag_name
			if l_tag = Void then
				l_tag := "No tag"
			end
			l_trace := l_exceptions.exception_trace
			if l_trace = Void then
				l_trace := "No trace"
			end
			create Result.make_with_tag_and_trace (l_tag, l_trace)
		ensure
			new_exception_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	stop_processing_requested: BOOLEAN
			-- Has 'stop_processing' been called?

	clipboard_internal: EV_CLIPBOARD
			-- Internal clipboard object.

	old_pointer_style: EV_CURSOR
			-- Pointer style of window being used while contextual help is enabled

 	old_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Button press actions of window being used whie contextual help is enabled

	screen: EV_SCREEN is
			-- Screen object used to retrieve widget under mouse pointer
		once
			create Result
		end

	help_handler_procedure: PROCEDURE [ANY, TUPLE] is
			-- Help handler procedure associated with help accelerator
		once
			Result := agent help_handler
		end

	help_handler is
			-- Display contextual help for currently focused widget.
		local
			w: EV_WIDGET
		do
			w := focused_widget
			if w /= Void then
				display_help_for_widget (w)
			end
		end

	contextual_help_handler_procedure: PROCEDURE [ANY, TUPLE] is
			-- Help handler procedure associated with context help accelerator
		once
			Result := agent enable_contextual_help
		end

	contextual_help_procedure: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]] is
			-- Called when mouse pointer is pressed while contextual help is enabled
		once
			Result := agent contextual_help
		end

	contextual_help (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Send help context of widget under mouse cursor when left mouse button is pressed to help engine.
			-- Cancel contextual help mode when right mouse button is pressed.
		local
			w: EV_WIDGET
		do
			if button = 1 then
				disable_contextual_help
				w := screen.widget_at_position (screen_x, screen_y)
				if w /= Void then
					display_help_for_widget (w)
				end
			end
		end

	disable_contextual_help is
			-- Disable contextual help: remove capture and restore mouse pointer style.
		do
			check
				valid_capture_widget: captured_widget /= Void
			end
			if old_pointer_button_press_actions /= Void then
				captured_widget.pointer_button_press_actions.fill (old_pointer_button_press_actions)
			end
			check
				valid_old_pointer_style: old_pointer_style /= Void
			end
			captured_widget.set_pointer_style (old_pointer_style)
			captured_widget.disable_capture
		end

	focused_widget_from_container (a_widget: EV_WIDGET): EV_WIDGET is
			-- Child widget of `a_widget' with keyboard focus, if any
		local
			a_container: EV_CONTAINER
			a_widget_list: LINEAR [EV_WIDGET]
			chain: CHAIN [EV_WIDGET]
			cursor: CURSOR
		do
			if a_widget.has_focus then
				Result := a_widget
			else
				a_container ?= a_widget
				if a_container /= Void then
					chain ?= a_container
					if chain /= Void then
						cursor := chain.cursor
					end
					from
						a_widget_list := a_container.linear_representation
						a_widget_list.start
					until
						a_widget_list.off or Result /= Void
					loop
						Result := focused_widget_from_container (a_widget_list.item)
						a_widget_list.forth
					end
					if chain /= Void then
						chain.go_to (cursor)
					end
				end
			end
		ensure
			focused_widget: Result /= Void implies Result.has_focus
		end

invariant
	dockable_targets_not_void: is_usable implies dockable_targets /= Void
	pnd_targets_not_void: is_usable implies pnd_targets /= void
	windows_not_void: is_usable implies windows /= void
	internal_idle_actions_not_void: is_usable implies
		internal_idle_actions /= Void
	once_idle_actions_not_void: is_usable implies
		once_idle_actions /= Void
	do_once_idle_actions_agent: is_usable implies
		do_once_idle_actions_agent /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_APPLICATION_I

