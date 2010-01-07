note
	description: "Summary description for {EVENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT

inherit
	EVENT_ANY

create
	make

feature {NONE} -- Initialization

	make (a_fd: like descriptor; a_type: INTEGER)
			-- Init
		require
			a_fd_valid: a_fd = -1 or a_fd > 0
			a_type_valid: (a_type & (ev_timeout | ev_read | ev_write | ev_signal | ev_persist | ev_et)) > 0
		do
			item := c_new_event
			descriptor := a_fd
			event_type := a_type
			create internal_actions
			c_initialize
		end

feature -- Access

	actions: ACTION_SEQUENCE [TUPLE [like event_type, like Current]]
			-- Actions to be taken by the event.
		do
			Result := internal_actions
		end

	descriptor: INTEGER
			-- The target descriptor on which the event occurs.

feature {EVENT_LOOP} -- Operation

	prepare_event (a_base: EVENT_BASE; a_time: EVENT_TIME)
			-- Connect the event to the base and schedule the event.
		local
			l_re: INTEGER
		do
			l_re := {EVENT_EXTERNALS}.event_base_set (a_base.item, item)
			l_re := {EVENT_EXTERNALS}.event_add (item, a_time.item)
		end

	delete
			-- Delete the event.
			-- Call `event_del'
		local
			l_re: INTEGER
		do
			l_re := {EVENT_EXTERNALS}.event_del (item)
		end

feature -- Constants

	frozen ev_timeout: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EV_TIMEOUT"
		end

	frozen ev_read: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EV_READ"
		end

	frozen ev_write: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EV_WRITE"
		end

	frozen ev_signal: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EV_SIGNAL"
		end

	frozen ev_persist: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EV_PERSIST"
		end

	frozen ev_et: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EV_ET"
		end

feature {NONE} -- Removal

	destroy_item
			-- <precursor>
		do
			c_free (item)
			free_cb_data (c_callback_data)
		end

feature {NONE} -- Implementation

	event_type: INTEGER
			-- Event type (timeout, read, write, signal, persist)

	internal_actions: like actions
			-- Actual actions for the event.

feature {NONE} -- C interaction

	c_initialize
			-- Initialize C structure
		do
			c_callback_data := c_new_callback_data ($Current, $callback)
			c_setup_structure (item, descriptor, event_type, c_callback_data)
		end

	callback (a_type: INTEGER)
			-- Callback from C code.
		do
			internal_actions.call ([a_type, Current])
		end

	c_callback_data: POINTER
			-- C callback data

	c_new_callback_data (a_obj: POINTER; a_callback: POINTER): POINTER
			-- Allocate C callback data structure,
			-- and setup current object and callback.
		external
			"C inline use %"eiffel_libevent.h%""
		alias
			"[
				EIF_EVCBDATAP p = (EIF_EVCBDATAP)malloc (sizeof (EIF_EVCBDATA));
				p->o = eif_protect($a_obj);
				p->func = $a_callback;
				return p;
			 ]"
		end

	c_setup_structure (a_event: POINTER; fd: INTEGER; a_type: INTEGER; a_data: POINTER)
			-- Setup C event stucture.
		external
			"C inline use %"eiffel_libevent.h%""
		alias
			"[
				event_set($a_event, (int)$fd, $a_type, c_event_callback, $a_data);
			]"
		end

feature {NONE} -- Externals

	c_new_event: POINTER
		external
			"C inline use %"eiffel_libevent.h%""
		alias
			"[
				return malloc (sizeof (struct event));
			 ]"
		end

	free_cb_data (a_data: POINTER)
			-- Frees the callback data created from `new_cb_data'.
			--
			-- `a_data': The callback data to free.
		require
			not_a_data_is_null: a_data /= default_pointer
		external
			"C inline use %"eiffel_libevent.h%""
		alias
			"[
				eif_wean (((EIF_EVCBDATAP)$a_data)->o);
				free($a_data);
			]"
		end

end
