note
	description: "Summary description for {TWITTER_STATUS_UPDATE_PARAMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_STATUS_UPDATE_PARAMS

inherit

	STRING_TABLE [STRING]
		export {TWITTER_STATUS_UPDATE_PARAMS} all
		end

create {TWITTER_STATUS_UPDATE_PARAMS}
	make, make_equal, make_caseless, make_equal_caseless

create
	make_with_status

feature {NONE} -- Initialization

	make_with_status (a_status: READABLE_STRING_32)
		require
			validd_lenght: a_status.count <= 140
		do
		  	make (1)
		  	add_status (a_status)
		end

feature -- Element Change

	add_status (a_val: READABLE_STRING_32)
			-- Add `status` parameter
		do
			force (a_val, status)
		ensure
			has_field: has (status)
		end

	add_in_reply_to_status_id (a_val: INTEGER_64)
			-- Add `in_reply_to_status_id` parameter
		do
			force (a_val.out, in_reply_to_status_id)
		ensure
			has_field: has (in_reply_to_status_id)
		end

	add_possibly_sensitive (a_val: BOOLEAN)
			-- Add `possibly_sensitive` parameter
		do
			force (a_val.out, possibly_sensitive)
		ensure
			has_field: has (possibly_sensitive)
		end

	add_latitude (a_val: REAL)
			-- Add `lat` parameter
		require
			valid_value: a_val >= -90.0 and then a_val <= 90.0
		do
			force (a_val.out, latitude)
		ensure
			has_field: has (latitude)
		end

	add_longitude (a_val: REAL)
			-- Add `long` parameter
		require
			valid_value: a_val >= -180.0 and then a_val <= 180.0
		do
			force (a_val.out, longitude)
		ensure
			has_field: has (longitude)
		end

	add_trim_user (a_val: BOOLEAN)
			-- Add `trim_user' parameter.
		do
			force (a_val.out, trim_user)
		ensure
			has_field: Current.has (trim_user)
		end

	add_place_id (a_val: STRING)
			-- Add `place_id` parameter.
		do
			force (a_val, place_id)
		ensure
			has_field: has (place_id)
		end

	add_enable_dm_commands (a_val: BOOLEAN)
			-- Add `enable_dm_commands` parameter.
		do
			force (a_val.out, enable_dm_commands)
		ensure
			has_field: has (enable_dm_commands)
		end

	add_fail_dm_commands (a_val: BOOLEAN)
			-- Add `enable_dm_commands` parameter.
		do
			force (a_val.out, fail_dm_commands)
		ensure
			has_field: has (fail_dm_commands)
		end

feature {NONE} -- Implementation

	status: STRING = "status"
			-- The text of the status update, typically up to 140 characters.
			-- URL encode as necessary. t.co link wrapping may affect character counts.
			-- There are some special commands in this field to be aware of.
			-- For instance, preceding a message with "D" or "M" and following it with a screen name
			-- can create a Direct Message to that user if the relationship allows for it.
			-- See the 'enable_dm_commands' parameter for information on disabling Direct Message
			-- creation to allow any text to be created as a Tweet.

	in_reply_to_status_id: STRING = "in_reply_to_status_id"
			-- The ID of an existing status that the update is in reply to.
			-- Note: This parameter will be ignored unless the author of the Tweet this parameter
			-- references is mentioned within the status text.
			-- Therefore, you must include @username, where username is the author of the referenced Tweet, within the update.

	possibly_sensitive: STRING = "possibly_sensitive"
			-- If you upload Tweet media that might be considered sensitive content such as nudity, violence, or medical procedures,
			-- you should set this value to true. See Media setting and best practices for more context.

	latitude: STRING = "lat"
			-- The latitude of the location this Tweet refers to.
			-- This parameter will be ignored unless it is inside the range -90.0 to +90.0 (North is positive) inclusive.
			-- It will also be ignored if there isn't a corresponding long parameter.		

	longitude: STRING = "long"
			-- The longitude of the location this Tweet refers to.
			-- The valid ranges for longitude is -180.0 to +180.0 (East is positive) inclusive.
			-- This parameter will be ignored if outside that range, if it is not a number,
			-- if geo_enabled is disabled, or if there not a corresponding lat parameter.	

	place_id: STRING = "place_id"
			-- A place in the world.

	display_coordinates: STRING = "display_coordinates"
		-- Whether or not to put a pin on the exact coordinates a Tweet has been sent from.	

	trim_user: STRING = "trim_user"
			-- When set to either true , t or 1 , each Tweet returned in a timeline
			-- will include a user object including only the status authors numerical ID.
			-- Omit this parameter to receive the complete user object.

	media_ids: STRING = "media_ids"
			-- A list of media_ids to associate with the Tweet.
			-- You may include up to 4 photos or 1 animated GIF or 1 video in a Tweet.
			-- See Uploading Media for further details on uploading media.		

	enable_dm_commands: STRING = "enable_dm_commands"
			-- When set to true, enables shortcode commands for sending Direct Messages
			-- as part of the status text to send a Direct Message to a user.
			-- When set to false, disables this behavior and includes any leading characters in the status text that is posted		

	fail_dm_commands: STRING = "fail_dm_commands"
			-- When set to true, causes any status text that starts with shortcode commands to return an API error.
			-- When set to false, allows shortcode commands to be sent in the status text and acted on by the API.
end
