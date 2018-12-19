note
	description: "Summary description for {TWITTER_USER_TIMELINE_PARAMS}."
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_USER_TIMELINE_PARAMS

inherit

	STRING_TABLE [STRING]
		export {TWITTER_USER_TIMELINE_PARAMS} all
		end

create
	make, make_equal, make_caseless, make_equal_caseless

-- TODO
-- Check if we can inherit from
-- TWITTER_HOME_TIMELINE_PARAMS

feature -- Element Change

	add_user_id (a_val: INTEGER_64)
			-- Add 'user_id' parameter.
		do
			force (a_val.out, user_id)
		ensure
			has_field: Current.has (user_id)
		end

	add_screen_name (a_val: STRING)
			-- Add `screen_name' parameter.
		do
			force (a_val, screen_name)
		ensure
			has_field: Current.has (screen_name)
		end


	add_count (a_val: INTEGER)
			-- Add 'count' parameter.
		do
			force (a_val.out, count_field)
		ensure
			has_field: Current.has (count_field)
		end

	add_since_id (a_val: INTEGER)
			-- Add `since_id' parameter.
		do
			force (a_val.out, since_id)
		ensure
			has_field: Current.has (since_id)
		end

	add_max_id (a_val: INTEGER)
			-- Add `max_id' parameter.
		do
			force (a_val.out, max_id)
		ensure
			has_field: Current.has (max_id)
		end

	add_trim_user (a_val: BOOLEAN)
			-- Add `trim_user' parameter.
		do
			force (a_val.out, trim_user)
		ensure
			has_field: Current.has (trim_user)
		end

	add_exclude_replies (a_val: BOOLEAN)
			-- Add `exclude_replies' parameter.
		do
			force (a_val.out, exclude_replies)
		ensure
			has_field: Current.has (exclude_replies)
		end

	add_include_trs (a_val: BOOLEAN)
			-- Add `include_rts' parameter.
		do
			force (a_val.out, include_rts)
		ensure
			has_field: Current.has (include_rts)
		end


feature {NONE} -- Implementation

	user_id: STRING = "user_id"
			-- The ID of the user for whom to return results.
			--| the id is an INTEGER_64

	screen_name: STRING = "screen_name"
			-- The screen name of the user for whom to return results.

	since_id: STRING = "since_id"
			-- Returns results with an ID greater than (that is, more recent than) the specified ID.
			-- There are limits to the number of Tweets that can be accessed through the API.
			-- If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.

	count_field: STRING = "count"
			-- Specifies the number of Tweets to try and retrieve, up to a maximum of 200 per distinct request.
			-- The value of count is best thought of as a limit to the number of Tweets to return because suspended or deleted content is removed after the count has been applied.
			-- We include retweets in the count, even if include_rts is not supplied. It is recommended you always send include_rts=1 when using this API method.

	max_id: STRING = "max_id"
			-- Returns results with an ID less than (that is, older than) or equal to the specified ID.

	trim_user: STRING = "trim_user"
			-- When set to either true , t or 1 , each Tweet returned in a timeline will include a user object
			-- including only the status authors numerical ID. Omit this parameter to receive the complete user object.	

	exclude_replies: STRING = "exclude_replies"
			-- This parameter will prevent replies from appearing in the returned timeline.

	include_rts: STRING = "include_rts"
			-- When set to false, the timeline will strip any native retweets (though they will still count toward both the maximal length of the timeline and the slice selected by the count parameter).

end
