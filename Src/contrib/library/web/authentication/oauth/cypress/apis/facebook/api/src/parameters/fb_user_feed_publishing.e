note
	description: "Summary description for {FB_USER_FEED_PUBLISHING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_USER_FEED_PUBLISHING

inherit

	STRING_TABLE [STRING]

create
	make, make_equal, make_caseless, make_equal_caseless

feature -- Access

	include_message (a_val: STRING)
			-- Include parameter `message' with value `a_val'.
		do
			force (a_val, message)
		ensure
			has_field: has (message)
		end

	include_link (a_val: STRING)
			-- Include parameter `link' with value `a_val'.
			--|TODO check if it's ok to validate a_val is a valid Link (URL).
		do
			force (a_val, link)
		ensure
			has_field: has (link)
		end

	include_place (a_val: STRING)
			-- Include parameter `place' with value `a_val'.	
		do
			force (a_val, place)
		ensure
			has_field: has (place)
		end

	include_tags (a_vals: LIST [STRING])
			-- Include parameter `tags' with a comma separated list of a_vals.
		local
			l_csv: STRING
		do
			create l_csv.make_empty
			across a_vals as ic loop
				l_csv.append (ic.item)
				l_csv.append (",")
			end
			l_csv.remove_tail (1)
			force (l_csv, tags)
		end

	include_privacy (a_val: FB_PRIVACY_PARAMETER)
			-- Include parameter `privacy' with `a_val'.
		do
			--| TODO Check how to add privacy
		ensure
			has_field: has (privacy)
		end

	include_object_attachment (a_val: STRING)
			-- Include parameter `object_attachment' with `a_val'.
		do
			force (a_val, object_attachment)
		ensure
			has_field: has (object_attachment)
		end

feature {NONE} -- Implementation

	message: STRING = "message"
			-- The main body of the post, otherwise called the status message.
			-- Either link, place, or message must be supplied string.

	link: STRING = "link"
			-- The URL of a link to attach to the post.
			-- Either link, place, or message must be supplied.
			-- Additional fields associated with link are shown below.

	place: STRING = "place"
			-- Page ID of a location associated with this post. Either link, place, or message must be supplied.
			-- string.

	tags: STRING = "tags"
			-- Comma-separated list of user IDs of people tagged in this post.
			-- You cannot specify this field without also specifying a place.

	privacy: STRING = "privacy"
			-- Determines the privacy settings of the post.
			-- If not supplied, this defaults to the privacy level granted to the app in the Login Dialog.
			--  This field cannot be used to set a more open privacy setting than the one granted.

	object_attachment: STRING = "object_attachment"
			-- Facebook ID for an existing picture in the person's photo albums to use as the thumbnail image.
			-- They must be the owner of the photo, and the photo cannot be part of a message attachment.
end

