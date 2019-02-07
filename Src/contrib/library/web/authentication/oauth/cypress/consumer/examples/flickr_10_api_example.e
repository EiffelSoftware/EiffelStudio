note
	description: "Summary description for {FLICKR_10_API_EXAMPLE}."
	date: "$Date$"
	revision: "$Revision$"

class
	FLICKR_10_API_EXAMPLE

create
	make
feature {NONE} -- Initialization

	make
		local
			api: API_BUILDER
			request_token, access_token: detachable OAUTH_TOKEN
			request: OAUTH_REQUEST
			service: OAUTH_SERVICE_I
			signature_type: OAUTH_SIGNATURE_TYPE
		do
			create signature_type.make
			signature_type.mark_query_string
			create api
			service := api.with_api (create {OAUTH_10_FLICKR_API})
								.with_api_key (api_key)
								.with_api_secret (api_secret)
								.with_signature (signature_type)
								.with_callback ("www.example.com")
								.build

			print ("%N=== Flickr's OAuth Workflow ===%N");
			print ("%NFetching the Request Token...");
			request_token := service.request_token
			print ("%NGot the Request Token!%N");

			print ("%NNow go and authorize here:");
			if attached  service.authorization_url (request_token) as l_auth_url then
				print (l_auth_url + "&perms=read");
   				print ("%N Copy the verifier here%N")
				io.read_line
			end

			access_token := service.access_token_get (request_token, create {OAUTH_VERIFIER}.make (io.last_string))
		   if attached access_token as l_access_token then
		   		print("%NGot the Access Token!%N");
    	   		print("%N(Token: " + l_access_token.debug_output + " )%N");


	      	  --Now let's go and ask for a protected resource!
	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("GET", protected_resource_url)
			  request.add_query_string_parameter("method", "flickr.test.login");
	 		  service.sign_request (l_access_token, request)
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
	Protected_resource_url: STRING = "http://api.flickr.com/services/rest/"
	Api_key: STRING  =""
	Api_secret: STRING =""
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

