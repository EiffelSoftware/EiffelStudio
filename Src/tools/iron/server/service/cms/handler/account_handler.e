note
	date: "$Date$"
	revision: "$Revision$"

class
	ACCOUNT_HANDLER

inherit
	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		select
			new_mapping
		end

	IRON_NODE_HANDLER
		rename
			set_iron as make
		end

	SHARED_HTML_ENCODER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			curr: like current_user
		do
			if req.is_get_request_method then
				curr := current_user (req)
				if curr = Void then
					if attached req.query_parameter ("register") then
						handle_registration (req, res)
					elseif attached {WSF_STRING} req.query_parameter ("reset_password") as s_reset_password then
						handle_reset_password (s_reset_password.value, req, res)
					elseif
						attached {WSF_STRING} req.query_parameter ("activate") as l_code and then
						attached {WSF_STRING} req.path_parameter ("uid") as l_uid
					then
						handle_activation (l_uid, l_code.value, req, res)
					else
						handle_user (Void, req, res)
					end
				elseif
					attached {WSF_STRING} req.query_parameter ("activate") as l_code and then
					attached {WSF_STRING} req.path_parameter ("uid") as s_uid and then
					curr.name.same_string (s_uid.value)
				then
					handle_activation (s_uid, l_code.value, req, res)
				else
					handle_user (curr, req, res)
				end
			else
				if not is_authenticated (req) then
					if attached req.query_parameter ("register") then
						handle_registration_post (req, res)
					elseif attached {WSF_STRING} req.query_parameter ("reset_password") then
						handle_reset_password (Void, req, res)
					end
				else
					res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
				end
			end
		end

	handle_user (a_user: detachable IRON_NODE_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			s: STRING
		do
			if req.is_content_type_accepted ("text/html") then
				m := new_response_message (req)
				s := "..."
				if attached {WSF_STRING} req.item ("redirection") as l_redir then
					m.set_location (l_redir.value)
				elseif a_user /= Void then

					m.set_location (iron.user_page (a_user))
				end

				m.set_title ("Information")
				m.set_body (s)
				res.send (m)
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

feature -- Users

	handle_reset_password (a_reset_pwd: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: WSF_FORM
			i: WSF_FORM_TEXT_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
			m: like new_response_message
			s: STRING
			l_uuid: STRING
		do
			m := new_response_message (req)
			create s.make_empty

			if attached {WSF_STRING} req.item ("uid") as s_uid then
				if attached iron.database.user (s_uid.value) as u then
					if
						req.is_post_request_method and then
						attached {WSF_STRING} req.form_parameter ("code") as s_code and then
						attached {WSF_STRING} req.form_parameter ("new_password") as s_new_password and then
						attached {WSF_STRING} req.form_parameter ("new_password_check") as s_new_password_check
					then
						if
							attached {READABLE_STRING_GENERAL} u.data_item ("reset_password.code") as l_code and then
							l_code.is_case_insensitive_equal (s_code.value)
						then
							if s_new_password.same_string (s_new_password_check.value) then
								u.set_password (s_new_password.value)
								u.remove_data_item ("reset_password.code")
								u.remove_data_item ("reset_password.url")
								u.remove_data_item ("reset_password.datetime")
								iron.database.update_user (u)
								s.append ("Password reset completed.")
								s.append ("<a href=%""+ iron.user_page (u) +"%">Sign in with your new password.</a>")
							else
								s.append ("The Password and Re-typed Password do not match!")
								f := new_reset_password_with_token_form (u, s_code.value)
								f.process (req, Void, Void)
								if attached f.last_data as f_data then
									f_data.set_fields_invalid (True, "new_password_check")
									f_data.apply_to_associated_form
								end
								f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
							end
						else
							s.append ("Reset password code is not associated with user ["+ html_encoder.general_encoded_string (s_uid.value) +"]!")
						end
					elseif a_reset_pwd /= Void and then not a_reset_pwd.is_empty then
						if
							attached {READABLE_STRING_GENERAL} u.data_item ("reset_password.code") as l_code and then
							l_code.is_case_insensitive_equal (a_reset_pwd)
						then
							f := new_reset_password_with_token_form (u, a_reset_pwd)
							f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
						else
							s.append ("Reset password url is not associated with user ["+ html_encoder.general_encoded_string (s_uid.value) +"]!")
						end
					else
						l_uuid := (create {UUID_GENERATOR}).generate_uuid.out
						u.set_data_item ("reset_password.code", l_uuid)
						u.set_data_item ("reset_password.url", req.absolute_script_url (iron.account_page (u) + "?reset_password=" + l_uuid))
						u.set_data_item ("reset_password.datetime", (create {HTTP_DATE}.make_now_utc).string)
						iron.database.update_user (u)
						s.append ("An email has just been sent to you. This describes how to reset your password. Check you inbox (eventually also your spam folder).")
					end
				else
					s.append ("User ["+ html_encoder.general_encoded_string (s_uid.value) +"] does not exists")
				end
			else
				create f.make (iron.account_page (Void) + "?reset_password", "reset_password")
				f.set_method_post
				create i.make ("uid")
				i.set_label ("Username") -- " or email"
				i.set_description ("Enter your username.") --, or the email associated with your account.")
				f.extend (i)
				create sub.make_with_text ("op", "Submit")
				f.extend (sub)
				f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
			end

			m.set_body (s)
			res.send (m)
		end

	handle_activation (a_uid: READABLE_STRING_32; a_code: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			s: STRING
			u: detachable like current_user
		do
			m := new_response_message (req)
			create s.make_empty
			u := iron.database.user (a_uid)
			if
				u /= Void and then
				attached {READABLE_STRING_GENERAL} u.data_item ("activation.code") as u_code and then
				a_code.is_case_insensitive_equal (a_code)
			then
				u.remove_data_item ("activation.code")
				u.remove_data_item ("activation.url")
				u.remove_data_item ("activation.datetime")
				iron.database.update_user (u)
				s.append ("User activated!")
			else
				s.append ("Activation code [" + html_encoder.general_encoded_string (a_code) + "] is not associated with user [" + html_encoder.general_encoded_string (a_uid) + "]!")
			end

			m.set_body (s)
			res.send (m)
		end

	handle_registration (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			f: WSF_FORM
			s: STRING
		do
			m := new_response_message (req)
			f := registration_form (req.script_url (req.path_info) + "?register", "new_account")
			create s.make_empty
			f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
			m.set_body (s)
			res.send (m)
		end

	handle_registration_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			f: WSF_FORM
			s: STRING
		do
			m := new_response_message (req)
			f := registration_form (req.script_url (req.path_info) + "?register", "new_account")
			f.validation_actions.extend (agent on_registration_form_validation (req, ?))
			f.submit_actions.extend (agent on_registration_form_submitted (req, ?))
			f.process (req, Void, Void)
			create s.make_empty
			if attached f.last_data as d and then not d.is_valid then
				s.append ("Error in form registration")
				if attached d.errors as errs then
					across
						errs as c
					loop
						if attached c.message as msg then
							s.append ("<li>")
							s.append (msg)
							s.append ("</li>")
						end
					end
				end
				f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
				m.set_body (s)
				res.send (m)
			else
				-- handled by on_registration_form_submitted
				s.append ("Registration completed.")
				m.set_body (s)
				res.send (m)
			end
		end

	on_registration_form_validation (req: WSF_REQUEST; d: WSF_FORM_DATA)
		do
			if attached d.string_item ("username") as l_user then
				if attached iron.database.user (l_user) then
					d.report_error ("User already exists!")
				end
			else
				d.report_error ("Missing valid username")
			end
			if attached d.string_item ("email") as l_email then
				if attached iron.database.user_by_email (l_email) then
					d.report_error ("This email is already associated with an account!")
				end
			else
				d.report_error ("Missing valid email address!")
			end
		end

	on_registration_form_submitted (req: WSF_REQUEST; d: WSF_FORM_DATA)
		local
			u: IRON_NODE_USER
			l_uuid: STRING
		do
			if attached d.string_item ("username") as l_user and then not l_user.is_empty then
				if attached iron.database.user (l_user) then
					d.report_error ("User already exists!")
				else
					create u.make (l_user)
					u.set_password (d.string_item ("password"))
					if attached d.string_item ("email") as l_email then
						if attached iron.database.user_by_email (l_email) then
							d.report_error ("This email is already associated with an account!")
						else
							u.set_email (l_email)
						end
					end
					if not d.has_error then
						l_uuid := (create {UUID_GENERATOR}).generate_uuid.out
						u.set_data_item ("activation.code", l_uuid)
						u.set_data_item ("activation.url", req.absolute_script_url (iron.account_page (u) + "?activate=" + l_uuid))
						u.set_data_item ("activation.datetime", (create {HTTP_DATE}.make_now_utc).string)
						if attached d.string_item ("note") as l_note and then not l_note.is_empty then
							u.set_data_item ("profile.note", l_note)
						end
						iron.database.update_user (u)
					end
				end
			else
				d.report_error ("Missing valid username")
			end
		end

	registration_form (a_url: READABLE_STRING_8; a_name: STRING): WSF_FORM
		local
			f: WSF_FORM
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

feature -- Helper

	new_reset_password_with_token_form (u: detachable IRON_NODE_USER; a_token: detachable READABLE_STRING_GENERAL;): WSF_FORM
		local
			i: WSF_FORM_TEXT_INPUT
			pwd: WSF_FORM_PASSWORD_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
		do
			if a_token /= Void then
				create Result.make (iron.account_page (u) + "?reset_password=" + url_encoder.general_encoded_string (a_token), "new-password")
				create i.make_with_text ("code", a_token.as_string_32)
			else
				create Result.make (iron.account_page (u) + "?reset_password", "new-password")
				create i.make_with_text ("code", "")
			end
			i.set_label ("Code")
			i.set_size (50)
			i.set_description ("The reset_password code.")
			Result.extend (i)

			create pwd.make ("new_password")
			pwd.set_label ("New Password")
			pwd.set_size (50)
			pwd.set_description ("Enter your new password.")
			Result.extend (pwd)

			create pwd.make ("new_password_check")
			pwd.set_label ("Re-type Password")
			pwd.set_size (50)
			pwd.set_description ("Re-type the same password.")
			Result.extend (pwd)

			create sub.make_with_text ("op", "Submit")
			Result.extend (sub)
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("GET: Access user information.")
			Result.add_description ("POST: Handling user registration, ...")
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
