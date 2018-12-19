note
	description: "Summary description for {TWITTER_RETWEETERS_PARAMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_RETWEETERS_PARAMS

inherit

	STRING_TABLE [STRING]
		export {TWITTER_RETWEETERS_PARAMS} all
		end

create {TWITTER_RETWEETERS_PARAMS}
	make, make_equal, make_caseless, make_equal_caseless

create
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_id: INTEGER_64)
		do
		  	make (1)
		  	add_id (a_id)
			add_stringify_ids (True)
		end

	add_id (a_val: INTEGER_64)
			-- Add `id` parameter.
		do
			force (a_val.out, id)
		ensure
			has_field: has (id)
		end

	add_stringify_ids (a_val: BOOLEAN)
		do
			force (a_val.out, stringify_ids)
		ensure
			has_field: has (stringify_ids)
		end

feature -- Element Change

	add_cursor (a_val: STRING)
		do
			force (a_val, cursor_field)
		ensure
			has_field: has (cursor_field)
		end

	add_count (a_val: INTEGER)
		do
			force (a_val.out, count_field)
		ensure
			has_field: has (count_field)
		end

feature {NONE} -- Implementation


	id: STRING = "id"
			-- The numerical ID of the desired status.

	cursor_field: STRING = "cursor"
		-- Causes the list of IDs to be broken into pages of no more than 100 IDs at a time.
		-- The number of IDs returned is not guaranteed to be 100 as suspended users are filtered out after connections are queried.
		-- If no cursor is provided, a value of -1 will be assumed, which is the first page.
		-- The response from the API will include a previous_cursor and next_cursor to allow paging back and forth. See our cursor docs for more information.
		-- While this method supports the cursor parameter, the entire result set can be returned in a single cursored collection.
		-- Using the count parameter with this method will not provide segmented cursors for use with this parameter.

	stringify_ids: STRING = "stringify_ids"
		-- Many programming environments will not consume Tweet ids due to their size.
		-- Provide this option to have ids returned as strings instead.			

	count_field: STRING = "count"
		-- Using this parameter to not provide segmented cursors.
end
