note
	description: "Summary description for {OAUTH_20_GOOGLE_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuth2 google apis", "src=https://developers.google.com/accounts/docs/OAuth2", "protocol=uri"

class
	OAUTH_20_GOOGLE_API

inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	access_token_verb: STRING_8
			-- <Precursor>
		do
			Result := "POST"
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		do
			create {STRING_8} Result.make_from_string ("https://oauth2.googleapis.com/token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		do
			if attached config.scope as l_scope then
				create Result.make_from_string (TEMPLATE_AUTHORIZE_URL + SCOPED_AUTHORIZE_URL)
				Result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					Result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
				end
				Result.replace_substring_all ("$SCOPE", (create {OAUTH_ENCODER}).encoded_string (l_scope.as_string_8))
			else
				create Result.make_from_string (TEMPLATE_AUTHORIZE_URL)
				Result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					Result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
				end
			end
		end

feature -- Implementation

	Template_authorize_url: STRING_8 = "https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI"

	Scoped_authorize_url: STRING = "&scope=$SCOPE"

note
	copyright: "2013-2020, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
