note
	description: "[
				{ESA_EMAIL_HANDLER}. Handle email change, show a form and also handle the post.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_EMAIL_HANDLER

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
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).change_email (req, res, create {ESA_EMAIL_VIEW})
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).change_email (req, res, Void)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_email: ESA_EMAIL_VIEW
			l_token: STRING
		do
			create l_rhf
			if
				attached current_media_type (req) as l_type
			then
				if
					attached current_user_name (req) as l_user
				then
					l_email := extract_data_from_request (req, l_type)
					if
						l_email.is_valid_form and then
					   	attached l_email.email as l_new_email and then
					   	l_new_email.is_valid_as_string_8 and then
					   	attached api_service.user_account_information (l_user).email as ll_email and then
					  	api_service.user_from_email (l_new_email) = Void
					 then
					   	l_token := (create {SECURITY_PROVIDER}).token
					   	api_service.change_user_email (l_user, l_new_email.to_string_8, l_token)
					   	if api_service.successful then
							email_notification_service.send_email_change_email (ll_email, l_token, req.absolute_script_url (""))
						  	if email_notification_service.successful then
							  	l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).post_email_change_page (req, res)
							else
								l_email.add_error ({STRING_32} "Send Email", email_notification_service.last_error_message)
								l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).change_email (req, res, l_email)
							end
						else
                            l_email.add_error ({STRING_32} "Email", "Could not send email")
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).change_email (req, res, l_email)
						end
					else
						if attached l_email.email as l_email_email and then attached api_service.user_from_email (l_email_email) then
							l_email.add_error ({STRING_32} "Exists", {STRING_32} "The email " + l_email_email + {STRING_32} " it's already used")
						end
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).change_email (req, res, l_email)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).change_email (req, res, Void)
			end
		end

feature -- Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_8): ESA_EMAIL_VIEW
			-- Is the form data populated?
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): ESA_EMAIL_VIEW
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
					--  <"name": "email", "prompt": "Password", "value": "{$form.email/}">,
					--  <"name": "check_email", "prompt": "Re-Type Password", "value": "{$form.check_email/}">,
				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("email") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_email (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (2) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("check_email") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_check_email (l_value.item)
				end
			end
		end

	extract_data_from_form (req: WSF_REQUEST): ESA_EMAIL_VIEW
			-- Extract request form data and build a object email view.
			-- email, check_email.
		do
			create Result
			if attached {WSF_STRING} req.form_parameter ("email") as l_email then
				Result.set_email (l_email.value)
			end
			if attached {WSF_STRING} req.form_parameter ("check_email") as l_check_email then
				Result.set_check_email (l_check_email.value)
			end

		end

end


