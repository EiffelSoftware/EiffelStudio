-- Request to run the application.

class RUN_REQUEST 

inherit
	
	EWB_REQUEST
		redefine
			send
		end

	SHARED_STATUS

creation

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
		local
			status: APPLICATION_STATUS
		do
			if server_mode and then not Application.is_running and then start_application then
				create status.do_nothing
				Application.set_status(status)
				send_breakpoints
				send_rqst_3 (Rqst_resume, Resume_cont, Application.interrupt_number, Application.critical_stack_depth)
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
	
end
