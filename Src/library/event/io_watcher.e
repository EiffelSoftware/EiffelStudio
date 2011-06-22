note
	description:
		"Watches an IO_MEDIUM and performs arbitrary actions when%
		%its state changes.%N%
		%Resources allocated by `set_medium' will not be released until%
		%`remove_medium' is called"
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	IO_WATCHER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_medium

feature {NONE} -- Initialization

	default_create
			-- Create action sequences.
		do
			create read_actions
			create write_actions
			create error_actions
			create exception_actions
		end

	make_with_medium (a_medium: IO_MEDIUM)
			-- Create with `a_medium'.
		require
			medium_void: medium = Void
			a_medium_not_void: a_medium /= Void
		do
			default_create
			set_medium (a_medium)
		ensure
			callback_handle_positive: callback_handle > 0
			medium_assigned: a_medium = medium
		end

feature -- Access

	medium: detachable IO_MEDIUM
			-- Medium watched for state changes.

	set_medium (a_medium: IO_MEDIUM)
			-- Assign `a_medium' to `medium'.
			-- `remove_medium' must be called to release resources allocated
			-- by this feature.
		require
			medium_void: medium = Void
			a_medium_not_void: a_medium /= Void
		local
			l_condition: INTEGER
			l_handle: INTEGER
		do
			medium := a_medium
			initialize_c_callback ($on_event)
			check
				callback_handle_zero: callback_handle = 0
			end
			l_condition := G_io_hup | G_io_err | G_io_nval | G_io_pri | G_io_in | G_io_out
			l_handle := a_medium.handle
			add_watch_callback (Current, l_handle, l_condition, $callback_handle)
		ensure
			medium_assigned: a_medium = medium
		end

	remove_medium
			-- Make `medium' `Void'.
		require
			medium_not_void: medium /= Void
		local
			res: BOOLEAN
		do
			medium := Void
			res := g_source_remove (callback_handle);
			check
				removed: res = True
			end
			callback_handle := 0
		ensure
			callback_handle_zero: callback_handle = 0
			medium = Void
		end

feature -- Event handling

	read_actions: ACTION_SEQUENCE [TUPLE []]
			-- Actions to be performed when `medium' has become
			-- available for reading.

	write_actions: ACTION_SEQUENCE [TUPLE []]
			-- Actions to be performed when `medium' has become
			-- available for non-blocking writing.			

	error_actions: ACTION_SEQUENCE [TUPLE []]
			-- Actions to be performed when `medium' is in an
			-- error state.

	exception_actions: ACTION_SEQUENCE [TUPLE []]
			-- Actions to be performed when an exception was raised
			-- on `medium'.

feature {NONE} -- Implementation

	on_event (condition: INTEGER)
			-- Call action sequence corresponding to `condition'.
		do
			if condition & (G_io_err | G_io_nval | G_io_hup) /= 0 then
					-- An error or exception has occured.
				if condition & G_io_hup /= 0 then
					exception_actions.call (Void)
				else
					error_actions.call (Void)
				end
			else
				if condition & (G_io_in | G_io_pri) /= 0 then
					read_actions.call (Void)
				end
				if condition & G_io_out /= 0 then
					write_actions.call (Void)
				end
			end
		end

feature {NONE} -- Externals

	G_io_in: INTEGER
			-- There is data to be read.
		external
			"C macro use <glib.h>"
		alias
			"G_IO_IN"
		end

	G_io_out: INTEGER
			-- Data can be written.
		external
			"C macro use <glib.h>"
		alias
			"G_IO_OUT"
		end

	G_io_pri: INTEGER
			-- There is urgent data to read.
		external
			"C macro use <glib.h>"
		alias
			"G_IO_PRI"
		end

	G_io_err: INTEGER
			-- Error condition.
		external
			"C macro use <glib.h>"
		alias
			"G_IO_ERR"
		end

	G_io_hup: INTEGER
			-- Hung up (the connection has been broken, usually for pipes and sockets).
		external
			"C macro use <glib.h>"
		alias
			"G_IO_HUP"
		end

	G_io_nval: INTEGER
			-- Invalid request. The file descriptor is not open.
		external
			"C macro use <glib.h>"
		alias
			"G_IO_NVAL"
		end

	add_watch_callback (io_watcher: IO_WATCHER; handle: INTEGER; condition: INTEGER; connection_id: TYPED_POINTER [NATURAL_32])
			-- Set up `on_event' callback for `io_watcher' when an event occurs
			-- on medium referenced by `handle'.
		external
			--| FIXME Make this inline when built in object protection for inline code is added to compiler.
			"C signature (EIF_OBJECT, EIF_INTEGER, GIOCondition, gint*) use %"io_watcher.h%""
		end

	initialize_c_callback (on_event_address: POINTER)
			-- Pass `on_event_address' to C side to enable callbacks.
		external
			"C inline use %"io_watcher.h%""
		alias
			"eif_on_event = (void (*) (EIF_REFERENCE, EIF_INTEGER)) $on_event_address"
		end

	callback_handle: NATURAL_32
			-- GLib callback handle.

	g_source_remove (a_tag: NATURAL_32): BOOLEAN
			-- gboolean g_source_remove (guint tag);
		external
			"C (guint): gboolean | <glib.h>"
		end

invariant
	read_actions_not_void: read_actions /= Void
	error_actions_not_void: error_actions /= Void
	exception_actions_not_void: exception_actions /= Void
	medium_has_callback_handle: not (medium /= Void xor callback_handle > 0)

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

