note
	description: "Summary description for {OAUTH_10_GOOGLE_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Google API OAuth 1.0", "src=https://developers.google.com/identity/protocols/OAuth_ref", "protocol=uri"

class
	OAUTH_10_GOOGLE_API

obsolete " OAuth 1.0 was officially deprecated on April 20, 2012, and is no longer supported. We encourage you to migrate to OAuth 2.0 {OAUTH_20_GOOGLE_API} as soon as possible."

inherit

	OAUTH_10_API
		redefine
			access_token_verb,
			request_token_verb
		end

feature -- Access

	access_token_endpoint: STRING_8
		do
			Result := "https://www.google.com/accounts/OAuthGetAccessToken"
		end

	request_token_endpoint:	STRING_8
		do
			Result := "https://www.google.com/accounts/OAuthGetRequestToken"
		end

	access_token_verb: STRING_8
		do
			Result := "GET"
		end

	request_token_verb: STRING_8
			-- <Precursor>
		do
			Result := "GET"
		end

	authorization_url (a_token: detachable OAUTH_TOKEN) : STRING_8
			-- <Precursor>
		local
			l_result : STRING
		do
			l_result := Authorize_url
			if a_token /= Void then
				l_result.append(a_token.token.as_string_8)
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	Authorize_url:STRING = "https://www.google.com/accounts/OAuthAuthorizeToken?oauth_token="

note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
