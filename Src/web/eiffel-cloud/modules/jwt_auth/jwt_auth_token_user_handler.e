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
			sub: WSF_FORM_SUBMIT_INPUT
			l_form: CMS_FORM
			s: STRING
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if u.same_as (l_user) or api.user_api.is_admin_user (u) then
						rep := new_generic_response (req, res)
						rep.set_title ("JWT tokens")
						create s.make_empty

						if attached jwt_auth_api.user_tokens (u, Void) as lst then
							across
								lst as ic
							loop
								create l_form.make (req.percent_encoded_path_info, "user-jwt-tokens")
								l_form.set_method_post
								create fset.make
								l_form.extend (fset)

								inf := ic.item
								create tf.make_with_text ("token", inf.token)
								tf.set_label ("Token")
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
								create sub.make_with_text ("op", "Delete")
								fset.extend (sub)

								l_form.append_to_html (rep.wsf_theme, s)
								l_form.append_html_attributes_to ("<br/>")
							end
						end
						rep.set_main_content (s)
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

	post_jwt_token (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			inf: JWT_AUTH_TOKEN
			rep: CMS_RESPONSE
			fset: WSF_FORM_FIELD_SET
			tf: WSF_FORM_TEXT_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
			l_form: CMS_FORM
			s: STRING
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if u.same_as (l_user) or api.user_api.is_admin_user (u) then
						if
							attached {WSF_STRING} req.form_parameter ("token") as p_token and then
							attached req.form_parameter ("op") as p_op and then p_op.same_string ("Delete")
						then
							rep := new_generic_response (req, res)

							create s.make_empty
--							print (jwt_auth_api.user_tokens (l_user, Void))
							jwt_auth_api.discard_user_token (l_user, p_token.value)
							if jwt_auth_api.has_error then
								rep.add_error_message ("Error when trying to discard token " + p_token.value + " !")
							else
								rep.add_success_message ("Token discarded.")
								rep.set_redirection (req.percent_encoded_path_info)
							end
							rep.execute
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

