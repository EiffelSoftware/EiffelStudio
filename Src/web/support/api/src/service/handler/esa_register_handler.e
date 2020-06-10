note
	description: "[
					{ESA_REGISTER_HANDLER}. Handle user registration where we query for the user email, password, first name and last name.
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
			l_register_view: ESA_REGISTER_VIEW
		do
			create l_register_view
			create l_rhf
			if attached current_media_type (req) as l_type then
				debug
					log.write_information (generator + ".do_get Processing request using media type " + l_type )
				end
                l_register_view.set_questions (api_service.security_questions)
				l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).register_page (req, res, l_register_view)
			else
				log.write_information (generator + ".do_get Processing request unacceptable media type" )
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).register_page (req, res, l_register_view)
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Registe a new user.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_register: ESA_REGISTER_VIEW
			l_successful: BOOLEAN
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				debug
					log.write_information (generator + ".do_post Processing request using media type " + l_type )
				end
				l_register := extract_data_from_request (req, l_type)
				if l_register.is_valid_form then
					l_successful := add_user (l_register, req.absolute_script_url (""))
					if l_successful then
							-- redirect to post register page
						l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).post_register_page (req, res)
					else
							--	"Unable to send email to " + l_register.email + ". Please check email address or contact administrator."
							-- or "Could not create user: Username/Email address already registered."
						remove_user (l_register)
						l_register.set_questions (api_service.security_questions)
						if attached l_register.email as l_email then
							l_register.add_error ("Email", "Unable to send email to " + l_email.to_string_8 + ". Please check email address or contact administrator.")
						end
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).register_page (req, res, l_register)
					end
				else
					l_register.set_questions (api_service.security_questions)
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).register_page (req, res, l_register)
				end
			else
					-- Not acceptable
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).bad_request_page (req,res)
			end
		end


	add_user (a_register: ESA_REGISTER_VIEW; a_host: READABLE_STRING_32): BOOLEAN
			-- Add a new user with `a_register' data, if it's ok.
		local
			l_token: STRING
			l_security: SECURITY_PROVIDER
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
				-- Database length 7 characters.
			l_token := l_token.substring (1, 7)
			if attached a_register.answer as l_answer and then
			   attached a_register.password as l_password and then
			   attached a_register.email as l_email and then
			   attached a_register.first_name as l_first_name and then
			   attached a_register.last_name as l_last_name and then
			   attached a_register.user_name as l_user_name and then
			   attached a_register.question as l_question then
			   Result := api_service.add_user (l_first_name, l_last_name, l_email.to_string_8, l_user_name, l_password, l_answer, l_token, l_question)
			   if Result then
					email_notification_service.send_post_registration_email (l_email, l_token, a_host)
					Result := email_notification_service.successful
			   else
				   	a_register.add_error ("User Creation", "Could not create user: Username/Email address already registered.")
			   end
			end
		end


	remove_user (a_register: ESA_REGISTER_VIEW)
			-- Remove user,
		do
			if attached a_register.user_name as l_user_name then
			   api_service.remove_user (l_user_name)
			end
		end


	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_8): ESA_REGISTER_VIEW
			-- Is the form data populated?
			-- first_name, last_name, user_email, user_name, password, check_password, question, answer_question.
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end


	extract_data_from_cj (req: WSF_REQUEST): ESA_REGISTER_VIEW
			-- Extract request form CJ data and build a object
			-- register view.
		local
			l_parser: JSON_PARSER
		do
			create Result
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY} l_template.item ("data") as l_data then
					--	<"name": "first_name", "prompt": "Frist Name", "value": "{$form.first_name/}">,
					-- 	<"name": "last_name", "prompt": "Last Name", "value": "{$form.last_name/}">,
					--  <"name": "email", "prompt": "Email", "value": "{$form.email/}">,
					--  <"name": "user_name", "prompt": "User Name", "value": "{$form.user_name/}">,
					--  <"name": "password", "prompt": "Password", "value": "{$form.password/}">,
					--  <"name": "check_password", "prompt": "Re-Type Password", "value": "{$form.check_password/}">,
					--  <"name": "question", "prompt": "Question", "value": "{$form.selected_question/}">,
					--  <"name": "answer", "prompt": "Answer", "value": "{$form.answer/}">
				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("first_name") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_first_name (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (2) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("last_name") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_last_name (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (3) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("email") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_email (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (4) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_name") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_user_name (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (5) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("password") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_password (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (6) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("check_password") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_check_password (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (7) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("question") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  and then l_value.item.is_integer then
					Result.set_question (l_value.item.to_integer)
				end
				if attached {JSON_OBJECT} l_data.i_th (8) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("answer") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_answer (l_value.item)
				end
			end
		end

	extract_data_from_form (req: WSF_REQUEST): ESA_REGISTER_VIEW
			-- Extract request form data and build a object
			-- register view.
		do
			create Result
			if attached {WSF_STRING} req.form_parameter ("first_name") as l_first_name then
				Result.set_first_name (l_first_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("last_name") as l_last_name then
				Result.set_last_name (l_last_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_email") as l_user_email then
				Result.set_email (l_user_email.value)
			end
			if attached {WSF_STRING} req.form_parameter ("user_name") as l_user_name then
				Result.set_user_name (l_user_name.value)
			end
			if attached {WSF_STRING} req.form_parameter ("password") as l_password then
				Result.set_password (l_password.value)
			end
			if  attached {WSF_STRING} req.form_parameter ("check_password") as l_check_password then
				Result.set_check_password (l_check_password.value)
			end
			if attached {WSF_STRING} req.form_parameter ("question") as l_question and then
			   l_question.is_integer then
				Result.set_question (l_question.integer_value)
			end
			if attached {WSF_STRING} req.form_parameter ("answer_question") as l_answer then
				Result.set_answer (l_answer.value)
			end
		end
end
