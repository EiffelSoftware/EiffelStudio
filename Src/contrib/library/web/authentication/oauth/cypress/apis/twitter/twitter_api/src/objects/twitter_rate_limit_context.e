note
	description: "Summary description for {TWITTER_RATE_LIMIT_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_RATE_LIMIT_CONTEXT

feature -- Access: Rate limit context

	access_token: detachable STRING

feature -- Access: Resource List

	resources: detachable STRING_TABLE [ LIST [STRING_TABLE [TUPLE [limit: INTEGER; remaining: INTEGER; reset: INTEGER ]]]]
			-- rate limit resources

-- Type of resources
--	lists
--	application
--	mutes
--	live_video_stream
--	friendships
--	guide
--	auth
--	blocks
--	geo
--	users
--	followers
--	collections
--	statuses
--	custom_profiles
--	webhooks
--	contacts
--	tweet_prompts
--	moments
--	help
--	feedback
--	business_experience
--	friends
--	sandbox
--	drafts
--	direct_messages
--  media
--  account_activity
-- 	account
--  favorites
--  live_event
--  device
--  saved_searches
--  search
--  trends
--  live_pipeline

feature -- Element Change: rate limit context

	set_access_token (a_token: detachable STRING)
			-- Set `access_token` with `a_token`.
		do
			access_token := a_token
		ensure
			access_token_set: access_token = a_token
		end

	set_resources (a_resources: like resources)
			-- Set `resources' with `a_resources'
		do
			resources := a_resources
		ensure
			resources_set: resources = a_resources
		end

end
