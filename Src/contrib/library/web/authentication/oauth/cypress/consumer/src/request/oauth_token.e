note
	description: "[
			Represents an OAuth token (either request or access token) and its secret

			--| OAuth2.0, there is no token secret, but refresh_token instead.
			--| We can write it by hand doing something like
			--| request.add_body_parameter("grant_type", "refresh_token")
			--| request.add_body_parameter("refresh_token", access_token.token)
			--| were access_token is the Token object you want to refresh.

		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Access Token", "src=http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-1.4", "protocol=uri"
	EIS: "name=Refresh Token", "src=http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-1.5", "protocol=uri"
	EIS: "name=Access Token Response", "src=http://tools.ietf.org/html/draft-ietf-oauth-v2-31#page-10", "protocol=uri"
	EIS: "name=Successfull Response", "http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-5.1", "protocol=uri"

class
	OAUTH_TOKEN

inherit

	ANY
		redefine
			is_equal
		end

create
	make_empty, make_token_secret, make_token_secret_response, make_token_secret_response_refresh

feature {NONE} -- Initilization

	make_empty
		do
			create token.make_empty
			create secret.make_empty
		ensure
			token_empty_set: token.is_empty
			secret_empty_set: secret.is_empty
		end

	make_token_secret (a_token: STRING; a_secret: STRING)
		do
			token := a_token
			secret := a_secret
		ensure
			token_set: token.same_string (a_token)
			secret_set: secret.same_string (a_secret)
		end

	make_token_secret_response (a_token: STRING; a_secret: STRING; a_response: like raw_response)
		do
			token := a_token
			secret := a_secret
			raw_response := a_response
		ensure
			token_set: token.same_string (a_token)
			secret_set: secret.same_string (a_secret)
		end

	make_token_secret_response_refresh (a_token: STRING; a_secret: STRING; a_response: like raw_response; a_refresh: like refresh_token)
		do
			token := a_token
			secret := a_secret
			raw_response := a_response
			refresh_token := a_refresh
		ensure
			token_set: token.same_string (a_token)
			secret_set: secret.same_string (a_secret)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			Result := 	token.same_string (other.token) and
						secret.same_string (other.secret)
		end

feature -- Access

	token: STRING
		 	-- REQUIRED. The access token issued by the authorization server.

	secret: STRING
			-- REQUIRED The type of the token issued
	        -- Value is case insensitive.
	  	  --|OAuth 2.0 define a token_type

	refresh_token: detachable STRING
			-- RECOMMENDED The refresh token, which can be used to obtain new
	        -- access tokens

    expires_in: INTEGER
   		 	--	 OPTIONAL The lifetime in seconds of the access token.

    scope: detachable STRING
	    	-- OPTIONAL, if identical to the scope requested by the client,
	        -- otherwise REQUIRED

    raw_response: detachable STRING


feature -- Element Change

	set_token (a_token: READABLE_STRING_GENERAL)
			-- Set `token' with `a_token'
		do
			token := a_token.as_string_8
		ensure
			token_set: token = a_token
		end

	set_secret (a_secret: READABLE_STRING_8)
			-- Set `secret' with `a_secret'
		do
			secret := a_secret
		ensure
			secret_set: secret = a_secret
		end

	set_refresh_token (a_refresh_token: READABLE_STRING_8)
			-- Set `refresh_token' with `a_refresh_token'
		do
			refresh_token := a_refresh_token
		ensure
			refresh_token_set: attached refresh_token as l_token implies l_token = a_refresh_token
		end

	set_expires_in (a_expire: INTEGER)
			-- Set `expires_in' with `a_expire'
		do
			expires_in := a_expire
		ensure
			exprires_in_set: expires_in = a_expire
		end

	set_scope (a_scope: READABLE_STRING_8)
			-- Set `scope' with `a_scope'
		do
			scope := a_scope
		ensure
			scope_set: attached scope as l_scope implies l_scope = a_scope
		end

	set_raw_response (a_response: READABLE_STRING_8)
			-- Set `raw_response' with `a_response'
		do
			raw_response := a_response
		ensure
			raw_response_set: attached raw_response as l_response implies l_response = a_response
		end
feature -- debug

	debug_output: STRING
		do
			create Result.make_from_string ("Token {")
			Result.append (token + ", ")
			Result.append (secret + "}")
		end

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
