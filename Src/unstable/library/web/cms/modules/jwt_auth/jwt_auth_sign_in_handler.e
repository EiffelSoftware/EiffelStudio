note
	description: "Summary description for {JWT_AUTH_SIGN_IN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_SIGN_IN_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_jwt_auth_api: JWT_AUTH_API; mod: JWT_AUTH_MODULE)
		do
			make_with_cms_api (a_jwt_auth_api.cms_api)
			jwt_auth_api := a_jwt_auth_api
			module := mod
		end

feature -- API

	jwt_auth_api: JWT_AUTH_API

	module: JWT_AUTH_MODULE

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if attached {WSF_STRING} req.path_parameter ("challenge") as p_challenge then
				if req.is_get_request_method then
					handle_client_sign_in (p_challenge.value, req, res)
				elseif req.is_post_request_method then
					if attached {WSF_STRING} req.form_parameter ("sign-with") as p_sign_with then
						handle_client_sign_in_validation (p_challenge.value, p_sign_with.value, req, res)
					else
						send_bad_request (req, res)
					end
				else
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

	new_sign_in_form (ch: JWT_AUTH_SIGN_IN_CHALLENGE; a_sign_with: READABLE_STRING_8; a_title: READABLE_STRING_GENERAL; a_action: READABLE_STRING_8): CMS_FORM
		local
		do
			create Result.make (a_action, "sign-in")
			Result.set_method_post
			Result.extend_hidden_input ("client_id", ch.client)
			Result.extend_hidden_input ("sign-with", a_sign_with)
			Result.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("sign-in-op", a_title))
		end

	handle_client_sign_in (a_challenge: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: CMS_RESPONSE
			now: DATE_TIME
			s: STRING_8
			f: CMS_FORM
			tpl_p: PATH
		do
			create now.make_now_utc
			if attached jwt_auth_api.sign_in_challenge (a_challenge) as ch then
				if jwt_auth_api.is_valid_sign_in_challenge (ch, now) then
					check not ch.is_approved or not ch.is_marked_expired end
					rep := new_generic_response (req, res)
					rep.set_title ({STRING_32} "Authenticate with ...")
					create s.make_empty
					s.append ("<div id=%"sign-in-box%">")
					s.append ("<div class=%"prompt%">")
					if attached ch.information as info then
						s.append ("Continue using <span class=%"product%">" + html_encoded (info) + "</span> with")
					else
						s.append ("Continue to authenticate with")
					end
					s.append ("</div>")
					rep.add_style_content ("[
					ul.choices li input[type=submit] {
						text-align: left;
						width: 60%;
						padding: 1rem;
						background-color: white;
						margin-bottom: .5rem;
					}
					ul.choices li input[type=submit]:hover {
						font-weight: bold;
					}
					]")
					s.append ("<ul class=%"sign-in choices%">")

					if attached api.user as l_user then
						rep.set_title ({STRING_32} "Authenticate with " + api.real_user_display_name (l_user) + " ?")
						if
					 		l_user.is_active and then
							not api.user_api.is_admin_user (l_user) and then -- Forbid this possibility for the site administrator
							api.has_permission ({JWT_AUTH_MODULE}.perm_use_client_sign_in)
						then
							s.append ("<li class=%"current-account%">")
							f := new_sign_in_form (ch, "current", {STRING_32} "account " + api.real_user_display_name (l_user) + " ...", req.request_uri)
							f.append_to_html (rep.wsf_theme, s)
							s.append ("</li>")
						else
							rep.add_error_message ("Impossible to use current account, please reconnect with another account.")
						end
						s.append ("<li class=%"other-account%">")
						f := new_sign_in_form (ch, "other", "Sign with a different account ...", rep.api.absolute_url ("/account/roc-logout", Void))
						f.set_method_get
						f.extend_hidden_input ("destination", req.percent_encoded_path_info)
						f.append_to_html (rep.wsf_theme, s)
						s.append ("</li>")

					else
							-- Sign in ...
						s.append ("<li class=%"other-account%">")
						f := new_sign_in_form (ch, "login", "Sign with ...", rep.api.absolute_url ("/account/", Void))
						f.set_method_get
						f.extend_hidden_input ("destination", req.percent_encoded_path_info)
						f.append_to_html (rep.wsf_theme, s)
						s.append ("</li>")
					end
					s.append ("</ul>") -- choice

					create tpl_p.make_from_string ("templates")
					if
						attached api.module_theme_resource_location (module, tpl_p.extended ("footer-sign-in-with.tpl")) as loc and then
						attached api.resolved_smarty_template (loc) as tpl
					then
						tpl.set_value (ch.information, "info")
						tpl.set_value (api.date_time_to_iso8601_string (ch.expiration_date), "expiration")
						if attached ch.remaining as d then
							tpl.set_value (d.minutes, "remaining_minutes")
							tpl.set_value (d.seconds, "remaining_seconds")
						end
						s.append (tpl.string)
					end

					s.append ("</div>%N") -- box

					rep.set_main_content (s)
					rep.execute
				else
					rep := new_generic_response (req, res)
					rep.set_title ({STRING_32} "This sign-in request is not valid anymore.")
					rep.add_error_message ("Cancelling this sign-in request ["+ percent_encoded (ch.challenge) + "] as it is not valid anymore.")
					create s.make_empty
					create tpl_p.make_from_string ("templates")
					if
						attached api.module_theme_resource_location (module, tpl_p.extended ("footer-sign-in-with-error.tpl")) as loc and then
						attached api.resolved_smarty_template (loc) as tpl
					then
						tpl.set_value (ch.information, "info")
						s.append (tpl.string)
					end
					rep.set_main_content (s)
					rep.execute
				end
			else
				send_not_found (req, res)
			end
		end

	handle_client_sign_in_validation (a_challenge, a_sign_with: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: CMS_RESPONSE
			now: DATE_TIME
			tpl_p: PATH
			s: STRING_8
		do
			create now.make_now_utc
			if attached jwt_auth_api.sign_in_challenge (a_challenge) as ch then
				if jwt_auth_api.is_valid_sign_in_challenge (ch, now) then
					check not ch.is_approved or not ch.is_marked_expired end
					if a_sign_with.same_string ("current") then
						if attached api.user as l_user then
							if
						 		l_user.is_active and then
								not api.user_api.is_admin_user (l_user) and then -- Forbid this possibility for the site administrator
								api.has_permission ({JWT_AUTH_MODULE}.perm_use_client_sign_in)
							then
								jwt_auth_api.approve_sign_in_challenge (ch, l_user)
								rep := new_generic_response (req, res)
								rep.set_title ({STRING_32} "Sign-in for " + api.real_user_display_name (l_user) + " approved.")
								rep.add_success_message ("Successfully signed-in as user [" +  html_encoded (api.real_user_display_name (l_user)) + "].")

								create s.make_empty
								create tpl_p.make_from_string ("templates")
								if
									attached api.module_theme_resource_location (module, tpl_p.extended ("footer-sign-in-with-success.tpl")) as loc and then
									attached api.resolved_smarty_template (loc) as tpl
								then
									tpl.set_value (ch.information, "info")
									s.append (tpl.string)
								else
									s.append ("Now, you can close this page.")
								end
								rep.set_main_content (s)
								rep.execute
							else
								send_bad_request (req, res)
							end
						else
							send_not_found (req, res)
						end
--					elseif a_sign_with.same_string ("other") then
--							-- signout and reload
--							-- Sign in ...
--						rep := new_generic_response (req, res)
--						rep.set_title ({STRING_32} "Login to approve sign-in request...")
--						rep.set_redirection (rep.api.absolute_url ("/account/?destination=" + req.percent_encoded_path_info, Void))
--						rep.execute
					else
						send_bad_request (req, res)
					end
				else
					rep := new_generic_response (req, res)
					rep.set_title ({STRING_32} "This sign-in request is not valid anymore.")
					rep.add_error_message ("Cancelling this sign-in request ["+ percent_encoded (ch.challenge) + "] as it is not valid anymore.")
					rep.execute
				end
			else
				send_not_found (req, res)
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
