note
	description: "Summary description for {VIMEO_10_API_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VIMEO_10_API_EXAMPLE

create
	make

feature {NONE} -- Initialization

	make
		local
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token,request_token : detachable OAUTH_TOKEN
			signature: OAUTH_SIGNATURE_TYPE
			api_builder: API_BUILDER
		do
			create api_builder
			api_service := api_builder.with_api (create {OAUTH_10_VIMEO_API})
												.with_api_key (api_key)
												.with_api_secret (api_secret)
												.build
			print ("%N===Twitter OAuth Workflow ===%N")

		 	-- Obtain the Request Token
		 	print ("%NGet the request token%N")
			request_token := api_service.request_token

			-- Obtain the Authorization URL
    		print("%NFetching the Authorization URL...");
    		if attached api_service.authorization_url (request_token) as lauthorization_url then
			    print("%NGot the Authorization URL!%N");
			    print("%NNow go and authorize here:%N");
			    print(lauthorization_url);
			    print("%NAnd paste the authorization code here%N");
			    io.read_line
			end

		   access_token := api_service.access_token_get (request_token, create {OAUTH_VERIFIER}.make (io.last_string))
		   if attached access_token as l_access_token then
		   		print("%NGot the Access Token!%N");
    	   		print("%N(Token: " + l_access_token.debug_output + " )%N");


	      	  --Now let's go and ask for a protected resource!
	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("POST", protected_resource_url)
			  request.add_body_parameter ("status", "testing!!!")
	 		  api_service.sign_request (l_access_token, request)
	    	  if attached {OAUTH_RESPONSE} request.execute as l_response then
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
	protected_resource_url : STRING = ""
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



