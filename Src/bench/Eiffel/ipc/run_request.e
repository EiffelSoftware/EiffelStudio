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
			ext_str: ANY
		do
			ext_str := application_name.to_c;
			send_run_request (request_code, $ext_str, application_name.count)
		end;

feature {NONE} -- External features

	send_run_request (i: INTEGER; s: ANY; l: INTEGER) is
		external
			"C"
		end

end
