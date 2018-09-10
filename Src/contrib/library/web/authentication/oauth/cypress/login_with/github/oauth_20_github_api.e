note
	description: "Summary description for {OAUTH_20_GITHUB_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_GITHUB_API

inherit
	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {TOKEN_EXTRACTOR_20} Result
		end

	access_token_verb: STRING_8
		do
			Result := "POST"
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		do
			create Result.make_from_string ("https://github.com/login/oauth/access_token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING_8
		do
			if attached config.scope as l_scope then
				create l_result.make_from_string (template_authorize_url + scoped_authorize_url)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
				end
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$SCOPE", (create {OAUTH_ENCODER}).encoded_string (l_scope.as_string_8))
					Result := l_result
				end
			else
				create l_result.make_from_string (template_authorize_url + scoped_authorize_url)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
				end
			end
		end

feature -- Implementation

	template_authorize_url: STRING = "https://github.com/login/oauth/authorize?client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI";

	scoped_authorize_url: STRING = "&scope=$SCOPE";

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
