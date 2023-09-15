note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CURL_HTTP_CLIENT

inherit
	TEST_HTTP_CLIENT_I

feature -- Factory

	new_session (a_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
		do
			create {CURL_HTTP_CLIENT_SESSION} Result.make (a_url)
		end

feature -- Tests

	test_curl_http_client
		do
			test_http_client
		end

	test_curl_http_client_ssl
		do
			test_http_client_ssl
		end

	test_curl_http_client_ssl_with_valid_certs
		do
			test_http_client_ssl_with_valid_certs
		end

	test_curl_http_client_ssl_with_missing_certs
		do
			test_http_client_ssl_with_missing_certs
		end

	test_curl_http_client_ssl_with_certs_missing_passphrase
		do
			test_http_client_ssl_with_certs_missing_passphrase
		end




	test_curl_abs_url
		do
			test_abs_url
		end

	test_curl_headers
		do
			test_headers
		end


end


