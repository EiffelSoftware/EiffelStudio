note
	description: "Summary description for {TEST_TOKEN_EXTRACTOR_10}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TOKEN_EXTRACTOR_10

inherit

	EQA_TEST_SET

feature -- Tests

	test_extract_token_from_oauth_standard_response
		local
			l_response: STRING
			l_token: detachable OAUTH_TOKEN
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_token=hh5s93j4hdidpola&oauth_token_secret=hdhd0244k9j7ao03"
			create l_extractor
			l_token := l_extractor.extract (l_response)
			if l_token /= Void then
				assert("Expected token:hh5s93j4hdidpola",l_token.token.is_equal ("hh5s93j4hdidpola"))
				assert("Expected secret:hdhd0244k9j7ao03",l_token.secret.is_equal ("hdhd0244k9j7ao03"))
			end
		end

	test_extract_token_from_inverted_oauth_standard_response
		local
			l_response: STRING
			l_token: detachable OAUTH_TOKEN
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_token_secret=hh5s93j4hdidpola&oauth_token=hdhd0244k9j7ao03"
			create l_extractor
			l_token := l_extractor.extract (l_response)
			if l_token /= Void then
				assert("Expected token:hh5s93j4hdidpola",l_token.secret.is_equal ("hh5s93j4hdidpola"))
				assert("Expected secret:hdhd0244k9j7ao03",l_token.token.is_equal ("hdhd0244k9j7ao03"))
			end
		end

	test_extract_token_from_oauth_standard_response_with_callback_confirmed
		local
			l_response: STRING
			l_token: detachable OAUTH_TOKEN
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_token=hh5s93j4hdidpola&oauth_token_secret=hdhd0244k9j7ao03&callback_confirmed=true"
			create l_extractor
			l_token := l_extractor.extract (l_response)
			if l_token /= Void then
				assert("Expected token:hh5s93j4hdidpola",l_token.token.is_equal ("hh5s93j4hdidpola"))
				assert("Expected secret:hdhd0244k9j7ao03",l_token.secret.is_equal ("hdhd0244k9j7ao03"))
			end
		end

	test_extract_token_from_inverted_oauth_standard_response_with_callback_true
		local
			l_response: STRING
			l_token: detachable OAUTH_TOKEN
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_token_secret=C6ehBPh3X7YWPYveWecQtPpAMGZP7uwU&oauth_token=RUhgxLKZgZvujSWpb6&oauth_callback_confirmed=true	"
			create l_extractor
			l_token := l_extractor.extract (l_response)
			if l_token /= Void then
				assert("Expected token:hh5s93j4hdidpola",l_token.token.is_equal ("RUhgxLKZgZvujSWpb6"))
				assert("Expected secret:hdhd0244k9j7ao03",l_token.secret.is_equal ("C6ehBPh3X7YWPYveWecQtPpAMGZP7uwU"))
			end
		end





	test_extract_token_from_inverted_oauth_standard_response_with_callback_confirmed
		local
			l_response: STRING
			l_token: detachable OAUTH_TOKEN
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_callback_confirmed=true&oauth_token=72157635100605416-d834a8fae380fdaf&oauth_token_secret=fc90c0eceed0c0b6"
			create l_extractor
			l_token := l_extractor.extract (l_response)
			if l_token /= Void then
				assert("Expected token:72157635100605416-d834a8fae380fdaf",l_token.token.is_equal ("72157635100605416-d834a8fae380fdaf"))
				assert("Expected secret:fc90c0eceed0c0b6",l_token.secret.is_equal ("fc90c0eceed0c0b6"))
			end
		end


	test_extract_token_from_with_empty_secret
		local
			l_response: STRING
			l_token: detachable OAUTH_TOKEN
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_token=hh5s93j4hdidpola&oauth_token_secret="
			create l_extractor
			l_token := l_extractor.extract (l_response)
			if l_token /= Void then
				assert("Expected token:hh5s93j4hdidpola",l_token.token.is_equal ("hh5s93j4hdidpola"))
				assert("Expected secret:",l_token.secret.is_empty)
			end
		end

	test_should_return_void_if_token_is_absent
		local
			l_response: STRING
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_secret=hh5s93j4hdidpola&callback_confirmed=true"
			create l_extractor
			assert("Expected Void",l_extractor.extract (l_response) = Void)
		end

	test_should_return_void_if_secret_is_absent
		local
			l_response: STRING
			l_extractor: TOKEN_EXTRACTOR_10
		do
			l_response := "oauth_token=hh5s93j4hdidpola&callback_confirmed=true"
			create l_extractor
			assert("Expected Void",l_extractor.extract (l_response) = Void)
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
