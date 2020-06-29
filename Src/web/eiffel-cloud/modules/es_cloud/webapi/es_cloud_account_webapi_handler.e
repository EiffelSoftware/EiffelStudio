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
			r: like new_response
			tb_plan, tb: STRING_TABLE [detachable ANY]
			lic: ES_CLOUD_LICENSE
			l_licenses: LIST [ES_CLOUD_USER_LICENSE]
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
						l_user.same_as (u) or else api.has_permissions (<<{ES_CLOUD_MODULE}.perm_view_es_accounts, {ES_CLOUD_MODULE}.perm_manage_es_accounts>>)
					then
						r := new_response (req, res)
						r.add_integer_64_field ("uid", l_user.id)
						r.add_string_field ("name", api.real_user_display_name (l_user))
						l_licenses := es_cloud_api.user_licenses (l_user)
						if l_licenses = Void or else l_licenses.is_empty then
								-- Auto trial ?
							if l_user.same_as (u) and then es_cloud_api.config.auto_trial_enabled then
								es_cloud_api.auto_assign_trial_to (u)
							end
						end
						if l_licenses /= Void and then not l_licenses.is_empty then
							create tb.make (l_licenses.count)
							across
								l_licenses as ic
							loop
								lic := ic.item.license
								if tb_plan = Void and then lic.is_active then
										-- Backward compatibility!
									tb_plan := license_to_table (lic)
								end
								tb.force (license_to_table (lic), lic.key)
							end
							r.add_table_iterator_field ("es:licenses", tb)
							if tb_plan = Void then
								tb_plan := license_to_table (l_licenses.first.license)
							end
							if tb_plan /= Void then
								r.add_table_iterator_field ("es:plan", tb_plan)
							end
						else
							if attached es_cloud_api.user_subscription (l_user) as sub then
									-- FIXME: check if this is the good place
								lic := es_cloud_api.converted_license_from_user_subscription (sub, Void)
								if lic /= Void then
									r.add_table_iterator_field ("es:plan", license_to_table (lic))
								end
							else
								create tb.make (0)
								r.add_table_iterator_field ("es:licenses", tb)
							end
						end

						add_cloud_user_links_to (a_version, l_user, r)
						add_user_links_to (l_user, r)
						r.add_link ("es:installations", Void, cloud_user_installations_link (a_version, l_user))
						r.add_link ("es:licenses", Void, cloud_user_licenses_link (a_version, l_user))
						r.add_self (req.percent_encoded_path_info)
					else
						r := new_permissions_access_denied_error_response (<<{ES_CLOUD_MODULE}.perm_view_es_accounts, {ES_CLOUD_MODULE}.perm_manage_es_accounts>>, "Access denied for user " + u.id.out + " on user " + l_user.id.out, req, res)
					end
				else
					r := new_access_denied_error_response ("No authenticated user!", req, res)
					add_cloud_link_to (a_version, r)
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

