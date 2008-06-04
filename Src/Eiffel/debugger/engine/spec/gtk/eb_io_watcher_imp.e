indexing
	description	: "Mechanism to call an action when a file/pipe is changed.%N%
				  %GTK Implementation."
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

	default_create is
			-- Create and initialize current to monitor file descriptor `listen_to_pipe_fd'.
		local
			l_condition: INTEGER
		do
				-- Open file descriptor for debugger pipe and set up polling.
			file_descriptor_pointer := file_binary_dopen (listen_to_pipe_fd, 0)
			initialize_c_callback ($on_event)
			check
				callback_handle_zero: callback_handle = 0
			end
			l_condition := 	{EV_GTK_EXTERNALS}.g_io_hup | {EV_GTK_EXTERNALS}.g_io_err |
							{EV_GTK_EXTERNALS}.g_io_nval | {EV_GTK_EXTERNALS}.g_io_pri | {EV_GTK_EXTERNALS}.g_io_in
			add_watch_callback (Current, file_fd (file_descriptor_pointer), l_condition, $callback_handle)
		end

feature -- Access

	action: PROCEDURE [ANY, TUPLE]
			-- Callback feature called with the file/pipe is changed.

	destroy is
			-- Clean up `Current'.
		local
			l_res: BOOLEAN
		do
			if not is_destroyed then
				l_res := {EV_GTK_EXTERNALS}.g_source_remove (callback_handle)
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

	set_action (an_action: like action) is
			-- Set `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			action := an_action
		ensure
			agent_set: action = an_action
		end

	remove_action is
			-- Remove the current action.
		do
			action := Void
		ensure
			no_action: action = Void
		end

feature {NONE} -- Implementation

	dispose is
			-- Clean up `Current'.
		do
			destroy
		end

	on_event (condition: INTEGER) is
			-- Call action sequence corresponding to `condition'.
		local
			l_call_actions: BOOLEAN
		do
			if action /= Void then
				if condition & {EV_GTK_EXTERNALS}.G_io_in = {EV_GTK_EXTERNALS}.G_io_in then
					l_call_actions := True
				end
				if condition & {EV_GTK_EXTERNALS}.G_io_pri = {EV_GTK_EXTERNALS}.G_io_pri then
					l_call_actions := True
				end
				if condition & {EV_GTK_EXTERNALS}.G_io_out = {EV_GTK_EXTERNALS}.G_io_out then
					-- Do nothing as we do not care about writing.
				end
				if condition & {EV_GTK_EXTERNALS}.G_io_err = {EV_GTK_EXTERNALS}.G_io_err then
					l_call_actions := True
				end
				if condition & {EV_GTK_EXTERNALS}.G_io_hup = {EV_GTK_EXTERNALS}.G_io_hup then
					l_call_actions := True
				end
				if condition & {EV_GTK_EXTERNALS}.G_io_nval = {EV_GTK_EXTERNALS}.G_io_nval then
					l_call_actions := True
				end
				if l_call_actions then
					action.call (Void)
				end
			end
		end

	callback_handle: NATURAL_32
			-- GLib callback handle.

	file_descriptor_pointer: POINTER
			-- File pointer as required in C.

feature {NONE} -- Externals

	add_watch_callback (io_watcher: EB_IO_WATCHER_IMP; handle: INTEGER; condition: INTEGER; connection_id: TYPED_POINTER [NATURAL_32]) is
			-- Set up `on_event' callback for `io_watcher' when an event occurs
			-- on medium referenced by `handle'.
		external
			--| FIXME Make this inline when built in object protection for inline code is added to compiler.
			"C signature (EIF_OBJECT, EIF_INTEGER, GIOCondition, gint*) use %"ev_c_util.h%""
		end

	initialize_c_callback (on_event_address: POINTER) is
			-- Pass `on_event_address' to C side to enable callbacks.
		external
			"C inline use %"ev_c_util.h%""
		alias
			"eif_on_event = (void (*) (EIF_REFERENCE, EIF_INTEGER)) $on_event_address"
		end

	file_binary_dopen (fd, how: INTEGER): POINTER is
			-- File pointer for file of descriptor `fd' in mode `how'
			-- (which must fit the way `fd' was obtained).
		external
			"C signature (int, int): EIF_POINTER use %"eif_file.h%""
		alias
			"file_binary_dopen"
		end

	file_close (file: POINTER) is
			-- Close `file'.
		external
			"C (FILE *) | %"eif_file.h%""
		end

	file_fd (file: POINTER): INTEGER is
			-- Operating system's file descriptor
		external
			"C (FILE *): EIF_INTEGER | %"eif_file.h%""
		end

	listen_to_pipe_fd: INTEGER is
		external
			"C"
		alias
			"ewb_pipe_read_fd"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- EB_IO_WATCHER_IMP

