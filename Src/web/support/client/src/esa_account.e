note
	description: "Object that represent a user account information"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACCOUNT

create
	make_with_username

feature {NONE} -- Creation

	make_with_username (a_username: READABLE_STRING_GENERAL)
		do
			create username.make_from_string_general (a_username)
		end

feature -- Access : Personal Information

	username: IMMUTABLE_STRING_32
			-- User_name.

	first_name: detachable IMMUTABLE_STRING_32
			-- First_name.

	last_name: detachable IMMUTABLE_STRING_32
			-- Last_name.	

	email: detachable IMMUTABLE_STRING_8
			-- Email.

	address: detachable IMMUTABLE_STRING_32
			-- Street address.

	city: detachable IMMUTABLE_STRING_32
			-- City.

	country: detachable IMMUTABLE_STRING_32
			-- Country.

	region: detachable IMMUTABLE_STRING_32
			-- Region.

	postal_code: detachable IMMUTABLE_STRING_32
			-- Postal_code.

	telephone: detachable IMMUTABLE_STRING_32
			-- Telephone.

	fax: detachable IMMUTABLE_STRING_32
			-- Fax.

	position: detachable IMMUTABLE_STRING_32
			-- Position.

feature -- Change Element

	set_first_name (a_first_name: detachable READABLE_STRING_GENERAL)
			-- Set `first_name` with `a_first_name`.
		do
			if a_first_name = Void then
				first_name := Void
			else
				create first_name.make_from_string_general (a_first_name)
			end
		ensure
			first_name_set: a_first_name /= Void implies (attached first_name as n and then a_first_name.same_string (n))
		end

	set_last_name (a_last_name: detachable READABLE_STRING_GENERAL)
			-- Set `last_name` with `a_last_name`.
		do
			if a_last_name = Void then
				last_name := Void
			else
				create last_name.make_from_string_general (a_last_name)
			end
		ensure
			last_name_set: a_last_name /= Void implies (attached last_name as n and then a_last_name.same_string (n))
		end

	set_email (a_email: READABLE_STRING_8)
			-- Set `email' to `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_address (a_address: READABLE_STRING_GENERAL)
			-- Set Street  `address' to `a_address'.
		do
			create address.make_from_string_general (a_address)
		ensure
			address_set: attached address as v and then a_address.same_string (v)
		end

	set_city (a_city: READABLE_STRING_GENERAL)
			-- Set `city' to `a_city'.
		do
			create city.make_from_string_general (a_city)
		ensure
			city_set: attached city as v and then a_city.same_string (v)
		end

	set_country (a_country: READABLE_STRING_GENERAL)
			-- Set `country' to `a_country'.
		do
			create country.make_from_string_general (a_country)
		ensure
			country_set: attached country as v and then a_country.same_string (v)
		end

	set_region (a_region: READABLE_STRING_GENERAL)
			-- Set `region' to `a_region'.
		do
			create region.make_from_string_general (a_region)
		ensure
			region_set: attached region as v and then a_region.same_string (v)
		end

	set_postal_code (a_postal_code: READABLE_STRING_GENERAL)
			-- Postal_code
		do
			create postal_code.make_from_string_general (a_postal_code)
		ensure
			post_code_set: attached postal_code as v and then a_postal_code.same_string (v)
		end

	set_telephone (a_telephone: READABLE_STRING_GENERAL)
			-- Set `telephone' to `a_telephone'.
		do
			create telephone.make_from_string_general (a_telephone)
		ensure
			telephone_set: attached telephone as v and then a_telephone.same_string (v)
		end

	set_fax (a_fax: READABLE_STRING_GENERAL)
			-- Set `fax' to `a_fax'.
		do
			create fax.make_from_string_general (a_fax)
		ensure
			fax_set: attached fax as v and then a_fax.same_string (v)
		end

	set_position (a_position: READABLE_STRING_GENERAL)
			-- Set `position' to `a_position'.
		do
			create position.make_from_string_general (a_position)
		ensure
			position_set: attached position as v and then a_position.same_string (v)
		end

feature -- Query

	has_basic_information: BOOLEAN
			-- Indicates if user has the basic information set.
		do
			Result := not (is_null_or_empty (username) or else
				is_null_or_empty (first_name) or else
				is_null_or_empty (last_name) or else
				is_null_or_empty (email))
		end

	displayed_name: detachable STRING_32
			-- Display representation of the name for Current user.
		do
			if attached first_name as l_first and then not l_first.is_empty then
				if attached last_name as l_last and then not l_last.is_empty then
						-- We have both the first and last name.
					create Result.make (l_first.count + 1 + l_last.count)
					Result.append (l_first)
					Result.append_character (' ')
					Result.append (l_last)
				else
						-- Only the last name.
					Result := l_first
				end
			elseif attached last_name as l_last and then not l_last.is_empty then
					-- Only the first name.
				Result := l_last
			else
					-- None of the first or lastname, we will use the username
				Result := username
			end
		end

feature {NONE} -- Implementation

	is_null_or_empty (a_argument: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_argument' null or empty?
		do
			Result := not  (attached a_argument as l_argument and then not l_argument.is_empty)
		end


end

