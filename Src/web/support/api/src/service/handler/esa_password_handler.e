note
	description: "[
					This handle it's in charge to show a form to change password.
					Completed this step also handle the form submission.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_PASSWORD_HANDLER

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
			-- Execute request handler.
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached current_user (req) as l_user then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).change_password (req, res, create {ESA_PASSWORD_VIEW})
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).change_password (req, res, Void)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_password: ESA_PASSWORD_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached current_user_name (req) as l_user then
					l_password := extract_data_from_request (req, l_type)
					if l_password.is_valid_form and then
					   attached l_password.password as l_new_password and then
					   attached api_service.user_account_information (l_user).email as l_email then
						api_service.update_password (l_email, l_new_password)
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).post_account_information_page (req, res)
					else
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).change_password (req, res, l_password)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).change_password (req, res, Void)
			end
		end

feature -- Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_32): ESA_PASSWORD_VIEW
			-- Is the form data populated?
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): ESA_PASSWORD_VIEW
			-- Extract request form CJ data and build a object
			-- password view.
		local
			l_parser: JSON_PARSER
		do
			create Result
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY}l_template.item ("data") as l_data then
					--  <"name": "password", "prompt": "Password", "value": "{$form.password/}">,
					--  <"name": "check_password", "prompt": "Re-Type Password", "value": "{$form.check_password/}">,
				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("password") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_password (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (2) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("check_password") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_check_password (l_value.item)
				end
			end
		end

	extract_data_from_form (req: WSF_REQUEST): ESA_PASSWORD_VIEW
			-- Extract request form data and build a object password view.
			-- password, check_password.
		do
			create Result
			if attached {WSF_STRING}req.form_parameter ("password") as l_password then
				Result.set_password (l_password.value)
			end
			if attached {WSF_STRING}req.form_parameter ("check_password") as l_check_password then
				Result.set_check_password (l_check_password.value)
			end
		end

end
