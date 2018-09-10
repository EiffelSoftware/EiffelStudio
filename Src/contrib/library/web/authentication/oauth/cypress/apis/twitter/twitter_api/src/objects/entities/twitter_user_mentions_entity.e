note
	description: "[
		Object that represent an user menstion in an array of Twitter screen names extracted from the Tweet text. 
		Each user mention entity comes with the following attributes:

		id	The user ID (int format)
		id_str	The user ID (string format)
		screen_name	The user screen name
		name	The user full name
		indices	The character positions the user mention was extracted from
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=User Mentions", "src=https://dev.twitter.com/overview/api/entities-in-twitter-objects#the-user-mentions-entity", "protocol=uri"

class
	TWITTER_USER_MENTIONS_ENTITY


feature -- Access

	indices: detachable TUPLE [INTEGER, INTEGER]
			-- The character positions the user mention was extracted from

	name: detachable STRING
			-- The user full name.

	screen_name: detachable STRING
			-- `screen_name'

	id_str: detachable STRING
			-- The user ID (string format).

	id: INTEGER_64
			-- The user ID (int format).

feature -- Element change

	set_indices (an_indices: like indices)
			-- Assign `indices' with `an_indices'.
		do
			indices := an_indices
		ensure
			indices_assigned: indices = an_indices
		end

	set_name (a_name: like name)
			-- Assign `name' with `a_name'.
		do
			name := a_name
		ensure
			name_assigned: name = a_name
		end

	set_screen_name (a_screen_name: like screen_name)
			-- Assign `screen_name' with `a_screen_name'.
		do
			screen_name := a_screen_name
		ensure
			screen_name_assigned: screen_name = a_screen_name
		end

	set_id_str (an_id_str: like id_str)
			-- Assign `id_str' with `an_id_str'.
		do
			id_str := an_id_str
		ensure
			id_str_assigned: id_str = an_id_str
		end

	set_id (an_id: like id)
			-- Assign `id' with `an_id'.
		do
			id := an_id
		ensure
			id_assigned: id = an_id
		end

end
