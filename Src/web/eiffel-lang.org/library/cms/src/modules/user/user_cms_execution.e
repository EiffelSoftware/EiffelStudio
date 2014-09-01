note
	description: "[
			]"

class
	USER_CMS_EXECUTION

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
			u: detachable CMS_USER
			l_first: BOOLEAN
		do
			if attached {WSF_STRING} request.path_parameter ("uid") as p_uid then
				if p_uid.is_integer then
					u := service.storage.user_by_id (p_uid.integer_value)
				else
					u := service.storage.user_by_name (p_uid.value)
				end
			else
				u := user
			end
			initialize_primary_tabs (u)

			if u /= Void then
				if not u.same_as (user) and then not has_permission ("admin view users") then
					set_main_content ("Access denied")
				else
					service.storage.fill_user_profile (u)
					create b.make_empty
					set_title ("User [" + u.name + "]")
					b.append ("<ul>%N")
					if attached u.email as l_email then
						b.append ("<li>Email: <a mailto=%""+ l_email +"%">"+ l_email +"</a></li>")
					end
					if has_permission ("administer users") and attached u.roles as u_roles then
						b.append ("<li>Roles:")
						l_first := True
						across
							u_roles as r
						loop
							if l_first then
								l_first := False
							else
								b.append (", ")
							end
							if attached service.storage.user_role_by_id (r.item) as ur then
								b.append (ur.name)
							else
								b.append (r.item.out)
							end
						end
						b.append ("</li>")
					end
					b.append ("<li>Created: "+ u.creation_date.out +"</li>%N")
					if attached u.last_login_date as dt then
						b.append ("<li>Last signed: "+ dt.out +"</li>%N")
					else
						b.append ("<li>Never signed yet</li>%N")
					end
					if u = user and then attached last_user_access_date as dt then
						b.append ("<li>Session date: "+ dt.out +"</li>%N")
					end

					service.storage.fill_user_profile (u)
					if attached u.profile as prof then
						across
							prof as p
						loop
							b.append ("<li>" + p.key + "=" + p.item +"</li>%N")
						end
					end
					b.append ("</ul>")
					set_main_content (b)
				end
			else
				process_login
			end
		end

	process_login
		local
			l_url: detachable READABLE_STRING_8
			b: STRING_8
			f: CMS_FORM
			fd: detachable WSF_FORM_DATA
		do
			if
				attached {WSF_STRING} request.item ("destination") as s_dest
			then
				l_url := request.script_url (s_dest.value)
			end
			if l_url = Void then
				l_url := request.script_url ("/user")
			end
			f := login_form (url ("/user", Void), "user-login", l_url)
			if request.is_request_method ("post") then
				f.submit_actions.extend (agent on_form_submitted)
				f.process (Current)
				fd := f.last_data
			else
				f.prepare (Current)
			end

			if authenticated then
				if
					fd /= Void and then fd.is_valid and then
					attached {WSF_STRING} fd.integer_item ("form-destination") as s_dest
				then
					l_url := request.script_url (s_dest.value)
				end

				set_redirection (l_url)
				set_title ("Login")
				create b.make_empty
				set_main_content (b)
				set_redirection (url ("/user", Void))
			else
				set_title ("Login")
				create b.make_empty
				f.append_to_html (theme, b)
				set_main_content (b)
			end
		end

	on_form_submitted (fd: WSF_FORM_DATA)
		local
			u: detachable CMS_USER
		do
			if attached {WSF_STRING} fd.item (form_username_or_email_name) as s_name and then not s_name.is_empty then
				u := service.storage.user_by_name (s_name.value)
				if u = Void then
					u := service.storage.user_by_email (s_name.value)
				end
			end
			if u = Void then
				fd.report_error ("Sorry, unrecognized username/email or password. " + link ("Have you forgotten your password?", "/user/password", Void))
			else
				if attached {WSF_STRING} fd.item (form_password_name) as s_passwd and then not s_passwd.is_empty then
					if service.auth_engine.valid_credential (u.name, s_passwd.value) then
						login (u, request)
					else
						fd.report_error ("Sorry, unrecognized username/email or password. " + link ("Have you forgotten your password?", "/user/password", Void))
					end
				end
			end
		end

	login_form (a_action: READABLE_STRING_8; a_form_name: READABLE_STRING_8; a_destination: READABLE_STRING_8): CMS_FORM
		local
			th: WSF_FORM_HIDDEN_INPUT
			ti: WSF_FORM_TEXT_INPUT
			tp: WSF_FORM_PASSWORD_INPUT
			ts: WSF_FORM_SUBMIT_INPUT
			l_logo: WSF_WIDGET_TEXT
			d: WSF_FORM_DIV
		do
			create Result.make (a_action, a_form_name)

			create th.make ("form-destination")
			th.set_default_value (a_destination)
			Result.extend (th)

			create l_logo.make_with_text ("[
						<img class="logo" alt="login" 
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAHiQAAB4kB+XNYvQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAASmSURBVGiB1ZpbaBxVGMd/Mzu5bSRJY6LubmKJl4J9qShdwdpGGxGlharJSwpVVFrUUF+iT1VEUYRgaEGqsa2FGtu8xNtDsBQi5EFBS8UnsYWUtpsmaqppIdkkm+4eH77ZzWazl7lllv7gPOycmXP+/9kzM+d839GUUnjEOqAL2A7cCdSYJWjWx4F5s/wN/AgMAzNedK65NHI38CKwAwiZpcLitUvAlFlGgBPAFadCnBppAQ4DDwNhQHMqwEQBk8A5oAeYsNuAXSP1QD/wFNBqtzOLxIAzQC9ww/JVSimrZbdSalwplVJrT8rsa7dVfVZNHFRKTftgIJdps++SGksNrSDwLbAFqHUxXNwwB/wEPIe8+fJSzEi12cCDgO61OpukgN+RG7qQ74RiRkaApylg4sj4YZLqpgcalwloBvvu7SlUnQJOI6/6VRQy8jHwKkWG04aRMIlUwp7SElTqlVzYMVnslDlgAHgztyLf3e5GPnLleiaKUYto686tyDXSCHwANPkgyilNiMbG7INGzkn9QJvdltdVNnJg43uOVH34x7vMJP6ze1kbovWl9IFsI+uBJ3Ew3QgGaulqXfVvW+Lg+T5msG1EQ7SuBy7DyqH1GTKHulVoQTQDy0YiwKayyHHHJkR7xsgLyBTcFYupRbdN2CWEaM8Y2Yn7qTjHLw4w9s+o22bsoCHa0YEGZE3hmsXkInvP7vHbTBhoMJDlacTu1fs39JJMJQGoq6jLHE+kEuw9u4ejmwdpv6PDI61FiQBdBtCB9eVphv339xas89lMBdCh48FDno+0GZ+GWchAIh0F+f7q15y6fMJSaxPx2IrfPv4zNQbL4Zq8TM5P8Mu/PzvuwSczQZ0SRrzAh2EW9G3lp6Ghaa4/VQXRKbIO9ooqvYqj0UG2NW9fqy7iBiWMhGtaeOT2Ry21NhGPcXV+5QNfpVdxLPoVW5ufcKzSAnEDicUWZFekk12RTkutHTrfx6ELfZnfYuIkW5sfdyPSCvMGEnv1nOpANcc2n+Sx5va1aD6XKQMYBTqx+XXv//MjbqolAOoqGnjtvjcydT6bWAJGDSS0/w4SWbfM5+OfZKIokZrWjJHqQDVfRE+xpWmbt3ILMwUM68B1PBpeNUaQ49EhP02AaL+eXrN/A0RxuSZ5uW0fFXqlW2F2UIj2zMJqEMlPuMJnEyCaB2HZyBSSZLnVOIf5WGRPUXpwkfoqA1cQzcDKuNYEkil6BZvPSjw5x3BsyJGaeHLOyWUK0ZpJ0eUGseuB34B7SrVUpiB2movAQ2Sl5nJnvzeAt4Fpz9R5zzSicUV+Md80fghJFc/6IMous4i2VeM4N4id5i3gASTRE8h3woGN769JoqcISWDM1LaKUqm3MSSXnteMjySRV207BVJvxVaIC+aFpynvMJs1NRQ0AaWTnAtISHIAuOaZNOtcM/veSRETgK0NA91KqUvKvw0Dl8w+Pd0wkC71SqkjSqnYGpqImX3U29HmdFNNCPgUmTGH8GZTzRTwK/A6DpYVbrc53YXkJ55FouJh7G1zmjTLd8CXwF9Ohbg1ks1twPPAM8i/FCT/xrM4csd/QNYSnrwR/wfI5AekDWyX2QAAAABJRU5ErkJggg==" 
						/>
					]"
				)
			create ti.make (form_username_or_email_name)
			ti.set_label ("Username or email")
			ti.set_is_required (True)

			create tp.make (form_password_name)
			tp.set_label ("Password")
			tp.set_is_required (True)
			tp.set_description (link ("Reset password", "/user/password", Void))

			create ts.make ("op")
			ts.set_default_value ("Log in")

			create d.make_with_item (ti)
			d.add_css_class ("input")
			d.extend (tp)
			Result.extend (l_logo)
			Result.extend (d)
			Result.extend (ts)

			Result.extend_html_text ("<div>Need an account?<br/>" + link ("Sign up now!", "/user/register", Void) + "</div>")
		end

	form_username_or_email_name: STRING = "name"
	form_password_name: STRING = "password"

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
