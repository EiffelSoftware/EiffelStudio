-- General request from workbench to ised.

class EWB_REQUEST 

creation

	make 

feature 

	make (code: INTEGER) is
		do
			request_code := code
		end;

	send is
			-- Send Current request to ised, which may 
			-- relay it to the application.
		do
			send_simple_request (request_code)
		end;

	request_code: INTEGER;

feature {NONE} -- External features

	send_simple_request (i: INTEGER) is
		external
			"C"
		end

end
