note
	description: "Summary description for {JWT_AUTH_TOKEN_USER_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_TOKEN_USER_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_jwt_auth_api: JWT_AUTH_API)
		do
			make_with_cms_api (a_jwt_auth_api.cms_api)
			jwt_auth_api := a_jwt_auth_api
		end

feature -- API

	jwt_auth_api: JWT_AUTH_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_uid: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("uid") as p_uid then
				l_uid := p_uid.value
				if req.is_get_request_method then
					get_jwt_tokens (l_uid, req, res)
				elseif req.is_post_request_method then
					post_jwt_token (l_uid, req, res)
				else
					send_bad_request (req, res)
				end
			else
				send_bad_request (req, res)
			end
		end

feature -- Helper

	user_by_uid (a_uid: READABLE_STRING_GENERAL): detachable CMS_USER
		do
			Result := api.user_api.user_by_id_or_name (a_uid)
		end

feature -- Request execution		

	get_jwt_tokens (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			inf: JWT_AUTH_TOKEN
			rep: CMS_RESPONSE
			fset: WSF_FORM_FIELD_SET
			tf: WSF_FORM_TEXT_INPUT
			tnum: WSF_FORM_NUMBER_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
			l_form: CMS_FORM
			s: STRING
			l_now: DATE_TIME
			lst: LIST [JWT_AUTH_TOKEN]
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as api_u then
					if api_u.same_as (l_user) or api.user_api.is_admin_user (api_u) then
						rep := new_generic_response (req, res)
						rep.set_title ("JWT tokens")
						create s.make_empty

						create l_now.make_now_utc

						lst := jwt_auth_api.user_tokens (l_user, Void)
						if lst /= Void and then not lst.is_empty then
							from
								lst.start
							until
								lst.off
							loop
								inf := lst.item
								if inf.is_expired (l_now) then
									jwt_auth_api.discard_user_token (l_user, lst.item.token)
									lst.remove
								else
									lst.forth
								end
							end
						end
						if lst /= Void and then not lst.is_empty then
							create l_form.make (req.percent_encoded_path_info, "user-jwt-tokens")
							l_form.set_method_post
							create fset.make
							l_form.extend (fset)
							create sub.make_with_text ("op", but_revoke_all_text)
							fset.extend (sub)


							fset.extend_html_text ("<p>Revoke all " + lst.count.out + " token(s) for user " +  html_encoded (api.user_display_name (l_user)) + " .</p>")
							l_form.append_to_html (rep.wsf_theme, s)
							l_form.append_html_attributes_to ("<br/>")

							across
								lst as ic
							loop
								inf := ic.item
								if inf.is_expired (l_now) then
									s.append ("<!-- <div>Expired JWT TOKEN</div> -->%N")
								else
									create l_form.make (req.percent_encoded_path_info, "user-jwt-tokens")
									l_form.set_method_post
									create fset.make
									fset.set_legend ("Token")
									l_form.extend (fset)

									create tf.make_with_text ("token", inf.token)
									tf.set_size (60)
									fset.extend (tf)
									if attached inf.jwt as jwt then
										fset.extend_html_text ("<code>" + jwt.claimset.string + "</code>")
										if attached jwt.claimset.issued_at as dt_iss then
											fset.extend_html_text ("<div><strong>Issued-at:</strong>" + dt_iss.out + "</div>")
										end
										if attached jwt.claimset.expiration_time as dt_exp then
											fset.extend_html_text ("<div><strong>Expiration-date:</strong>" + dt_exp.out + "</div>")
										end
									end

									if attached inf.applications_as_csv as apps then
										create tf.make_with_text ("apps", apps)
									else
										create tf.make_with_text ("apps", "None")
									end
									tf.set_label ("Applications")
	--								create sub.make_with_text ("op", "Refresh-token")
	--								fset.extend (sub)
									create sub.make_with_text ("op", but_revoke_text)
									fset.extend (sub)

									l_form.append_to_html (rep.wsf_theme, s)
									l_form.append_html_attributes_to ("<br/>")
								end
							end
						end

							-- Create new token
						create l_form.make (req.percent_encoded_path_info, "user-jwt-tokens")
						l_form.set_method_post
						create fset.make
						fset.set_legend ("Operations")
						fset.add_css_style ("background-color: #ff830038")
						l_form.extend (fset)
						create sub.make_with_text ("op", but_create_new_token_text)
						fset.extend (sub)

						fset.extend_html_text ("<p>Create a new token for user " +  html_encoded (api.user_display_name (l_user)) + " .</p>")
						if api.has_permission ({JWT_AUTH_MODULE}.perm_use_magic_login) then
								-- Create new magic link
							create sub.make_with_text ("op", but_create_new_magic_link_text)
							fset.extend (sub)
							create tnum.make_with_text ("magin_link_expiration", "1800") -- 30min -> 1800 seconds
							tnum.set_max (48 * 60 * 60)
							tnum.set_min (30)
							tnum.set_description ("Expiration in seconds (default: 30 minutes = 1 800 seconds; between 30s and 48h)")
							fset.extend (tnum)

							fset.extend_html_text ("<p>Create a magic link to sign is as user " +  html_encoded (api.user_display_name (l_user)) + ".</p>")
						end
						s.append ("<br/>")
						l_form.append_to_html (rep.wsf_theme, s)

						rep.set_main_content (s)
						rep.add_to_primary_tabs (api.local_link ("JWT Tokens", req.percent_encoded_path_info))
						rep.execute
					else
							-- Only admin, or current user can see its access_token!
						send_access_denied (req, res)
					end
				else
					send_access_denied (req, res)
				end
			else
				send_not_found (req, res)
			end
		end

	but_revoke_text: STRING = "Revoke"
	but_revoke_all_text: STRING = "Revoke All"
	but_create_new_token_text: STRING = "New Token"
	but_create_new_magic_link_text: STRING = "New Magic Link"

	post_jwt_token (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			tok: JWT_AUTH_TOKEN
			rep: CMS_RESPONSE
			l_expiration: NATURAL_32
			s: STRING
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if u.same_as (l_user) or api.user_api.is_admin_user (u) then
						if
							attached {WSF_STRING} req.form_parameter ("token") as p_token and then
							attached req.form_parameter ("op") as p_op and then p_op.same_string (but_revoke_text)
						then
							rep := new_generic_response (req, res)

							create s.make_empty
--							print (jwt_auth_api.user_tokens (l_user, Void))
							jwt_auth_api.discard_user_token (l_user, p_token.value)
							if jwt_auth_api.has_error then
								rep.add_error_message ("Error when trying to discard token " + html_encoded (p_token.value) + " !")
							else
								rep.add_success_message ("Token discarded.")
								rep.set_redirection (req.percent_encoded_path_info)
							end
							rep.add_to_primary_tabs (api.local_link ("JWT Tokens", req.percent_encoded_path_info))
							rep.execute
						elseif attached req.form_parameter ("op") as p_op and then p_op.same_string (but_revoke_all_text) then
							rep := new_generic_response (req, res)

							create s.make_empty

							jwt_auth_api.discard_all_user_tokens (l_user)
							if jwt_auth_api.has_error then
								rep.add_error_message ("Error when trying to discard all tokens !")
							else
								rep.add_success_message ("All Tokens discarded.")
								rep.set_redirection (req.percent_encoded_path_info)
							end
							rep.add_to_primary_tabs (api.local_link ("JWT Tokens", req.percent_encoded_path_info))
							rep.execute
						elseif attached req.form_parameter ("op") as p_op and then p_op.same_string (but_create_new_token_text) then
							rep := new_generic_response (req, res)

							create s.make_empty

							tok := jwt_auth_api.new_token (l_user, Void)
							if jwt_auth_api.has_error then
								rep.add_error_message ("Error when trying to create a new token !")
							else
								rep.add_success_message ("New token created.")
								rep.set_redirection (req.percent_encoded_path_info)
							end
							rep.add_to_primary_tabs (api.local_link ("JWT Tokens", req.percent_encoded_path_info))
							rep.execute
						elseif attached req.form_parameter ("op") as p_op and then p_op.same_string (but_create_new_magic_link_text) then
							if api.user_has_permission (l_user, {JWT_AUTH_MODULE}.perm_use_magic_login) then
								rep := new_generic_response (req, res)
								create s.make_empty
								l_expiration := {NATURAL_32} 5 *60
								if
									attached {WSF_STRING} req.form_parameter ("magin_link_expiration") as p_expiration and then
									p_expiration.is_integer
								then
									l_expiration := p_expiration.integer_value.to_natural_32
								end
								l_expiration := l_expiration.max ({NATURAL_32} 30).min ({NATURAL_32} 48 * 60 * 60) -- Max 48H
								if attached jwt_auth_api.new_magic_login_link (l_user, l_expiration) as l_link then
									rep.add_success_message ("New magic link: <a href=%"" + l_link + "%">"+ html_encoded (l_link) +"</a>")
									s.append ("To sign-in, use the following magic link: <a href=%"" + l_link + "%">"+ html_encoded (l_link) +"</a>")
									rep.set_main_content (s)
								else
									rep.add_error_message ("Error when trying to create a new magic link !")
								end
								rep.add_to_primary_tabs (api.local_link ("JWT Tokens", req.percent_encoded_path_info))
								rep.execute
							else
								send_access_denied (req, res)
							end
						else
							send_bad_request (req, res)
						end
					else
							-- Only admin, or current user can see its access_token!
						send_access_denied (req, res)
					end
				else
					send_access_denied (req, res)
				end
			else
				send_not_found (req, res)
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

