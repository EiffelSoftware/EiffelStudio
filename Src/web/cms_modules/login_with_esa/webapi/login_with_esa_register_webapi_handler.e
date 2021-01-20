note
	description: "Summary description for {LOGIN_WITH_ESA_REGISTER_WEBAPI_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_REGISTER_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_HANDLER

create
	make_with_esa_api

feature {NONE} -- Creation

	make_with_esa_api (a_esa_api: LOGIN_WITH_ESA_API)
		do
			login_with_esa_api := a_esa_api
			make (a_esa_api.cms_api)
		end

	login_with_esa_api: LOGIN_WITH_ESA_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_post_request_method then
				register_esa_user (req, res)
			else
				new_bad_request_error_response (Void, req, res).execute
			end
		end

	register_esa_user (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: CMS_FORM
			rep: like new_response
			l_user_api: CMS_USER_API
			l_email: STRING_8
			acc: ESA_ACCOUNT
		do
			if
				api.has_permission ("register with esa") and then
				req.is_post_request_method
			then
				f := new_registration_form (req)

				rep := new_response (req, res)
				f.process (rep)
				if
					attached f.last_data as fd and then not fd.has_error and then
					attached fd.string_item ("first_name") as l_first_name and then
					attached fd.string_item ("last_name") as l_last_name and then
					attached fd.string_item ("user_name") as l_username and then
					attached fd.string_item ("password") as l_password and then
					attached fd.string_item ("email") as f_email
				then
					l_email := f_email.to_string_8

					l_user_api := api.user_api
					if
						attached l_user_api.user_by_name (l_username)
						or else attached l_user_api.temp_user_by_name (l_username)
					then
							-- Username already exists.
						fd.report_invalid_field ("user_name", "User name already exists!")
					elseif
						attached l_user_api.user_by_email (l_email)
						or else attached l_user_api.temp_user_by_email (l_email)
					then
							-- Email already exists.
						fd.report_invalid_field ("email", "An account is already associated with that email address!")
					elseif
						not attached fd.string_item ("password-bis") as l_password_bis or else
						l_password.same_string (l_password_bis)
					then
						create acc.make_with_username (l_username)
						acc.set_email (l_email)
						acc.set_first_name (l_first_name)
						acc.set_last_name (l_last_name)
						login_with_esa_api.register_esa_account (acc, l_password)
						if login_with_esa_api.has_error then
							fd.report_error ("Registration with ESA failed ...!")
						end
					else
						fd.report_invalid_field ("password-bis", "Password mismatched")
					end
					if fd.has_error then
						rep := new_bad_request_error_response ("Issue with your application, invalid or missing values!", req, res)
						rep.add_string_field ("status", "failed")
					else
						rep.add_string_field ("status", "succeed")
						rep.add_string_field ("information", "Waiting for activation")
						rep.add_self (req.percent_encoded_path_info)
					end
				else
					rep := new_access_denied_error_response ("Issue with your application, invalid or missing values!", req, res)
				end
			else
				rep := new_permissions_access_denied_error_response (<<"account register">>, "You can also contact the webmaster to ask for an account.", req, res)
			end
			rep.execute
		end

feature -- Forms		

	new_registration_form (req: WSF_REQUEST): CMS_FORM
		local
			tf: WSF_FORM_TEXT_INPUT
			pf: WSF_FORM_PASSWORD_INPUT
			ef: WSF_FORM_EMAIL_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "esa-registration")
			Result.set_method_post
			create tf.make ("user_name"); tf.enable_required
			Result.extend (tf)

			create tf.make ("first_name"); tf.enable_required
			Result.extend (tf)

			create tf.make ("last_name"); tf.enable_required
			Result.extend (tf)

			create pf.make ("password"); pf.enable_required
			Result.extend (pf)
			create pf.make ("password-bis");
			Result.extend (pf)

			create ef.make ("email"); ef.enable_required
			Result.extend (ef)
		end

end
