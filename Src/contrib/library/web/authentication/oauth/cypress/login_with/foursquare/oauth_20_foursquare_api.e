note
	description: "Summary description for {OAUTH_20_FOURSQUARE_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuth2 foursquare", "src=https://developer.foursquare.com/overview/auth", "protocol=uri"

class
	OAUTH_20_FOURSQUARE_API

inherit
	OAUTH_20_API
		redefine
			access_token_extractor
		end

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		do
			create {STRING_8} Result.make_from_string ("https://foursquare.com/oauth2/access_token?grant_type=authorization_code")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING_8
		do
			create l_result.make_from_string (TEMPLATE_AUTHORIZATION_URL)
			l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
			if attached config.callback as l_callback then
				l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
				Result := l_result
			end
		end

feature -- Implementation

	Template_authorization_url: STRING = "https://foursquare.com/oauth2/authenticate?client_id=$CLIENT_ID&response_type=code&redirect_uri=$REDIRECT_URI"

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
