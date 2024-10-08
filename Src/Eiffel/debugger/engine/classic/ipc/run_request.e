note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	description: "Request to run the application."

class RUN_REQUEST

inherit
	EWB_REQUEST
		redefine
			send
		end

	SHARED_STATUS

	APPLICATION_STATUS_EXPORTER

create
	make

feature -- Status report

	application_path: PATH
			-- Path to executable of application

	arguments: READABLE_STRING_32
			-- Arguments for application execution

	working_directory: detachable PATH
			-- Directory in which `application_name' will be launched.

	environment_variables: NATIVE_STRING
			-- Environment in which `application_name' will be launched.

	ipc_timeout: INTEGER
			-- Timeout used in IPC communication between dbg and app.

feature -- Status setting

	set_application_path (a_path: like application_path)
			-- Assign `a_path' to `application_path'.
		require
			a_path_not_void: a_path /= Void
		do
			application_path := a_path
		ensure
			application_path_set: application_path.is_same_file_as (a_path)
		end

	set_arguments (s: like arguments)
			-- Assign `s' to `arguments'.
		do
			arguments := s
		ensure
			arguments_set: arguments = s
		end

	set_working_directory (p: like working_directory)
			-- Assign `p' to `working_directory'.
		do
			working_directory := p
		ensure
			working_directory_set: working_directory = p
		end

	set_environment_variables (s: like environment_variables)
			-- Assign `s' to `environment_variables'.
		do
			environment_variables := s
		ensure
			environment_variables_set: environment_variables = s
		end

	set_ipc_timeout (t: INTEGER)
			-- Assign `t' to `ipc_timeout'.
		require
			t > 0
		do
			ipc_timeout := t
		ensure
			ipc_timeout_set: ipc_timeout = t
		end

feature -- Update

	send
			-- Send `Current' request to ised, which may relay it to the application.
		local
			l_app_started: BOOLEAN
			app: APPLICATION_EXECUTION
		do
			if server_mode and then not Debugger_manager.application_is_executing then
				l_app_started := start_application
				if l_app_started then
					app := Debugger_manager.application
					app.build_status
					app.status.set_process_id (last_process_id)
					app.status.set_is_stopped (True)
					app.send_breakpoints
					debugger_manager.on_application_initialized

					send_rqst_3_integer (Rqst_resume, Resume_cont, debugger_manager.interrupt_number, debugger_manager.critical_stack_depth)
					app.status.set_is_stopped (False)
				end
			end
		end

feature {NONE} -- Implementation

	start_application: BOOLEAN
			-- Send a request to the Ised daemon to
			-- start application `application_name',
			-- and perform a handshake with the
			-- application to check that it is alive.
			-- Return False if something went wrong
			-- in the communication.
		do
				-- Initialize sending of working directory
			if attached working_directory as w then
				send_rqst_0 (Rqst_application_cwd)
					-- Send working directory of application
				send_native_string_content (w.native_string)
			end

				-- Initialize sending of environment
			if attached environment_variables as envs then
				check envs.managed_data.count > 0 end
				send_rqst_0 (Rqst_application_env)
				-- Send environment of application
				send_native_string_content (envs)
			end

				-- Start the application (in debug mode).
			send_rqst_0 (Rqst_application)

				-- Send the name of the application.
			send_native_string_content	(application_path.native_string)

				-- Send the arguments.

			if attached arguments as l_args then
				send_string_32_content	(l_args)
			else
				send_string_32_content	({STRING_32} "")
			end

			Result := recv_ack
			debug("DEBUGGER")
				if Result then
					io.put_string("acknowledge received%N");
				end

				io.put_string("Performing a handshake with the application....");
			end

				-- Perform a handshake with the application.
			if Result then
				last_process_id := to_integer_32 (c_tread)
				send_rqst_0 (Rqst_hello)
				Result := recv_ack
				debug("DEBUGGER")
					io.put_string("[ ok ]%N");
				end
			else
				last_process_id := 0
			end
		end

	last_process_id: INTEGER;
			-- Process ID of last application launched

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end
