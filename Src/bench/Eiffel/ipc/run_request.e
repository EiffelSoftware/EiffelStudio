-- Request to run the application.

class RUN_REQUEST 

inherit
	
	EWB_REQUEST
		redefine
			send
		end;
	WINDOWS

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
		do
			if not run_info.is_running then
				if start_application (application_name) and then send_byte_code then
					send_breakpoints;
					debug_info.tenure;
					send_rqst_1 (Rqst_resume, Resume_cont);
					debug_window.clear_window;
					debug_window.put_string ("Application is running%N");
					run_info.set_is_running (True);
					debug_window.display					
				else
					debug_info.tenure;
					debug_window.clear_window;
					debug_window.put_string ("Unable to launch application%N");
					debug_window.display					
				end
			end
		end; -- send

feature {NONE} -- External features

	send_run_request (i: INTEGER; s: ANY; l: INTEGER) is
		external
			"C"
		end

end
