note
	description	: "Mechanism to call an action when a file/pipe is changed.%N%
				  %Glib Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_IO_WATCHER_IMP

inherit
	DISPOSABLE
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create and initialize current to monitor file descriptor `listen_to_pipe_fd'.
		local
			l_condition: INTEGER
			l_file_fd: INTEGER
		do
				-- Open file descriptor for debugger pipe and set up polling.
			file_descriptor_pointer := file_binary_dopen (listen_to_pipe_fd, 0)
			initialize_c_callback ($on_event)
			check
				callback_handle_zero: callback_handle = 0
			end
			l_condition := 	g_io_hup | g_io_err | g_io_nval | g_io_pri | g_io_in
			l_file_fd := file_fd (file_descriptor_pointer)
			add_watch_callback (Current, l_file_fd, l_condition, $callback_handle)
		end

feature -- Access

	action: PROCEDURE [ANY, TUPLE]
			-- Callback feature called when the file/pipe is changed.

	exception_action: detachable PROCEDURE [ANY, TUPLE]
			-- Callback feature called when an exceptions occurs on the file/pipe.

	destroy
			-- Clean up `Current'.
		local
			l_res: BOOLEAN
		do
			if not is_destroyed then
				l_res := g_source_remove (callback_handle)
				check
					removed: l_res
				end
				callback_handle := 0
					-- Close original file descriptor
				file_close (file_descriptor_pointer)
				file_descriptor_pointer := default_pointer
				action := Void
				is_destroyed := True
			end
		end

	is_destroyed: BOOLEAN
		-- Has `Current' been destroyed?

feature -- Element change

	set_action (an_action: like action)
			-- Set `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			action := an_action
		ensure
			agent_set: action = an_action
		end

	set_exception_action (an_action: like exception_action)
			-- Set `an_action' as exception callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			exception_action := an_action
		ensure
			agent_set: exception_action = an_action
		end

	remove_action
			-- Remove the current action.
		do
			action := Void
		ensure
			no_action: action = Void
		end

feature {NONE} -- Implementation

	dispose
			-- Clean up `Current'.
		do
			destroy
		end

	on_event (a_condition: INTEGER)
			-- Call action sequence corresponding to `a_condition'.
		do
			if a_condition & (g_io_err | g_io_hup | g_io_nval) /= 0 then
				if exception_action /= Void then
					exception_action.call (Void)
				end
			elseif a_condition & (g_io_in | g_io_pri) /= 0 then
				if action /= Void then
					action.call (Void)
				end
			end
		end

	callback_handle: NATURAL_32
			-- GLib callback handle.

	file_descriptor_pointer: POINTER
			-- File pointer as required in C.

feature {NONE} -- Externals

	g_io_in: INTEGER = 1
	g_io_pri: INTEGER = 2
	g_io_out: INTEGER = 4
	g_io_err: INTEGER = 8
	g_io_hup: INTEGER = 16
	g_io_nval: INTEGER = 32
		-- G_IO status flags.

	add_watch_callback (io_watcher: EB_IO_WATCHER_IMP; handle: INTEGER; condition: INTEGER; connection_id: TYPED_POINTER [NATURAL_32])
			-- Set up `on_event' callback for `io_watcher' when an event occurs
			-- on medium referenced by `handle'.
		external
			--| FIXME Make this inline when built in object protection for inline code is added to compiler.
			"C signature (EIF_OBJECT, EIF_INTEGER, GIOCondition, gint*) use %"io_watcher.h%""
		end

	g_source_remove (a_tag: NATURAL_32): BOOLEAN
		external
			"C (guint): gboolean | %"io_watcher.h%""
		end

	initialize_c_callback (on_event_address: POINTER)
			-- Pass `on_event_address' to C side to enable callbacks.
		external
			"C inline use %"io_watcher.h%""
		alias
			"eif_on_event = (void (*) (EIF_REFERENCE, EIF_INTEGER)) $on_event_address"
		end

	file_binary_dopen (fd, how: INTEGER): POINTER
			-- File pointer for file of descriptor `fd' in mode `how'
			-- (which must fit the way `fd' was obtained).
		external
			"C signature (int, int): EIF_POINTER use %"eif_file.h%""
		alias
			"file_binary_dopen"
		end

	file_close (file: POINTER)
			-- Close `file'.
		external
			"C (FILE *) | %"eif_file.h%""
		end

	file_fd (file: POINTER): INTEGER
			-- Operating system's file descriptor
		external
			"C (FILE *): EIF_INTEGER | %"eif_file.h%""
		end

	listen_to_pipe_fd: INTEGER
		external
			"C"
		alias
			"ewb_pipe_read_fd"
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EB_IO_WATCHER_IMP

