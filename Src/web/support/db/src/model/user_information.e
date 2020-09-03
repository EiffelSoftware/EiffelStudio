note
	description: "User data type with username, email, first and last name"
	date: "$Date$"
	revision: "$Revision$"

class
	USER_INFORMATION

create
	make

feature {NONE} -- Initialization

	make (a_username: STRING_32)
			-- Initialize instance.
		do
			username := a_username
		ensure
			username_set: username = a_username
		end

feature -- Access : Personal Information

	username: READABLE_STRING_32
			-- Username.

	first_name: detachable READABLE_STRING_32
			-- First_name.

	last_name: detachable READABLE_STRING_32
			-- Last_name.	

	email: detachable READABLE_STRING_8
			-- Email.

	address: detachable READABLE_STRING_32
			-- Street address.

	city: detachable READABLE_STRING_32
			-- City.

	country: detachable READABLE_STRING_32
			-- Country.

	region: detachable READABLE_STRING_32
			-- Region.

	postal_code: detachable READABLE_STRING_8
			-- Postal_code.

	telephone: detachable READABLE_STRING_8
			-- Telephone.

	fax: detachable READABLE_STRING_8
			-- Fax.

	position: detachable READABLE_STRING_32
			-- Position.

feature -- Access : Organization Information

	organization_name: detachable READABLE_STRING_32
			-- Organization name.

	organization_email: detachable READABLE_STRING_8
			-- Organization email.

	organization_url: detachable READABLE_STRING_8
			-- Organization_url.

	organization_address: detachable READABLE_STRING_32
			-- Organization street address.

	organization_city: detachable READABLE_STRING_32
			-- Organization city.

	organization_country: detachable READABLE_STRING_32
			-- Organization country.

	organization_region: detachable READABLE_STRING_32
			-- Organization region.

	organization_postal_code: detachable READABLE_STRING_8
			-- Organization postal code.

	organization_telephone: detachable READABLE_STRING_8
			-- Organization telephone.

	organization_fax: detachable READABLE_STRING_8
			-- Organization fax.

feature -- Change Element


	set_first_name (a_first_name: READABLE_STRING_32)
			-- Set `first_name' to `a_first_name'.
		do
			first_name := a_first_name
		ensure
			first_name_set:  first_name = a_first_name
		end

	set_last_name (a_last_name: READABLE_STRING_32)
			-- Set `last_name' to `a_last_name'.
		do
			last_name := a_last_name
		ensure
			last_name_set:
		end

	set_email (a_email: READABLE_STRING_8)
			-- Set `email' to `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_address (a_address: READABLE_STRING_32)
			-- Set Street  `address' to `a_address'.
		do
			address := a_address
		ensure
			address_set: address = a_address
		end

	set_city (a_city: READABLE_STRING_32)
			-- Set `city' to `a_city'.
		do
			city := a_city
		ensure
			city_set: city = a_city
		end

	set_country (a_country: READABLE_STRING_32)
			-- Set `country' to `a_country'.
		do
			country := a_country
		ensure
			country_set: country = a_country
		end

	set_region (a_region: READABLE_STRING_32)
			-- Set `region' to `a_region'.
		do
			region := a_region
		ensure
			region_set: region = a_region
		end

	set_postal_code (a_postal_code: READABLE_STRING_8)
			-- Postal_code
		do
			postal_code := a_postal_code
		ensure
			post_code_set: postal_code = a_postal_code
		end

	set_telephone (a_telephone: READABLE_STRING_8)
			-- Set `telephone' to `a_telephone'.
		do
			telephone := a_telephone
		ensure
			telephone_set: telephone = a_telephone
		end

	set_fax ( a_fax : READABLE_STRING_8)
			-- Set `fax' to `a_fax'.
		do
			fax := a_fax
		ensure
			fax_set: fax = a_fax
		end

	set_position ( a_position : READABLE_STRING_32)
			-- Set `position' to `a_position'.
		do
			position := a_position
		ensure
			position_set: position = a_position
		end

	set_organization_name ( a_organization_name : READABLE_STRING_32)
			-- Set `organization_name' to `a_organization_name'.
		do
			organization_name := a_organization_name
		ensure
			organization_name_set: organization_name = a_organization_name
		end

	set_organization_email ( a_organization_email : READABLE_STRING_8)
			-- Set `organization_email' to `a_organization_email'
		do
			organization_email := a_organization_email
		ensure
			organization_email_set: organization_email = a_organization_email
		end

	set_organization_url ( a_organization_url : READABLE_STRING_8)
			-- Set `organization_url' to `a_organization_url'.
		do
			organization_url := a_organization_url
		ensure
			organization_url_set: organization_url = a_organization_url
		end

	set_organization_address ( a_organization_address : READABLE_STRING_32)
			-- Set `organization_address' to `a_organization_address'.
		do
			organization_address := a_organization_address
		ensure
			organization_address_set: organization_address = a_organization_address
		end

	set_organization_city ( a_organization_city : READABLE_STRING_32)
			-- Set `organization_city' to `a_organization_city'.
		do
			organization_city := a_organization_city
		ensure
			organization_city_set: organization_city = a_organization_city
		end

	set_organization_country ( a_organization_country : READABLE_STRING_32)
			-- Set `organization_country' to `a_organization_country'.
		do
			organization_country := a_organization_country
		ensure
			organization_country_set: organization_country = a_organization_country
		end

	set_organization_region ( a_organization_region : READABLE_STRING_32)
			-- Set `organization_region' to `a_organization_region'.
		do
			organization_region := a_organization_region
		ensure
			organization_region_set: organization_region = a_organization_region
		end

	set_organization_postal_code( a_organization_postal_code : READABLE_STRING_8)
			-- Set `organization_postal_code' to `a_organization_postal_code'.
		do
			organization_postal_code := a_organization_postal_code
		ensure
			organization_postal_code_set: organization_postal_code = a_organization_postal_code
		end

	set_organization_telephone ( a_organization_telephone : READABLE_STRING_8)
			-- Set `organization_telephone' to `a_organization_telephone'.
		do
			organization_telephone := a_organization_telephone
		ensure
			organization_telephone_set: organization_telephone = a_organization_telephone
		end

	set_organization_fax ( a_organization_fax: READABLE_STRING_8)
			-- Set `organization_fax' to `a_organization_fax'.	
		do
			organization_fax := a_organization_fax
		ensure
			organixation_fax_set: organization_fax = a_organization_fax
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

	displayed_name: STRING_32
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

	has_extended_information: BOOLEAN
			-- Inidicates if user has set extended information needed to access
			-- protected areas.
		do
			Result := not (is_null_or_empty (organization_name) or else
				is_null_or_empty (organization_email) or else
				is_null_or_empty (organization_address) or else
				is_null_or_empty (organization_city) or else
				is_null_or_empty (organization_country) or else
				is_null_or_empty (organization_region) or else
				is_null_or_empty (organization_postal_code) or else
				is_null_or_empty (organization_telephone))
		end


feature {NONE} -- Implementation

	is_null_or_empty (a_argument: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_argument' null or empty?
		do
			Result := not  (attached a_argument as l_argument and then not l_argument.is_empty)
		end


end
