note
	description: "Summary description for {ZMQ_API}."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	EIS: "name=API", "src=http://api.zeromq.org/3-3:_start", "protocol=uri"
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ

feature -- Error handling

	errno: INTEGER
			-- Value of `errno' as set by ZMQ.
		external
			"C inline use <errno.h>"
		alias
			"return zmq_errno();"
		ensure
			is_class: class
		end

	strerror (an_errnum: INTEGER): POINTER
			-- C string describing error `an_errnum'.
		external
			"C inline use <zmq.h>"
		alias
			"return (EIF_POINTER) zmq_strerror ((int)$an_errnum);"
		end

feature -- General

	version (a_major, a_minor, a_patch: TYPED_POINTER [INTEGER])
		external
			"C inline use <zmq.h>"
		alias
			"[
				int maj, min, patch;
				zmq_version (&maj, &min, &patch);
				*(EIF_INTEGER *) $a_major = maj;
				*(EIF_INTEGER *) $a_minor = min;
				*(EIF_INTEGER *) $a_patch = patch;
			]"
		end

feature -- Context API

	ctx_new: POINTER
			-- ZMQ_EXPORT void *zmq_ctx_new (void);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_ctx_new();"
		ensure
			is_class: class
		end

	ctx_set (a_context: POINTER; a_option: INTEGER; a_value: INTEGER): INTEGER
			-- ZMQ_EXPORT int zmq_ctx_set (void *context, int option_name, int option_value);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_ctx_set((void *) $a_context, (int) $a_option, (int) $a_value);"
		ensure
			is_class: class
		end

	ctx_get (a_context: POINTER; a_option: INTEGER): INTEGER
			-- ZMQ_EXPORT int zmq_ctx_get (void *context, int option_name);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_ctx_get((void *) $a_context, (int) $a_option);"
		ensure
			is_class: class
		end

	ctx_destroy (a_context: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_ctx_destroy (void *context);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_ctx_destroy ((void *)$a_context);"
		ensure
			is_class: class
		end

feature -- Socket API

	setsockopt (a_s: POINTER; an_option: INTEGER_32; an_optval: POINTER; an_optvallen: NATURAL_32): INTEGER_32
			--ZMQ_EXPORT int zmq_setsockopt (void *s, int option, const void *optval,size_t optvallen);

		external
			"C inline use <zmq.h>"
		alias
			"return zmq_setsockopt ((void *)$a_s, (int)$an_option, (const void *)$an_optval,(size_t)$an_optvallen);"
		ensure
			is_class: class
		end

	msg_init_size (a_msg: POINTER; a_size: NATURAL_32): INTEGER_32
			-- ZMQ_EXPORT int zmq_msg_init_size (zmq_msg_t *msg, size_t size);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_init_size ((zmq_msg_t *)$a_msg, (size_t)$a_size);"
		ensure
			is_class: class
		end

	send (a_s: POINTER; a_msg: POINTER; a_msg_length: INTEGER; a_flags: INTEGER_32): INTEGER_32
			-- ZMQ_EXPORT int zmq_send (void *s, const void *buf, size_t len, int flags);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_send ((void *) $a_s, (const void *) $a_msg, (size_t) $a_msg_length, (int)$a_flags);"
		ensure
			is_class: class
		end

	sendmsg (a_s: POINTER; a_msg: POINTER; a_flags: INTEGER_32): INTEGER_32
			--ZMQ_EXPORT int zmq_sendmsg (void *s, zmq_msg_t *msg, int flags);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_sendmsg ((void *)$a_s, (zmq_msg_t *)$a_msg, (int)$a_flags);"
		ensure
			is_class: class
		end

	msg_copy (a_dest: POINTER; a_src: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_msg_copy (zmq_msg_t *dest, zmq_msg_t *src);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_copy ((zmq_msg_t *)$a_dest, (zmq_msg_t *)$a_src);"
		end

	stopwatch_stop (a_watch: POINTER): NATURAL_32
			-- ZMQ_EXPORT unsigned long zmq_stopwatch_stop (void *watch_);
		external
			"C inline use <zmq_utils.h>"
		alias
			"return zmq_stopwatch_stop ((void *)$a_watch);"
		end

	msg_close (a_msg: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_msg_close (zmq_msg_t *msg);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_close((zmq_msg_t *)$a_msg);"
		ensure
			is_class: class
		end

	msg_size (a_msg: POINTER): NATURAL_64
			-- ZMQ_EXPORT size_t zmq_msg_size (zmq_msg_t *msg);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_size ((zmq_msg_t *)$a_msg);"
		ensure
			is_class: class
		end

	socket (a_context: POINTER; a_type: INTEGER_32): POINTER
			-- ZMQ_EXPORT void *zmq_socket (void *context, int type);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_socket ((void *)$a_context, (int)$a_type);"
		ensure
			is_class: class
		end

	close (a_s: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_close (void *s);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_close ((void *)$a_s);"
		ensure
			is_class: class
		end

	sleep (a_seconds: INTEGER_32)
			-- ZMQ_EXPORT void zmq_sleep (int seconds_);
		external
			"C inline use <zmq_utils.h>"
		alias
			"zmq_sleep ((int)$a_seconds);"
		ensure
			is_class: class
		end

	msg_init_data (a_msg: POINTER; a_data: POINTER; a_size: NATURAL_32; a_ffn: POINTER; a_hint: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_msg_init_data (zmq_msg_t *msg, void *data, size_t size, zmq_free_fn *ffn, void *hint);

		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_init_data ((zmq_msg_t *)$a_msg, (void *)$a_data, (size_t)$a_size, (zmq_free_fn *)$a_ffn, (void *)$a_hint);"
		ensure
			is_class: class
		end

	connect (a_s: POINTER; an_addr: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_connect (void *s, const char *addr);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_connect ((void *)$a_s, (const char *)$an_addr);"
		ensure
			is_class: class
		end

	msg_data (a_msg: POINTER): POINTER
			-- ZMQ_EXPORT void *zmq_msg_data (zmq_msg_t *msg);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_data ((zmq_msg_t *)$a_msg);"
		ensure
			is_class: class
		end

	bind (a_s: POINTER; an_addr: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_bind (void *s, const char *addr);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_bind ((void *)$a_s, (const char *)$an_addr);"
		ensure
			is_class: class
		end

	recv (a_s: POINTER; a_msg: POINTER; a_msg_length: INTEGER; a_flags: INTEGER_32): INTEGER_32
			-- ZMQ_EXPORT int zmq_recv (void *s, void *buf, size_t len, int flags);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_recv ((void *)$a_s, (void *) $a_msg, (size_t) $a_msg_length, (int)$a_flags);"
		ensure
			is_class: class
		end

	msg_recv (a_msg: POINTER; a_s: POINTER; a_flags: INTEGER_32 ): INTEGER_32
			-- ZMQ_EXPORT int zmq_msg_recv (zmq_msg_t *msg, void *s, int flags);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_recv ((zmq_msg_t *)$a_msg, (void *)$a_s, (int)$a_flags);"
		ensure
			is_class: class
		end

	stopwatch_start: POINTER
			-- ZMQ_EXPORT void *zmq_stopwatch_start ();
		external
			"C inline use <zmq_utils.h>"
		alias
			"return zmq_stopwatch_start ();"
		end

	poll (an_items: POINTER; a_nitems: INTEGER_32; a_timeout: INTEGER_32): INTEGER_32
			-- ZMQ_EXPORT int zmq_poll (zmq_pollitem_t *items, int nitems, long timeout);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_poll ((zmq_pollitem_t *)$an_items, (int)$a_nitems, (long)$a_timeout);"
		ensure
			is_class: class
		end

	msg_move (a_dest: POINTER; a_src: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_msg_move (zmq_msg_t *dest, zmq_msg_t *src);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_move ((zmq_msg_t *)$a_dest,(zmq_msg_t *)$a_src);"
		end

	msg_init (a_msg: POINTER): INTEGER_32
			-- ZMQ_EXPORT int zmq_msg_init (zmq_msg_t *msg);
		external
			"C inline use <zmq.h>"
		alias
			"return zmq_msg_init ((zmq_msg_t *)$a_msg);"
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ZMQ_API
