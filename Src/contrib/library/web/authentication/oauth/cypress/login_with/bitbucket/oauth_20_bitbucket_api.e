note
	description: "Summary description for {OAUTH_20_BITBUCKET_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "Atlassian bitbucket OAuth20 API", "src=https://developer.atlassian.com/cloud/bitbucket/oauth-2/", "protocol=uri"
	EIS: "Atlassian bitbucket OAuth20 API Tutorial", "src=https://developer.atlassian.com/bitbucket/api/2/reference/meta/authentication", "protocol=uri"


class
	OAUTH_20_BITBUCKET_API


inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

feature -- Access

	access_token_verb: STRING_8
			-- <Precursor>
		do
			Result := "POST"
		end

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request.
		do
			create Result.make_from_string ("https://bitbucket.org/site/oauth2/access_token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authenticate
		local
			l_result: STRING_8
		do
			create l_result.make_from_string (TEMPLATE_AUTHORIZATION_URL)
			l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
			if attached config.grant_type as l_grant_type then
				l_result.replace_substring_all ("$GRANT_TYPE", (create {OAUTH_ENCODER}).encoded_string (l_grant_type.as_string_8))
			else
				--By default we use
				-- Authorization Code Grant (4.1)
				l_result.replace_substring_all ("$GRANT_TYPE", (create {OAUTH_ENCODER}).encoded_string ("code"))
			end
			if attached config.callback as l_callback then
				l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
			end
			if attached config.scope as l_scope then
				l_result.replace_substring_all ("$SCOPE", (create {OAUTH_ENCODER}).encoded_string (l_scope.as_string_8))
			end
			Result := l_result
		end

feature -- Implementation

	Template_authorization_url: STRING = "https://bitbucket.org/site/oauth2/authorize?client_id=$CLIENT_ID&response_type=$GRANT_TYPE&redirect_uri=$REDIRECT_URI"


	Scoped_authorize_url: STRING = "&scope=$SCOPE";

note
	copyright: "2013-2019, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
