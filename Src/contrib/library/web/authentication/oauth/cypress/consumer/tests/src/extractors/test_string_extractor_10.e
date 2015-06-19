note
	description: "Summary description for {TEST_STRING_EXTRACTOR_10}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STRING_EXTRACTOR_10

inherit

	EQA_TEST_SET


feature -- Test


	test_extract_string_from_oauth_request
		local
			l_extractor: STRING_EXTRACTOR_10
			l_request: OAUTH_REQUEST
			l_expected: STRING
		do
			l_request := (create {OAUTH_REQUEST_FIXTURE_FACTORY}).default_request
			l_expected := "[
					GET&http%3A%2F%2Fexample.com&oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature%26oauth_timestamp%3D123456
					]"
			l_expected.right_adjust
			l_expected.left_justify
			create l_extractor
			assert("Equals",l_extractor.extract (l_request).is_equal (l_expected))
		end

	test_contract_violation_request_has_no_oauth_parameters
		local
			l_extractor: STRING_EXTRACTOR_10
			l_retry: BOOLEAN
			l_request: OAUTH_REQUEST
			l_resp: STRING
		do
			if not l_retry then
				create l_request.make ("GET","http://example.com")
				create l_extractor
				l_resp := l_extractor.extract (l_request)
			end
			assert("Expected",True)
		rescue
			l_retry := True
			retry
		end


	test_add_encode_spaces_properly
		local
			l_extractor: STRING_EXTRACTOR_10
			l_request: OAUTH_REQUEST
			l_expected: STRING
		do
			l_request := (create {OAUTH_REQUEST_FIXTURE_FACTORY}).default_request
			l_expected := "[
					GET&http%3A%2F%2Fexample.com&body%3Dthis%2520param%2520has%2520whitespace%26oauth_callback%3Dhttp%253A%252F%252Fexample%252Fcallback%26oauth_consumer_key%3DAS%2523%2524%255E%252A%2540%2526%26oauth_signature%3DOAuth-Signature%26oauth_timestamp%3D123456
					]"
			l_expected.right_adjust
			l_expected.left_justify
			l_request.add_body_parameter ("body", "this param has whitespace")
			create l_extractor
			assert("Equals",l_extractor.extract (l_request).is_equal (l_expected))
		end

note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
