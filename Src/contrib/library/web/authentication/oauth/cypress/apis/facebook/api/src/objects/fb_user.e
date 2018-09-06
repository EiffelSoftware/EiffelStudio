note
	description: "Object representing a Facebook User."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Facebook User", "src=https://developers.facebook.com/docs/graph-api/reference/user/", "protocol=uri"

class
	FB_USER

--|TODO Evaluate if we can have a make_with_id or make_with_name would be good, to have either the id or the name as attached attribute.

feature -- Access: Basic Properties

	id:  detachable STRING
			-- The id of this person's user account.

	name: detachable STRING_32
			-- The person's full name.
			--! Predeterminded.

	birthday: detachable STRING
			-- The person's birthday.
			-- This is a fixed format string, like MM/DD/YYYY.
			-- However, people can control who can see the year they were born separately
			-- from the month and day so this string can be only the year (YYYY) or the month + day (MM/DD)

	email: detachable STRING
			--	The person's email.

	first_name: detachable STRING_32
			-- The person's first name.

	last_name: detachable STRING_32
			--	The person's LAST name.			

	gender: detachable STRING
			--  The gender selected by this person, male or female.

	middle_name: detachable STRING_32
			-- The person's middle name.

	time_zone: REAL
			-- 	timezone float (min: -24) (max: 24)	

	locale: detachable STRING
			-- The person's locale

	link: detachable STRING
			-- A link to the person's Timeline

	location: detachable FB_PAGE
			-- The person's current location as entered by them on their profile. This field is not related to check-ins.

feature -- Element Change: Basic Properties

	set_id (a_id: like id)
			-- Set 'id' with a_id.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_name (a_name: like name)
			-- Set `name' with a_name.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_birthday (a_birthday: like birthday)
			-- Set `birthday' with `a_birthday'.
		do
			birthday := a_birthday
		ensure
			birthday_set: birthday = a_birthday
		end

	set_email (a_email: like email)
			-- Set `email' with `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_first_name (a_fn: like first_name)
			-- Set `first_name' with `a_fn'.
		do
			first_name := a_fn
		ensure
			first_name_set: first_name = a_fn
		end

	set_last_name (a_ln: like last_name)
			-- Set `last_name' with `a_ln'.
		do
			last_name := a_ln
		ensure
			last_name_set: last_name = a_ln
		end

	set_middle_name (a_mn: like middle_name)
			-- Set `middle_name' with `a_mn'.
		do
			middle_name := a_mn
		ensure
			middle_name_set: middle_name = a_mn
		end

	set_gender (a_gender: like gender)
			-- Set `gender' with `a_gender'.
		do
			gender := a_gender
		ensure
			gender_set: gender = a_gender
		end

	set_time_zone (a_tz: like time_zone)
			-- Set `time_zone' with `a_tz'.
		require
			valid_time_zone: time_zone >= -24 and then time_zone <= 24
		do
			time_zone := a_tz
		ensure
			time_zone_set: time_zone = a_tz
		end

	set_locale (a_locale: like locale)
			-- Set `locale' with  `a_locale'.
		do
			locale := a_locale
		ensure
			locale_set: locale = a_locale
		end

	set_link (a_link: like link)
			-- Set `link' to `a_link'.
		do
			link := a_link
		ensure
			link_set: link = a_link
		end

	set_location (a_location: like location)
			-- Set `location' with  `a_location'.
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

feature -- Status Report

	basic_out: STRING
			-- <Precursor>
		local
			n: STRING
		do
			create n.make_from_string ("USER: ")

			if attached name as l_name then
				n.append_string ( "%N(" + l_name)
				n.append_string (")")
				n.append ("%N")
			end
			if attached id as l_id then
				n.append_string (" %"id: ")
				n.append_string (l_id)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached birthday as l_birthday then
				n.append_string (" %"birthday: ")
				n.append_string (l_birthday)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached email as l_email then
				n.append_string (" %"email:")
				n.append_string (l_email)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached first_name as l_fn then
				n.append_string (" %"first_name: ")
				n.append_string (l_fn)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached last_name as l_ln then
				n.append_string (" %"last_name: ")
				n.append_string (l_ln)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached gender as l_g then
				n.append_string (" %"gender: ")
				n.append_string (l_g)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached middle_name as l_mn then
				n.append_string (" %"middle_name: ")
				n.append_string (l_mn)
				n.append_string ("%"")
				n.append ("%N")
			end
			if time_zone > 0 then
				n.append_string (" %"time_zone: ")
				n.append_string (time_zone.out)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached locale as l_locale then
				n.append_string (" %"locale: ")
				n.append_string (l_locale)
				n.append_string ("%"")
				n.append ("%N")
			end
			if attached link as l_link then
				n.append_string (" %"link: ")
				n.append_string (l_link)
				n.append_string ("%"")
				n.append ("%N")
			end
			Result := n
		end

	invariant
		valid_time_zone: time_zone >= -24 and then time_zone <= 24
end
