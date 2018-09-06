note
	description: "[
					Object representing the privacy settings of the post. If not supplied, this defaults to the privacy level granted to the app in the Login Dialog. 
					This field cannot be used to set a more open privacy setting than the one granted.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	FB_PRIVACY_PARAMETER

inherit

	FB_PRIVACY_CONSTANTS

feature -- Access

	value: detachable STRING
			-- The value of the privacy setting.
		    -- enum{'EVERYONE', 'ALL_FRIENDS', 'FRIENDS_OF_FRIENDS', 'CUSTOM', 'SELF'}

	allowed_users: detachable LIST [STRING]
		-- When value is CUSTOM, this is a comma-separated list of user IDs and friend list IDs that can see the post.
		-- This can also be ALL_FRIENDS or FRIENDS_OF_FRIENDS to include all members of those sets.

	denied_users: detachable LIST [STRING]
		-- When value is CUSTOM, this is a comma-separated list of user IDs and friend list IDs that cannot see the post.

feature -- Element Change

	set_value (a_val: like value)
			-- Set `value' with `a_val'.
		require
			is_valid: is_valid_privacy_settings (a_val)
		do
			value := a_val
		ensure
			value_set: value = a_val
		end

	set_allowed_users (a_val: like allowed_users)
			-- Set `allowed_users' with `a_val'.
		do
			allowed_users := a_val
		ensure
			allow_set: allowed_users = a_val
		end

	set_denied_users (a_val: like denied_users )
			-- Set `denied_users' with `a_val'.
		do
			denied_users := a_val
		ensure
			deny_set: denied_users = a_val
		end
end
