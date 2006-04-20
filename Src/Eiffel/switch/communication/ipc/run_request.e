indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Request to run the application.

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
	
	working_directory: STRING
			-- Directory in which `application_name' will be launched.

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
		
	set_working_directory (s: STRING) is
			-- Assign `s' to `working_directory'.
		require
			s_not_void: s /= Void
		do
			working_directory := s
		ensure
			working_directory_set: working_directory = s
		end

feature -- Update

	send is
			-- Send `Current' request to ised, which may relay it to the application.
		do
			if server_mode and then not Application.is_running and then start_application then
				Application.build_status
				send_breakpoints
				send_rqst_3_integer (Rqst_resume, Resume_cont, Application.interrupt_number, Application.critical_stack_depth)
				Application.status.set_is_stopped (False)
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
		local
			ext_str: ANY
		do
				-- Initialize sending of working directory
			send_rqst_0 (Rqst_application_cwd)
			
				-- Send working directory of application
			ext_str := working_directory.to_c
			c_send_str ($ext_str)
			
				-- Start the application (in debug mode).
			send_rqst_0 (Rqst_application)

				-- Send the name of the application.
			ext_str := application_name.to_c
			c_send_str ($ext_str)
			Result := recv_ack

			debug("DEBUGGER")
				if Result then
					io.put_string("acknowledge received%N");
				end

				io.put_string("Performing a handshake with the application....");
			end


				-- Perform a handshake with the application.
			if Result then
				send_rqst_0 (Rqst_hello)
				Result := recv_ack
				debug("DEBUGGER")
					io.put_string("[ ok ]%N");
				end
			end
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

end
