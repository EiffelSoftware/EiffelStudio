note
	description: "Summary description for {TWITTER_OAUTH_20_API_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_OAUTH_20_API_EXAMPLE

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			twitter : OAUTH_20_TWITTER_API
			config : OAUTH_CONFIG
			request : OAUTH_REQUEST
			access_token : detachable OAUTH_TOKEN
			api_service: OAUTH_SERVICE_I
			full_key: STRING_8
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("http://127.0.0.1")
			config.set_grant_type ("client_credentials")
			create twitter
			api_service := twitter.create_service (config)

			print ("%N=== Twitter OAuth 2.0 Workflow ===%N")

			full_key := url_encode.encoded_string (api_key) + ":" + url_encode.encoded_string (api_secret)
				-- Twitter OAuth2.0, specific workflow.
			create request.make (twitter.access_token_verb, twitter.access_token_endpoint)
			request.add_header ("Authorization: Basic ", base64.encoded_string (full_key))
			if attached config.grant_type as l_grant_type then
				request.add_body_parameter ({OAUTH_CONSTANTS}.grant_type, l_grant_type)
			end
				-- Execute the request
			if attached request.execute as l_response then
				if attached l_response.body as l_body then
					access_token := access_token_extractor.extract (l_body)
				end
			end


		   if attached access_token as l_access_token then
		   		print("%NGot the Access Token!%N");
    	   		print("%N(Token: " + l_access_token.debug_output + " )%N");

		      	  --Now let's go and ask for a protected resource!
	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("GET", protected_resource_url)
			  request.add_header("Authorization", "Bearer " +l_access_token.token )
			  request.add_header("Host", "api.twitter.com");
			  request.add_query_string_parameter ("count", "20")
			  request.add_query_string_parameter ("screen_name","twitterapi")

	 		  api_service.sign_request (l_access_token, request)
	    	  if attached request.execute as l_response then
					print ("%NOk, let see what we found...")
					print ("%NResponse: STATUS" + l_response.status.out)
					if attached l_response.body as l_body then
						print ("%NBody:"+l_body)
					end
	    	  end
		   end

 		end




feature {NONE} -- Implementation

	base64: BASE64
		once
			create Result
		end

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	url_encode: URL_ENCODER
		do
			create Result
		end


	api_key : STRING =""
	api_secret :STRING =""
	protected_resource_url : STRING = "https://api.twitter.com/1.1/statuses/user_timeline.json";
 	empty_token : detachable  OAUTH_TOKEN

;note
	copyright: "2013-2017, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


