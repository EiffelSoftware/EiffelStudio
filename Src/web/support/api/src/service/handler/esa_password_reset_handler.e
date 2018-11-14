note
	description: "[
					Handle password reset, show a form and also handle the post.
				    ]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_PASSWORD_RESET_HANDLER

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
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_view: ESA_PASSWORD_RESET_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached {WSF_STRING} req.query_parameter ("token") as l_token then
					create l_view
					if api_service.successful then
						l_view.set_token (l_token.url_encoded_value)
					else
						l_view.put_error (api_service.last_error_message, "Error")
					end
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).confirm_change_password (req, res, l_view)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).confirm_change_password (req, res, Void)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_password: ESA_PASSWORD_RESET_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				l_password := extract_data_from_request (req, l_type)
				if
					l_password.is_valid_form and then
					attached l_password.token as l_token and then
				   	attached l_password.password as l_new_password and then
				   	attached api_service.email_from_reset_password (l_token) as l_email then
				   	api_service.update_password (l_email, l_new_password)
				   	l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).home_page_redirect (req, res)
				else
					l_password.put_error ("Wrong token or passwords does not match", "error")
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).confirm_change_password (req, res, l_password)
				end
			else
				l_rhf.new_representation_handler (esa_config,Empty_string, media_type_variants (req)).bad_request_page (req, res)
			end
		end


feature -- Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_8): ESA_PASSWORD_RESET_VIEW
			-- Is the form data populated?
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): ESA_PASSWORD_RESET_VIEW
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
					l_name.item.same_string ("token") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_token (l_value.item)
				end
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

	extract_data_from_form (req: WSF_REQUEST): ESA_PASSWORD_RESET_VIEW
			-- Extract request form data and build a object password view.
			-- token, password, check_password.
		do
			create Result
			if attached {WSF_STRING}req.form_parameter ("token") as l_token then
				Result.set_token (l_token.value)
			end
			if attached {WSF_STRING}req.form_parameter ("password") as l_password then
				Result.set_password (l_password.value)
			end
			if attached {WSF_STRING}req.form_parameter ("check_password") as l_check_password then
				Result.set_check_password (l_check_password.value)
			end
		end

end
