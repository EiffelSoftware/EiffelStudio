note
	description: "Summary description for {PAYPAL_OAUTH_20_API_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAYPAL_OAUTH_20_API_EXAMPLE
create
	make
feature -- Access	
	make
		local
			box : OAUTH_20_PAYPAL_API
			config : OAUTH_CONFIG
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token : detachable OAUTH_TOKEN
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("http://127.0.0.1")
			config.set_grant_type ("client_credentials")
			create box
			api_service := box.create_service (config)
			print ("%N===Paypal OAuth Workflow ===%N")

		   access_token := api_service.access_token_post (empty_token, Void)
		   if attached access_token as l_access_token then
		   		print("%NGot the Access Token!%N");
    	   		print("%N(Token: " + l_access_token.debug_output + " )%N");


	      	  --Now let's go and ask for a protected resource!
	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("GET", protected_resource_url)
			  request.add_header("Authorization", "Bearer " + l_access_token.token )
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

	api_key : STRING =""
	api_secret :STRING =""
	protected_resource_url : STRING = "https://api.sandbox.paypal.com/v1/payments/"
 	empty_token : detachable  OAUTH_TOKEN


;note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
