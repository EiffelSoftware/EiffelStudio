note
	description: "Summary description for {ESA_REGISTER_API_TEST}."
	date: "$Date$"
	revision: "$Revision$"
	testing:"execution/serial"

class
	ESA_REGISTER_API_TEST


inherit

	ESA_ABSTRACT_API_TEST



feature -- Test

	test_register_html_get_request
			-- New test routine
		do
			media_type := "html"
			if attached execute_get ("register") as l_resp then
				assert("Expected status 200", l_resp.status = 200)
			end
		end

	test_register_html_bad_request
			-- New test routine
		do
			media_type := "html"
			if attached execute_post ("register", "") as l_resp then
				assert("Expected status 404", l_resp.status = 404)
			end
		end

	test_register_cj_bad_request
			-- New test routine
		do
			media_type := "cj"
			if attached execute_post ("register", Void) as l_resp then
				assert("Expected status 404", l_resp.status = 404)
			end
		end


	test_register_cj_success_request
			-- New test routine
		do
			media_type := "cj"
			if attached execute_post ("register", cj_register_user_data) as l_resp then
				assert("Expected status 200", l_resp.status = 200)
			end
		end



	cj_register_user_data : STRING ="[
		{
		"template": {
	      "data": [
	        {"name": "first_name", "prompt": "Frist Name", "value": "test"},
	        {"name": "last_name", "prompt": "Last Name", "value": "test"},
	        {"name": "email", "prompt": "Email", "value": "test@gmail.com"},
	        {"name": "user_name", "prompt": "User Name", "value": "test"},
	        {"name": "password", "prompt": "Password", "value": "test"},
	        {"name": "check_password", "prompt": "Re-Type Password", "value": "test"},
	        {"name": "question", "prompt": "Question", "value": "1"},
	        {"name": "answer", "prompt": "Answer", "value": "test"}
	      ]
	      }
		}
	]"

end
