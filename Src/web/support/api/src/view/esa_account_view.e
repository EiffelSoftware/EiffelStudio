note
	description: "Generic Representation of an Account."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACCOUNT_VIEW

create
	make,
	make_from_user_info

feature {NONE}-- Initialization

	make (a_username: STRING_32)
			-- Create a new instance set `user_name' to `a_username'.
		do
			username := a_username
		ensure
			username_set: username = a_username
		end

	make_from_user_info (a_user_info: USER_INFORMATION)
			-- Create a new instance from user information `a_user_info'.
		do
			username := a_user_info.username
			if attached a_user_info.first_name as l_first_name then
				set_first_name (l_first_name)
			end
			if attached a_user_info.last_name as l_last_name then
				set_last_name (l_last_name)
			end
			if attached a_user_info.email as l_email and then not l_email.is_empty then
				set_email (l_email)
			end
			if attached a_user_info.address as l_address and then not l_address.is_empty then
				set_address (l_address)
			end
			if attached a_user_info.city as l_city and then not l_city.is_empty then
				set_city (l_city)
			end
			if attached a_user_info.country as l_country and then not l_country.is_empty then
				set_country (l_country)
			end
			if attached a_user_info.region as l_region and then not l_region.is_empty then
				set_region (l_region)
			end
			if attached a_user_info.postal_code as l_postal_code and then not l_postal_code.is_empty then
				set_postal_code (l_postal_code)
			end
			if attached a_user_info.telephone as l_telephone and then not l_telephone.is_empty then
				set_telephone (l_telephone)
			end
			if attached a_user_info.fax as l_fax and then not l_fax.is_empty then
				set_fax (l_fax)
			end
			if attached a_user_info.position as l_position and then not l_position.is_empty then
				set_position (l_position)
			end
		ensure
			username_set: username = a_user_info.username
		end

feature -- Access : Personal Information

	username: STRING_32
			-- Username.

	first_name: detachable STRING_32
			-- First_name.

	last_name: detachable STRING_32
			-- Last_name.	

	email: detachable STRING_32
			-- Email.

	address: detachable STRING_32
			-- Street address.

	city: detachable STRING_32
			-- City.

	country: detachable STRING_32
			-- Country.

	region: detachable STRING_32
			-- Region.

	postal_code: detachable STRING_32
			-- Postal_code.

	telephone: detachable STRING_32
			-- Telephone.

	fax: detachable STRING_32
			-- Fax.

	position: detachable STRING_32
			-- Position.

	countries: detachable LIST [COUNTRY]
			-- Countries.

	selected_country: detachable STRING_32
			-- Selected country.

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

	set_email (a_email: READABLE_STRING_GENERAL)
			-- Set `email' to `a_email'.
		do
			email := a_email.to_string_32
		ensure
			email_set: attached email as e_email and then e_email.same_string_general (a_email)
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

	set_postal_code (a_postal_code: READABLE_STRING_GENERAL)
			-- Postal_code
		do
			postal_code := a_postal_code.to_string_32
		ensure
			post_code_set: attached postal_code as e_zip and then e_zip.same_string_general (a_postal_code)
		end

	set_telephone (a_telephone: READABLE_STRING_GENERAL)
			-- Set `telephone' to `a_telephone'.
		do
			telephone := a_telephone.to_string_32
		ensure
			telephone_set: attached telephone as e_tel and then e_tel.same_string_general (a_telephone)
		end

	set_fax ( a_fax : READABLE_STRING_GENERAL)
			-- Set `fax' to `a_fax'.
		do
			fax := a_fax.to_string_32
		ensure
			fax_set: attached fax as e_fax and then e_fax.same_string_general (a_fax)
		end

	set_position ( a_position : READABLE_STRING_32)
			-- Set `position' to `a_position'.
		do
			position := a_position
		ensure
			position_set: position = a_position
		end

	set_countries (a_countries: like countries)
			-- Set `countries' to `a_countries'.
		do
			countries := a_countries
			if attached country as l_country and then
			   attached countries as l_countries then
			   	from
			   		l_countries.start
			   	until
			   		l_countries.after
			   	loop
			   		if l_countries.item.name.same_string (l_country) then
			   			selected_country := l_countries.item.id
			   			l_countries.finish
			   		else
			   			l_countries.forth
			   		end
			   	end
			end
		ensure
			countries_set: countries = a_countries
		end


end
