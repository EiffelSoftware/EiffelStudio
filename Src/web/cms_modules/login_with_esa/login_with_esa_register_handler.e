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

	make (a_mod: CMS_MODULE; a_mod_api: LOGIN_WITH_ESA_API)
		do
			module := a_mod
			make_with_cms_api (a_mod_api.cms_api)
			login_with_esa_api := a_mod_api
		end

feature -- API

	login_with_esa_api: LOGIN_WITH_ESA_API

	module: CMS_MODULE

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_uid: READABLE_STRING_GENERAL
		do
			if attached api.user as u then
				send_already_signed_in (u, req, res)
			elseif req.is_get_request_method then
				send_registration_form (req, res)
			elseif req.is_post_request_method then
				submit_registration_form (req, res)
			else
				send_bad_request (req, res)
			end
		end

	send_already_signed_in (u: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			l_html: STRING
		do
			r := new_generic_response (req, res)
			r.add_notice_message ("You are already signed in as user %"" + html_encoded (api.user_display_name (u)) + "%".")
			r.set_redirection (api.absolute_url ({CMS_AUTHENTICATION_MODULE}.roc_account_location, Void))
			r.set_title ("Account registration")
			r.execute
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
						err := True
						fd.report_invalid_field ("user_name", "User name %"" + html_encoded (l_username) + "%" already taken!")
					end
					if
						attached l_user_api.user_by_email (l_email)
						or else attached l_user_api.temp_user_by_email (l_email)
					then
						err := True
						fd.report_invalid_field ("email", "The email address %"" + html_encoded (l_email) + "%" is already associated with an existing account!")
					end
					if not l_password.same_string (l_password_bis) then
						err := True
						fd.report_invalid_field ("password-bis", "Password mismatched")
					end
					if not err then
						create acc.make_with_username (l_username)
						acc.set_email (l_email)
						acc.set_first_name (l_first_name)
						acc.set_last_name (l_last_name)
						login_with_esa_api.register_esa_account (acc, l_password)
						if login_with_esa_api.has_error then
							fd.report_error ("Registration failed ...!")
							fd.report_error (html_encoded (login_with_esa_api.error_handler.as_string_representation))
						end
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
			fset: WSF_FORM_FIELD_SET
			tf: WSF_FORM_TEXT_INPUT
			pf: WSF_FORM_PASSWORD_INPUT
			ef: WSF_FORM_EMAIL_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
			tpl_p: PATH
		do
			create Result.make (req.percent_encoded_path_info, "esa-registration")
			Result.set_method_post

			create tpl_p.make_from_string ("templates")

			if
				attached api.module_theme_resource_location (module, tpl_p.extended ("signup_header.tpl")) as loc and then
				attached api.resolved_smarty_template_text (loc) as s
			then
				Result.extend_html_text (s)
			end

			create fset.make
			fset.set_legend ("Sign up for an eiffel.com account")
			Result.extend (fset)

			create tf.make ("user_name"); tf.set_label ("User name")
			tf.set_description ("This is your main identifier")
			tf.enable_required
			tf.set_size (32)
			fset.extend (tf)

			create tf.make ("first_name"); tf.set_label ("First name")
			tf.enable_required
			tf.set_size (32)
			fset.extend (tf)

			create tf.make ("last_name"); tf.set_label ("Last name")
			tf.enable_required
			tf.set_size (32)
			fset.extend (tf)

			create pf.make ("password"); pf.set_label ("Password")
			pf.enable_required
			pf.set_size (32)
			fset.extend (pf)
			create pf.make ("password-bis"); pf.set_label ("Password")
			pf.enable_required
			pf.set_description ("Confirm password value.")
			pf.set_size (32)
			fset.extend (pf)

			create ef.make ("email"); ef.set_label ("Email")
			ef.set_description ("You will get an activation code by email to validate your account.")
			ef.enable_required
			ef.set_size (32)
			fset.extend (ef)

			fset.extend_html_text ("<br/>")
			create sub.make_with_text ("op", "Sign up for Eiffel")
			fset.extend (sub)

			if
				attached api.module_theme_resource_location (module, tpl_p.extended ("signup_footer.tpl")) as loc and then
				attached api.resolved_smarty_template_text (loc) as s
			then
				Result.extend_html_text (s)
			end
		end

end
