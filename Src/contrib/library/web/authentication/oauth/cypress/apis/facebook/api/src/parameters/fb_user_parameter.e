note
	description: "Summary description for {FB_USER_PARAMETER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_USER_PARAMETER

inherit

	REFACTORING_HELPER

feature -- Parameters - Basic

	include_birthday
			--  The person's birthday.
			-- This is a fixed format string, like MM/DD/YYYY.
			-- However, people can control who can see the year they were born separately from the month and day so this string can be only the year (YYYY) or the month + day (MM/DD)
		do
			include ("birthday")
		end

	include_email
			-- The person's primary email address listed on their profile. This field will not be returned if no valid email address is available	
		do
			include ("email")
		end

	include_first_name
			-- The person's first name
		do
			include ("first_name")
		end

	include_gender
			-- The gender selected by this person, male or female.
			-- If the gender is set to a custom value, this value will be based off of the preferred pronoun; it will be omitted if the preferred preferred pronoun is neutral
		do
			include ("gender")
		end

	include_last_name
			-- The person's last name
		do
			include ("last_name")
		end

	include_link
			-- A link to the person's Timeline
		do
			include ("link")
		end

	include_locale
			-- The person's locale
		do
			include ("locale")
		end

	include_location
			-- The person's current location as entered by them on their profile. This field is not related to check-ins
		do
			include ("location")
		end

	include_middle_name
			-- The person's middle name
		do
			include ("middle_name")
		end

	include_timezone
			-- 	timezone float (min: -24) (max: 24)	
			-- The person's current timezone offset from UTC
		do
			include ("timezone")
		end

	include_all_basic
			-- Include all basic fields.
		do
			include_birthday
			include_email
			include_first_name
			include_gender
			include_last_name
			include_link
			include_locale
			include_location
			include_middle_name
			include_timezone
		end

feature -- Access

	parameters: detachable STRING

feature {NONE} -- Implementation

	include (a_val: STRING)
		local
			l_parameters: STRING
		do
			l_parameters := parameters
			if l_parameters /= Void then
				l_parameters.append_character (',')
				l_parameters.append (a_val)
			else
				create l_parameters.make_from_string ("fields=")
				l_parameters.append (a_val)
			end
			parameters := l_parameters
		end
end
