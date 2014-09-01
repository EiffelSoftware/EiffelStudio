note
	description: "[
			]"

class
	USER_NEW_PASSWORD_CMS_EXECUTION

inherit
	CMS_EXECUTION

	USER_MODULE_LIB

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			f: CMS_FORM
			u: detachable CMS_USER
			fd: detachable WSF_FORM_DATA
		do
			set_title ("Request new password")
			create b.make_empty
			if not request.is_post_request_method and authenticated then
				u := user
				initialize_primary_tabs (u)
				if u /= Void then
					if attached u.email as l_email then
						f := new_password_form (url (request.path_info, Void), "new-password")
						b.append ("Password reset instructions will be mailed to <em>" + l_email + "</em>. You must " +  link ("log out", "/user/logout", Void)  + " to use the password reset link in the e-mail.")
						f.append_to_html (theme, b)
					else
						b.append ("Your account does not have any email address set!")
						set_redirection (url ("/user/"+ u.id.out +"/edit", Void))
					end
				else
					b.append ("Unexpected issue")
				end
			else
				f := new_password_form (url (request.path_info, Void), "new-password")
				if request.is_post_request_method then
					f.validation_actions.extend (agent password_form_validate)
					f.submit_actions.extend (agent password_form_submit (?, b))
					f.process (Current)
					fd := f.last_data
				else
					initialize_primary_tabs (Void)
				end

				f.append_to_html (theme, b)
			end
			set_main_content (b)
		end

	password_form_validate (fd: WSF_FORM_DATA)
		local
			u: detachable CMS_USER
		do
			if attached {WSF_STRING} fd.item ("name") as s_name then
				u := service.storage.user_by_name (s_name.value)
				if u = Void then
					u := service.storage.user_by_email (s_name.value)
					if u = Void then
						fd.report_invalid_field ("name", "Sorry, " + html_encoded (s_name.value)+ " is not recognized as a user name or an e-mail address.")
					end
				end
			end
			fd.add_cached_value ("user", u)
			initialize_primary_tabs (u)
		end

	password_form_submit (fd: WSF_FORM_DATA; b: STRING)
		local
			e: detachable CMS_EMAIL
			l_uuid: UUID
		do
			debug
				across
					fd as c
				loop
					b.append ("<li>" +  html_encoded (c.key) + "=")
					if attached c.item as v then
						b.append (html_encoded (v.string_representation))
					end
					b.append ("</li>")
				end
			end
			if attached {CMS_USER} fd.cached_value ("user") as u then
				if attached u.email as l_mail_address then
					l_uuid := (create {UUID_GENERATOR}).generate_uuid
					e := new_password_email (u, l_mail_address, l_uuid.out)
					u.set_data_item ("new_password_extra", l_uuid.out)
					service.storage.save_user (u)
					service.mailer.safe_process_email (e)
					add_success_message ("Further instructions have been sent to your e-mail address.")
					set_redirection (url ("/user", Void))
				else
					add_error_message ("No email is associated with the requested account. Please contact the webmaster for help.")
					set_redirection (url ("/user", Void))
				end
			else
				add_error_message ("User not defined!")
			end
		end

	new_password_form (a_url: READABLE_STRING_8; a_name: STRING): CMS_FORM
		require
			attached user as l_auth_user implies l_auth_user.has_email
		local
			u: like user
			f: CMS_FORM
			ti: WSF_FORM_TEXT_INPUT
			th: WSF_FORM_HIDDEN_INPUT
			ts: WSF_FORM_SUBMIT_INPUT
			err: BOOLEAN
		do
			create f.make (a_url, a_name)
			u := user
			if u = Void then
				create ti.make ("name")
				ti.set_label ("Username or e-mail address")
				ti.set_is_required (True)
				f.extend (ti)
			elseif attached u.email as l_mail then
				create th.make ("name")
				th.set_default_value (l_mail)
				th.set_is_required (True)
				f.extend (th)
			else
				f.extend_html_text ("The associated account has no e-mail address.")
				err := True
			end

			if not err then
				create ts.make ("op")
				ts.set_default_value ("E-mail new password")
				f.extend (ts)
			end

			Result := f
		end

	new_password_email (u: CMS_USER; a_mail_address: STRING; a_extra: READABLE_STRING_8): CMS_EMAIL
		local
			b: STRING
			opts: CMS_URL_API_OPTIONS
			dt: detachable DATE_TIME
		do
			create b.make_empty
			create opts.make_absolute

			b.append ("A request to reset the password for your account has been made at " + service.site_name + ".%N")
			b.append ("You may now log in by clicking this link or copying and pasting it to your browser:%N%N")
			dt := u.last_login_date
			if dt = Void then
				dt := u.creation_date
			end
			b.append (url ("/user/reset/" + u.id.out + "/" + unix_timestamp (dt).out + "/" + a_extra, opts))
			b.append ("%N")
			b.append ("%N")
			b.append ("This link can only be used once to log in and will lead you to a page where you can set your password. It expires after one day and nothing will happen if it's not used.%N")
			b.append ("%N%N-- The %"" + service.site_name + "%" team")

			create Result.make (service.site_email, a_mail_address, "Account details for " + u.name + " at " + service.site_name, b)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
