note
	description: "[
					Here will show how to read a tweet calling the  /1.1/statuses/show.json endpoint, which returns data for a Tweet, given its ID number.	
					Go to https://dev.twitter.com/apps  
					1. register a new application.
					2. On Keys and Access Tokens page click "Create my access token" to generate an access token and secret.
					
					You have to use your own API keys and Access token, and set them in
					
						api_key with Consumer Key (API Key)	
					    api_secret with Consumer Secret (API Secret)
					    
					   and
					   
					    access_key: Access Token
					    access_secret: 	Access Token Secret
		
					See https://apps.twitter.com/ to get api keys and related.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Register Twitter App", "src=https://dev.twitter.com/apps", "protocol=uri"
	EIS: "name=Read a tweet", "src=https://dev.twitter.com/rest/reference/get/statuses/show/id", "protocol=uri"
	EIS: "name=Twitter API Authentication Model", "src=https://dev.twitter.com/oauth", "protocol=uri"
	EIS: "name=How to get Twitter tokens", "src=https://dev.twitter.com/oauth/overview", "protocol"


class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Consumers Key

	api_key: STRING = ""
			-- Consumer key
			--| The consumer key identifies the application making the request.

	api_secret: STRING = ""
			-- Consumer secret

feature {NONE} -- 	Access Key

	access_key: STRING = ""
			-- The access token identifies the user making the request.

	access_secret: STRING = ""
			-- Secret token

feature {NONE} -- Twitter ID

	twitter_id : STRING = "822023365175156736"
			-- Tweet id to read.

feature {NONE} -- Initialization

	make
		local
			config: OAUTH_CONFIG
			api_service: OAUTH_SERVICE_I
			request: OAUTH_REQUEST
			access_token, request_token: detachable OAUTH_TOKEN
			signature: OAUTH_SIGNATURE_TYPE
			api_builder: API_BUILDER
			l_retry: BOOLEAN
		do
			if not l_retry then
					-- Initialization
				create api_builder
				create signature.make
				signature.mark_query_string

					-- Create the Twitter oauth service with the consumers key
				api_service := api_builder.with_api (create {OAUTH_10_TWITTER_API}).with_api_key (api_key).with_api_secret (api_secret).build

				print ("%N===Twitter OAuth Workflow using OAuth access token for the owner of the application ===%N")
					-- Obtain the Request Token
				print ("%NGet the request token%N")
				request_token := api_service.request_token

					-- Create the access token that will identifies the user making the request.
				create access_token.make_token_secret (access_key, access_secret)
				if attached access_token as l_access_token then
					print ("%NGot the Access Token!%N");

						--Now let's go and check if the request is signed correcty
					print ("%NNow we're going to verify our credentials...%N");
						-- Build the request and authorize it with OAuth.
					create request.make ("GET", protected_resource_url)
						-- adding the query string
						-- 1.1/statuses/show.json?id=%tweet_id%
					request.add_query_string_parameter ("id", twitter_id)
					api_service.sign_request (l_access_token, request)
					if attached {OAUTH_RESPONSE} request.execute as l_response then
						print ("%NOk, let see what we get from response status...%N")
						io.put_new_line
						 -- Now we will parse the response body.
						 -- and display the tweet details.
						if l_response.status = 200 and then attached l_response.body as l_body then
							if attached {TWITTER_TWEETS} (create {TWITTER_JSON}).show_tweet (l_body) as l_tweet then
								print (l_tweet.full_out)
							end
						else
							print ("%NResponse: STATUS:" + l_response.status.out)
						end
					end
				end
			end
		rescue
			print ("Authentication failed. Retry ...%N")
			if attached (create {EXCEPTION_MANAGER}).last_exception as l_exception and then attached l_exception.description as l_decription then
				print (l_decription)
			end
			l_retry := True
			retry
		end

feature {NONE} -- Implementation

	protected_resource_url: STRING = "https://api.twitter.com/1.1/statuses/show.json";
			-- Returns a single Tweet, specified by the id parameter. The Tweet's author will also be embedded within the Tweet

note
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
