note
	description: "[
			]"

class
	USER_REGISTER_CMS_EXECUTION

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
			fd: detachable WSF_FORM_DATA
		do
			set_title ("Create new account")
			create b.make_empty
			if authenticated then
				initialize_primary_tabs (user)
				b.append ("You are already " + link ("signed in", "/user", Void) + ", please " + link ("signout", "/user/logout", Void) + " before trying to " + link ("register a new account", "/account/register", Void) + ".")
				set_redirection (url ("/user", Void))
			else
				f := registration_form (url (request.path_info, Void), "user-register")

				if request.is_post_request_method then
					f.validation_actions.extend (agent registration_form_validate)
					f.submit_actions.extend (agent registration_form_submitted (?, b))

					f.process (Current)
					fd := f.last_data
				else
					f.prepare (Current)
				end
				if fd /= Void and then fd.is_valid then
					set_main_content (b)
				else
					initialize_primary_tabs (user)
					f.append_to_html (theme, b)
				end
			end
			set_main_content (b)
		end

	registration_form_validate (fd: WSF_FORM_DATA)
		local
			u: detachable CMS_USER
		do
			if attached {WSF_STRING} fd.item ("username") as s_username then
				u := service.storage.user_by_name (s_username.value)
				if u /= Void then
					fd.report_invalid_field ("username", "User already exists!")
				end
			end
			if attached {WSF_STRING} fd.item ("email") as s_email then
				u := service.storage.user_by_email (s_email.value)
				if u /= Void then
					fd.report_invalid_field ("email", "Email is already used!")
				end
			end
		end

	registration_form_submitted (fd: WSF_FORM_DATA; buf: STRING)
		local
			b: STRING
			u: detachable CMS_USER
			up: detachable CMS_USER_PROFILE
			e: detachable CMS_EMAIL
			l_pass: detachable READABLE_STRING_32
			l_uuid: UUID
		do
			b := buf
			across
				fd as c
			loop
				b.append ("<li>" +  html_encoded (c.key) + "=")
				if attached c.item as v then
					b.append (html_encoded (v.string_representation))
				end
				b.append ("</li>")
			end
			if attached {WSF_STRING} fd.item ("username") as s_username then
				u := service.storage.user_by_name (s_username.value)

				create u.make_new (s_username.value)
				if attached {WSF_STRING} fd.item ("password") as s_password then
					u.set_password (s_password.value)
					l_pass := u.password
				end
				if attached {WSF_STRING} fd.item ("email") as s_email then
					u.set_email (s_email.value)
				end

				if attached {WSF_STRING} fd.item ("note") as s_note then
					create up.make
					up.force (s_note.value, "note")
					u.set_profile (up)
				end

				l_uuid := (create {UUID_GENERATOR}).generate_uuid
				u.set_data_item ("new_password_extra", l_uuid.out)

				service.storage.save_user (u)
				if attached u.email as l_mail_address then
					e := new_registration_email (l_mail_address, u, l_pass, l_uuid.out)
					service.mailer.safe_process_email (e)
				end
				e := new_user_account_email (service.site_email, u)
				service.mailer.safe_process_email (e)

				login (u, request)
				set_redirection (url ("/user", Void))
			end
		end

	registration_form (a_url: READABLE_STRING_8; a_name: STRING): CMS_FORM
		local
			f: CMS_FORM
			ti: WSF_FORM_TEXT_INPUT
			tp: WSF_FORM_PASSWORD_INPUT
			ta: WSF_FORM_TEXTAREA
			ts: WSF_FORM_SUBMIT_INPUT
		do
			create f.make (a_url, a_name)

			create ti.make ("username")
			ti.set_label ("Username")
			ti.set_is_required (True)
			ti.set_validation_action (agent (fd: WSF_FORM_DATA)
					do
						if attached {WSF_STRING} fd.item ("username") as f_username and then f_username.value.count >= 5 then
						else
							fd.report_invalid_field ("username", "Username should contain at least 5 characters!")
						end
					end)
			f.extend (ti)

			f.extend_html_text ("<br/>")

			create tp.make ("password")
			tp.set_label ("Password")
			tp.set_is_required (True)
			f.extend (tp)

			f.extend_html_text ("<br/>")

			create ti.make ("email")
			ti.set_label ("Valid email address")
			ti.set_is_required (True)
			f.extend (ti)

			f.extend_html_text ("<br/>")

			create ta.make ("note")
			ta.set_label ("Additional note about you")
			ta.set_description ("You can use this input to tell us more about you")
			ta.set_is_required (False)
			f.extend (ta)

			f.extend_html_text ("<br/>")

			create ts.make ("Register")
			ts.set_default_value ("Register")
			f.extend (ts)

			Result := f
		end

	new_registration_email (a_mail_address: STRING; u: CMS_USER; a_password: detachable like {CMS_USER}.password; a_extra: READABLE_STRING_8): CMS_EMAIL
		require
			has_clear_password: u.password /= Void or else a_password /= Void
		local
			p: detachable like {CMS_USER}.password
			b: STRING
			opts: CMS_URL_API_OPTIONS
		do
			p := a_password
			if p = Void then
				p := u.password
			end

			create b.make_from_string (u.name + "%N" + "Thank you for registering at " + service.site_name + ". ")
			create opts.make_absolute
--			if p /= Void then
				b.append ("You may now log in to " + url ("/user", opts) + " using your username %""+ u.name +"%" and password%N")
--				b.append ("%Nusername: " + u.name + "%Npassword: " + p + "%N%N")
--			end
			b.append ("You may also log in by clicking on this link or copying and pasting it in your browser:%N%N")
			b.append (url ("/user/reset/" + u.id.out + "/" + unix_timestamp (u.creation_date).out + "/" + a_extra, opts))
--			b.append (url ("/user/reset/" + u.id.out + "/" + unix_timestamp (u.creation_date).out + "/", opts))
			b.append ("%N%NThis is a one-time login, so it can be used only once.%N%NAfter logging in, you will be redirected to " + url ("/user/" + u.id.out + "/edit", opts) + " so you can change your password.%N")
			b.append ("%N%N-- The %"" + service.site_name + "%" team")

			create Result.make (service.site_email, a_mail_address, "Account details for " + u.name + " at " + service.site_name, b)
		end

	new_user_account_email (a_mail_address: STRING; u: CMS_USER): CMS_EMAIL
		local
			b: STRING
			opts: CMS_URL_API_OPTIONS
		do
			create b.make_from_string ("New user account %"" + u.name + "%" at " + service.site_name + ". ")
			create opts.make_absolute
			b.append ("See user account: " + user_url (u) + "%N")
			b.append ("%N%N-- The %"" + service.site_name + "%" team")
			create Result.make (service.site_email, a_mail_address, "New User Account %"" + u.name + "%" at " + service.site_name, b)
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
