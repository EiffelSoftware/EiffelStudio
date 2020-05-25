note
	description: "Summary description for {JWT_AUTH_MAGIC_LOGIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_MAGIC_LOGIN_HANDLER

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
					handle_magic_login (l_uid, req, res)
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

	handle_magic_login (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
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
				if
					not api.user_api.is_admin_user (l_user) and then -- Forbid this magic link for administrator! (security)
					api.has_permission ({JWT_AUTH_MODULE}.perm_use_magic_login) and then
					attached {WSF_STRING} req.path_parameter ("token") as p_token and then
					attached jwt_auth_api.user_for_token (p_token.value) as l_token_user and then
					l_token_user.same_as (l_user)
				then
					if attached {CMS_SESSION_API} api.module_api ({CMS_SESSION_AUTH_MODULE}) as l_session_api then
						l_session_api.process_user_login (l_user, req, res)
					end
					jwt_auth_api.discard_user_token (l_user, p_token.value)
					rep := new_generic_response (req, res)
					rep.set_title ({STRING_32} "Magic login for user " + api.real_user_display_name (l_user))
					if attached {WSF_STRING} req.query_parameter ("destination") as p_destination then
						rep.set_redirection (p_destination.url_encoded_value)
					else
						rep.set_redirection (api.absolute_url ("/", Void))
					end
					rep.add_success_message ("Successfully signed-in as user " +  api.user_html_link (l_user) + " .")
					rep.execute
				else
					send_access_denied (req, res)
				end
			else
				send_not_found (req, res)
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
