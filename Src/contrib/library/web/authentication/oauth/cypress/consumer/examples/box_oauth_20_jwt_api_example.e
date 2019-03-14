note
	description: "Summary description for {BOX_OAUTH_20_JWT_API_EXAMPLE}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Box JWT", "src=https://developer.box.com/docs/construct-jwt-claim-manually", "protocol=uri"
	EIS: "name=App Auth", "src=https://box-content.readme.io/v2.0/docs/app-auth", "procol=uri"
	EIS: "name=Connecting Your Developer Enterprise", "src=https://box-content.readme.io/v2.0/docs/connecting-your-developer-enterprise", "procol=uri"


class
	BOX_OAUTH_20_JWT_API_EXAMPLE

create
	make

feature -- Access

	make
		local
			oauth_jwt: OAUTH_20_JWT_API
			config: OAUTH_JWT_CONFIG
			api_service: OAUTH_20_JWT_SERVICE
			request: OAUTH_REQUEST
			access_token: OAUTH_TOKEN
		do
			create oauth_jwt.make (authentication_url)
			create config.make (jwt_signing, client_id)
			config.set_api_secret (client_secret)
			api_service := oauth_jwt.create_service (config)
			print ("%N===Box OAuth Server to Server Workflow ===%N")

            if attached api_service then
					-- client id and client secreat are required by BOX
            	api_service.enable_client_id
            	api_service.enable_client_secret
	   			access_token := api_service.access_token_post (empty_token, Void)
				if attached access_token as l_access_token then
					print ("%NGot the Access Token!%N");
					print ("%N(Token: " + l_access_token.debug_output + " )%N");

						--Now let's go and ask for a protected resource!
					print ("%NNow we're going to access a protected resource...%N");
					create request.make ("GET", protected_resource_url)
					api_service.sign_request (l_access_token, request)
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


feature {NONE}	-- Implementation

	jwt_signing: STRING
			-- Box API supports  the "RS256", "RS384", and "RS512" Algorithms.
		local
			jwt: JWS
			l_date: DATE_TIME
		do
			create jwt.default_create
			jwt.algorithms.register_algorithm (create {JWT_ALG_RS512})
			jwt.algorithms.register_algorithm (create {JWT_ALG_RS384})
			jwt.algorithms.register_algorithm (create {JWT_ALG_RS256})
--			jwt.set_algorithm ({JWT_ALG_RS256}.name)
			jwt.set_algorithm ({JWT_ALG_RS384}.name)
--			jwt.set_algorithm ({JWT_ALG_RS512}.name)
			jwt.header.set_private_key_id (private_key_id)
			jwt.claimset.set_claim ("iss", client_id)
			jwt.claimset.set_claim ("sub", sub)
			jwt.claimset.set_claim ("box_sub_type", box_sub_type)
			jwt.claimset.set_claim ("aud", authentication_url)
			jwt.claimset.set_claim ("jti", jti)
			jwt.claimset.set_issued_at_now_utc
			create l_date.make_now_utc
			l_date.second_add (45)
			jwt.claimset.set_expiration_time (l_date)
			private_key.adjust
			Result := jwt.encoded_string (private_key)
		end


feature {NONE} -- Implementation

	protected_resource_url : STRING = "https://api.box.com/2.0/users/me"
	empty_token: detachable OAUTH_TOKEN


		-- TO BE Completed: Check BOX documentation.
		-- https://developer.box.com/docs/construct-jwt-claim-manually#section-3-create-jwt-assertion
	private_key: STRING =""
	private_key_id: STRING = ""
	client_email: STRING = ""
	client_id: STRING = ""
	client_secret: STRING = ""
	sub: STRING = ""
	box_sub_type:  STRING = ""
	jti: STRING = ""
			-- A universally unique identifier specified by the client for this JWT. A unique string of at least 16 characters and at most 128 characters.
	authentication_url: STRING = "https://api.box.com/oauth2/token"

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
