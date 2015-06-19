note
	description: "Summary description for {TEST_HEAD_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HEAD_EXTRACTOR

inherit

	EQA_TEST_SET

feature -- Test

	test_extract_standard_header
		local
			l_extractor: HEADER_EXTRACTOR_10
			l_request: OAUTH_REQUEST
			l_expected: STRING_32
		do
			l_request := (create {OAUTH_REQUEST_FIXTURE_FACTORY}).default_request
			l_expected :="[
						OAuth oauth_timestamp="123456", oauth_consumer_key="AS%23%24%5E%2A%40%26", oauth_callback="http%3A%2F%2Fexample%2Fcallback", oauth_signature="OAuth-Signature"
							]"
			l_expected.left_adjust
			l_expected.right_adjust
			create l_extractor
			assert("Equals",l_extractor.extract (l_request).is_equal (l_expected))
		end


	test_contract_violation_request_has_no_oauth_parameters
		local
			l_extractor: HEADER_EXTRACTOR_10
			l_retry: BOOLEAN
			l_request: OAUTH_REQUEST
			l_resp: STRING
		do
			if not l_retry then
				create l_request.make ("GET","http://example.com")
				create l_extractor
				l_resp := l_extractor.extract (l_request).as_string_8
			end
			assert("Expected",True)
		rescue
			l_retry := True
			retry
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
