note
	description: "Summary description for {CMS_USER_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				execute_get (req, res)
--			elseif req.is_post_request_method then
--				execute_post (req, res)
			else
				send_bad_request (Void, req, res)
			end
		end

	execute_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			l_user: detachable CMS_USER
		do
			if attached api.user as u then
				if attached {WSF_STRING} req.path_parameter ("uid") as p_uid then
					if p_uid.is_integer then
						l_user := api.user_api.user_by_id (p_uid.integer_value)
					else
						l_user := api.user_api.user_by_name (p_uid.value)
					end
--					if l_user = Void and p_uid.is_case_insensitive_equal ("me") then
--						l_user := u
--					end
					if l_user /= Void then
						if l_user.same_as (u) or api.has_permissions (<<"admin users", "view users">>) then
							rep := new_webapi_response (req, res)
							rep.add_string_field ("uid", l_user.id.out)
							rep.add_string_field ("name", l_user.name)
							if attached l_user.email as l_email then
								rep.add_string_field ("email", l_email)
							end
							if not l_user.is_active then
								rep.add_boolean_field ("is_active", False)
							end
							if attached l_user.profile_name as l_profile_name then
								rep.add_string_field ("profile_name", l_profile_name)
							end
							if attached l_user.creation_date as dt then
								rep.add_string_field ("creation_date", date_time_to_string (dt))
							end
							if attached l_user.last_login_date as dt then
								rep.add_string_field ("last_login_date", date_time_to_string (dt))
							end
							add_user_links_to (l_user, rep)
						else
							rep := new_wepapi_error_response ("denied", req, res)
							rep.set_status_code ({HTTP_STATUS_CODE}.user_access_denied)
						end
					else
						rep := new_wepapi_error_response ("Not found", req, res)
						rep.set_status_code ({HTTP_STATUS_CODE}.not_found)
					end
				else
					rep := new_wepapi_error_response ("Bad request", req, res)
					rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
				end
				rep.execute
			else
					-- FIXME: use specific Web API response!
				send_access_denied (Void, req, res)
			end
		end

--	execute_post (req: WSF_REQUEST; res: WSF_RESPONSE)
--			-- Execute handler for `req' and respond in `res'.
--		local
--			rep: HM_WEBAPI_RESPONSE
--			l_user: detachable CMS_USER
--		do
--			if attached api.user as u and then api.has_permission ("admin users") then
--				if attached {WSF_STRING} req.path_parameter ("uid") as p_uid then
--					if p_uid.is_integer then
--						l_user := api.user_api.user_by_id (p_uid.integer_value)
--					else
--						l_user := api.user_api.user_by_name (p_uid.value)
--					end
----					if l_user = Void and p_uid.is_case_insensitive_equal ("me") then
----						l_user := u
----					end
--					if l_user /= Void then
--					else
--						rep := new_wepapi_error_response ("Not found", req, res)
--						rep.set_status_code ({HTTP_STATUS_CODE}.not_found)
--					end
--				else
--					rep := new_wepapi_error_response ("Bad request", req, res)
--					rep.set_status_code ({HTTP_STATUS_CODE}.bad_request)
--				end
--				rep.execute
--			else
--					-- FIXME: use specific Web API response!
--				send_access_denied (Void, req, res)
--			end
--		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
