indexing
	description:
		"EiffelVision application, Carbon implementation."
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
		undefine
			dispose
		redefine
			launch,
			process_events_until_stopped,
			process_events,
			stop_processing
		end

	IDENTIFIED
		undefine
			is_equal,
			copy
		end

	EV_APPLICATION_ACTION_SEQUENCES_IMP

	EXECUTION_ENVIRONMENT
		rename
			launch as ee_launch
		end

	PLATFORM

	EXCEPTIONS

	PROCESSES_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTSCORE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	EVENT_HANDLER_PROC_PTR_CALLBACK
		export
			{NONE} all
		end

	EVENT_LOOP_IDLE_TIMER_PROC_PTR_CALLBACK
		rename
			on_callback as on_idle
		export
			{NONE} all
		end

	HIOBJECT_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Set up the callback marshalL
		do
			base_make (an_interface)

			create windows.make

			id_count := 1
			create free_ids.make
			create widget_list.make ( 1, initial_widget_list_size )

			create dispatcher.make (Current)
			create idle_dispatcher.make (Current)
		ensure then
			free_ids_exists : free_ids /= Void
			windows_exists : windows /= Void
			widget_list_exists : widget_list /= Void
			dispatcher_exists : dispatcher /= Void
		end

feature -- Settings

	initial_widget_list_size : INTEGER is 200
	initial_custom_control_list_size : INTEGER is 5

feature {NONE} -- Event loop

	 launch is
			-- Display the first window, set up the post_launch_actions,
			-- and start the event loop.
		local
			target: POINTER
			event: OPAQUE_EVENT_REF_STRUCT_EXTERNAL
			ret: INTEGER
			timer: EVENT_LOOP_TIMER_STRUCT
		do
			enable_foreground_operation

			create timer.make_new_unshared
			ret := install_event_loop_idle_timer_external (get_main_event_loop_external, 1, 1, idle_dispatcher.c_dispatcher, int_to_pointer(0), timer.item)

			post_launch_actions.call ([])
			run_application_event_loop_external
--			target := get_event_dispatcher_target_external
--			from
--
--			until
--				false
--			loop
--				receive_next_event_external (0, null, kEventDurationForever, true, event.item)
--				send_event_to_event_target_external (event, target)
--				release_event_external (event.item)
--			end
		end

	enable_foreground_operation is
			-- Transform the application into a foreground process with manubar and Dock icon
		local
			psn: PROCESS_SERIAL_NUMBER_STRUCT
			ret: INTEGER
		do
			create psn.make_new_unshared
			ret := get_current_process_external(psn.item)
			ret := transform_process_type_external(psn.item, 1)
			ret := set_front_process_external(psn.item)
		end


feature -- Access

	ctrl_pressed: BOOLEAN is
			-- Is ctrl key currently pressed?
		do
		end

	alt_pressed: BOOLEAN is
			-- Is alt key currently pressed?
		do
		end

	shift_pressed: BOOLEAN is
			-- Is shift key currently pressed?
		do
		end

	caps_lock_on: BOOLEAN is
			-- Is the Caps or Shift Lock key currently on?
		do
		end

	windows: LINKED_LIST [EV_WINDOW]
			-- Global list of windows.

feature -- Basic operation

	process_events_until_stopped is
			-- Process all events until one event is received
			-- by `widget'.
		do
			run_application_event_loop_external
		end

	process_events is
			-- Process all pending events and redraws.
		local
			ret: INTEGER
		do
			ret := run_current_event_loop_external (100)
		end

	stop_processing is
			-- Exit `process_events_until_stopped'.
		do
			quit_application_event_loop_external
		end

	process_underlying_toolkit_event_queue is
			-- ??
		do
		end

	process_graphical_events is
			-- Process all pending graphical events and redraws.
		do
		end

	motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER] is
			-- Tuple optimizations
		once
		end

	handle_dnd (a_event: POINTER) is
			-- Handle drag and drop event.
		do
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		do
		end

	destroy is
			-- End the application.
		do
			quit_application_event_loop_external
			set_is_destroyed (True)
		end

feature -- Status report

	tooltip_delay: INTEGER
			-- Time in milliseconds before tooltips pop up.

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		do
			tooltip_delay := a_delay
		end


feature {EV_PICK_AND_DROPABLE_IMP} -- Pick and drop

	on_pick (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.start_transport
		do
		end

	on_drop (a_pebble: ANY) is
			-- Called by EV_PICK_AND_DROPABLE_IMP.end_transport
		do
		end

feature {EV_ANY} -- Implementation

	is_display_remote: BOOLEAN
			-- Is application display remote?
			-- This function is primarily to determine if drawing to the display is optimal.

feature -- Implementation

	wait_for_input (msec: INTEGER) is
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

	enable_is_in_transport is
			-- Set `is_in_transport' to True.
		require
			not_in_transport: not is_in_transport
		do
		end

	disable_is_in_transport is
			-- Set `is_in_transport' to False.
		require
			in_transport: is_in_transport
		do
		end

	keyboard_modifier_mask: INTEGER is
			-- Mask representing current keyboard modifiers state.
		do
		end

	enable_debugger is
			-- Enable the Eiffel debugger.
		do
		end

	disable_debugger is
			-- Disable the Eiffel debugger.
		do
		end

feature {EV_PICK_AND_DROPABLE_IMP} -- Pnd Handling

	old_pointer_x,
	old_pointer_y: INTEGER
		-- Position of pointer on previous PND draw.

	set_old_pointer_x_y_origin (a_old_pointer_x, a_old_pointer_y: INTEGER) is
			-- Set PND pointer origins to `a_old_pointer_x' and `a_old_pointer_y'.
		do
		end

feature -- Thread Handling.

	initialize_threading is
			-- Initialize thread support.
		do
		end

	lock is
			-- Lock the Mutex.
		do
		end

	try_lock: BOOLEAN is
			-- Try to see if we can lock, False means no lock could be attained
		do
			Result := True
			-- TODO: Uhhh, this could be dangerous
		end

	unlock is
			-- Unlock the Mutex.
		do
		end

feature {NONE} -- Idle handling

	idle_dispatcher: EVENT_LOOP_IDLE_TIMER_PROC_PTR_DISPATCHER
			-- The dispatcher is on the one side connected to a C function,
			-- that can be given to the C library as a callback target
			-- and on the other hand to an Eiffel object with a feature
			-- `on_idle'. Whenn its C function gets called, the dispatcher
			-- calls `on_idle' in the connected Eiffel object

	on_idle (a_intimer: POINTER; a_instate: INTEGER; a_inuserdata: POINTER) is
			-- Callback target. This feature gets called when the application idles
		do
				idle_actions_internal.call (Void)
		end

feature {NONE} -- callback handling for events

	dispatcher: EVENT_HANDLER_PROC_PTR_DISPATCHER
			-- The dispatcher is on the one side connected to a C function,
			-- that can be given to the C library as a callback target
			-- and on the other hand to an Eiffel object with a feature
			-- `on_callback'. Whenn its C function gets called, the dispatcher
			-- calls `on_callback' in the connected Eiffel object


	on_callback (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER is
			-- Callback target. This feature gets called
			-- anytime somebody calls `trigger_event_external'
		local
			a_id: INTEGER
		do
			a_id := pointer_to_int ( a_inuserdata )
			check
				valid_id : widget_list.index_set.has ( a_id )
				target_valid : widget_list.item ( a_id ) /= Void
			end
			--print ("on_callback has been called by id:" + a_id.out + "%N")
			Result := widget_list.item ( a_id ).on_event ( a_inhandlercallref, a_inevent, a_inuserdata )
		end

	id_count: INTEGER  -- the next id for an event.

	free_ids: LINKED_LIST[INTEGER]

feature {EV_CARBON_EVENTABLE} -- event handling

	widget_list: ARRAY[EV_CARBON_EVENTABLE]

	get_id (a_widget : EV_CARBON_EVENTABLE) : INTEGER is
			-- Get a unique ID so we can associate an event by its ID with a control
		do
			if free_ids.is_empty then
				widget_list.force (a_widget, id_count)
				Result := id_count
				id_count := id_count + 1
			else
				free_ids.start
				widget_list.force (a_widget, free_ids.item)
				Result :=  free_ids.item
				free_ids.remove
			end
			--io.put_string ("Get ID: " + Result.out + "%N")
		end

	dispose_id (a_id: INTEGER) is
				-- Give an id back (it will be recycled)
			do
				widget_list.force (void, a_id)
				free_ids.extend (a_id)
				--io.put_string ("Freed " + a_id.out + "%N")
			end

feature -- event handling

	install_event_handler (a_id: INTEGER ; a_target: POINTER; a_event_class: INTEGER; a_event_kind: INTEGER): POINTER is
			-- install a carbon event handler
		local
			ret: INTEGER
			event_type: EVENT_TYPE_SPEC_STRUCT
			handler: POINTER
		do
			create event_type.make_new_unshared
			event_type.set_eventclass (a_event_class)
			event_type.set_eventkind (a_event_kind)
			ret := install_event_handler_external (a_target, dispatcher.c_dispatcher, 1, event_type.item, int_to_pointer( a_id ), $handler)
			--io.put_string ("handler installed for id: " + a_id.out + " ret: " + ret.out + "%N")
			Result := handler
		end

	install_event_handlers (a_id: INTEGER ; a_target: POINTER; a_event_array : EVENT_TYPE_SPEC_ARRAY ): POINTER is
			-- install a carbon event handler for multiple events
		local
			ret: INTEGER
			handler: POINTER
		do
			ret := install_event_handler_external (a_target, dispatcher.c_dispatcher, a_event_array.count, a_event_array.array_address, int_to_pointer( a_id ), $handler)
		--	io.put_string ("handler installed for id: " + a_id.out + " ret: " + ret.out + "%N")
			Result := handler
		end

	frozen int_to_pointer ( a_int: INTEGER ) : POINTER is
		external
			"C inline"
		alias
			"[
				{
					return (void*) $a_int;
				}
			]"
		end

	frozen pointer_to_int ( a_pointer: POINTER ) : INTEGER is
		external
			"C inline"
		alias
			"[
				{
					return (EIF_INTEGER_32) $a_pointer;
				}
			]"
		end

invariant
	dispatcher_exists : dispatcher /= Void

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_APPLICATION_IMP

