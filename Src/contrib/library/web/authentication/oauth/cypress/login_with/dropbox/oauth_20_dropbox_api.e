note
	description: "Represent the oauth20 dropbox API to work with the OAuth 2.0 authorization flow."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Dropbox API v2", "src=https://www.dropbox.com/developers", "protocol=url"

class
	OAUTH_20_DROPBOX_API

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
			create {STRING_8} Result.make_from_string ("https://api.dropbox.com/oauth2/token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING_8
		do
				-- TODO complete this code!!!.
			if attached config.state as l_state then
				create l_result.make_from_string (Template_authorize_url)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_8))
				end
				l_result.replace_substring_all ("$CSRF_TOKEN", l_state)
				Result := l_result
			else
				-- Check the API
			end

		end

feature {NONE} -- Implementation

	Template_authorize_url: STRING = "https://www.dropbox.com/oauth2/authorize?client_id=$CLIENT_ID&response_type=code&redirect_uri=$REDIRECT_URI&state=$CSRF_TOKEN";

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
