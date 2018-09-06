note
	description: "Summary description for {OAUTH_20_PAYPAL_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= Paypal Authentitcation", "src=https://developer.paypal.com/docs/api/overview/#authentication-and-authorization", "protocol=uri"

class
	OAUTH_20_PAYPAL_API

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
		do
			Result := "POST"
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request.
		do
			create Result.make_from_string (ACCESS_TOKEN_SANDBOX_URL)
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate
		do
				--Do nothing
		end

feature -- Implementation

	Access_token_sandbox_url: STRING = "https://api.sandbox.paypal.com/v1/oauth2/token"

	Access_token_live_url: 	STRING =  "https://api.paypal.com"

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
