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

	make (a_username: STRING)
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

	username: STRING
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

	countries: detachable LIST [COUNTRY]
			-- Countries.

	selected_country: detachable STRING
			-- Selected country.

feature -- Change Element

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
