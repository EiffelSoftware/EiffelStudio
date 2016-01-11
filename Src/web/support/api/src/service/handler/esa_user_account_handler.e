note
	description: "User Account information, personal information and organizational information"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER_ACCOUNT_HANDLER

inherit
	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_FILTER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_account: ESA_ACCOUNT_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached current_user (req) as l_user then
					create l_account.make_from_user_info (api_service.user_account_information (l_user.name))
					l_account.set_countries (api_service.countries)
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).account_information_page (req, res, l_account)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).account_information_page (req, res, Void)
			end
		end



	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_account: ESA_ACCOUNT_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached current_user (req) as l_user then
					l_account := extract_data_from_request (req, l_type, l_user.name)
					if update_user_info (l_account) then
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).post_account_information_page (req, res)
					else
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).account_information_page (req, res, l_account)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).account_information_page (req, res, Void)
			end
		end

feature -- Update User Information

	update_user_info (a_user: ESA_ACCOUNT_VIEW): BOOLEAN
			-- Update user info.
		do
			Result := api_service.update_personal_information (a_user.username, a_user.first_name, a_user.last_name, a_user.position, a_user.address, a_user.city, a_user.country, a_user.region, a_user.postal_code, a_user.telephone, a_user.fax )
		end

feature -- Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_32; a_user: READABLE_STRING_32): ESA_ACCOUNT_VIEW
			-- Is the form data populated?
			-- first_name, last_name, user_email, country, user_region, user_position, user_city, user_address, user_postal_code, user_phone, user_fax
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req, a_user)
			end
		end


	extract_data_from_cj (req: WSF_REQUEST): ESA_ACCOUNT_VIEW
			-- Extract request form CJ data and build a object
			-- register view.
		local
			l_parser: JSON_PARSER
		do
			create Result.make ("TEST")
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY} l_template.item ("data") as l_data then
					--	<"name": "first_name", "prompt": "Frist Name", "value": "{$form.first_name/}">,
					-- 	<"name": "last_name", "prompt": "Last Name", "value": "{$form.last_name/}">,
					--  <"name": "user_email", "prompt": "Email", "value": "{$form.email/}">,
					--  <"name": "country", "prompt": "Country", "value": "{$form.country/}">,
					--  <"name": "user_region", "prompt": "Region", "value": "{$form.region/}">,
					--  <"name": "user_position", "prompt": "Position", "value": "{$form.position/}">,
					--  <"name": "user_city", "prompt": "City", "value": "{$form.city/}">,
					--  <"name": "user_address", "prompt": "Address", "value": "{$form.address/}">,
					--  <"name": "user_post_code", "prompt": "Postal Code", "value": "{$form.postal_code/}">,
					--  <"name": "user_phone", "prompt": "Thelehone", "value": "{$form.telephone/}">,
					--  <"name": "user_fax", "prompt": "Fax", "value": "{$form.fax/}">,

				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("first_name") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_first_name (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (2) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("last_name") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_last_name (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (3) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_email") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_email (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (4) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_region") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_region (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (5) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_position") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_region (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (6) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_city") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_city (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (7) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_address") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_address (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (8) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_postal_code") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_postal_code (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (9) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_phone") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_telephone (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (10) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_fax") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_fax (l_value.item)
				end
			end
		end

	extract_data_from_form (req: WSF_REQUEST; a_user: READABLE_STRING_32 ): ESA_ACCOUNT_VIEW
			-- Extract request form data and build a object account view.
			-- first_name, last_name, user_email, country, user_region, user_position, user_city, user_address, user_postal_code, user_phone, user_fax
		do
			create Result.make (a_user)
			if attached {WSF_STRING} req.form_parameter ("first_name") as l_first_name then
				Result.set_first_name (l_first_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("last_name") as l_last_name then
				Result.set_last_name (l_last_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_email") as l_email then
				Result.set_email (l_email.value)
			end
			if attached {WSF_STRING} req.form_parameter ("country") as l_country then
				Result.set_country (l_country.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_region") as l_region then
				Result.set_region (l_region.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_position") as l_position then
				Result.set_position (l_position.value)
			end
			if  attached {WSF_STRING} req.form_parameter ("user_city") as l_city then
				Result.set_city (l_city.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_address") as l_address then
				Result.set_address (l_address.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_postal_code") as l_postal_code  then
				Result.set_postal_code (l_postal_code.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_phone") as l_phone  then
				Result.set_telephone (l_phone.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_fax") as l_fax  then
				Result.set_fax (l_fax.value)
			end
		end

end
