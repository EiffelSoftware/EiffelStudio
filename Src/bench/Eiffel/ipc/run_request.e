-- Request to run the application.

class RUN_REQUEST 

inherit
	
	EWB_REQUEST
		redefine
			send
		end;

creation

	make 

feature 

	set_application_name (s: STRING) is
		do
			application_name := s
		end;

	application_name: STRING;

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
					send_rqst_1 (Rqst_resume, Resume_cont);
					status.set_is_stopped (False);
					Application.set_status (status);
				else
					debug_info.tenure;
				end
			end
		end; -- send

feature {NONE} -- External features

	send_run_request (i: INTEGER; s: ANY; l: INTEGER) is
		external
			"C"
		end

	eif_timeout_msg: STRING is
			-- Message displayed when ebench is unable to launch
			-- the system (because of a timeout)
		external
			"C"
		end;
	
end
