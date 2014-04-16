note
	description: "Summary description for {ESA_ROOT_API_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ROOT_API_TEST

inherit

	ESA_ABSTRACT_API_TEST



feature -- Test

	test_register_html_get_request
			-- New test routine
		do
			media_type := "html"
			if attached execute_get ("reports") as l_resp then
				assert("Expected status 200", l_resp.status = 200)
			end
		end

	test_home_unnaceptable
			-- New test routine
		do
			if attached execute_get ("") as l_resp then
				assert("Expected status 406", l_resp.status = 406)
			end
		end

	test_home_accept_html
			-- New test routine
		do
			media_type := "html"
			if attached execute_get ("") as l_resp then
				assert("Expected status 200", l_resp.status = 200)
				if attached l_resp.header ("Content-Type") as l_type then
					assert("Expected Content-Type text/html", l_type.same_string ("text/html"))
				end

			end
		end

	test_home_accept_cj
			-- New test routine
		do
			media_type := "cj"
			if attached {HTTP_CLIENT_RESPONSE} execute_get ("") as l_resp then
				assert("Expected status 200", l_resp.status = 200)
				if attached l_resp.header ("Content-Type") as l_type then
					assert("Expected Content-Type application/vnd.collection+json", l_type.same_string ("application/vnd.collection+json"))
				end
			end
		end

end
