note
	description: "Handler used to initialize the workflow to reset the password for a given user."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_PASSWORD_REMINDER_HANDLER

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
				debug
					log.write_information (generator + ".do_get Processing request using media type " + l_type )
				end
     			l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).reminder_page (req, res, Void)
			else
				log.write_information (generator + ".do_get Processing request unacceptable media type" )
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).reminder_page (req, res, Void)
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Send a new password.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_user_info, l_email: READABLE_STRING_32
			l_error: detachable STRING;
			l_token: STRING
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				debug
					log.write_information (generator + ".do_post Processing request using media type " + l_type )
				end
				l_user_info:= extract_data_from_request (req, l_type)
				l_email := email_from_user_info (l_user_info)


				if attached api_service.token_from_email (l_email) then
							-- Account not activated
					l_error := "Account not activated"
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).reminder_page (req, res, l_error)
				else
					if
						attached api_service.question_from_email (l_email.to_string_8) and then
						attached api_service.user_from_email (l_email) as l_user
					then
							-- Email address exist send email with a link
							-- to reactivate his password.
						l_token := (create {SECURITY_PROVIDER}).token

						api_service.change_password (l_user.user_name, l_email, l_token)
								--  detachable TUPLE [first_name: STRING; last_name: STRING; user_name: STRING] then
						email_notification_service.send_password_reset (l_email, message_change_password (l_token, l_user, req))
						if email_notification_service.successful then
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).post_reminder_page (req, res, l_email)
						else
							l_error := email_notification_service.last_error_message
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).reminder_page (req, res, l_error)
						end
					else
						l_error := "User does not exist for the given email/username"
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).reminder_page (req, res, l_error)
					end
				end
			else
					-- Not acceptable
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).bad_request_page (req,res)
			end
		end


	email_from_user_info (a_data: READABLE_STRING_32): STRING_32
			-- Retrieve user email from request data.
		do
				-- Check if the user data represents an email.
			if attached api_service.user_from_email (a_data) then
				Result := a_data
			elseif attached {USER_INFORMATION} api_service.user_account_information (a_data) as l_user_info and then attached l_user_info.email as l_email then
				Result := l_email
			else
				Result := a_data
			end
		end


	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_8): READABLE_STRING_32
			-- Is the form data populated?
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): READABLE_STRING_32
			-- Extract request form CJ data.
		local
			l_parser: JSON_PARSER
		do
			Result := ""
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY} l_template.item ("data") as l_data and then
					--	<"name": "email", "prompt": "Email", "value": "{$form.first_name/}">,
			   attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				l_name.item.same_string ("email") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value
			 then
				Result := l_value.item
			end
		end

	extract_data_from_form (req: WSF_REQUEST): READABLE_STRING_32
			-- Extract request form data.
		do
			Result := ""
			if attached {WSF_STRING} req.form_parameter ("email") as l_email then
				Result := l_email.value
			end
		end

	message_change_password (a_token: STRING; a_user: TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]; req: WSF_REQUEST): STRING
			-- Username and Password e-mail content.
		do
			create Result.make (1024)
			Result.append ("Dear ")
			Result.append (a_user.first_name)
			Result.append (",%NYou have requested a new password at support.eiffel.com %N%N")
			Result.append ("* Username: ")
			Result.append (a_user.user_name)
			Result.append ("%NTo complete your request, please click on the following link to generate a new password ")
			Result.append (req.absolute_script_url (""))
			Result.append ("/password-reset?token=")
			Result.append (a_token)
			Result.append ("%N%NThank you,%N%N--%NThe eiffel.com Team%N%N------------------------------------------------------------%N")
		end

end
