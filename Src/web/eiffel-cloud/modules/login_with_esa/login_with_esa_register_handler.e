note
	description: "Summary description for {LOGIN_WITH_ESA_REGISTER_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_REGISTER_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod_api: LOGIN_WITH_ESA_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			login_with_esa_api := a_mod_api
		end

feature -- API

	login_with_esa_api: LOGIN_WITH_ESA_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_uid: READABLE_STRING_GENERAL
		do
			if req.is_get_request_method then
				send_registration_form (req, res)
			elseif req.is_post_request_method then
				submit_registration_form (req, res)
			else
				send_bad_request (req, res)
			end
		end

	send_registration_form (req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			is_get: req.is_get_request_method
		local
			r: like new_generic_response
			f: like new_registration_form
			l_html: STRING
		do
			r := new_generic_response (req, res)
			f := new_registration_form (req)

			create l_html.make_empty
			f.append_to_html (r.wsf_theme, l_html)

			r.set_title ("Account registration")
			r.set_main_content (l_html)
			r.execute
		end

	submit_registration_form (req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			is_post: req.is_post_request_method
		local
			r: like new_generic_response
			acc: ESA_ACCOUNT
			l_user_api: CMS_USER_API
			f: like new_registration_form
			l_html: STRING
			err: BOOLEAN
			e: STRING
		do
			r := new_generic_response (req, res)
			create l_html.make_empty

			f := new_registration_form (req)
			f.process (r)
			if attached f.last_data as fd and then not fd.has_error then
				if
					attached fd.string_item ("first_name") as l_first_name and then
					attached fd.string_item ("last_name") as l_last_name and then
					attached fd.string_item ("user_name") as l_username and then
					attached fd.string_item ("password") as l_password and then
					attached fd.string_item ("password-bis") as l_password_bis and then
					attached fd.string_item ("email") as l_email
				then
					l_user_api := api.user_api
					if
						attached l_user_api.user_by_name (l_username)
						or else attached l_user_api.temp_user_by_name (l_username)
					then
						fd.report_invalid_field ("user_name", "User name already taken!")
					elseif
						attached l_user_api.user_by_email (l_email)
						or else attached l_user_api.temp_user_by_email (l_email)
					then
						fd.report_invalid_field ("email", "An account is already associated with that email address!")
					elseif
						l_password.same_string (l_password_bis)
					then
						create acc.make_with_username (l_username)
						acc.set_email (l_email)
						acc.set_first_name (l_first_name)
						acc.set_last_name (l_last_name)
						login_with_esa_api.register_esa_account (acc, l_password)
						if login_with_esa_api.has_error then
							fd.report_error ("Registration failed ...!")
							fd.report_error (html_encoded (login_with_esa_api.error_handler.as_string_representation))
						end
					else
						fd.report_invalid_field ("password-bis", "Password mismatched")
					end
				else
					fd.report_error ("Issue with your application, invalid or missing values!")
				end
				err := fd.has_error
				if err and then attached fd.errors as err_lst then
					across
						err_lst as ic
					loop
						create e.make_empty
						if attached ic.item.field as l_field then
							e.append_character ('%'')
							e.append (l_field.name)
							e.append_character ('%'')
						end
						if attached ic.item.message as l_mesg then
							if not e.is_empty then
								e.append_character (':')
								e.append_character (' ')
							end
							e.append (l_mesg)
						end
						r.add_error_message (e)
					end
					fd.apply_to_associated_form
				end
			else
				err := True
			end
			if err then
				f.append_to_html (r.wsf_theme, l_html)
				r.add_error_message ("Error occurred!")
				r.set_title ("Account registration")
				r.set_value ("redirection", "toto")
				r.set_value ("location", "toto")
			else
				r.add_success_message ("Account created, check your email inbox to validate your registration.")
				r.set_value ("redirection", "toto")
			end
			r.set_main_content (l_html)
			r.execute
		end

feature -- Forms

	new_registration_form (req: WSF_REQUEST): CMS_FORM
		local
			tf: WSF_FORM_TEXT_INPUT
			pf: WSF_FORM_PASSWORD_INPUT
			ef: WSF_FORM_EMAIL_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "esa-registration")
			Result.set_method_post
			create tf.make ("user_name"); tf.set_label ("User name")
			tf.enable_required
			tf.set_size (32)
			Result.extend (tf)

			create tf.make ("first_name"); tf.set_label ("First name")
			tf.enable_required
			tf.set_size (32)
			Result.extend (tf)

			create tf.make ("last_name"); tf.set_label ("Last name")
			tf.enable_required
			tf.set_size (32)
			Result.extend (tf)

			create pf.make ("password"); pf.set_label ("Password")
			pf.enable_required
			pf.set_size (32)
			Result.extend (pf)
			create pf.make ("password-bis"); pf.set_label ("Password")
			pf.enable_required
			pf.set_description ("Confirm password value.")
			pf.set_size (32)
			Result.extend (pf)

			create ef.make ("email"); ef.set_label ("Email")
			ef.enable_required
			ef.set_size (32)
			Result.extend (ef)

			create sub.make_with_text ("op", "Register")
			Result.extend (sub)
		end

end
