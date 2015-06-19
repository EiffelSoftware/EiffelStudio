note
	description: "Summary description for {TEST_TOKEN_EXTRACTOR_20}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TOKEN_EXTRACTOR_20

inherit

	EQA_TEST_SET

feature -- Test

	test_extract_token_from_oauth_standard_response
		local
			l_token_extractor : TOKEN_EXTRACTOR_20
			l_response : STRING
		do
			l_response := "access_token=166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159|RsXNdKrpxg8L6QNLWcs2TVTmcaE"
			create l_token_extractor
			if attached l_token_extractor.extract (l_response) as l_token then
				assert ("Expected equals", l_token.token.same_string("166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159|RsXNdKrpxg8L6QNLWcs2TVTmcaE"))
				assert ("Expected empty secret", l_token.secret.is_empty)
			end
		end

	test_extract_token_from_oauth_standard_response_with_expires_param
		local
			l_token_extractor : TOKEN_EXTRACTOR_20
			l_response : STRING
		do
			l_response := "access_token=166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159|RsXNdKrpxg8L6QNLWcs2TVTmcaE&expires=5108"
			create l_token_extractor
			if attached l_token_extractor.extract (l_response) as l_token then
				assert ("Expected equals", l_token.token.same_string("166942940015970|2.2ltzWXYNDjCtg5ZDVVJJeg__.3600.1295816400-548517159|RsXNdKrpxg8L6QNLWcs2TVTmcaE"))
				assert ("Expected empty secret", l_token.secret.is_empty)
			end
		end

	test_extract_token_from_response_with_many_parameters
		local
			l_token_extractor : TOKEN_EXTRACTOR_20
			l_response : STRING
		do
			l_response := "access_token=foo1234&other_stuff=yeah_we_have_this_too&number=42"
			create l_token_extractor
			if attached l_token_extractor.extract (l_response) as l_token then
				assert ("Expected equals", l_token.token.same_string("foo1234"))
				assert ("Expected empty secret", l_token.secret.is_empty)
			end
		end

	test_void_token
		local
			l_token_extractor : TOKEN_EXTRACTOR_20
			l_response : STRING
		do
			l_response := "&expires=5108"
			create l_token_extractor
			assert("Expected void", l_token_extractor.extract (l_response) = Void)
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
