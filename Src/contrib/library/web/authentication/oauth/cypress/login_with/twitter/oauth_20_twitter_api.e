note
	description: "Summary description for {OAUTH_20_TWITTER_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Twitter OAuth api", "src=https://dev.twitter.com/oauth/application-only", "protocol=uri"

class
	OAUTH_20_TWITTER_API

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
			-- send 'grant_type=client_credentials'
		do
			create Result.make_from_string ("https://api.twitter.com/oauth2/token")
		end

	invalidate_token: STRING_8
			-- Allows a registered application to revoke an issued OAuth 2 Bearer Token by presenting its client credentials.
			-- Once a Bearer Token has been invalidated, new creation attempts will yield a different Bearer Token and usage of the invalidated token will no longer be allowed.
			-- Send access_toke: The value of the bearer token to revoke.
		do
			create Result.make_from_string ("https://api.twitter.com/oauth2/invalidate_token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		do
			-- Not needed
		end


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
