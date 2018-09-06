note
	description: "Summary description for {FB_PRIVACY_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_PRIVACY_CONSTANTS


feature -- Privacy Settings

	Everyone: STRING = "'EVERYONE'"

	All_friends: STRING = "'ALL_FRIENDS'"

	Friend_of_friends: STRING = "'FRIENDS_OF_FRIENDS'"

	Custom: STRING = "'CUSTOM'"

	Self: STRING = "'SELF'"

feature -- Access

	is_valid_privacy_settings (a_settings: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_settings' a valid privacy settings?
		do
			if attached a_settings then
				if
					a_settings.is_case_insensitive_equal (everyone) or else
					a_settings.is_case_insensitive_equal (all_friends) or else
					a_settings.is_case_insensitive_equal (friend_of_friends) or else
					a_settings.is_case_insensitive_equal (custom) or else
					a_settings.is_case_insensitive_equal (self)
				then
					Result := True
				end
			end

		end

end
