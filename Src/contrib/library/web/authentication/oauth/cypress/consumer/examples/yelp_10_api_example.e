note
	description: "Summary description for {YELP_10_API_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	YELP_10_API_EXAMPLE

create
	make

feature {NONE} -- Initialization

	make
		local
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token: OAUTH_TOKEN
			api_builder: API_BUILDER
		do
			create api_builder
			api_service := api_builder.with_api (create {OAUTH_10_YELPV2_API})
												.with_api_key (api_key)
												.with_api_secret (api_secret)
												.build

			create access_token.make_token_secret (token, token_secret)
			print ("%N===Yelp OAuth Workflow ===%N")

	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("GET", "http://api.yelp.com/v2/search")
	    	  --Based on a GPS coordinate latitude / longitude
  			 request.add_query_string_parameter("ll", "30.361471,-87.164326")
  		  	 -- Looking for any restaurants
  				request.add_query_string_parameter("category", "restaurants")
			  api_service.sign_request (access_token, request)
	    	  if attached request.execute as l_response then
					print ("%NOk, let see what we found...")
					print ("%NResponse: STATUS" + l_response.status.out)
					if attached l_response.body as l_body then
						print ("%NBody:"+l_body)
					end
	    	  end
 		end


feature {NONE} -- Implementation

	token: STRING =""
	token_secret: STRING=""
	api_key : STRING =""
	api_secret :STRING =""
	empty_token : detachable  OAUTH_TOKEN

;note
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
