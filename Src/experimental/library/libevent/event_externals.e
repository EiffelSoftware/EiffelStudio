note
	description: "Collection of all libevent APIs (1.4.13-stable)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_EXTERNALS

feature -- Macros

	frozen EVENT_LOG_DEBUG: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"_EVENT_LOG_DEBUG"
		end

	frozen EVENT_LOG_MSG: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"_EVENT_LOG_MSG"
		end

	frozen EVENT_LOG_WARN: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"_EVENT_LOG_WARN"
		end

	frozen EVENT_LOG_ERR: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"_EVENT_LOG_ERR"
		end

	frozen EVLOOP_ONCE: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EVLOOP_ONCE"
		end

	frozen EVLOOP_NONBLOCK: INTEGER
		external
			"C macro use %"event.h%""
		alias
			"EVLOOP_NONBLOCK"
		end

feature -- Event

	frozen event_base_new: POINTER
		external
			"C signature (): struct event_base* use %"event.h%""
		end

	frozen event_init: POINTER
		external
			"C signature (): struct event_base* use %"event.h%""
		end

	frozen event_reinit (a_base: POINTER): INTEGER
		external
			"C signature (struct event_base *): int use %"event.h%""
		end

	frozen event_dispatch: INTEGER
		external
			"C signature (): int use %"event.h%""
		end

	frozen event_base_dispatch (a_base: POINTER): INTEGER
		external
			"C signature (struct event_base *): int use %"event.h%""
		end

	frozen event_base_get_method (a_base: POINTER): POINTER
		external
			"C signature (struct event_base *): const char * use %"event.h%""
		end

	frozen event_base_free (a_base: POINTER)
		external
			"C signature (struct event_base *) use %"event.h%""
		end

	frozen event_base_set (a_base: POINTER; a_event: POINTER): INTEGER
		external
			"C signature (struct event_base *, struct event *): int use %"event.h%""
		end

	frozen event_loop (a_flag: INTEGER): INTEGER
		external
			"C signature (int): int use %"event.h%""
		end

	frozen event_base_loop (a_base: POINTER; a_flag: INTEGER)
		external
			"C signature (struct event_base *, int) use %"event.h%""
		end

	frozen event_loopexit (timeval: POINTER): INTEGER
		external
			"C signature (struct timeval *): int use %"event.h%""
		end

	frozen event_base_loopexit (a_base: POINTER; timeval: POINTER): INTEGER
		external
			"C signature (struct event_base *, struct timeval *): int use %"event.h%""
		end

	frozen event_loopbreak: INTEGER
		external
			"C signature (): int use %"event.h%""
		end

	frozen event_base_loopbreak (a_base: POINTER)
		external
			"C signature (struct event_base *) use %"event.h%""
		end

	frozen event_base_got_break (a_base: POINTER): INTEGER
		external
			"C signature (struct event_base *): int use %"event.h%""
		end

	frozen event_base_got_exit (a_base: POINTER): INTEGER
		external
			"C signature (struct event_base *): int use %"event.h%""
		end

	frozen event_add (a_event: POINTER; timeval: POINTER): INTEGER
		external
			"C signature (struct event *, struct timeval *): int use %"event.h%""
		end

	frozen event_del (a_event: POINTER): INTEGER
		external
			"C signature (struct event *): int use %"event.h%""
		end

	frozen event_active (a_event: POINTER; res: INTEGER; ncalls: INTEGER)
		external
			"C signature (struct event *, int, short) use %"event.h%""
		end

	frozen event_pending (a_event: POINTER; event: INTEGER; timeval: POINTER): INTEGER
		external
			"C signature (struct event *, short, struct timeval *): int use %"event.h%""
		end

	frozen event_initialized (a_event: POINTER): BOOLEAN
		external
			"C inline use %"event.h%""
		alias
			"[
				struct event *ev = (struct event *)$a_event;
				return event_initialized(ev);
			]"
		end

	frozen event_get_version: POINTER
		external
			"C signature (): int use %"event.h%""
		end

	frozen event_get_method: POINTER
		external
			"C signature (): int use %"event.h%""
		end

	frozen event_priority_init (a_event: INTEGER): INTEGER
		external
			"C signature (int): int use %"event.h%""
		end

	frozen event_base_priority_init (a_base: POINTER; n_priorities: INTEGER): INTEGER
		external
			"C signature (struct event_base *, int): int use %"event.h%""
		end

	frozen event_priority_set (event: POINTER; n_priorities: INTEGER): INTEGER
		external
			"C signature (struct event *, int): int use %"event.h%""
		end

feature -- Buffer event

	frozen bufferevent_base_set (a_base: POINTER; a_bfevent: POINTER): INTEGER
		external
			"C signature (struct event_base *, struct bufferevent *): int use %"event.h%""
		end

	frozen bufferevent_priority_set (a_bfevent: POINTER; priority: INTEGER): INTEGER
		external
			"C signature (struct bufferevent *, int): int use %"event.h%""
		end

	frozen bufferevent_free (a_bfevent: POINTER)
		external
			"C signature (struct bufferevent *) use %"event.h%""
		end

	frozen bufferevent_setfd (a_bfevent: POINTER; fd: INTEGER)
		external
			"C signature (struct bufferevent *, int) use %"event.h%""
		end

	frozen bufferevent_write (a_bfevent: POINTER; a_data: POINTER; a_size: INTEGER): INTEGER
		external
			"C signature (struct bufferevent *, const void *, size_t): int use %"event.h%""
		end

	frozen bufferevent_write_buffer (a_bfevent: POINTER; a_evbuf: POINTER): INTEGER
		external
			"C signature (struct bufferevent *, struct evbuffer *): int use %"event.h%""
		end

	frozen bufferevent_read (a_bfevent: POINTER; a_data: POINTER; a_size: INTEGER): INTEGER
		external
			"C signature (struct bufferevent *, void *, size_t): int use %"event.h%""
		end

	frozen bufferevent_enable (a_bfevent: POINTER; a_event: INTEGER): INTEGER
		external
			"C signature (struct bufferevent *, short): int use %"event.h%""
		end

	frozen bufferevent_disable (a_bfevent: POINTER; a_event: INTEGER): INTEGER
		external
			"C signature (struct bufferevent *, short): int use %"event.h%""
		end

	frozen bufferevent_settimeout (a_bfevent: POINTER; a_timeout_read: INTEGER; a_timeout_write: INTEGER)
		external
			"C signature (struct bufferevent *, int, int) use %"event.h%""
		end

	frozen bufferevent_setwatermark (a_bfevent: POINTER; events: INTEGER; lowmark: INTEGER; highmark: INTEGER)
		external
			"C signature (struct bufferevent *, short, size_t, size_t) use %"event.h%""
		end

	frozen evbuffer_new: POINTER
		external
			"C signature (): struct evbuffer * use %"event.h%""
		end

	frozen evbuffer_free (a_evbuf: POINTER)
		external
			"C signature (struct evbuffer *) use %"event.h%""
		end

	frozen evbuffer_expand (a_evbuf: POINTER; a_size: INTEGER): INTEGER
		external
			"C signature (struct evbuffer *, size_t): int use %"event.h%""
		end

	frozen evbuffer_add (a_evbuf: POINTER; a_data: POINTER; a_size: INTEGER): INTEGER
		external
			"C signature (struct evbuffer *, const void *, size_t): int use %"event.h%""
		end

	frozen evbuffer_remove (a_evbuf: POINTER; a_data: POINTER; a_size: INTEGER): INTEGER
		external
			"C signature (struct evbuffer *, void *, size_t): int use %"event.h%""
		end

	frozen evbuffer_readline (a_evbuf: POINTER): POINTER
		external
			"C signature (struct evbuffer *): char * use %"event.h%""
		end

	frozen evbuffer_add_buffer (a_evbuf: POINTER; a_other_evbuf: POINTER): INTEGER
		external
			"C signature (struct evbuffer *, struct evbuffer *): int use %"event.h%""
		end

	frozen evbuffer_drain (a_evbuf: POINTER; a_size: INTEGER)
		external
			"C signature (struct evbuffer *, int) use %"event.h%""
		end

	frozen evbuffer_write (a_evbuf: POINTER; fd: INTEGER): INTEGER
		external
			"C signature (struct evbuffer *, int): int use %"event.h%""
		end

	frozen evbuffer_read (a_evbuf: POINTER; fd: INTEGER; a_size: INTEGER): INTEGER
		external
			"C signature (struct evbuffer *, int, int): int use %"event.h%""
		end

	frozen evbuffer_find (a_evbuf: POINTER; a_str: POINTER; a_size: INTEGER): POINTER
		external
			"C signature (struct evbuffer *, const u_char *, size_t): u_char * use %"event.h%""
		end

end
