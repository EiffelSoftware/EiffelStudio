note
	description: "Summary description for {ES_CLOUD_LICENSES_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSES_WEBAPI_HANDLER

inherit
	ES_CLOUD_WEBAPI_HANDLER

create
	make

feature -- Execution

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_user: ES_CLOUD_USER
		do
			if
				attached {WSF_STRING} req.path_parameter ("uid") as p_uid and then
				attached user_by_uid (p_uid.value) as l_cms_user
			then
				create l_user.make (l_cms_user)
				if req.is_get_request_method then
					if attached {WSF_STRING} req.path_parameter ("license_id") as lid then
						handle_license (a_version, l_user, lid.value, req, res)
					else
						list_licenses (a_version, l_user, req, res)
					end
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			else
				new_not_found_error_response ("User not found", req, res).execute
			end
		end

	handle_license (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; a_license: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			lic: ES_CLOUD_LICENSE
		do
			if a_user.same_as (api.user) or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
				r := new_response (req, res)
				if a_license.is_integer_64 then
					lic := es_cloud_api.license (a_license.to_integer_64)
				else
					lic := es_cloud_api.license_by_key (a_license)
				end
				if lic /= Void then
					r.add_table_iterator_field ("es:licence", license_to_table (lic))
					r.add_link ("licenses", "licenses", cloud_user_licenses_link (a_version, a_user))
					r.add_self (r.location)
				else
					r := new_error_response ("No license found", req, res)
				end
				add_cloud_user_links_to (a_version, a_user, r)
				r.execute
			else
				r := new_access_denied_error_response (Void, req, res)
			end
		end

	list_licenses (a_version: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb_licenses: STRING_TABLE [detachable ANY]
			k: READABLE_STRING_GENERAL
			l_embedded: BOOLEAN
		do
			if a_user.same_as (api.user) or else api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
				l_embedded := attached {WSF_STRING} req.query_parameter ("embedded")
				r := new_response (req, res)
				if attached es_cloud_api.user_licenses (a_user) as lst then
					create tb_licenses.make (lst.count)
					across
						lst as ic
					loop
						if attached ic.item as lic then
							k := lic.license.key
							if l_embedded then
								tb_licenses.force (license_to_table (lic), k)
							end
							r.add_link (url_encoded (k), detachable_html_encoded (k), cloud_user_license_link (a_version, a_user, k))
						end
					end
					if l_embedded then
						r.add_table_iterator_field ("es:licenses", tb_licenses)
					end
				end
				add_cloud_user_links_to (a_version, a_user, r)
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

