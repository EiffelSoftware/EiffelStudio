-- Request to run the application.

class RUN_REQUEST 

inherit
	
	EWB_REQUEST
		redefine
			send
		end;

creation

	make 

feature -- Status report

	application_name: STRING;

feature -- Status setting

	set_application_name (s: STRING) is
		do
			application_name := s
		end;

feature -- Update

	send is
			-- Send `Current' request to ised, which may relay it to the application.
		local
			status: APPLICATION_STATUS
		do
			if not Application.is_running then
				if start_application (application_name) and then send_byte_code then
					!! status.do_nothing;
					send_breakpoints;
					debug_info.tenure;
					send_rqst_2 (Rqst_resume, Resume_cont, 
						Application.interrupt_number);
					status.set_is_stopped (False);
					Application.set_status (status);
				else
					debug_info.tenure;
				end
			end
		end; -- send

feature {NONE} -- Implementation

	start_application (app_name: STRING): BOOLEAN is
			-- Send a request to the Ised daemon to 
			-- start the application `app_name',
			-- and perform a handshake with the
			-- application to check that it is alive.
			-- Return False if something went wrong
			-- in the communication.
		local
			ext_str: ANY;
		do
			-- Start the application (in debug mode).
			send_rqst_0 (Rqst_application);

			-- Send the name of the application.
			ext_str := app_name.to_c;
			c_send_str ($ext_str);
			Result := recv_ack;

			-- Perform a handskae with the application.
			if Result then
				send_rqst_0 (Rqst_hello);
				Result := recv_ack
			end;
		end;

feature {NONE} -- External features

	eif_timeout_msg: STRING is
			-- Message displayed when ebench is unable to launch
			-- the system (because of a timeout)
		external
			"C"
		end;
	
end
