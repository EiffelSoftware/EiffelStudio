note
	description: "Handle Login using Session Authentication with Cookies."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGIN_SESSION_HANDLER

inherit
	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_FILTER


	WSF_RESOURCE_HANDLER_HELPER
		redefine
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

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_token: STRING
			l_cookie: WSF_COOKIE
			l_time: DATE_TIME
		do
			if
				attached {WSF_STRING} req.form_parameter ("username") as l_username and then
				attached {WSF_STRING} req.form_parameter ("password") as l_password and then
				attached {WSF_STRING} req.form_parameter ("remember_me") as l_remember_me
			then
				if
--					api_service.login_valid (l_username.value, l_password.value) and then
--					api_service.is_active (l_username.value) and then
--					attached api_service.user_from_username (l_username.value) as l_user
					attached api_service.user_login_valid (l_username.value, l_password.value) as l_user
				then
					l_token := generate_token
					create l_cookie.make (esa_session_token, l_token)
					if l_remember_me.value.to_boolean then
							-- Set max-age and expiration_date if remember_me
							-- in other case, set the cookie to session.
						l_cookie.set_max_age (cookie_service.remember_me_max_age.as_integer_32)
						create l_time.make_now_utc
						l_time.second_add (cookie_service.remember_me_max_age.as_integer_32)
						l_cookie.set_expiration_date (l_time)
						api_service.new_user_session_auth (l_token, l_user, cookie_service.remember_me_max_age.as_integer_32)
					else
						api_service.new_user_session_auth (l_token, l_user, cookie_service.default_max_age.as_integer_32)
					end
					l_cookie.set_path ("/")
					res.add_cookie (l_cookie)
					req.set_execution_variable ("user", l_user)
				end
			end
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached {READABLE_STRING_32} current_user_name (req) as l_user and then api_service.is_active (l_user) then
					debug
						log.write_information (generator + ".do_get Processing Login request using media_type: "+ l_type +" User: " + l_user.to_string_8)
					end
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).login_page (req, res)
				else
					log.write_alert (generator + ".do_get Processing Login request using media_type: "+ l_type + " Could not login, the user does not exist or is not active!")
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).login_page (req, res)
			end
		end


	generate_token: STRING
			-- Generate token to use in a Session.
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
			Result := l_token
		end
end
