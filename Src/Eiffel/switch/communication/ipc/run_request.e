indexing
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

	application_name: STRING
			-- Path to executable of application

	arguments: STRING
			-- Arguments for application execution

	working_directory: STRING
			-- Directory in which `application_name' will be launched.

	environment_variables: STRING
			-- Environment in which `application_name' will be launched.

	ipc_timeout: INTEGER
			-- Timeout used in IPC communication between dbg and app.

feature -- Status setting

	set_application_name (s: STRING) is
			-- Assign `s' to `application_name'.
		require
			s_not_void: s /= Void
		do
			application_name := s
		ensure
			application_name_set: application_name = s
		end

	set_arguments (s: STRING) is
			-- Assign `s' to `arguments'.
		do
			arguments := s
		ensure
			arguments_set: arguments = s
		end

	set_working_directory (s: STRING) is
			-- Assign `s' to `working_directory'.
		require
			s_not_void: s /= Void
		do
			working_directory := s
		ensure
			working_directory_set: working_directory = s
		end

	set_environment_variables (s: STRING) is
			-- Assign `s' to `environment_variables'.
		do
			environment_variables := s
		ensure
			environment_variables_set: environment_variables = s
		end

	set_ipc_timeout (t: INTEGER) is
			-- Assign `t' to `ipc_timeout'.
		require
			t > 0
		do
			ipc_timeout := t
		ensure
			ipc_timeout_set: ipc_timeout = t
		end

feature -- Update

	send is
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
					app.send_breakpoints
					send_rqst_3_integer (Rqst_resume, Resume_cont, debugger_manager.interrupt_number, debugger_manager.critical_stack_depth)
					app.status.set_is_stopped (False)
				end
			end
		end

feature {NONE} -- Implementation

	start_application: BOOLEAN is
			-- Send a request to the Ised daemon to
			-- start application `application_name',
			-- and perform a handshake with the
			-- application to check that it is alive.
			-- Return False if something went wrong
			-- in the communication.
		do
				-- Initialize sending of working directory
			if working_directory /= Void then
				send_rqst_0 (Rqst_application_cwd)
					-- Send working directory of application
				send_string_content (working_directory)
			end

				-- Initialize sending of environment
			if environment_variables /= Void and then environment_variables.count > 0 then
				send_rqst_0 (Rqst_application_env)
				-- Send environment of application
				send_string_content_with_size (environment_variables, environment_variables.count)
			end

				-- Start the application (in debug mode).
			send_rqst_0 (Rqst_application)

				-- Send the name of the application.
			send_string_content	(application_name)

				-- Send the arguments.

			if arguments = Void then
				send_string_content	("")
			else
				send_string_content	(arguments)
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

end
