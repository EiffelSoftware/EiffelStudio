note
	description: "Summary description for {TWITTER_STATUS_SHOW_PARAMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_STATUS_SHOW_PARAMS

inherit

	STRING_TABLE [STRING]
		export {TWITTER_STATUS_SHOW_PARAMS} all
		end

create {TWITTER_STATUS_SHOW_PARAMS}
	make, make_equal, make_caseless, make_equal_caseless

create
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_id: INTEGER_64)
		do
		  	make (1)
		  	add_id (a_id)
		end

feature -- Element Change

	add_id (a_val: INTEGER_64)
			-- Add 'id' parameter.
		do
			force (a_val.out, id)
		ensure
			has_field: Current.has (id)
		end

	add_trim_user (a_val: BOOLEAN)
			-- Add `trim_user' parameter.
		do
			force (a_val.out, trim_user)
		ensure
			has_field: Current.has (trim_user)
		end

	add_include_my_retweet (a_val: BOOLEAN)
		do
			force (a_val.out, include_my_retweet)
		ensure
			has_field: Current.has (include_my_retweet)
		end

	add_include_entities (a_val: BOOLEAN)
			-- Add `include_entities' parameter.
		do
			force (a_val.out, include_entities)
		ensure
			has_field: Current.has (include_entities)
		end

feature {NONE} -- Implementation

	id: STRING = "id"
			-- The numerical ID of the desired Tweet.

	trim_user: STRING = "trim_user"
			-- When set to either true , t or 1 , each Tweet returned in a timeline
			-- will include a user object including only the status authors numerical ID.
			-- Omit this parameter to receive the complete user object.

	include_my_retweet: STRING = "include_my_retweet"
			-- When set to either true , t or 1 , any Tweets returned that have been retweeted by the authenticating user will include an additional current_user_retweet node,
			--  containing the ID of the source status for the retweet.		

	include_entities: STRING = "include_entities"
			-- The entities node will not be included when set to false.


invariant
	has_id_field: has (id)
end
