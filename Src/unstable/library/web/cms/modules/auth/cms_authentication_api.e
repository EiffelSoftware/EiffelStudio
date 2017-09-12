note
	description: "Summary description for {CMS_AUTHENTICATION_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_API

inherit
	CMS_AUTH_API_I

create {CMS_AUTHENTICATION_MODULE}
	make

feature -- Token Generation

	register_user (u: CMS_TEMP_USER; a_email: READABLE_STRING_8; a_personal_information: READABLE_STRING_8)
		local
			l_user_api: CMS_USER_API
			l_url_activate: STRING
			l_url_reject: STRING
			l_token: STRING
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
		do
			l_user_api := cms_api.user_api
			l_user_api.new_temp_user (u)
				-- Create activation token
			l_token := new_token
			l_user_api.new_activation (l_token, u.id)
			l_url_activate := cms_api.absolute_url ("/account/activate/" + l_token, void)
			l_url_reject := cms_api.absolute_url ("/account/reject/" + l_token, Void)
				-- Send Email to webmaster
			cms_api.log_debug ("registration", "send_register_email", Void)
			create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (cms_api))
			es.send_account_evaluation (u, a_personal_information, l_url_activate, l_url_reject, cms_api.absolute_url ("", Void))

				-- Send Email to user
			cms_api.log_debug ("registration", "send_contact_email", Void)
			create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (cms_api))
			es.send_contact_email (a_email, u, cms_api.absolute_url ("", Void))

			cms_api.log ("registration", {STRING_32} "new user %"" + u.name + "%" <" + a_email + ">", {CMS_LOG}.level_info, Void)
		end

	new_token: STRING
			-- Generate a new token activation token
		local
			l_token: STRING
			l_security: SECURITY_PROVIDER
			l_encode: URL_ENCODER
		do
			create l_security
			l_token := l_security.token
			create l_encode
			from
			until
				l_token.same_string (l_encode.encoded_string (l_token))
			loop
					-- Loop ensure that we have a security token that does not contain characters that need encoding.
					-- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
					-- but the user will need to use an unencoded token if activation has to be done manually.
				l_token := l_security.token
			end
			Result := l_token
		end

end
