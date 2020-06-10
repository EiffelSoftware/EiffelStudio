note
	description: "Summary description for {JWT_AUTH_TOKEN_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_TOKEN_WEBAPI_HANDLER

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
		local
			l_uid: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("uid") as p_uid then
				l_uid := p_uid.value
				if req.path_info.ends_with_general ("/new_jwt_magic_link") then
					handle_new_jwt_magic_link (l_uid, req, res)
				elseif req.is_post_request_method then
					post_jwt_token (l_uid, req, res)
				elseif req.is_get_request_method then
					get_jwt_tokens (l_uid, req, res)
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			else
				new_bad_request_error_response ("Missing {uid} parameter", req, res).execute
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
			rep: HM_WEBAPI_RESPONSE
			tb: STRING_TABLE [detachable ANY]
			arr: ARRAYED_LIST [STRING_TABLE [detachable ANY]]
			l_app: detachable READABLE_STRING_GENERAL
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if u.same_as (l_user) or api.user_api.is_admin_user (u) then
						rep := new_response (req, res)
						if attached {WSF_STRING} req.query_parameter ("application") as p_application then
							l_app := p_application.value
						end

						if attached jwt_auth_api.user_tokens (l_user, l_app) as l_tokens and then not l_tokens.is_empty then
							create arr.make (l_tokens.count)
							across
								l_tokens as ic
							loop
								create tb.make (2)
								tb.force (ic.item.token, "token")
--								tb.force (ic.item.refresh_key, "refresh_key") -- Should be shared only on creation from the webapi!
								tb.force (ic.item.applications_as_csv, "applications")
								arr.extend (tb)
							end
						else
							create arr.make (0)
						end
						rep.add_iterator_field ("access_tokens", arr)
						create tb.make_equal (3)
						tb.force (l_user.name, "name")
						tb.force (l_user.id, "uid")
						rep.add_table_iterator_field ("user", tb)

						rep.add_self (req.percent_encoded_path_info)
						add_user_links_to (l_user, rep)
					else
							-- Only admin, or current user can see its access_token!
						rep := new_access_denied_error_response (Void, req, res)
					end
				else
					rep := new_access_denied_error_response (Void, req, res)
				end
			else
				rep := new_not_found_error_response ("User not found", req, res)
			end
			rep.execute
		end

	post_jwt_token (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			tb: STRING_TABLE [detachable ANY]
			rep: like new_response
			l_apps: detachable LIST [READABLE_STRING_GENERAL]
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if u.same_as (l_user) or api.user_api.is_admin_user (u) then
						if attached req.string_item ("refresh") as s_refresh_key then
							if
								attached {WSF_STRING} req.form_parameter ("token") as s_token and then
								attached jwt_auth_api.refresh_token (l_user, s_token.value, s_refresh_key) as l_refreshed_token
							then
								rep := new_response (req, res)
								rep.add_string_field ("access_token", l_refreshed_token.token)
								rep.add_string_field ("refresh_key", l_refreshed_token.refresh_key)
							else
								rep := new_error_response ("Could not refresh token", req, res)
							end
						elseif
							attached req.string_item ("op") as s_op and then
							s_op.is_case_insensitive_equal ("discard")
						then
							if
								attached {WSF_STRING} req.form_parameter ("token") as s_token
							then
								jwt_auth_api.discard_user_token (l_user, s_token.value)
								if attached jwt_auth_api.user_for_token (s_token.value) then
									rep := new_error_response ("Could not discard token", req, res)
								else
									rep := new_response (req, res)
								end
							else
								rep := new_error_response ("Could not discard token", req, res)
							end
						else
							if attached {WSF_STRING} req.form_parameter ("applications") as s_app then
								l_apps := s_app.value.split (',')
							end
							if attached jwt_auth_api.new_token (l_user, l_apps) as l_new_token then
								rep := new_response (req, res)
								rep.add_string_field ("access_token", l_new_token.token)
								rep.add_string_field ("refresh_key", l_new_token.refresh_key)
								rep.add_link ("jwt:refresh_token", Void, rep.api.webapi_path ("user/" + u.id.out + "/jwt_access_token?refresh=" + l_new_token.refresh_key))
							else
								rep := new_error_response ("Could not create new token", req, res)
							end
						end
						create tb.make_equal (2)
						tb.force (l_user.name, "name")
						tb.force (l_user.id, "uid")
						rep.add_table_iterator_field ("user", tb)
						rep.add_self (req.percent_encoded_path_info)
						add_user_links_to (l_user, rep)
					else
							-- Only admin, or current user can create the user access_token!
						rep := new_access_denied_error_response (Void, req, res)
					end
				else
					rep := new_access_denied_error_response (Void, req, res)
				end
			else
				rep := new_not_found_error_response ("User not found", req, res)
			end
			rep.execute
		end

	handle_new_jwt_magic_link (a_uid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			tb: STRING_TABLE [detachable ANY]
			rep: like new_response
		do
			if attached user_by_uid (a_uid) as l_user then
				if attached api.user as u then
					if
						api.user_api.is_admin_user (u)
					 	or api.has_permission ({JWT_AUTH_MODULE}.perm_use_magic_login) and then (u.same_as (l_user))
					then
						if attached module.module.new_magic_login_link (u, {NATURAL_32} 5 * 60) as lnk then
							rep := new_response (req, res)
							rep.add_link ("jwt:magic_login", Void, lnk)
						else
							rep := new_error_response ("Could not create new magic login link", req, res)
						end
						rep.add_self (req.percent_encoded_path_info)
					else
							-- Only admin, or current user can create the user access_token!
						rep := new_access_denied_error_response (Void, req, res)
					end
				else
					rep := new_access_denied_error_response (Void, req, res)
				end
			else
				rep := new_not_found_error_response ("User not found", req, res)
			end
			rep.execute
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

