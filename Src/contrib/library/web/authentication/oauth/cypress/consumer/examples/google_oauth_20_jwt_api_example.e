note
	description: "Summary description for {GOOGLE_OAUTH_20_JWT_API_EXAMPLE}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuth 2.0 for Server to Server Applications", "src=https://developers.google.com/identity/protocols/OAuth2ServiceAccount", "protocol=uri"
	readme: "[
		To setup this example, please set the values for :
			- private_key
			- private_key_id
			- client_id
			- client_email

		How-to:
			- go to https://console.developers.google.com
			- Dashboard
			- Credentials
			- [Create credential v]
			- Service account key
			- Key type: JSON ... and this JSON file contains all the information to set the attributes.
	]"

class
	GOOGLE_OAUTH_20_JWT_API_EXAMPLE

create
	make

feature -- Access

	make
		local
			oauth_jwt: OAUTH_20_JWT_API
			config: OAUTH_JWT_CONFIG
			api_service: OAUTH_SERVICE_I
			request: OAUTH_REQUEST
			access_token: OAUTH_TOKEN
		do
			create oauth_jwt.make (authentication_url)
			create config.make (jwt_signing, client_id)
			api_service := oauth_jwt.create_service (config)
			print ("%N===Google OAuth Server to Server Workflow ===%N")

            if attached api_service then
					-- client id and client secreat are required by Google
          		access_token := api_service.access_token_post (empty_token, Void)
				if access_token /= Void then
					print ("%NGot the Access Token!%N");
					print ("%N(Token: " + access_token.debug_output + " )%N");

						--Now let's go and ask for a protected resource!
					print ("%NNow we're going to access a protected resource...%N");
					create request.make ("GET", protected_resource_url)
					api_service.sign_request (access_token, request)
					if attached request.execute as l_response then
						print ("%NOk, let see what we found...")
						print ("%NResponse: STATUS" + l_response.status.out)
						if attached l_response.body as l_body then
							print ("%NBody:" + l_body)
						end
					end
				end
			end
		end

feature -- Settings

	private_key: STRING = "-SET-THIS-VALUE-"
	private_key_id: STRING = "-SET-THIS-VALUE-"
	client_email: STRING = "-SET-THIS-VALUE-"
	client_id: STRING = "-SET-THIS-VALUE-"

feature {NONE}	-- Implementation

	jwt_signing: STRING
			-- Box API supports  the "RS256", "RS384", and "RS512" Algorithms.
		local
			jwt: JWS
			l_date: DATE_TIME
		do
			create jwt.default_create
			jwt.algorithms.register_algorithm (create {JWT_ALG_RS256})
			jwt.set_algorithm ({JWT_ALG_RS256}.name)
			jwt.header.set_private_key_id (private_key_id)
			jwt.claimset.set_claim ("iss", client_email)
			jwt.claimset.set_claim ("sub", sub)
			jwt.claimset.set_claim ("aud", authentication_url)
			jwt.claimset.set_claim ("scope", "https://www.googleapis.com/auth/plus.me")
			jwt.claimset.set_issued_at_now_utc
			create l_date.make_now_utc
			l_date.second_add (45)
			jwt.claimset.set_expiration_time (l_date)
			private_key.adjust
			Result := jwt.encoded_string (private_key)
		end

feature {NONE} -- Implementation

	protected_resource_url : STRING = "https://www.googleapis.com/plus/v1/people/me"
	empty_token: detachable OAUTH_TOKEN

	sub: STRING = ""
	authentication_url: STRING = "https://oauth2.googleapis.com/token"


note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
