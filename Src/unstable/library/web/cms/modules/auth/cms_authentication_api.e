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

	register_user (u: CMS_TEMP_USER; a_email: READABLE_STRING_8; a_personal_information: READABLE_STRING_GENERAL)
		local
			l_user_api: CMS_USER_API
			l_url_activate: STRING
			l_url_reject: STRING
			l_token: STRING
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
		do
			l_user_api := cms_api.user_api

				-- New temp user
			u.set_personal_information (a_personal_information)
			l_user_api.new_temp_user (u)

				-- Create activation token
			l_token := new_token
			l_user_api.new_activation (l_token, u.id)
			l_url_activate := cms_api.absolute_url (cms_api.administration_path ("/account/activate/" + l_token), Void)
			l_url_reject := cms_api.absolute_url (cms_api.administration_path ("/account/reject/" + l_token), Void)

				-- Send Email to webmaster
			cms_api.log_debug ("registration", "send_register_email", Void)
			create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (cms_api))
			es.send_admin_account_evaluation (u, a_personal_information, l_url_activate, l_url_reject, cms_api.absolute_url ("", Void))

-- TODO: 2018-08-13 add email verification operation.
--			if cms_api.user_has_permission (Void, "account auto activate") then
--					-- Send Email comfirmation to user
--				cms_api.log_debug ("registration", "send_email_confirmation", Void)
--				create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (cms_api))
--				es.send_contact_account_email_verification (a_email, u, cms_api.absolute_url ("/account/confirm-email/" + l_token, Void), cms_api.absolute_url ("", Void))
--			end

				-- Send Email to user
			cms_api.log_debug ("registration", "send_contact_email", Void)
			create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (cms_api))
			es.send_contact_email (a_email, u, cms_api.absolute_url ("", Void))

			cms_api.log ("registration", "new user %"" + html_encoded (u.name) + "%" <" + html_encoded (a_email) + ">", {CMS_LOG}.level_info, Void)
		end

	activate_user (a_temp_user: CMS_TEMP_USER; a_token: READABLE_STRING_GENERAL)
		require
			a_temp_user.has_id
			not a_temp_user.is_active
		local
			l_user_api: CMS_USER_API
			l_temp_id: INTEGER_64
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
		do
			l_temp_id := a_temp_user.id

					-- Valid user_id			
			a_temp_user.set_id (0)
			a_temp_user.mark_active
			l_user_api := cms_api.user_api
			l_user_api.new_user_from_temp_user (a_temp_user)

			if
				not l_user_api.has_error and then
				attached l_user_api.user_by_name (a_temp_user.name) as l_new_user
			then
				if attached a_temp_user.personal_information as l_perso_info then
						-- Keep personal information in profile item!
					l_user_api.save_user_profile_item (l_new_user, "personal_information", l_perso_info)
				end
					-- Delete temporal User
				a_temp_user.set_id (l_temp_id)
				l_user_api.delete_temp_user (a_temp_user)
				l_user_api.remove_activation (a_token)

					-- Send Email
				if attached l_new_user.email as l_email then
					cms_api.log_debug ("activation", "send_contact_activation_confirmation_email", Void)
					create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (cms_api))
					es.send_contact_activation_confirmation_email (l_email, l_new_user, cms_api.site_url)
				end
			else
				error_handler.add_custom_error (-1, "activation error", "Activation failed!")
			end
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

feature -- Hooks

	invoke_get_login_redirection (a_response: CMS_RESPONSE; a_destination_url: detachable READABLE_STRING_8)
		do
			if attached cms_api.hooks.subscribers ({CMS_HOOK_AUTHENTICATION}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_HOOK_AUTHENTICATION} ic.item as h then
						h.get_login_redirection (a_response, a_destination_url)
					end
				end
			end
		end

end
