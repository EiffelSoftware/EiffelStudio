indexing
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

	default_create is
			-- Create action sequences.
		do
			create read_actions
			create error_actions
			create exception_actions
		end

	make_with_medium (a_medium: IO_MEDIUM) is
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

	medium: IO_MEDIUM
			-- Watched for state changes.

	set_medium (a_medium: IO_MEDIUM) is
			-- Assign `a_medium' to `medium'.
			-- `remove_medium' must be called to release resources allocated
			-- by this feature.
		require
			medium_void: medium = Void
			a_medium_not_void: a_medium /= Void
		do
			medium := a_medium
			initialize_callback
			check
				callback_handle_zero: callback_handle = 0
			end
			callback_handle := c_add_watch_callback (Current, medium.handle)
		ensure
			callback_handle_positive: callback_handle > 0
			medium_assigned: a_medium = medium
		end
	
	remove_medium is
			-- Make `medium' `Void'.
		require
			medium_not_void: medium /= Void
		local
			res: BOOLEAN
		do
			medium := Void
			check
				callback_handle_positive: callback_handle > 0
			end
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

	error_actions: ACTION_SEQUENCE [TUPLE []]
			-- Actions to be performed when `medium' is in an
			-- error state.

	exception_actions: ACTION_SEQUENCE [TUPLE []]
			-- Actions to be performed when an exception was raised
			-- on `medium'.

feature {NONE} -- Implementation

	on_event (condition: INTEGER) is
			-- Call action sequence corresponding to `condition'.
		do
			if condition & G_io_in /= 0 then
				read_actions.call ([])
			end
			if condition & G_io_out /= 0 then
				--FIXME
			end
			if condition & G_io_err /= 0 then
				error_actions.call ([])
			end
			if condition & G_io_pri /= 0 then
				exception_actions.call ([])
			end
			if condition & G_io_hup /= 0 then
				--FIXME
			end
			if condition & G_io_nval /= 0 then
				--FIXME
			end
		end

	G_io_in: INTEGER is 1

	G_io_out: INTEGER is 4

	G_io_pri: INTEGER is 2

	G_io_err: INTEGER is 8

	G_io_hup: INTEGER is 16

	G_io_nval: INTEGER is 32

	c_add_watch_callback (object: IO_WATCHER; handle: INTEGER): INTEGER is
			-- Set up `on_event' callback for `object' when an event occurs
			-- on medium referenced by `handle'.
		external
			"C (EIF_OBJECT, gint): guint | %"io_watcher.h%""
		alias
			"c_io_watcher_add_watch_callback"
		end

	initialize_callback is
			-- Pass address of `on_event' to C side to enable callbacks.
		once
			c_initialize_callback ($on_event)
		end

	c_initialize_callback (on_event_address: POINTER) is
			-- Pass `on_event_address' to C side to enable callbacks.
		external
			"C (gpointer) | %"io_watcher.h%""
		alias
			"c_io_watcher_initialize_callback"
		end

	callback_handle: INTEGER
			-- GLib callback handle.

	g_source_remove (a_tag: INTEGER): BOOLEAN is 
			-- gboolean g_source_remove (guint tag);
		external
			"C (guint): gboolean | <gtk/gtk.h>"
		end

invariant
	read_actions_not_void: read_actions /= Void
	error_actions_not_void: error_actions /= Void
	exception_actions_not_void: exception_actions /= Void
	medium_has_callback_handle: not (medium /= Void xor callback_handle > 0)

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




end

