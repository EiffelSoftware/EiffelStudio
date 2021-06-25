note
	description:
		"[
			Eiffel Vision application. Implementation interface.
			See `{EV_APPLICATION}`.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_APPLICATION_I

inherit
	EV_ANY_I
		export
			{ANY} attached_interface
		redefine
			interface
		end

	EV_APPLICATION_ACTION_SEQUENCES_I

	EXCEPTIONS

	MEMORY

feature -- Initialization

	old_make (an_interface: attached like interface)
		do
			assign_interface (an_interface)
		end

	make
			-- Create pick and drop target list.
			-- Set F1 as default help key.
			-- Create default help engine.
		local
			f1_key: EV_KEY
		do
			create kamikaze_actions.make (25)
			if {PLATFORM}.is_thread_capable then
					-- Create the idle action mutexes if target is thread capable.
				create idle_action_mutex.make
				create kamikaze_action_mutex.make
			end

				-- Create and initialize action sequences.
			create pnd_targets.make (8)
			create dockable_targets.make (8)

				-- Initialize contextual help.
			create {EV_SIMPLE_HELP_ENGINE} help_engine
			create f1_key.make_with_code ({EV_KEY_CONSTANTS}.Key_f1)
				-- Create accelerators before hand to satisfy void safety
			create help_accelerator.make_with_key_combination (f1_key, False, False, False)
			create contextual_help_accelerator.make_with_key_combination (f1_key, False, False, True)

			help_handler_procedure := agent help_handler
			contextual_help_handler_procedure := agent enable_contextual_help

				-- Hookup accelerators with implementation.
			set_help_accelerator (help_accelerator)
			set_contextual_help_accelerator (contextual_help_accelerator)

				-- Set this thread as the gui thread.
			is_gui_thread_cell.put (True)

				-- Create idle actions as this is called in the event loop.
			idle_actions.call (Void)

			idle_iteration_count := 1
				-- Enable `invoke_garbage_collection_when_inactive'.
			set_invoke_garbage_collection_when_inactive (True)
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Implementation

	cpu_relinquishment_time: INTEGER = 20
			-- Number of milliseconds to relinquish CPU when idling.

	idle_iteration_count: NATURAL_32
			-- Number of iterations that the application has been idle.

	idle_iteration_boundary: NATURAL_32 = 1500
			-- Number of iterations before forcing Garbage Collector to kick in.
			-- 30 Seconds = 30 * 1000 / sleep time

	idle_actions_snapshot: detachable SPECIAL [PROCEDURE]
			-- Idle actions snapshot used for temporarily storing a copy of `idle_actions' during its iteration.
		note
			option: stable
		attribute
		end

	kamikaze_idle_actions_snapshot: detachable SPECIAL [separate PROCEDURE]
			-- Kamikaze Idle actions snapshot used for temporarily storing a copy of `kamikaze_idle_actions' during its iteration.
		note
			option: stable
		attribute
		end

feature {EV_APPLICATION, EV_ANY_HANDLER, EV_ANY_I} -- Implementation

	process_event_queue (a_relinquish_cpu: BOOLEAN)
			-- Process all posted events on the event queue.
			-- CPU will be relinquished if `a_relinquish_cpu' and idle actions are successfully executed.
		local
			l_idle_actions_internal: like idle_actions_internal
			l_idle_is_locked, l_kamikaze_is_locked: BOOLEAN
			l_retry_count: INTEGER
			l_idle_actions_snapshot: detachable SPECIAL [PROCEDURE]
			l_kamikaze_idle_actions_snapshot: detachable SPECIAL [separate PROCEDURE]
			i, l_count: INTEGER
		do
			if l_retry_count = 0 then
				process_underlying_toolkit_event_queue
					-- There are no more events left so call idle actions if read lock can be attained.
				if user_events_processed_from_underlying_toolkit then
						-- If any user events have been processed then we reset the `idle_iteration_count'
					idle_iteration_count := 1
				elseif a_relinquish_cpu and then not events_processed_from_underlying_toolkit then
						-- We only want to increase the count if the event loop is not forced and no events were processed.
					idle_iteration_count := idle_iteration_count + 1
					if idle_iteration_count = idle_iteration_boundary then
							-- We have reached a fully idle/inactive state.
						if invoke_garbage_collection_when_inactive then
							full_collect
							full_coalesce
						end
						idle_iteration_count := 1
					end
				else
					idle_iteration_count := 1
						-- Reset idle iteration counter if CPU is not relinquished.
				end
				l_idle_actions_internal := idle_actions_internal
				if not is_destroyed and then l_idle_actions_internal /= Void and then not events_processed_from_underlying_toolkit then
					if try_kamikaze_lock then
						l_kamikaze_is_locked := True
							-- Make a snapshot of the idle actions to avoid side effects.

						if kamikaze_idle_actions_snapshot = Void then
							if kamikaze_actions.count > 0 then
								kamikaze_idle_actions_snapshot := kamikaze_actions.area.twin
								l_kamikaze_idle_actions_snapshot := kamikaze_idle_actions_snapshot
							end
						else
							if idle_actions_executing and kamikaze_idle_actions_snapshot.count > 0 then
									-- We are doing a recursive call to the idle actions, we need to create a copy.
								kamikaze_idle_actions_snapshot := kamikaze_idle_actions_snapshot.resized_area (kamikaze_actions.count)
							else
								kamikaze_idle_actions_snapshot := kamikaze_idle_actions_snapshot.aliased_resized_area (kamikaze_actions.count)
							end
							kamikaze_idle_actions_snapshot.copy_data (kamikaze_actions.area, 0, 0, kamikaze_actions.count)
							l_kamikaze_idle_actions_snapshot := kamikaze_idle_actions_snapshot
						end

							-- Wipe out the kamikaze actions as we now have a snapshot.
						if l_kamikaze_idle_actions_snapshot /= Void then
							kamikaze_actions.wipe_out
						end

						kamikaze_unlock
						l_kamikaze_is_locked := False
					end

					if try_idle_lock then
						l_idle_is_locked := True
						if idle_actions_snapshot = Void then
							if l_idle_actions_internal.count > 0 then
								idle_actions_snapshot := l_idle_actions_internal.area.twin
								l_idle_actions_snapshot := idle_actions_snapshot
							end
						else
							if idle_actions_executing and idle_actions_snapshot.count > 0 then
									-- We are doing a recursive call to the idle actions, we need to create a copy.
								idle_actions_snapshot := idle_actions_snapshot.resized_area (l_idle_actions_internal.count)
							else
								idle_actions_snapshot := idle_actions_snapshot.aliased_resized_area (l_idle_actions_internal.count)
							end
							idle_actions_snapshot.copy_data (l_idle_actions_internal.area, 0, 0, l_idle_actions_internal.count)
							l_idle_actions_snapshot := idle_actions_snapshot
						end

							-- We can now unlock the resource as we have our own local copy.
						idle_unlock
						l_idle_is_locked := False
					end

						-- Set `idle_actions_executing' flag to avoid recursive idle actions execution.
					idle_actions_executing := True
					if l_kamikaze_idle_actions_snapshot /= Void then
						from
							i := 0
							l_count := l_kamikaze_idle_actions_snapshot.count
						until
							i = l_count or else is_destroyed
						loop
							call_separate_action (l_kamikaze_idle_actions_snapshot [i])
							i := i + 1
						end
							-- Wipeout snapshot list to signify that that any nested idle calls do not have to clone the snapshot
						l_kamikaze_idle_actions_snapshot.wipe_out
					end
					if l_idle_actions_snapshot /= Void then
						from
							l_count := l_idle_actions_snapshot.count
							i := 0
						until
							i = l_count or else is_destroyed
						loop
							l_idle_actions_snapshot [i].call (Void)
							i := i + 1
						end
							-- Clear snapshot list.
						l_idle_actions_snapshot.wipe_out
					end
					idle_actions_executing := False

					if a_relinquish_cpu and then not is_destroyed then
							-- Relinquish CPU if requested and no more events are available to be processed.
						process_underlying_toolkit_event_queue
						if not events_processed_from_underlying_toolkit and then kamikaze_actions.count = 0 then
							wait_for_input (cpu_relinquishment_time)
						end
					end
				end
			else
				if l_retry_count = 1 then
					on_exception_action (new_exception)
				end
			end
		rescue
			idle_actions_executing := False
			if l_kamikaze_is_locked then
				l_kamikaze_is_locked := False
				kamikaze_unlock
			end
			if l_idle_is_locked then
				l_idle_is_locked := False
				idle_unlock
			end
			if l_retry_count = 0 then
				l_retry_count := l_retry_count + 1
				retry
			end
		end

	idle_actions_executing: BOOLEAN
			-- Are the idle actions currently being executed?
			-- We need this flag to prevent recursive calls to idle actions from the GUI thread.

	call_separate_action (a_action: separate PROCEDURE)
			-- Execute `call' on 'a_action'.
		do
			a_action.call (Void)
		end

feature {NONE} -- Implementation

	process_underlying_toolkit_event_queue
			-- Process event queue from underlying toolkit.
			-- `events_process_from_toolkit
		deferred
		end

	events_processed_from_underlying_toolkit: BOOLEAN
			-- Were any events processed in previous call to `process_underlying_toolkit_event_queue'?

	user_events_processed_from_underlying_toolkit: BOOLEAN
			-- Were user generated events processed in previous call to `process_underlying_toolkit_event_queue'?

feature {EV_DOCKABLE_SOURCE_I, EV_DOCKABLE_TARGET_I, EV_SHARED_TRANSPORT_I} -- Access

	dockable_targets: ARRAYED_LIST [INTEGER]

feature -- Access

	invoke_garbage_collection_when_inactive: BOOLEAN
			-- Should garbage collection be invoked when application is inactive.

	pnd_targets: HASH_TABLE [INTEGER, INTEGER]
			-- Global list of pick and drop target object ids.

	windows: LINEAR [EV_WINDOW]
			-- Global list of windows.
		deferred
		end

	locked_window: detachable EV_WINDOW
			-- Window currently locked. Void if no window
			-- is currently locked.
			--
			-- See `{EV_WINDOW}.lock_update' for more details

	captured_widget: detachable EV_WIDGET
			-- Widget currently captured. Void if none.

	pick_and_drop_source: detachable EV_PICK_AND_DROPABLE_I
			-- The current pick and drop source.
		deferred
		end

	help_accelerator: EV_ACCELERATOR
			-- Accelerator that displays contextual help

	contextual_help_accelerator: EV_ACCELERATOR
			-- Accelerator that enables contextual help mode

	help_engine: EV_HELP_ENGINE
			-- Object that handle contextual help display requests

	clipboard: EV_CLIPBOARD
			-- Native platform clipboard access.
		do
			if clipboard_internal = Void then
				create clipboard_internal
			end
			Result := clipboard_internal
		end

	ctrl_pressed: BOOLEAN
			-- Is ctrl key currently pressed?
		deferred
		end

	shift_pressed: BOOLEAN
			-- Is shift key currently pressed?
		deferred
		end

	alt_pressed: BOOLEAN
			-- Is alt key currently pressed?
		deferred
		end

	caps_lock_on: BOOLEAN
			-- Is the Caps Lock key currently on?
		deferred
		end

	transport_in_progress: BOOLEAN
			-- Is a Pick and Drop transport currently in progress?
		do
			Result := pick_and_drop_source /= Void
		end

	is_display_remote: BOOLEAN
			-- Is application display remote?
			-- This function is primarily to determine if drawing to the display is optimal.
		deferred
		end

feature -- Element Change

	set_invoke_garbage_collection_when_inactive (a_enabled: BOOLEAN)
			-- Set `invoke_garbage_collection_when_inactive' to `a_enabled'.
		do
			invoke_garbage_collection_when_inactive := a_enabled
		end

	set_captured_widget (a_captured_widget: detachable EV_WIDGET)
			-- Set `captured_widget' to the widget that has the current capture 'a_capture_widget'.
		do
			captured_widget := a_captured_widget
		ensure
			captured_widget_set: captured_widget = a_captured_widget
		end

	set_help_accelerator (an_accelerator: EV_ACCELERATOR)
			-- Assign `an_accelerator' to `help_accelerator'
		require
			an_accelerator_not_void: an_accelerator /= Void
		do
			help_accelerator := an_accelerator
			if help_handler_procedure /= Void and then not help_accelerator.actions.has (help_handler_procedure) then
				help_accelerator.actions.extend (help_handler_procedure)
			end
		ensure
			help_accelerator_assigned: help_accelerator = an_accelerator
			help_accelerator_complete: attached help_handler_procedure and then help_accelerator.actions.has (help_handler_procedure)
		end

	set_contextual_help_accelerator (an_accelerator: EV_ACCELERATOR)
			-- Assign `an_accelerator' to `contextual_help_accelerator'
		require
			an_accelerator_not_void: an_accelerator /= Void
		do
			contextual_help_accelerator := an_accelerator
			if contextual_help_handler_procedure /= Void and then not contextual_help_accelerator.actions.has (contextual_help_handler_procedure) then
				contextual_help_accelerator.actions.extend (contextual_help_handler_procedure)
			end
		ensure
			contextual_help_accelerator_assigned: contextual_help_accelerator = an_accelerator
			contextual_help_accelerator_complete: attached contextual_help_handler_procedure and then contextual_help_accelerator.actions.has (contextual_help_handler_procedure)
		end

	set_help_engine (an_engine: EV_HELP_ENGINE)
			-- Assign `an_engine' to `help_engine'
		require
			an_engine_not_void: an_engine /= Void
		do
			help_engine := an_engine
		ensure
			help_engine_set: help_engine = an_engine
		end

	set_locked_window (a_window: detachable EV_WINDOW)
			-- Set `locked_window' to `a_window'.
			--
			-- See `{EV_WINDOW}.lock_update' for more details
		do
			locked_window := a_window
		end

feature -- Basic operation

	process_events
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		do
			process_event_queue (False)
		end

	process_graphical_events
			-- Process any pending paint events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any paint events that may be in its queue.
		deferred
		end

	process_events_until_stopped
			-- Process all events until 'stop_processing' is called.
		do
			from
				stop_processing_requested := False
			until
				stop_processing_requested or else is_destroyed
			loop
				process_event_queue (True)
			end
		end

	stop_processing
			--  Exit `process_events_until_stopped'.
		do
			stop_processing_requested := True
		end

	sleep (msec: INTEGER)
			-- Wait for `msec' milliseconds and return.
		require
			msec_non_negative: msec >= 0
		deferred
		end

	enable_contextual_help
			-- Change mouse cursor to help cursor
			-- Capture mouse input
			-- Send help context of widget under mouse cursor when left mouse button is pressed to help engine.
			-- Cancel contextual help mode when right mouse button is pressed.
		do
			if attached focused_widget as l_focused_widget then
				captured_widget := l_focused_widget
				old_pointer_button_press_actions := l_focused_widget.pointer_button_press_actions
				l_focused_widget.pointer_button_press_actions.wipe_out
				l_focused_widget.pointer_button_press_actions.extend_kamikaze (contextual_help_procedure)
				old_pointer_style := l_focused_widget.pointer_style
				l_focused_widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).Help_cursor)
				l_focused_widget.enable_capture
			end
		end

	display_help_for_widget (a_widget: EV_WIDGET)
			-- Display contextual help for `a_widget', if any.
		require
			a_widget_not_void: a_widget /= Void
		local
			an_help_context: detachable FUNCTION [EV_HELP_CONTEXT]
		do
			an_help_context := a_widget.help_context
			if an_help_context /= Void then
				help_engine.show (an_help_context.item (Void))
			end
		end

	add_idle_action (a_idle_action: PROCEDURE)
			-- Extend `idle_actions' with `a_idle_action'.
			-- Thread safe
		require
			a_idle_action_not_void: a_idle_action /= Void
		do
			idle_lock
			if not idle_actions.has (a_idle_action) and then idle_actions_internal /= Void then
				idle_actions_internal.extend (a_idle_action)
			end
			idle_unlock
		end

	remove_idle_action (a_idle_action: PROCEDURE)
			-- Remove `a_idle_action' from `idle_actions'
			-- Thread safe
		require
			a_idle_action_not_void: a_idle_action /= Void
		local
			l_cursor: CURSOR
			l_idle_actions: like idle_actions
		do
			idle_lock
			l_idle_actions := idle_actions
			l_cursor := l_idle_actions.cursor
			l_idle_actions.prune_all (a_idle_action)
			if l_idle_actions.valid_cursor (l_cursor) then
				l_idle_actions.go_to (l_cursor)
			end
			idle_unlock

				-- Remove from kamikaze list if present.
			kamikaze_lock
			kamikaze_actions.prune_all (a_idle_action)
			kamikaze_unlock
		end

	idle_lock
			-- Lock the Idle Actions Mutex.
		do
			if idle_action_mutex /= Void then
				idle_action_mutex.lock
			end
		end

	try_idle_lock: BOOLEAN
			-- Attempt to lock the Idle Actions Mutex. True if successful.
		do
			if idle_action_mutex /= Void then
				Result := idle_action_mutex.try_lock
			else
				Result := True
			end
		end

	idle_unlock
			-- Unlock the Idle Actions Mutex.
		do
			if idle_action_mutex /= Void then
				idle_action_mutex.unlock
			end
		end

	kamikaze_lock
			-- Lock the Kamikaze Actions Mutex.
		do
			if kamikaze_action_mutex /= Void then
				kamikaze_action_mutex.lock
			end
		end

	try_kamikaze_lock: BOOLEAN
			-- Attempt to lock the Kamikaze Actions Mutex. True if successful.
		do
			if kamikaze_action_mutex /= Void then
				Result := kamikaze_action_mutex.try_lock
			else
				Result := True
			end
		end

	kamikaze_unlock
			-- Unlock the Kamikaze Actions Mutex.
		do
			if kamikaze_action_mutex /= Void then
				kamikaze_action_mutex.unlock
			end
		end

feature {NONE} -- Thread implementation

	idle_action_mutex: detachable MUTEX note option: stable attribute end
			-- Mutex used to access idle_actions.

	kamikaze_action_mutex: detachable MUTEX note option: stable attribute end
			-- Mutex used to access kamikaze_actions.

feature -- Events

	do_once_on_idle (an_action: separate PROCEDURE)
			-- Perform `an_action' one time only on idle.
		do
			kamikaze_lock
			if not kamikaze_actions.has (an_action) then
				kamikaze_actions.extend (an_action)
			end
				-- Wake up GUI thread if sleeping.
			if not is_gui_thread then
				wake_up_gui_thread
			end
			kamikaze_unlock
		end

	actions_are_callable: BOOLEAN
			-- May actions be called
		do
				-- If application has been destroyed
			if not is_destroyed then
				increase_action_sequence_call_counter
				Result := True
			end
		end

	increase_action_sequence_call_counter
			-- Increase `action_sequence_call_counter' by one.
		do
			action_sequence_call_counter := action_sequence_call_counter + 1
		end

	action_sequence_call_counter: NATURAL_32
			-- Counter used in post-conditions to determine if any actions sequences have been
			-- called as a result of the routine the post-condition is applied to.

feature -- Event handling

	accelerator_actions (an_accelerator: EV_ACCELERATOR): EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `an_accelerator' key sequence is
			-- pressed.
		do
			create Result
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.
		deferred
		end

	focused_widget: detachable EV_WIDGET
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

	set_tooltip_delay (a_delay: INTEGER)
			-- Set `tooltip_delay' to `a_delay'.
		require
			a_delay_non_negative: a_delay >= 0
		deferred
		ensure
			assigned: tooltip_delay = a_delay
		end

feature -- Implementation

	interface: detachable EV_APPLICATION note option: stable attribute end
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

feature {EV_APPLICATION, EV_PICK_AND_DROPABLE_I} -- Pick and drop

	pnd_screen: EV_SCREEN
			-- Screen object used for drawing PND transport line.
		once
			create Result
			Result.enable_dashed_line_style
			Result.set_foreground_color (stock_colors.white)
			Result.set_invert_mode
		end

	stock_colors: EV_STOCK_COLORS
			-- Once access to default colors
		once
			create Result
		end

feature {EV_PICK_AND_DROPABLE_I} -- Pick and drop

	x_origin, y_origin: INTEGER
			-- Temp coordinate values for origin of Pick and Drop.

	set_x_y_origin (a_x_origin, a_y_origin: INTEGER)
			-- Set `x_origin' and `y_origin' to `a_x_origin' and `a_y_origin' respectively.
		do
			x_origin := a_x_origin
			y_origin := a_y_origin
		end

	rubber_band_is_drawn: BOOLEAN
			-- Is the PnD rubber band drawn on screen?

	draw_rubber_band
			-- Draw a segment between initial pick point and `destination'.
		do
			pnd_screen.draw_segment (x_origin, y_origin, pnd_pointer_x, pnd_pointer_y)
			rubber_band_is_drawn := True
		end

	erase_rubber_band
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				pnd_screen.draw_segment (x_origin, y_origin, pnd_pointer_x, pnd_pointer_y)
				rubber_band_is_drawn := False
			end
		end

	pnd_pointer_x,
	pnd_pointer_y: INTEGER
			-- Position of pointer on previous PND draw.

	set_pnd_pointer_coords (a_pnd_pointer_x, a_pnd_pointer_y: INTEGER)
			-- Set PND pointer origins to `a_pnd_pointer_x' and `a_pnd_pointer_y'.
		do
			pnd_pointer_x := a_pnd_pointer_x
			pnd_pointer_y := a_pnd_pointer_y
		end

	create_target_menu (a_x, a_y, a_screen_x, a_screen_y: INTEGER; a_pnd_source: EV_PICK_AND_DROPABLE; a_pebble: detachable ANY; a_configure_agent: detachable PROCEDURE; a_menu_only: BOOLEAN)
			-- Menu of targets that accept `a_pebble'.
		local
			cur: CURSOR
			targets: like pnd_targets
			identified: detachable IDENTIFIED
			l_item_data: detachable EV_PND_TARGET_DATA
			l_search_tree: detachable BINARY_SEARCH_TREE [PROXY_COMPARABLE [EV_PND_TARGET_DATA]]
			l_object_comparable: PROXY_COMPARABLE [EV_PND_TARGET_DATA]
			l_comparator_agent: PREDICATE [EV_PND_TARGET_DATA, EV_PND_TARGET_DATA]
			l_arrayed_list: ARRAYED_LIST [EV_PND_TARGET_DATA]
			l_alphabetical_sort_agent: PROCEDURE [PROCEDURE, detachable BINARY_SEARCH_TREE [PROXY_COMPARABLE [EV_PND_TARGET_DATA]], ARRAYED_LIST [EV_PND_TARGET_DATA]]
			l_configurable_item_added: BOOLEAN
			l_menu: EV_MENU
			l_menu_count: INTEGER
			l_has_targets: BOOLEAN
			l_pebble: detachable ANY
		do
			targets := pnd_targets
			create l_menu
			create identified
			cur := targets.cursor
			from
				targets.start
					-- Create agent for comparing menu item texts used for alphabetical sorting with PROXY_COMPARABLE.
				l_comparator_agent :=
					agent (first_item, second_item: EV_PND_TARGET_DATA): BOOLEAN
						do
							if attached first_item.name as l_first_name and then attached second_item.name as l_second_name then
								Result := l_first_name < l_second_name
							end
						end
			until
				targets.after
			loop
				if
					attached {EV_ABSTRACT_PICK_AND_DROPABLE} identified.id_object (targets.item_for_iteration) as trg and then
					(not attached {EV_PICK_AND_DROPABLE} trg as pnd_trg or else not pnd_trg.is_destroyed)
				then
					if
						attached a_pebble as l_p and then trg.drop_actions.accepts_pebble (l_p)
					then
						if not (attached {EV_SENSITIVE} trg as sensitive and then
								(not sensitive.is_destroyed and then
									not sensitive.is_sensitive)
							)
						then
							l_has_targets := True
							if not l_configurable_item_added and then a_configure_agent /= Void then
								l_menu.extend (create {EV_MENU_ITEM}.make_with_text_and_action ("Pick", a_configure_agent))
								l_configurable_item_added := True
							end
							if attached trg.target_data_function as l_target_data_function then
								l_item_data := l_target_data_function.item ([l_p])
							end
							if l_item_data /= Void then
								l_item_data.set_target (trg)
								create l_object_comparable.make (l_item_data, l_comparator_agent)
								if l_search_tree = Void then
									create l_search_tree.make (l_object_comparable)
								else
									l_search_tree.put (l_object_comparable)
								end
								l_item_data := Void
							end
						end
					end
				end
				targets.forth
			end

			if l_has_targets then
				create l_arrayed_list.make (0)

				if l_search_tree /= Void then
						-- Sort items alphabetically using recursive inline agent
					l_alphabetical_sort_agent := agent (l_sort_agent: PROCEDURE; a_node: detachable BINARY_SEARCH_TREE [PROXY_COMPARABLE [EV_PND_TARGET_DATA]]; a_list: ARRAYED_LIST [EV_PND_TARGET_DATA])
							do
								if a_node /= Void then
									l_sort_agent.call ([l_sort_agent, a_node.left_child, a_list])
									a_list.extend (a_node.item.item)
									l_sort_agent.call ([l_sort_agent, a_node.right_child, a_list])
								end
							end
						-- Call the recursive agent by passing itself in as the first parameter.
					l_alphabetical_sort_agent.call ([l_alphabetical_sort_agent, l_search_tree, l_arrayed_list])
				end

				l_menu_count := l_menu.count
				if attached a_pnd_source.configurable_target_menu_handler as l_menu_handler then
					l_pebble := a_pebble
						-- Implied by l_has_targets.
					check l_pebble /= Void then
						l_menu_handler.call ([l_menu, l_arrayed_list, a_pnd_source, l_pebble])
					end
				else
					from
						l_arrayed_list.start
					until
						l_arrayed_list.after
					loop
						if attached l_arrayed_list.item.target as l_target then
							l_pebble := a_pebble
								-- Implied by l_has_targets.
							check l_pebble /= Void then
								l_menu.extend (create {EV_MENU_ITEM}.make_with_text_and_action (l_arrayed_list.item.name, agent (l_target.drop_actions).call ([l_pebble])))
							end
						end
						l_arrayed_list.forth
					end
				end
				if not l_menu.is_destroyed and then l_menu.count > l_menu_count then
					l_menu.show_at (Void, a_screen_x - menu_placement_offset, a_screen_y - menu_placement_offset)
				elseif a_configure_agent /= Void and not a_menu_only then
					a_configure_agent.call (Void)
				end
			else
				if attached a_pnd_source.configurable_target_menu_handler as l_configurable_target_menu_handler then
					create l_menu
					l_configurable_target_menu_handler.call ([l_menu, create {ARRAYED_LIST [EV_PND_TARGET_DATA]}.make (0), a_pnd_source, a_pebble])
					if not l_menu.is_destroyed and then l_menu.count > 0 and then not ctrl_pressed then
							-- If the pebble is Void then no menu should be displayed if Ctrl is pressed.
						l_menu.show_at (Void, a_screen_x - menu_placement_offset, a_screen_y - menu_placement_offset)
					end
				end
			end
			if targets.valid_cursor (cur) then
				targets.go_to (cur)
			end
		end

	menu_placement_offset: INTEGER = 3
			-- Offset for both X and Y dimensions to which to move the menu so its placement is directly underneath the mouse pointer.

feature {EV_ANY_I} -- Tab Navigation

	tab_navigation_state: NATURAL_8
			-- Current tab navigation state.

	set_tab_navigation_state (a_state: like tab_navigation_state)
			-- Set `tab_navigation_state' to `a_state'.
		require
			a_valid_state: a_state >= tab_state_none and then a_state <= tab_state_from_next
		do
			tab_navigation_state := a_state
		end

	tab_state_none: NATURAL_8 = 0
	tab_state_from_previous: NATURAL_8 = 1
	tab_state_from_next: NATURAL_8 = 2
			-- Tab navigation states.

feature {NONE} -- Debug

	trace
			-- Output all PND targets.
		local
			cur: CURSOR
			identified: IDENTIFIED
		do
			cur := pnd_targets.cursor
			create identified
			from
				pnd_targets.start
			until
				pnd_targets.after
			loop
				if
					attached {EV_ABSTRACT_PICK_AND_DROPABLE} identified.id_object (pnd_targets.item_for_iteration) as trg and then
					attached trg.target_name as l_target_name
				then
					io.error.put_string (l_target_name.to_string_8)
				end
				pnd_targets.forth
			end
			pnd_targets.go_to (cur)
		end

feature -- Implementation

	call_post_launch_actions
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
			if not retried then
				retried := True
				retry
			end
		end

	on_exception_action (an_exception: EXCEPTION)
			-- Call exception actions.
		require
			an_exception_not_void: an_exception /= Void
		local
			l_dialog: like exception_dialog
		do
				-- Clean up any locked windows of captures.
			if attached locked_window as l_locked_window then
				l_locked_window.unlock_update
			end
			if attached captured_widget as l_captured_widget then
				l_captured_widget.disable_capture
			end
			if
				not uncaught_exception_actions_called and then
				uncaught_exception_actions_internal /= Void and then
				not uncaught_exception_actions.is_empty
			then
				uncaught_exception_actions_called := True
				uncaught_exception_actions.call ([an_exception])
				uncaught_exception_actions_called := False
			else
				if show_exception_dialog then
						-- Show a basic exception dialog so that exception doesn't get lost if undealt with.
					create l_dialog
					exception_dialog := l_dialog
					raise_default_exception_dialog (l_dialog, an_exception)
				end
			end
		end

	raise_default_exception_dialog (a_empty_dialog: EV_DIALOG; an_exception: EXCEPTION)
			-- Raise the exception dialog
		require
			a_empty_dialog_valid: a_empty_dialog /= Void and then not a_empty_dialog.is_destroyed
		local
			l_exception_string: detachable STRING_32
			l_label: EV_TEXT
			l_label_box: EV_HORIZONTAL_BOX
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_font: EV_FONT
			l_ignore, l_quit: EV_BUTTON
			l_frame: EV_FRAME
			l_error_box: EV_HORIZONTAL_BOX
			l_error_label: EV_LABEL
			l_exception_message: READABLE_STRING_GENERAL
		do
			l_exception_string := an_exception.trace
			if l_exception_string /= Void then
				l_exception_string := l_exception_string.twin
				l_exception_string.prune_all ('%R')
			end
			create l_label
			l_label.disable_word_wrapping
			l_label.disable_edit
			create l_font
			l_font.set_family ({EV_FONT_CONSTANTS}.Family_typewriter)
			l_label.set_font (l_font)
			if l_exception_string /= Void then
				l_label.set_text (l_exception_string)
			else
				l_label.set_text ("No trace available.")
			end
			create l_vbox
			create l_error_box
			l_error_box.set_border_width (5)
			l_error_box.set_padding (5)
			l_error_box.extend ((create {EV_STOCK_PIXMAPS}).error_pixmap.twin)
			l_error_box.disable_item_expand (l_error_box.first)
			l_error_box.first.set_minimum_size (32, 32)
			create l_error_label
			l_error_label.align_text_left
			l_error_label.set_text ("The following uncaught exception has occurred:%N%NClick Ignore to continue or Quit to exit the application")
			l_error_box.extend (l_error_label)
			l_vbox.extend (l_error_box)
			l_vbox.disable_item_expand (l_error_box)

			create l_frame
			create l_label_box
			l_frame.extend (l_label_box)
			l_label_box.set_padding (5)
			l_label_box.set_border_width (5)
			l_label_box.extend (l_label)
			l_frame.set_text ("Exception Trace")
			l_vbox.extend (l_frame)
			a_empty_dialog.extend (l_vbox)
			create l_hbox
			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)
			create l_ignore.make_with_text ("Ignore")
			l_ignore.select_actions.extend (agent a_empty_dialog.destroy)
			l_hbox.extend (create {EV_CELL})
			l_hbox.extend (l_ignore)
			l_hbox.disable_item_expand (l_ignore)
			create l_quit.make_with_text ("Quit")
			l_quit.set_minimum_width (l_ignore.minimum_width)
			l_quit.select_actions.extend (agent safe_destroy)
			l_hbox.extend (l_quit)
			l_hbox.disable_item_expand (l_quit)
			l_hbox.set_border_width (5)
			l_hbox.set_padding (5)
			if attached an_exception.description as l_message then
				l_exception_message := l_message
			else
				l_exception_message := ""
			end
			a_empty_dialog.set_title ({STRING_32} "Uncaught Exception: " + l_exception_message)
			a_empty_dialog.set_minimum_height (350)
			a_empty_dialog.set_size (500, 300)
			a_empty_dialog.raise
				--| FIXME Behavior would be better if dialog has full application modality.

				-- Set "Ignore" as the default
			l_ignore.set_focus
		end

	exception_dialog: detachable EV_DIALOG
			-- Dialog used for showing uncaught exceptions.

	show_exception_dialog: BOOLEAN = True
			-- Should the exception dialog be shown by default?

	uncaught_exception_actions_called: BOOLEAN
			-- Are the `uncaught_exceptions_actions' currently being called?
			-- This is used to prevent infinite looping should an exception be raised as part of calling `uncaught_exception_actions'.

	new_exception: EXCEPTION
			-- New exception object representating the last exception caught in Current
		local
			l_result: detachable EXCEPTION
		do
			l_result := exception_manager.last_exception
			check l_result /= Void then end
			Result := l_result
		ensure
			new_exception_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	wake_up_gui_thread
			-- Wake up the GUI thread if sleeping.
		do
				-- By default do nothing, redefined in descendents.
		end

	is_gui_thread: BOOLEAN
			-- Is the currently executing thread a gui thread?
		do
			Result := is_gui_thread_cell.item
		end

	is_gui_thread_cell: CELL [BOOLEAN]
			-- Cell holder for `is_gui_thread'.
		once
			create Result.put (False)
		end

	stop_processing_requested: BOOLEAN
			-- Has 'stop_processing' been called?

	clipboard_internal: detachable EV_CLIPBOARD note option: stable attribute end
			-- Internal clipboard object.

	old_pointer_style: detachable EV_POINTER_STYLE
			-- Pointer style of window being used while contextual help is enabled

	old_pointer_button_press_actions: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Button press actions of window being used whie contextual help is enabled

	help_handler_procedure: detachable PROCEDURE note option: stable attribute end
			-- Help handler procedure associated with help accelerator

	help_handler
			-- Display contextual help for currently focused widget.
		local
			w: detachable EV_WIDGET
		do
			w := focused_widget
			if w /= Void then
				display_help_for_widget (w)
			end
		end

	contextual_help_handler_procedure: detachable PROCEDURE note option: stable attribute end
			-- Help handler procedure associated with context help accelerator

	contextual_help_procedure: PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			-- Called when mouse pointer is pressed while contextual help is enabled
		once
			Result := agent contextual_help
		end

	contextual_help (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Send help context of widget under mouse cursor when left mouse button is pressed to help engine.
			-- Cancel contextual help mode when right mouse button is pressed.
		local
			w: detachable EV_WIDGET
		do
			if button = 1 then
				disable_contextual_help
				w := pnd_screen.widget_at_mouse_pointer
				if w /= Void then
					display_help_for_widget (w)
				end
			end
		end

	disable_contextual_help
			-- Disable contextual help: remove capture and restore mouse pointer style.
		do
			if attached captured_widget as l_captured_widget then
				if attached old_pointer_button_press_actions as l_actions then
					l_captured_widget.pointer_button_press_actions.fill (l_actions)
				end
				if attached old_pointer_style as l_old_pointer_style then
					l_captured_widget.set_pointer_style (l_old_pointer_style)
				end
				l_captured_widget.disable_capture
			else
				check False end
			end

		end

	focused_widget_from_container (a_widget: EV_WIDGET): detachable EV_WIDGET
			-- Child widget of `a_widget' with keyboard focus, if any
		do
			if a_widget.has_focus then
				Result := a_widget
			else
				if attached {EV_CONTAINER} a_widget as a_container then
					across
						a_container as ic
					until
						Result /= Void
					loop
						Result := focused_widget_from_container (ic)
					end
				end
			end
		ensure
			focused_widget: Result /= Void implies Result.has_focus
		end

	wait_for_input (msec: INTEGER)
			-- Wait for at most `msec' milliseconds for an input.
		require
			msec_non_negative: msec >= 0
		deferred
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
