note
	description: "Summary description for {TEST_JSON_TOKEN_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_TOKEN_EXTRACTOR
inherit
	EQA_TEST_SET

feature -- Test

	test_parser_json_response
		local
			l_extractor : JSON_TOKEN_EXTRACTOR
			l_response : STRING
		do
			l_response := "'{ %"access_token%":%"I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T3X%"}'"
			create l_extractor
			if attached l_extractor.extract (l_response) as l_token then
				assert ("Expected equals", l_token.token.same_string("I0122HHJKLEM21F3WLPYHDKGKZULAUO4SGMV3ABKFTDT3T3X"))
			end
		end

		test_parser_json_response_empty_should_be_void
			local
				l_extractor : JSON_TOKEN_EXTRACTOR
				l_response : STRING
			do
				l_response := "'{}'"
				create l_extractor
				assert ("Expected Void",l_extractor.extract (l_response) = Void)
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
