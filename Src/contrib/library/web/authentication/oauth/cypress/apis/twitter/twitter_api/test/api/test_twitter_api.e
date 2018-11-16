note
	description: "Summary description for {TEST_TWITTER_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TWITTER_API

inherit

	EQA_TEST_SET

feature -- Test Verify Credentials

	test_verify_credentials_invalid
		local
			l_twitter_api: TWITTER_I
			l_user: TWITTER_USER
			l_retry: BOOLEAN
		do
			if not l_retry then
					-- test api call with invalid credentials
					-- in this case Void.
				create {TWITTER_JSON} l_twitter_api
				l_user := l_twitter_api.verify_credentials (Void)
				assert ("Unexpected", False)
			else
				assert ("Expected Exception", True)
			end
		rescue
			l_retry := True
			retry
		end

	test_verify_credentials_valid
		local
			l_twitter_api: TWITTER_I
			l_user: TWITTER_USER
			l_retry: BOOLEAN
		do
			if not l_retry then
				--
				create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
				l_user := l_twitter_api.verify_credentials (Void)
				assert ("User", l_user /= Void)
				assert ("Status 200 Ok", l_twitter_api.last_status_code = 200)
			else
				assert ("Expected Exception", False)
			end
		rescue
			l_retry := True
			retry
		end

	test_verify_credentials_with_params
		local
			l_twitter_api: TWITTER_I
			l_user: TWITTER_USER
			l_retry: BOOLEAN
			l_params: TWITTER_VERIFY_CREDENTIALS_PARAMS
		do
			create l_params.make_caseless (3)
			l_params.add_include_email (True)
			l_params.add_include_entities (True)
			if not l_retry then
				create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
				l_user := l_twitter_api.verify_credentials (l_params)
				assert ("User", l_user /= Void)
				assert ("Status 200 Ok", l_twitter_api.last_status_code = 200)
			else
				assert ("Expected Exception", False)
			end
		rescue
			l_retry := True
			retry
		end


feature -- Test User Status

	test_home_timeline
		local
				l_twitter_api: TWITTER_I
				l_home_timeline: LIST [TWITTER_TWEETS]
				l_retry: BOOLEAN
			do
				if not l_retry then
					create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
					l_home_timeline := l_twitter_api.home_timeline (void)
					assert ("Home timeline", l_home_timeline /= Void)
					assert ("Status 200 Ok", l_twitter_api.last_status_code = 200)
				else
					assert ("Expected Exception", False)
				end
			rescue
				l_retry := True
				retry
			end

	test_user_timeline
		local
				l_twitter_api: TWITTER_I
				l_user_timeline: LIST [TWITTER_TWEETS]
				l_retry: BOOLEAN
			do
				if not l_retry then
					create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
					l_user_timeline := l_twitter_api.user_timeline (void)
					assert ("User timeline", l_user_timeline /= Void)
					assert ("Status 200 Ok", l_twitter_api.last_status_code = 200)
				else
					assert ("Expected Exception", False)
				end
			rescue
				l_retry := True
				retry
			end

	test_show_tweet
		local
				l_twitter_api: TWITTER_I
				l_tweet: TWITTER_TWEETS
				l_retry: BOOLEAN
				l_param: TWITTER_STATUS_SHOW_PARAMS
			do
				if not l_retry then
					create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
					create l_param.make_with_id (1)
				else
					assert ("Expected Exception", False)
				end
			rescue
				l_retry := True
				retry
			end

feature -- Test tweet


	test_tweet
			-- post a tweet.
		local
				l_twitter_api: TWITTER_I
				l_tweet: TWITTER_TWEETS
				l_retry: BOOLEAN
			do
				if not l_retry then
					create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
					l_tweet := l_twitter_api.tweet (create {TWITTER_STATUS_UPDATE_PARAMS}.make_with_status ("Hello from Eiffel API"))
					assert ("Attached tweet", l_tweet /= Void)
				end
			rescue
				l_retry := True
				retry
			end

feature -- Test Rate Limits

	test_rate_limit_status
			-- test rate limit status
		local
			l_twitter_api: TWITTER_I
			l_tweet: TWITTER_TWEETS
			l_retry: BOOLEAN
		do
			if not l_retry then
				create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
				if attached l_twitter_api.rate_limit_status (Void) as l_resource_limit then
					assert ("resources", attached l_resource_limit.resources)
				end
			end
		rescue
			l_retry := True
			retry
		end

feature -- Test direct messages

	test_direct_messages
			-- test direct messages
		local
			l_twitter_api: TWITTER_I
			l_tweet: TWITTER_TWEETS
			l_retry: BOOLEAN
		do
			if not l_retry then
				create {TWITTER_JSON} l_twitter_api.make (consumer_token, access_token)
				if attached l_twitter_api.direct_messages (Void) as l_messages then

				end
			end
		rescue
			l_retry := True
			retry
		end


feature -- Tokens

	consumer_token: TWITTER_CONSUMER_TOKEN
		do
			create Result.make ("9IO5la10HW2cdD3LLx9EnTtMS", "ar8JQSbFu4r6w6tMvBgXTLBi20TNgIM24PkYcmewpymNbb8koi")
		end

	access_token: TWITTER_ACCESS_TOKEN
		do
			create Result.make ("4141349777-agbuHMCx7knqVEABnuLQeBKBFe8C7fwJMbQ7nnb", "SbcCsk4XGIDe3yL1Wa8PsnjMY2JuHGchyrH7MxibRyjxq")
		end



end
