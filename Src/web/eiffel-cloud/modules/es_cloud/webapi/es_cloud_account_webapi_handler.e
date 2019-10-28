note
	description: "Summary description for {ES_CLOUD_ACCOUNT_WEBAPI_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ACCOUNT_WEBAPI_HANDLER

inherit
	ES_CLOUD_WEBAPI_HANDLER

create
	make

feature -- Execution

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_cms_user: detachable CMS_USER
			l_user: ES_CLOUD_USER
			l_uid: READABLE_STRING_GENERAL
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
		do
			if req.is_get_request_method then
				if attached api.user as u then
					if attached {WSF_STRING} req.path_parameter ("uid") as p_uid then
						l_cms_user := user_by_uid (p_uid.value)
					else
						l_cms_user := u
					end
					if l_cms_user /= Void then
						create l_user.make (l_cms_user)
					end
					if l_user = Void then
						r := new_not_found_error_response ("User not found", req, res)
					elseif
						l_user.same_as (u) or else api.has_permissions (<<"view es account", "manage es acounts">>)
					then
						r := new_response (req, res)
						r.add_integer_64_field ("uid", u.id)
						r.add_string_field ("name", api.real_user_display_name (u))
						if attached es_cloud_api.user_subscription (l_user) as sub then
							create tb.make (3)
							tb.force (sub.plan.id, "id")
							tb.force (sub.plan.name, "name")
							tb.force (date_time_to_string (sub.creation_date), "creation")
							tb.force (sub.is_active, "is_active")
							if attached sub.expiration_date as exp then
								tb.force (date_time_to_string (exp), "expiration")
								tb.force (sub.days_remaining, "days_remaining")
							end
							r.add_table_iterator_field ("es:plan", tb)
						else
							r.add_string_field ("es:plan", "none")
							-- Add link to subscription ...
						end
						add_user_links_to (l_user, r)
						r.add_link ("es:installations", Void, req.percent_encoded_path_info + "/installations")
						r.add_self (req.percent_encoded_path_info)
					else
						r := new_permissions_access_denied_error_response (<<"view es account", "manage es accounts">>, "Access denied for user " + u.id.out + " on user " + l_user.id.out, req, res)
					end
				else
					r := new_access_denied_error_response ("No authenticated user!", req, res)
				end
			else
				r := new_bad_request_error_response ("Only GET request!", req, res)
			end
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

