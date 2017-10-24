note
	description: "Object that represent a user account information"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACCOUNT

feature -- Access : Personal Information

	username: detachable STRING
			-- Username.

	first_name: detachable STRING
			-- First_name.

	last_name: detachable STRING
			-- Last_name.	

	email: detachable STRING
			-- Email.

	address: detachable STRING
			-- Street address.

	city: detachable STRING
			-- City.

	country: detachable STRING
			-- Country.

	region: detachable STRING
			-- Region.

	postal_code: detachable STRING
			-- Postal_code.

	telephone: detachable STRING
			-- Telephone.

	fax: detachable STRING
			-- Fax.

	position: detachable STRING
			-- Position.

feature -- Change Element

	set_user_name (a_username: STRING)
			-- Set 'user_name' with 'a_username'.
		do
			username := a_username
		ensure
			username_set : username = a_username
		end


	set_first_name (a_first_name: STRING)
			-- Set `first_name' to `a_first_name'.
		do
			first_name := a_first_name
		ensure
			first_name_set:  first_name = a_first_name
		end

	set_last_name (a_last_name: STRING)
			-- Set `last_name' to `a_last_name'.
		do
			last_name := a_last_name
		ensure
			last_name_set:
		end

	set_email (a_email: STRING)
			-- Set `email' to `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_address (a_address: STRING)
			-- Set Street  `address' to `a_address'.
		do
			address := a_address
		ensure
			address_set: address = a_address
		end

	set_city (a_city: STRING)
			-- Set `city' to `a_city'.
		do
			city := a_city
		ensure
			city_set: city = a_city
		end

	set_country (a_country: STRING)
			-- Set `country' to `a_country'.
		do
			country := a_country
		ensure
			country_set: country = a_country
		end

	set_region (a_region: STRING)
			-- Set `region' to `a_region'.
		do
			region := a_region
		ensure
			region_set: region = a_region
		end

	set_postal_code (a_postal_code: STRING)
			-- Postal_code
		do
			postal_code := a_postal_code
		ensure
			post_code_set: postal_code = a_postal_code
		end

	set_telephone (a_telephone: STRING)
			-- Set `telephone' to `a_telephone'.
		do
			telephone := a_telephone
		ensure
			telephone_set: telephone = a_telephone
		end

	set_fax ( a_fax : STRING)
			-- Set `fax' to `a_fax'.
		do
			fax := a_fax
		ensure
			fax_set: fax = a_fax
		end

	set_position ( a_position : STRING)
			-- Set `position' to `a_position'.
		do
			position := a_position
		ensure
			position_set: position = a_position
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

	displayed_name: detachable STRING
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

	is_null_or_empty (a_argument: detachable STRING): BOOLEAN
			-- Is `a_argument' null or empty?
		do
			Result := not  (attached a_argument as l_argument and then not l_argument.is_empty)
		end


end

