note
	description: "Summary description for {JWT_AUTH_SIGN_IN_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_SIGN_IN_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (mod: JWT_AUTH_MODULE_WEBAPI; a_jwt_auth_api: JWT_AUTH_API)
		do
			module := mod
			make_with_cms_api (a_jwt_auth_api.cms_api)
			jwt_auth_api := a_jwt_auth_api
		end

feature -- API

	module: JWT_AUTH_MODULE_WEBAPI

	jwt_auth_api: JWT_AUTH_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if attached {WSF_STRING} req.path_parameter ("challenge") as p_challenge then
				if req.is_post_request_method then
					handle_process_challenge (p_challenge.value, req, res)
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			elseif req.is_post_request_method then
				handle_post (req, res)
			else
				new_bad_request_error_response ("Bad request", req, res).execute
			end
		end

feature -- Request execution

	handle_process_challenge (a_challenge: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			rep: like new_response
		do
			if api.has_permission ({JWT_AUTH_MODULE}.perm_use_magic_login) then
				if
					attached {WSF_STRING} req.item ("client_id") as p_client_id and then
					attached jwt_auth_api.sign_in_challenge (a_challenge) as ch and then
					p_client_id.same_string (ch.client) -- Security!!!
				then
					rep := new_response (req, res)
					rep.add_string_field ("challenge", ch.challenge)
					if
						ch.is_approved and then
						attached api.user_api.user_by_id (ch.user_id) as l_approved_user
					then
						rep.add_boolean_field ("approved", ch.is_approved)
						rep.add_string_field ("name", l_approved_user.name)
						rep.add_integer_64_field ("uid", l_approved_user.id)
						if attached jwt_auth_api.new_token (l_approved_user, ch.applications) as tok then
							rep.add_string_field ("access_token", tok.token)
							rep.add_string_field ("refresh_key", tok.refresh_key)
							rep.add_link ("jwt:refresh_token", Void, rep.api.webapi_path ("user/" + l_approved_user.id.out + "/jwt_access_token?refresh=" + tok.refresh_key))
--							jwt_auth_api.discard_sign_in_challenge (ch)
						else
							rep.add_boolean_field ("error_occurred", True)
							rep.add_string_field ("error_message", "could not create new access token")
						end
					else
						if ch.is_denied then
							rep.add_boolean_field ("denied", True)
						end
						if ch.is_expired (create {DATE_TIME}.make_now_utc) then
							rep.add_boolean_field ("expired", True)
						end
					end
					rep.api.hooks.invoke_webapi_response_alter (rep)
					rep.add_link ("jwt:client_sign_in_link", Void, jwt_auth_api.client_sign_in_link (ch))
					rep.add_self (rep.location)
				else
					rep := new_not_found_error_response ("Not found", req, res)
--					new_bad_request_error_response ("Bad request", req, res)
				end
			else
				rep := new_access_denied_error_response (Void, req, res)
			end
			rep.execute
		end

	handle_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			rep: like new_response
			l_challenge: JWT_AUTH_SIGN_IN_CHALLENGE
			cl, info: READABLE_STRING_GENERAL
			apps: detachable LIST [READABLE_STRING_GENERAL]
		do
			if api.has_permission ({JWT_AUTH_MODULE}.perm_use_client_sign_in) then
				rep := new_response (req, res)
				if
					attached {WSF_STRING} req.form_parameter ("client_id") as p_client_id
				then
					if attached {WSF_STRING} req.form_parameter ("information") as p_info then
						info := p_info.value
					end
					if attached {WSF_STRING} req.form_parameter ("applications") as p_apps then
						apps := p_apps.value.split (',')
					end
					cl := p_client_id.value
					api.log ("auth", "new sign-in challenge from " + req.remote_addr, 0, Void)

					l_challenge := jwt_auth_api.new_sign_in_challenge_with_expiration (cl, info, apps, 0)
					if l_challenge /= Void then
						rep.add_string_field ("jwt:client_sign_in_challenge", l_challenge.challenge)
						rep.add_date_time_field ("jwt:client_sign_in_expiration_date", l_challenge.expiration_date)
						rep.add_link ("jwt:client_sign_in_link", Void, jwt_auth_api.client_sign_in_link (l_challenge))
						rep.add_link ("jwt:client_sign_in_request_link", Void, module.client_sign_in_request_link (api, l_challenge))
					else
						rep := new_access_denied_error_response (Void, req, res)
					end
				else
					rep := new_bad_request_error_response ("Missing client_id parameter", req, res)
				end
			else
				rep := new_access_denied_error_response (Void, req, res)
			end
			rep.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

