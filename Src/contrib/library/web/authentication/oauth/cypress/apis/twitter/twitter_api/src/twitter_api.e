note
	description: "Summary description for {TWITTER_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=REST API", "src=https://dev.twitter.com/rest/reference", "protocol=uri"

class
	TWITTER_API

create
	make,
	make_with_source

feature {NONE} -- Initialization

	make (a_consumer_key: TWITTER_CONSUMER_TOKEN; a_access_key: TWITTER_ACCESS_TOKEN)
		do
			consumer_key := a_consumer_key
			access_token := a_access_key
		end

	make_with_source (a_consumer_key: TWITTER_CONSUMER_TOKEN; a_access_key: TWITTER_ACCESS_TOKEN; a_source: like application_source)
		do
			make (a_consumer_key, a_access_key)
			application_source := a_source
		end

feature -- Reset

	reset
			-- Reset consumer key and access token
		do
			create consumer_key.make (Void, Void)
			create access_token.make (Void, Void)
		end

feature -- Access

	consumer_key: TWITTER_CONSUMER_TOKEN
			--  Twitter consumer key.

	access_token: TWITTER_ACCESS_TOKEN
			-- Twitter access token.

	http_status: INTEGER
		-- Contains the last HTTP status code returned.

	last_api_call: detachable STRING
		-- Contains the last API call.

	last_response: detachable OAUTH_RESPONSE
		-- Cointains the last API response.

	application_source: detachable STRING
		--	Contains the application calling the API.


feature {TWITTER_I} -- Element Change

	set_appication_source (a_source: like application_source)
			-- Set 'application_source' with 'a_source'.
		do
			application_source := a_source
		ensure
			application_source_set: application_source = a_source
		end

feature -- Twitter: GET Status Methods

	home_timeline (a_params: detachable TWITTER_HOME_TIMELINE_PARAMS): detachable STRING
			-- Returns a collection of the most recent Tweets and retweets posted by the authenticating user and the users they follow.
			-- The home timeline is central to how most users interact with the Twitter service.
			-- Up to 800 Tweets are obtainable on the home timeline. It is more volatile for users that follow many users or follow users who Tweet frequently.
			-- URL: https://api.twitter.com/1.1/statuses/home_timeline.json
			-- Response formats	JSON
			-- Requires authentication?	Yes (user context only)
			-- Rate limited?	Yes
			-- Requests / 15-min window (user auth)	15
		do
			api_get_call (twitter_url ("statuses/home_timeline.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	user_timeline (a_params: detachable TWITTER_USER_TIMELINE_PARAMS): detachable STRING
		do
			api_get_call (twitter_url ("statuses/user_timeline.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	mentions_timeline (a_params: detachable TWITTER_MENTIONS_TIMELINE_PARAMS): detachable STRING
		do
			api_get_call (twitter_url ("statuses/mentions_timeline.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end


	show_tweet (a_params: TWITTER_STATUS_SHOW_PARAMS): detachable STRING
		do
			api_get_call (twitter_url ("statuses/show.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	retweets_of_me (a_params: detachable TWITTER_RETWEET_OF_ME_PARAMS): detachable STRING
		do
			api_get_call (twitter_url ("statuses/retweets_of_me.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Twitter: POST Status Methods		

	tweet (a_params: detachable TWITTER_STATUS_UPDATE_PARAMS): detachable STRING
		do
			api_post_call (twitter_url ("statuses/update.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Twitter: Account Methods

	verify_credentials (a_params: detachable TWITTER_VERIFY_CREDENTIALS_PARAMS): detachable STRING
				-- Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful;
				-- returns a 401 status code and an error message if not.
				-- Use this method to test if supplied user credentials are valid.	
		do
			api_get_call (twitter_url ("account/verify_credentials.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Twitter Application

	rate_limit_status (a_params: detachable TWITTER_RATE_LIMIT_PARAMS): detachable STRING
		do
			api_get_call (twitter_url ("application/rate_limit_status.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Twitter Direct Messages

	direct_messages (a_params: detachable TWITTER_DIRECT_MESSAGE_PARAMS ): detachable STRING
		do
			api_get_call (twitter_url ("direct_messages.json"), a_params)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Parameters Factory

	parameters (a_params: detachable STRING_TABLE [STRING] ): detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
		local
			l_result: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
			l_tuple : detachable TUPLE [name: STRING; value: STRING]
			i: INTEGER
		do
			if attached a_params then
				i := 1
				create l_result.make_filled (Void, 1, a_params.count)
				across a_params as ic
				loop
					create l_tuple.default_create
					l_tuple.put (ic.key, 1)
					l_tuple.put (ic.item, 2)
					l_result.force (l_tuple, i)
					i := i + 1
				end
				Result := l_result
			end
		end

feature -- Error Report

	has_error: BOOLEAN
			-- Last api call raise an error?
		do
			if attached last_response as l_response then
				Result := l_response.status /= 200
			else
				Result := False
			end
		end

	error_message: STRING
			-- Last api call error message.
		require
			has_error: has_error
		do
			if
				attached last_response as l_response
			then
				if
					attached l_response.error_message as l_error_message
				then
					Result := l_error_message
				else
					Result := l_response.status.out
				end
			else
				Result := "Unknown Error"
			end
		end

feature {NONE} -- Implementation

	api_post_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- POST REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "POST", a_params)
		end

	api_get_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- GET REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "GET", a_params)
		end

	internal_api_call (a_api_url: STRING; a_method: STRING; a_params: detachable STRING_TABLE [STRING])
		local
			api_service: OAUTH_SERVICE_I
			request: OAUTH_REQUEST
			l_access_token, request_token: detachable OAUTH_TOKEN
			api_builder: API_BUILDER
		do
				-- Initialization
			create api_builder

				-- Create the Twitter oauth service with the consumers key
			api_service := api_builder.with_api (create {OAUTH_10_TWITTER_API}).with_api_key (api_key).with_api_secret (api_secret).build

			print ("%N===Twitter OAuth Workflow using OAuth access token for the owner of the application ===%N")
				-- Obtain the Request Token
			print ("%NGet the request token%N")
			request_token := api_service.request_token

				-- Create the access token that will identifies the user making the request.
			create l_access_token.make_token_secret (access_key, access_secret)
			if attached l_access_token as ll_access_token then
				print ("%NGot the Access Token!%N");

					--Now let's go and check if the request is signed correcty
				print ("%NNow we're going to verify our credentials...%N");
					-- Build the request and authorize it with OAuth.
				create request.make (a_method, a_api_url)
				add_query_string (request, a_params)
				api_service.sign_request (ll_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					last_response := l_response
				end
			end
			last_api_call := a_api_url.string
		end


	api_key: STRING
		do
			create Result.make_empty
			if attached consumer_key.api_key as l_api_key then
				Result := l_api_key
			end
		end

	api_secret: STRING
		do
			create Result.make_empty
			if attached consumer_key.api_secret as l_api_secret then
				Result := l_api_secret
			end
		end

	access_key: STRING
		do
			create Result.make_empty
			if attached access_token.access_key as l_access_key then
				Result := l_access_key
			end
		end

	access_secret: STRING
		do
			create Result.make_empty
			if attached access_token.access_secret as l_access_secret then
				Result := l_access_secret
			end
		end


	twitter_url (a_query: STRING): STRING
			-- Twitter url for `a_query' and `a_parameters'
		require
			a_query_attached: a_query /= Void
		do
			Result := "https://api.twitter.com/1.1/" + a_query
		ensure
			Result_attached: Result /= Void
		end

	url (a_base_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]): STRING
			-- url for `a_base_url' and `a_parameters'
		require
			a_base_url_attached: a_base_url /= Void
		do
			create Result.make_from_string (a_base_url)
			append_parameters_to_url (Result, a_parameters)
		end

	append_parameters_to_url (a_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]])
			-- Append parameters `a_parameters' to `a_url'
		require
			a_url_attached: a_url /= Void
		local
			i: INTEGER
			l_first_param: BOOLEAN
		do
			if a_parameters /= Void and then a_parameters.count > 0 then
				if a_url.index_of ('?', 1) > 0 then
					l_first_param := False
				elseif a_url.index_of ('&', 1) > 0 then
					l_first_param := False
				else
					l_first_param := True
				end
				from
					i := a_parameters.lower
				until
					i > a_parameters.upper
				loop
					if attached a_parameters[i] as a_param then
						if l_first_param then
							a_url.append_character ('?')
						else
							a_url.append_character ('&')
						end
						a_url.append_string (a_param.name)
						a_url.append_character ('=')
						a_url.append_string (a_param.value)
						l_first_param := False
					end
					i := i + 1
				end
			end
		end

	add_query_string (request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
		do
			if attached a_params then
				across a_params as ic
				loop
					request.add_query_string_parameter (ic.key.as_string_8, ic.item)
				end
			end
		end

end
