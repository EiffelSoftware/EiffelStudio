note
	description: "[
					{ESA_REGISTER_HANDLER}. Handle user registration where we query  for the user email, password, first name and last name.
				    Also handle create a new user after completing the first step.
				 ]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REGISTER_HANDLER

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
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_register_view: ESA_REGISTER_VIEW
		do
			create l_register_view
			create l_rhf
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
                    l_register_view.set_questions (api_service.security_questions)
					l_rhf.new_representation_handler (esa_config,l_type,media_variants).register_page (req, res, l_register_view)
				end
			else
				l_rhf.new_representation_handler (esa_config,"",media_variants).register_page (req, res, l_register_view)
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Registe a new user
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_register: ESA_REGISTER_VIEW
			l_successful: BOOLEAN
		do
			create l_rhf
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
					l_register := extract_data_from_request (req)
					if l_register.is_valid_form then
						l_successful := add_user (l_register, req.absolute_script_url (""))
						if l_successful then
							-- redirect to post register page
							l_rhf.new_representation_handler (esa_config,l_type,media_variants).post_register_page (req, res)
						else
							--	register_error_ "Unable to send email to " + l_register.email + ". Please check email address or contact administrator."
							remove_user (l_register)
							l_register.set_questions (api_service.security_questions)
							if attached l_register.email as l_email then
								l_register.add_error ("Email", "Unable to send email to " + l_email + ". Please check email address or contact administrator.")
							end
							l_rhf.new_representation_handler (esa_config,l_type,media_variants).register_page (req, res, l_register)
						end
					else
						-- Validation errors				
					end
				else
					-- Media type error	
				end
			else
				-- Not acceptable	
			end
		end


	add_user (a_register: ESA_REGISTER_VIEW; a_host: READABLE_STRING_32): BOOLEAN
			-- Add a new user with `a_register' data, if it's ok.
		local
			l_token: STRING
			l_string: STRING
			l_security: ESA_SECURITY_PROVIDER
			l_encode: URL_ENCODER
		do
			create l_security
			l_token := l_security.token
			create l_encode
			from until l_token.same_string (l_encode.encoded_string (l_token)) loop
				-- Loop ensure that we have a security token that does not contain characters that need encoding.
			    -- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
				-- but the user will need to use an unencoded token if activation has to be done manually.
				l_token := l_security.token
			end
			if attached a_register.answer as l_answer and then
			   attached a_register.password as l_password and then
			   attached a_register.email as l_email and then
			   attached a_register.first_name as l_first_name and then
			   attached a_register.last_name as l_last_name and then
			   attached a_register.user_name as l_user_name and then
			   attached a_register.question as l_question then
			   Result := api_service.add_user (l_first_name, l_last_name, l_email, l_user_name, l_password, l_answer, l_token, l_question)
			   if Result then
					email_service.send_post_registration_email (l_email, l_token, a_host)
					Result := email_service.successful
			   end
			end
		end


	remove_user (a_register: ESA_REGISTER_VIEW)
			-- Remove user
		do
			if attached a_register.user_name as l_user_name then
			   api_service.remove_user (l_user_name)
			end
		end


	extract_data_from_request (req: WSF_REQUEST): ESA_REGISTER_VIEW
			-- Is the form data populated?
			-- first_name, last_name, user_email, user_name, password, check_password, question, answer_question
		do
			create Result
			if attached {WSF_STRING}req.form_parameter ("first_name") as l_first_name then
				Result.set_first_name (l_first_name.value)
			end
			if attached {WSF_STRING}req.form_parameter ("last_name") as l_last_name then
				Result.set_last_name (l_last_name.value)
			end
			if attached {WSF_STRING}req.form_parameter ("user_email") as l_user_email then
				Result.set_email (l_user_email.value)
			end
			if attached {WSF_STRING}req.form_parameter ("user_name") as l_user_name then
				Result.set_user_name (l_user_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("password") as l_password then
				Result.set_password (l_password.value)
			end
			if  attached {WSF_STRING} req.form_parameter ("check_password") as l_check_password then
				Result.set_check_password (l_check_password.value)
			end
			if attached {WSF_STRING}req.form_parameter ("question") as l_question and then
			   l_question.is_integer then
				Result.set_question (l_question.integer_value)
			end
			if attached {WSF_STRING}req.form_parameter ("answer_question") as l_answer then
				Result.set_answer (l_answer.value)
			end
		end






--			-- Register user.
--		local
--			l_retried: BOOLEAN
--			l_string: SYSTEM_STRING
--			l_token: SYSTEM_STRING
--			l_security: EFA_SECURITY_PROVIDER
--		do
--			if is_valid and not l_retried then
--				register_error_label.set_text ("")
--				create l_security
--				l_token := l_security.token
--				from until {SYSTEM_STRING}.equals (l_token, server.url_encode (l_token)) loop
--						-- Loop ensure that we have a security token that does not contain characters that need encoding.
--						-- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
--						-- but the user will need to use an unencoded token if activation has to be done manually.
--					l_token := l_security.token
--				end
--				Data_provider.add_user (register_first_name.text, register_last_name.text, register_email.text, register_username.text.to_lower, register_password.text, register_answer.text, l_token, {SYSTEM_CONVERT}.to_int_32 (register_questions_list.selected_value))
--				if successful then
--					send_post_registration_email (register_email.text, l_token)
--					if successful then
--						register_error_label.set_text ("")
--						response.redirect (login_root (True) + "secure/post_register.aspx")
--					else
--						register_error_label.set_text ("Unable to send email to " + register_email.text + ". Please check email address or contact administrator.")
--						Data_provider.remove_user (register_username.text)
--					end
--				else
--					register_error_label.set_text (last_error_message)
--				end
--			else
--				register_error_label.set_text ("Registration could not complete, check input for invalid values.")
--			end
--		rescue
--			l_retried := True
--			retry
--		end
end
