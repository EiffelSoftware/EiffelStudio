note
	description: "Summary description for {EIFFEL_COMMUNITY_ADMIN_HACK_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_ADMIN_HACK_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get, do_post
		end

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			r: CMS_RESPONSE
		do
			create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("manage " + {EIFFEL_COMMUNITY_MODULE}.name) then
				handle_admin_hack (api, req, res)
			else
				r.execute
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			r: CMS_RESPONSE
		do
			create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("manage " + {EIFFEL_COMMUNITY_MODULE}.name) then
				handle_admin_hack (api, req, res)
			else
				r.execute
			end
		end

feature {NONE} -- Handler: admin hack...

	handle_admin_hack (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING
			r: CMS_RESPONSE
			f: CMS_FORM
			t: WSF_FORM_TEXT_INPUT
			fe: WSF_FORM_EMAIL_INPUT
			fs: WSF_FORM_FIELD_SET
			f_submit: WSF_FORM_SUBMIT_INPUT
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)

			create f.make (req.percent_encoded_path_info, {EIFFEL_COMMUNITY_MODULE}.name + "_hack_form")
			create fs.make
			fs.set_legend ("Create new user without password:")
			create t.make_with_text ("username", "")
			t.set_label ("User name")
			t.enable_required
			t.set_placeholder ("username")
			fs.extend (t)

			create fe.make_with_text ("email", "")
			fe.set_label ("Email")
			fe.enable_required
			fe.set_placeholder ("valid email")
			fs.extend (fe)
			create f_submit.make_with_text ("op", "Create user")
			fs.extend (f_submit)
			f.extend (fs)

			if req.is_post_request_method then
				create s.make_empty
				f.validation_actions.extend (agent (fd: WSF_FORM_DATA; ia_api: CMS_API)
						do
							if attached fd.string_item ("username") as l_username then
								if attached ia_api.user_api.user_by_name (l_username) then
									fd.report_invalid_field ("username", "Username already taken!")
								end
							else
								fd.report_invalid_field ("username", "missing username")
							end
							if attached fd.string_item ("email") as l_email then
								if attached ia_api.user_api.user_by_email (l_email) then
									fd.report_invalid_field ("email", "Email address already associated with an existing account!")
								end
							else
								fd.report_invalid_field ("email", "missing email address")
							end
						end(?, a_api)
					)
				f.submit_actions.extend (agent (fd: WSF_FORM_DATA; ia_api: CMS_API; a_output: STRING)
						local
							u: CMS_USER
						do
							if
								attached fd.string_item ("username") as l_username and then
								attached fd.string_item ("email") as l_email and then
								l_email.is_valid_as_string_8
							then
								create u.make (l_username)
								u.set_email (l_email.as_string_8)
								u.set_password (new_random_password (u))
								ia_api.user_api.new_user (u)
								if ia_api.user_api.has_error then

								end
								a_output.append ("<li>New user ["+ html_encoded (l_username) +"] created.</li>")
							else
								fd.report_invalid_field ("username", "Missing username!")
								fd.report_invalid_field ("email", "Missing email address!")
							end
						end(?, a_api, s)
					)
				f.process (r)
				f.append_to_html (create {CMS_TO_WSF_THEME}.make (r, r.theme), s)
				r.set_main_content (s)
			elseif req.is_get_head_request_method then
				create s.make_empty
				f.append_to_html (create {CMS_TO_WSF_THEME}.make (r, r.theme), s)
				r.set_main_content (s)
			end
			r.execute
		end

	new_random_password (u: CMS_USER): STRING
			-- Generate a new token activation token
		local
			l_token: STRING
			l_security: SECURITY_PROVIDER
			l_encode: URL_ENCODER
		do
			create l_security
			l_token := l_security.token
			create l_encode
			from until l_token.same_string (l_encode.encoded_string (l_token)) loop
				-- Loop ensure that we have a security token that does not contain characters that need encoding.
			    -- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
				-- but the user will need to use an unencoded token if activation has to be done manually.
				l_token := l_security.token
			end
			Result := l_token + url_encoded (u.name) + u.creation_date.out
		end

end
