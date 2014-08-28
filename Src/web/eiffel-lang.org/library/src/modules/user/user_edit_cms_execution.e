note
	description: "[
			]"

class
	USER_EDIT_CMS_EXECUTION

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
			u: detachable CMS_USER
			l_is_editing_current_user: BOOLEAN
		do
			if attached {WSF_STRING} request.path_parameter ("uid") as p_uid and then p_uid.is_integer then
				u := service.storage.user_by_id (p_uid.integer_value)
				if has_permission ("view users") then
				else
					if u /= Void and then u.same_as (user) then
					else
						u := Void
					end
				end
			else
				u := user
			end
			if attached user as l_active_user then
				l_is_editing_current_user := l_active_user.same_as (u)
			end
			create b.make_empty
			initialize_primary_tabs (u)
			if u = Void then
				b.append ("Access denied")
				set_redirection (url ("/user/register", Void))
			else
				service.storage.fill_user_profile (u)
				f := edit_form (u, url (request.path_info, Void), "user-edit")

				if request.is_post_request_method then
					f.validation_actions.extend (agent edit_form_validate (?, u))
					f.submit_actions.extend (agent edit_form_submit (?, u, l_is_editing_current_user, b))
					f.process (Current)
					fd := f.last_data
				else
					f.prepare (Current)
				end

				f.append_to_html (theme, b)

			end
			set_main_content (b)
		end

	edit_form_validate (fd: WSF_FORM_DATA; u: CMS_USER)
		local
			fu: detachable CMS_USER
		do
			if attached {WSF_STRING} fd.item ("username") as s_username then
				fu := service.storage.user_by_name (s_username.value)
				if fu = Void then
					fd.report_invalid_field ("username", "User does not exist!")
				end
			end
			if attached {WSF_STRING} fd.item ("email") as s_email then
				fu := service.storage.user_by_email (s_email.value)
				if fu /= Void and then fu.id /= u.id then
					fd.report_invalid_field ("email", "Email is already used by another user!")
				end
			end
		end

	edit_form_submit (fd: WSF_FORM_DATA; u: CMS_USER; a_is_editing_current_user: BOOLEAN; b: STRING)
		local
			up: detachable CMS_USER_PROFILE
			l_roles: like {CMS_USER}.roles
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

			if attached {WSF_STRING} fd.item ("password") as s_password  and then not s_password.is_empty then
				u.set_password (s_password.value)
			end
			if attached {WSF_STRING} fd.item ("email") as s_email then
				u.set_email (s_email.value)
			end

			if attached {WSF_STRING} fd.item ("note") as s_note then
				up := u.profile
				if up = Void then
					create up.make
				end
				up.force (s_note.value, "note")
				u.set_profile (up)
			end
			if has_permission ("administer users") then
				l_roles := u.roles
				u.clear_roles
				if attached fd.table_item ("roles") as f_roles and then not f_roles.is_empty then
					create {ARRAYED_LIST [INTEGER]} l_roles.make (f_roles.count)
					across
						f_roles as r
					loop
						if attached {WSF_STRING} r.item as s and then attached s.is_integer then
							u.add_role_by_id (s.integer_value)
						end
					end
				end
			end

			service.storage.save_user (u)
			if a_is_editing_current_user and u /= user then
				set_user (u)
			end
			set_redirection (user_url (u))
		end

	edit_form (u: CMS_USER; a_url: READABLE_STRING_8; a_name: STRING): CMS_FORM
		local
			f: CMS_FORM
			ti: WSF_FORM_TEXT_INPUT
			tp: WSF_FORM_PASSWORD_INPUT
			ta: WSF_FORM_TEXTAREA
			ts: WSF_FORM_SUBMIT_INPUT
			tset: WSF_FORM_FIELD_SET
			cb: WSF_FORM_CHECKBOX_INPUT
		do
			create f.make (a_url, a_name)

			create ti.make ("username")
			ti.set_label ("Username")
			ti.set_default_value (u.name)
			ti.set_is_required (False)
			ti.set_is_readonly (True)
			f.extend (ti)

			f.extend_html_text ("<br/>")

			create tp.make ("password")
			tp.set_label ("Password")
			tp.set_is_required (False)
			f.extend (tp)

			f.extend_html_text ("<br/>")

			create ti.make ("email")
			ti.set_label ("Valid email address")
			if attached u.email as l_email then
				ti.set_default_value (l_email)
			end
			ti.set_is_required (True)
			f.extend (ti)

			f.extend_html_text ("<br/>")

			create ta.make ("note")
			ta.set_label ("Additional note about you")
			ta.set_description ("You can use this input to tell us more about you")
			if attached u.profile as p and then attached p.item ("note") as l_note then
				ta.set_default_value (l_note)
			end
			ta.set_is_required (False)
			f.extend (ta)

			if has_permission ("administer users") then
				create tset.make
				tset.set_legend ("User roles")
				tset.set_collapsible (True)
				f.extend (tset)
				across
					service.storage.user_roles as r
				loop
					if
						r.item ~ service.storage.anonymous_user_role or
						r.item ~ service.storage.authenticated_user_role
					then
						-- Skip
					else
						create cb.make_with_value ("roles[]", r.item.id.out)
						cb.set_title (r.item.name)
						cb.set_checked (u /= Void and then u.has_role (r.item))
						tset.extend (cb)
					end
				end
			end
			f.extend_html_text ("<br/>")

			create ts.make ("op")
			ts.set_default_value ("Save")
			f.extend (ts)

			Result := f
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
