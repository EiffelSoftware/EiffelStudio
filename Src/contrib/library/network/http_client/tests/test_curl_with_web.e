note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CURL_WITH_WEB

inherit
	TEST_WITH_WEB_I

feature -- Factory

	new_session (a_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
		local
			cl: CURL_HTTP_CLIENT
		do
			create cl
			Result := cl.new_session (a_url)
		end

feature -- Tests

	curl_test_post_url_encoded
		do
			test_post_url_encoded
		end

	curl_test_post_with_form_data
		do
			test_post_with_form_data
		end

	curl_test_post_with_uncommon_form_data
		do
			test_post_with_uncommon_form_data
		end

	curl_test_post_with_file
		do
			test_post_with_file
		end

	curl_test_put_with_file
		do
			test_put_with_file
		end

	curl_test_put_with_data
		do
			test_put_with_data
		end

	curl_test_post_with_file_and_form_data
		do
			test_post_with_file_and_form_data
		end

	curl_test_post_with_multiple_file_and_form_data
		do
			test_post_with_multiple_file_and_form_data
		end

	curl_test_get_with_redirection
		do
			test_get_with_redirection
		end

	curl_test_get_with_authentication
		do
			test_get_with_authentication
		end

end
