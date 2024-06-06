note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DEBUGGER

inherit
	CLI_DEBUGGER_I

	ICOR_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_useless_clr_runtime_version: STRING_32; a_integration: like integration)
			-- Initialize `Current'.
		do
			integration := a_integration
			create icor_debug_factory
		end

feature -- Status

	is_debugging: BOOLEAN
		do
			Result := True -- icor_debug will be created later by `create_process`
		end

	last_call_success: INTEGER

	last_call_succeed: BOOLEAN
		do
			Result := last_call_success = 0
		end

feature -- Access

	integration: CLI_DEBUGGER_INTEGRATION

feature -- Factory		

	icor_debug_factory: ICOR_DEBUG_FACTORY

feature {NONE} -- Implementation

	icor_debug: detachable ICOR_DEBUG

feature {ICOR_EXPORTER} -- Access

	last_icor_debug_process_handle: POINTER
		do
			if attached icor_debug as dbg then
				Result := dbg.last_icor_debug_process_handle
			end
		end

feature -- Change

	create_process (a_command_line: READABLE_STRING_GENERAL; a_working_directory: PATH; a_ns_env: detachable NATIVE_STRING): POINTER
			-- Pointer on the freshly created ICorDebugProcess
		local
			c_cmd_line: NATIVE_STRING
			c_env: POINTER
			c_cwd: NATIVE_STRING
			l_pid: INTEGER
			n, hr: INTEGER
			p,proc_h: POINTER
			l_icor_debug: ICOR_DEBUG
		do
			icor_debug := Void
			create c_cmd_line.make (a_command_line)
			create c_cwd.make (a_working_directory.name)
			if a_ns_env /= Void then
				c_env := a_ns_env.item
			end

			last_call_success := c_start_debug_session (c_cmd_line.item, c_env, c_cwd.item, $l_pid, Current, $on_startup)

			integration.enable_debugger_callback
			from
				n := 100
			until
				n <= 0 or l_icor_debug /= Void
			loop
				{EXECUTION_ENVIRONMENT}.sleep (50_000_000) -- 50 ms
				p := c_get_icor_debug
				if not p.is_default_pointer then
					create l_icor_debug.make_by_pointer (p)
					icor_debug := l_icor_debug
					l_icor_debug.last_icor_debug_process_id := l_pid
				end
				n := n -1
			end
			if l_icor_debug /= Void then
				l_icor_debug.initialize
				n := l_icor_debug.can_launch_or_attach (123, False)
				if attached {ICOR_DEBUG_FACTORY}.new_cordebug_managed_callback as l_managed_cb then
					l_managed_cb.add_ref
					l_managed_cb.initialize_callback
					l_icor_debug.set_managed_handler (l_managed_cb)
				end
				if attached {ICOR_DEBUG_FACTORY}.new_cordebug_unmanaged_callback as l_unmanaged_cb then
					l_unmanaged_cb.add_ref
					l_unmanaged_cb.initialize_callback
					l_icor_debug.set_unmanaged_handler (l_unmanaged_cb)
				end
				Result := l_icor_debug.get_debug_active_process_pointer (l_pid)
				if not Result.is_default_pointer then
					hr := {ICOR_DEBUG_PROCESS}.cpp_get_handle (Result, $proc_h)
				else
					check has_active_process: False end
				end
				l_icor_debug.last_icor_debug_process_handle := proc_h
			else
				last_call_success := -1
			end
		end

	on_startup (p_cordb: POINTER; a_param: POINTER; hr: INTEGER)
		do
			debug ("cli_debugger")
				print ("%N%NStartup Cordb="+ p_cordb.out +" hr="+ hr.out +"...%N%N")
			end
		end

	clean_data
		do
			if attached icor_debug as dbg then
				dbg.clean_data
				icor_debug := Void
			end
		end

feature {NONE} -- Implementation

	c_start_debug_session (a_cmd_line: POINTER; a_env: POINTER; a_curr_dir: POINTER; a_proc_id: POINTER; a_callback_target: ANY; a_callback_function: POINTER): INTEGER
		external
			"C++ inline use %"cli_debugger_netcore.h%""
		alias
			"[
				(EIF_INTEGER) initialize_debug_session ((LPWSTR) $a_cmd_line, (LPVOID) $a_env, (LPCWSTR) $a_curr_dir, (PDWORD) $a_proc_id, (EIF_OBJECT) $a_callback_target, (EIF_POINTER) $a_callback_function)
			]"
		end

	c_get_icor_debug: POINTER
		external
			"C++ inline use %"cli_debugger_netcore.h%""
		alias
			"get_icor_debug ()"
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
