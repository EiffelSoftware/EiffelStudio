note
	description: "Summary description for {ESA_API_SERVICE_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_API_SERVICE_TEST

inherit

	ESA_ABSTRACT_API_TEST

feature -- Register User

	test_add_user
		do
			assert ("Expected created new user",esa_api_service.add_user ("esa", "api", "esapirest@gmail.com", "esapi", "pwd123", "testing", security.token, 1))
		end

end
