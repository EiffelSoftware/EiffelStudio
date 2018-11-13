note
	description: "Summary description for {CMS_USER_REGISTER_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_REGISTER_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_HANDLER

create
	make_with_auth_api

feature {NONE} -- Initialization

	make_with_auth_api (a_auth_api: CMS_AUTHENTICATION_API)
		do
			auth_api := a_auth_api
			make (a_auth_api.cms_api)
		end

	auth_api: CMS_AUTHENTICATION_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_post_request_method then
				register_user (req, res)
			else
				new_bad_request_error_response (Void, req, res).execute
			end
		end

	register_user (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: CMS_FORM
			rep: like new_response
			l_user_api: CMS_USER_API
			u: CMS_TEMP_USER
			l_exist: BOOLEAN
			l_email: READABLE_STRING_8
		do
			if
				api.has_permission ("account register") and then
				req.is_post_request_method
			then
				create f.make (req.percent_encoded_path_info, "roccms-user-register")
				f.extend_text_field ("name", Void)
				f.extend_password_field ("password", Void)
				f.extend_text_field ("email", Void)
				f.extend_text_field ("personal_information", Void)

				rep := new_response (req, res)
				f.process (rep)
				if
					attached f.last_data as fd and then not fd.has_error and then
					attached fd.string_item ("name") as l_name and then
					attached fd.string_item ("password") as l_password and then
					attached fd.string_item ("email") as s_email and then
					attached fd.string_item ("personal_information") as l_personal_information
				then
					if s_email.is_valid_as_string_8 then
						l_email := s_email.to_string_8
						l_user_api := api.user_api
						if attached l_user_api.user_by_name (l_name) or else attached l_user_api.temp_user_by_name (l_name) then
								-- Username already exists.
							fd.report_invalid_field ("name", "User name already exists!")
							l_exist := True
						end
						if attached l_user_api.user_by_email (l_email) or else attached l_user_api.temp_user_by_email (l_email) then
								-- Email already exists.
							fd.report_invalid_field ("email", "An account is already associated with that email address!")
							l_exist := True
						end
						if fd.has_error or l_exist then
							rep := new_bad_request_error_response ("User name or email is already taken!", req, res)
						else
								-- New temp user
							create u.make (l_name)
							u.set_email (l_email)
							u.set_password (l_password)
							u.set_personal_information (l_personal_information)

							auth_api.register_user (u, l_email, l_personal_information)
								-- Until it is activated, this is not a real user.
--							add_user_links_to (u, rep)
							rep.add_string_field ("status", "succeed")
							rep.add_string_field ("information", "Waiting for activation")
							rep.add_self (req.percent_encoded_path_info)
						end
					else
						rep := new_access_denied_error_response ("Invalid email", req, res)
					end
				else
					rep := new_access_denied_error_response ("There were issue with your application, invalid or missing values.", req, res)
				end
			else
				rep := new_permissions_access_denied_error_response (<<"account register">>, "You can also contact the webmaster to ask for an account.", req, res)
			end
			rep.execute
		end


end
