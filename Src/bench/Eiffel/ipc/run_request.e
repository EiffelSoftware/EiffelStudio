-- Request to run the application.

class RUN_REQUEST 

inherit
	
	EWB_REQUEST
		redefine
			send
		end

creation

	make 

feature 

	set_application_name (s: STRING) is
		do
			application_name := s
		end;

	application_name: STRING;

	send is
			-- Send Current request to ised, which may 
			-- relay it to the application.
		local
			status: BOOLEAN
		do
			if not run_info.is_running then
				status := start_application (application_name);
				if status then
					status := send_byte_code
				end;
				if status then
					send_breakpoints
				end;
				debug_info.tenure;
				if status then
					send_rqst_1 (Rqst_resume, Resume_cont);
				end;
				run_info.set_is_running (true);
			end;
		end;

feature {NONE} -- External features

	send_run_request (i: INTEGER; s: ANY; l: INTEGER) is
		external
			"C"
		end

end
