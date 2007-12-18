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

	EXCEPTIONS

	MEMORY

feature {EV_APPLICATION} -- Initialization

	initialize is
			-- Create pick and drop target list.
			-- Set F1 as default help key.
			-- Create default help engine.
		local
			f1_key: EV_KEY
			environment_imp: EV_ENVIRONMENT_IMP
		do
				-- Set the application in EV_ENVIRONMENT.
			environment_imp ?= (create {EV_ENVIRONMENT}).implementation
			environment_imp.set_application (interface)

				-- Initialize contextual help.
			create f1_key.make_with_code ({EV_KEY_CONSTANTS}.Key_f1)
			set_help_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (f1_key, False, False, False))
			set_contextual_help_accelerator (create {EV_ACCELERATOR}.make_with_key_combination (f1_key, False, False, True))
			create {EV_SIMPLE_HELP_ENGINE} help_engine

				-- Create and initialize action sequences.
			create pnd_targets.make (8)
			create dockable_targets.make (8)

				-- Create idle actions as this is called in the event loop.
			idle_actions.call (Void)

			idle_iteration_count := 1
				-- Enable `invoke_garbage_collection_when_inactive'.
			set_invoke_garbage_collection_when_inactive (True)
			set_is_initialized (True)
		end

	 launch is
			-- Call the `post_launch_actions' and start the event loop.
		do
			from
				call_post_launch_actions
			until
				is_destroyed
			loop
				process_event_queue (True)
			end
		end

feature {EV_ANY_I} -- Implementation

	cpu_relinquishment_time: INTEGER is 20
		-- Number of milliseconds to relinquish CPU when idling.

	idle_iteration_count: NATURAL_32
		-- Number of iterations that the application has been idle.

	idle_iteration_boundary: NATURAL_32 is 1500
		-- Number of iterations before forcing Garbage Collector to kick in.
		-- 30 Seconds = 30 * 1000 / sleep time

	process_event_queue (a_relinquish_cpu: BOOLEAN)
			-- Process all posted events on the event queue.
			-- CPU will be relinquished if `a_relinquish_cpu' and idle actions are successfully executed.
		local
			l_locked: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				process_underlying_toolkit_event_queue
					-- There are no more events left so call idle actions if read lock can be attained.
				if user_events_processed_from_underlying_toolkit then
						-- If any user events have been processed then we reset the `idle_iteration_count'
					idle_iteration_count := 1
				elseif a_relinquish_cpu then
						-- We only want to increase the count if the event loop is not forced.
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
				if try_lock then
					l_locked := True
					idle_actions_internal.call (Void)
					unlock
					l_locked := False
					if a_relinquish_cpu then
							-- We only relinquish CPU if requested and a lock for the idle actions has been attained.
						wait_for_input (cpu_relinquishment_time)
					end
				end
			else
				on_exception_action (new_exception)
			end
		rescue
			if not retried then
				if l_locked then
						-- If a crash occurred whilst calling the idle actions then we must unlock the mutex.
					unlock
					l_locked := False
				end
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation

	process_underlying_toolkit_event_queue is
			-- Process event queue from underlying toolkit.
			-- `events_process_from_toolkit
		deferred
		end

	user_events_processed_from_underlying_toolkit: BOOLEAN
		-- Were user generated events processed in previous call to `process_underlying_toolkit_event_queue'.

feature {EV_DOCKABLE_SOURCE_I, EV_DOCKABLE_TARGET_I, EV_SHARED_TRANSPORT_I} -- Access

	dockable_targets: ARRAYED_LIST [INTEGER]

feature -- Access

	invoke_garbage_collection_when_inactive: BOOLEAN
		-- Should garbage collection be invoked when application is inactive.

	pnd_targets: HASH_TABLE [INTEGER, INTEGER]
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

	pick_and_drop_source: EV_PICK_AND_DROPABLE_I is
			-- The current pick and drop source.
		deferred
		end

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

	caps_lock_on: BOOLEAN is
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

	process_events is
			-- Process any pending events.
			--| Pass control to the GUI toolkit so that it can
			--| handle any events that may be in its queue.
		do
			process_event_queue (False)
		end

	process_graphical_events is
			-- Process any pending paint events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any paint events that may be in its queue.
		deferred
		end

	process_events_until_stopped is
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

	stop_processing is
			--  Exit `process_events_until_stopped'.
		do
			stop_processing_requested := True
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
				idle_actions_internal.extend (a_idle_action)
			end
			unlock
		end

	remove_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Remove `a_idle_action' from `idle_actions'
			-- Thread safe
		require
			a_idle_action_not_void: a_idle_action /= Void
		local
			l_cursor: CURSOR
			l_idle_actions: like idle_actions
		do
			lock
			l_idle_actions := idle_actions
			l_cursor := l_idle_actions.cursor
			l_idle_actions.prune_all (a_idle_action)
			if l_idle_actions.valid_cursor (l_cursor) then
				l_idle_actions.go_to (l_cursor)
			end
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

	do_once_on_idle (an_action: PROCEDURE [ANY, TUPLE]) is
			-- Perform `an_action' one time only on idle.
		do
			lock
			if not idle_actions.has (an_action) then
				idle_actions_internal.extend_kamikaze (an_action)
			end
			unlock
		end

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

feature {EV_PICK_AND_DROPABLE_I} -- Pick and drop

	x_origin, y_origin: INTEGER
		-- Temp coordinate values for origin of Pick and Drop.

	set_x_y_origin (a_x_origin, a_y_origin: INTEGER) is
			-- Set `x_origin' and `y_origin' to `a_x_origin' and `a_y_origin' respectively.
		do
			x_origin := a_x_origin
			y_origin := a_y_origin
		end

	rubber_band_is_drawn: BOOLEAN
		-- Is the PnD rubber band drawn on screen?

	draw_rubber_band is
			-- Draw a segment between initial pick point and `destination'.
		do
			pnd_screen.draw_segment (x_origin, y_origin, pnd_pointer_x, pnd_pointer_y)
			rubber_band_is_drawn := True
		end

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				pnd_screen.draw_segment (x_origin, y_origin, pnd_pointer_x, pnd_pointer_y)
				rubber_band_is_drawn := False
			end
		end

	pnd_screen: EV_SCREEN is
			-- Screen object used for drawing PND transport line
		once
			create Result
			Result.enable_dashed_line_style
			Result.set_foreground_color ((create {EV_STOCK_COLORS}).white)
			Result.set_invert_mode
		end

	pnd_pointer_x,
	pnd_pointer_y: INTEGER
		-- Position of pointer on previous PND draw.

	set_pnd_pointer_coords (a_pnd_pointer_x, a_pnd_pointer_y: INTEGER) is
			-- Set PND pointer origins to `a_pnd_pointer_x' and `a_pnd_pointer_y'.
		do
			pnd_pointer_x := a_pnd_pointer_x
			pnd_pointer_y := a_pnd_pointer_y
		end

	create_target_menu (a_x, a_y, a_screen_x, a_screen_y: INTEGER; a_pnd_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_configure_agent: PROCEDURE [ANY, TUPLE]; a_menu_only: BOOLEAN) is
			-- Menu of targets that accept `a_pebble'.
		local
			cur: CURSOR
			trg: EV_ABSTRACT_PICK_AND_DROPABLE
			pnd_trg: EV_PICK_AND_DROPABLE
			targets: like pnd_targets
			identified: IDENTIFIED
			sensitive: EV_SENSITIVE
			l_item_data: EV_PND_TARGET_DATA
			l_search_tree: BINARY_SEARCH_TREE [PROXY_COMPARABLE [EV_PND_TARGET_DATA]]
			l_object_comparable: PROXY_COMPARABLE [EV_PND_TARGET_DATA]
			l_comparator_agent: PREDICATE [ANY, TUPLE [EV_PND_TARGET_DATA, EV_PND_TARGET_DATA]]
			l_arrayed_list: ARRAYED_LIST [EV_PND_TARGET_DATA]
			l_alphabetical_sort_agent: PROCEDURE [ANY, TUPLE [PROCEDURE [ANY, TUPLE], BINARY_SEARCH_TREE [PROXY_COMPARABLE [EV_PND_TARGET_DATA]],  ARRAYED_LIST [EV_PND_TARGET_DATA]]]
			l_configurable_item_added: BOOLEAN
			l_menu: EV_MENU
			l_menu_count: INTEGER
			l_has_targets: BOOLEAN
		do
			targets := pnd_targets
			create l_menu
			create identified
			cur := targets.cursor
			if a_pebble /= Void then
				from
					targets.start
						-- Create agent for comparing menu item texts used for alphabetical sorting with PROXY_COMPARABLE.
					l_comparator_agent :=
						agent (first_item, second_item: EV_PND_TARGET_DATA): BOOLEAN
							do
								Result := first_item.name < second_item.name
							end
				until
					targets.after
				loop
					trg ?= identified.id_object (targets.item_for_iteration)
					pnd_trg ?= trg
					if trg /= Void and then (pnd_trg = Void or else not pnd_trg.is_destroyed) then
						if
							trg.drop_actions.accepts_pebble (a_pebble)
						then
							sensitive ?= trg
							if not (sensitive /= Void and then (not sensitive.is_destroyed and then not sensitive.is_sensitive)) then
								l_has_targets := True
								if not l_configurable_item_added then
									l_menu.extend (create {EV_MENU_ITEM}.make_with_text_and_action ("Pick", a_configure_agent))
									l_configurable_item_added := True
								end
								if trg.target_data_function /= Void then
									l_item_data := trg.target_data_function.item ([a_pebble])
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
			end

			if l_has_targets then
				create l_arrayed_list.make (0)

				if l_search_tree /= Void then
						-- Sort items alphabetically using recursive inline agent
					l_alphabetical_sort_agent := agent (l_sort_agent: PROCEDURE [ANY, TUPLE]; a_node: BINARY_SEARCH_TREE [PROXY_COMPARABLE [EV_PND_TARGET_DATA]]; a_list: ARRAYED_LIST [EV_PND_TARGET_DATA])
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
				if a_pnd_source.configurable_target_menu_handler /= Void then
					a_pnd_source.configurable_target_menu_handler.call ([l_menu, l_arrayed_list, a_pnd_source, a_pebble])
				else
					from
						l_arrayed_list.start
					until
						l_arrayed_list.after
					loop
						l_menu.extend (create {EV_MENU_ITEM}.make_with_text_and_action (l_arrayed_list.item.name, agent (l_arrayed_list.item.target.drop_actions).call ([a_pebble])))
						l_arrayed_list.forth
					end
				end
				if not l_menu.is_destroyed and then l_menu.count > l_menu_count then
					l_menu.show_at (Void, a_screen_x - menu_placement_offset, a_screen_y - menu_placement_offset)
				elseif a_configure_agent /= Void and not a_menu_only then
					a_configure_agent.call (Void)
				end
			else
				if a_pnd_source.configurable_target_menu_handler /= Void then
					create l_menu
					a_pnd_source.configurable_target_menu_handler.call ([l_menu, create {ARRAYED_LIST [EV_PND_TARGET_DATA]}.make (0), a_pnd_source, a_pebble])
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
				trg ?= identified.id_object (pnd_targets.item_for_iteration)
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
			if not retried then
				retried := True
				retry
			end
		end

	on_exception_action (an_exception: EXCEPTION) is
			-- Call exception actions.
		require
			an_exception_not_void: an_exception /= Void
		local
			l_exception_string: STRING_8
			l_label: EV_TEXT
			l_label_box: EV_HORIZONTAL_BOX
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_font: EV_FONT
			l_ignore, l_quit: EV_BUTTON
			l_frame: EV_FRAME
			l_error_box: EV_HORIZONTAL_BOX
			l_error_label: EV_LABEL
		do
				-- Clean up any locked windows of captures.
			if locked_window /= Void then
				locked_window.unlock_update
			end
			if captured_widget /= Void then
				captured_widget.disable_capture
			end
			if
				not uncaught_exception_actions_called and then
				uncaught_exception_actions_internal /= Void and then
				not uncaught_exception_actions_internal.is_empty
			then
				uncaught_exception_actions_called := True
				uncaught_exception_actions_internal.call ([an_exception])
				uncaught_exception_actions_called := False
			else
				if show_exception_dialog then
						-- Show a basic exception dialog so that exception doesn't get lost if undealt with.
					l_exception_string := an_exception.exception_trace.twin
					l_exception_string.prune_all ('%R')
					create exception_dialog
					create l_label
					l_label.disable_word_wrapping
					l_label.disable_edit
					create l_font
					l_font.set_family ({EV_FONT_CONSTANTS}.Family_typewriter)
					l_label.set_font (l_font)
					l_label.set_text (l_exception_string)
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
					exception_dialog.extend (l_vbox)
					create l_hbox
					l_vbox.extend (l_hbox)
					l_vbox.disable_item_expand (l_hbox)
					create l_ignore.make_with_text ("Ignore")
					l_ignore.select_actions.extend (agent exception_dialog.destroy)
					l_hbox.extend (create {EV_CELL})
					l_hbox.extend (l_ignore)
					l_hbox.disable_item_expand (l_ignore)
					create l_quit.make_with_text ("Quit")
					l_quit.set_minimum_width (l_ignore.minimum_width)
					l_quit.select_actions.extend (agent destroy)
					l_hbox.extend (l_quit)
					l_hbox.disable_item_expand (l_quit)
					l_hbox.set_border_width (5)
					l_hbox.set_padding (5)
					exception_dialog.set_title ("Uncaught Exception: " + an_exception.message)
					exception_dialog.set_minimum_height (350)
					exception_dialog.set_size (500, 300)
					exception_dialog.raise
						--| FIXME Behavior would be better if dialog has full application modality.

						-- Set "Ignore" as the default
					l_ignore.set_focus
				end
			end
		end

	exception_dialog: EV_DIALOG
		-- Dialog used for showing uncaught exceptions.

	show_exception_dialog: BOOLEAN is True
		-- Should the exception dialog be shown by default?

	uncaught_exception_actions_called: BOOLEAN
			-- Are the `uncaught_exceptions_actions' currently being called?
			-- This is used to prevent infinite looping should an exception be raised as part of calling `uncaught_exception_actions'.

	new_exception: EXCEPTION is
			-- New exception object representating the last exception caught in Current
		do
			Result := (create {EXCEPTION_MANAGER}).last_exception
		ensure
			new_exception_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	stop_processing_requested: BOOLEAN
			-- Has 'stop_processing' been called?

	clipboard_internal: EV_CLIPBOARD
			-- Internal clipboard object.

	old_pointer_style: EV_POINTER_STYLE
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
				w := screen.widget_at_mouse_pointer
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

	wait_for_input (msec: INTEGER) is
			-- Wait for at most `msec' milliseconds for an input.
		require
			msec_non_negative: msec >= 0
		deferred
		end

invariant
	dockable_targets_not_void: is_usable implies dockable_targets /= Void
	pnd_targets_not_void: is_usable implies pnd_targets /= void
	windows_not_void: is_usable implies windows /= void

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

