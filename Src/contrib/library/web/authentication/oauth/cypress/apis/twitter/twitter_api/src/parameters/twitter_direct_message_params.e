note
	description: "Summary description for {TWITTER_DIRECT_MESSAGE_PARAMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_DIRECT_MESSAGE_PARAMS
inherit

	STRING_TABLE [STRING]
		export {TWITTER_DIRECT_MESSAGE_PARAMS} all
		end
create
	make, make_equal, make_caseless, make_equal_caseless


feature -- Element Change

	add_count (a_val: INTEGER)
			-- Add 'count' parameter.
		do
			force (a_val.out, count_field)
		ensure
			has_field: has (count_field)
		end

	add_since_id (a_val: INTEGER)
			-- Add `since_id' parameter.
		do
			force (a_val.out, since_id)
		ensure
			has_field: has (since_id)
		end

	add_max_id (a_val: INTEGER)
			-- Add `max_id' parameter.
		do
			force (a_val.out, max_id)
		ensure
			has_field: has (max_id)
		end

	add_skip_staus (a_val: BOOLEAN)
			-- Add `skip_status' parameter.
		do
			force (a_val.out, skip_status)
		ensure
			has_field: has (skip_status)
		end

	add_include_entities (a_val: BOOLEAN)
			-- Add `include_entities' parameter.
		do
			force (a_val.out, include_entities)
		ensure
			has_field: has (include_entities)
		end

feature {NONE} -- Implementation

	count_field: STRING = "count"
			-- Specifies the number of direct messages to try and retrieve, up to a maximum of 200.
			-- The value of count is best thought of as a limit to the number of Tweets to return
			-- because suspended or deleted content is removed after the count has been applied.

	since_id: STRING = "since_id"
			-- Returns results with an ID greater than (that is, more recent than) the specified ID.
			-- There are limits to the number of Tweets which can be accessed through the API.
			-- If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.	

	max_id: STRING = "max_id"
			-- Returns results with an ID less than (that is, older than) or equal to the specified ID.		

	skip_status: STRING = "skip_status"
			-- When set to either true , t or 1 statuses will not be included in the returned user objects.

	include_entities: STRING = "include_entities"
			-- The entities node will not be included when set to false.				
end
