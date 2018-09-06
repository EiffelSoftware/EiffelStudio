note
	description: "Summary description for {OAUTH_20_ASANA_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuth2 asana apis", "src=https://developers.asana.com/accounts/docs/OAuth2", "protocol=uri"
	EIS: "name=Asana API", "src=https://asana.com/guide/help/api/api", "protocol=uri"

class
	OAUTH_20_ASANA_API

inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
			-- <Precursor>
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
			create {STRING_8} Result.make_from_string ("https://app.asana.com/-/oauth_token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING_8
		do
			if attached config.scope as l_scope then
				create l_result.make_from_string (TEMPLATE_AUTHORIZE_URL + SCOPED_AUTHORIZE_URL)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key)
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback))
				end
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$SCOPE", (create {OAUTH_ENCODER}).encoded_string (l_scope))
					Result := l_result
				end
			else
				create l_result.make_from_string (TEMPLATE_AUTHORIZE_URL)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback))
					Result := l_result
				end
			end
		end

feature -- Implementation

	Template_authorize_url: STRING = "https://app.asana.com/-/oauth_authorize?response_type=code&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI";

	Scoped_authorize_url: STRING = "&scope=$SCOPE";

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
