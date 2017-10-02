note
	description: "Summary description for {ES_CLOUD_INSTALLATIONS_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATIONS_WEBAPI_HANDLER

inherit
	ES_CLOUD_WEBAPI_HANDLER

create
	make

feature -- Execution

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_uid: READABLE_STRING_GENERAL
		do
			if
				attached {WSF_STRING} req.path_parameter ("uid") as p_uid and then
				attached user_by_uid (p_uid.value) as l_user
			then
				if req.is_get_request_method then
					if attached {WSF_STRING} req.path_parameter ("installation_id") as iid then
						handle_installation (l_user, iid.value, req, res)
					else
						list_installations (l_user, req, res)
					end
				elseif req.is_post_request_method then
					register_installation (l_user, req, res)
				else
					new_bad_request_error_response (Void, req, res).execute
				end
			else
				new_not_found_error_response ("User not found", req, res).execute
			end
		end

	handle_installation (a_user: CMS_USER; iid: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			inst: ES_CLOUD_INSTALLATION
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es acounts") then
				r := new_response (req, res)
				if attached es_cloud_api.user_installations (a_user) as lst then
					across
						lst as ic
					until
						inst /= Void
					loop
						inst := ic.item
						if not iid.same_string (inst.installation_id) then
							inst := Void
						end
					end
					if inst /= Void then
						r := new_response (req, res)
						create tb.make (2)
						tb.force (inst.installation_id, "id")
						tb.force (inst.info, "info")
						if attached inst.creation_date as dt then
							tb.force (dt, "creation_date")
						end
						if inst.is_active then
							tb.force ("yes", "is_active")
						else
							tb.force ("no", "is_active")
						end
						r.add_table_iterator_field ("es:installation", tb)
						r.add_self (r.location)
					else
						r := new_error_response ("Installation not found", req, res)
					end
					r.execute
				else
					r := new_error_response ("No installation found", req, res)
				end
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	list_installations (a_user: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es acounts") then
				r := new_response (req, res)
				if attached es_cloud_api.user_installations (a_user) as lst then
					create tb.make (lst.count)
					across
						lst as ic
					loop
						if attached ic.item as inst then
							tb.force (ic.item.info, ic.item.installation_id)
						end
					end
					r.add_table_iterator_field ("es:installations", tb)
				end
				add_user_links_to (a_user, r)
			else
				r := new_access_denied_error_response (Void, req, res)
			end
			r.execute
		end

	register_installation (a_user: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_post_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			f: CMS_FORM
			l_install_id: detachable READABLE_STRING_GENERAL
			err: BOOLEAN
		do
			if a_user.same_as (api.user) or else api.has_permission ("manage es acounts") then
				create f.make (req.percent_encoded_path_info, "es-register-installation")
				f.extend_text_field ("installation_id", Void)
				f.extend_text_field ("info", Void)
				r := new_response (req, res)
				f.process (r)
				if
					attached f.last_data as fd and then not fd.has_error
				then
					l_install_id := fd.string_item ("installation_id")
					if l_install_id /= Void then
						es_cloud_api.register_installation (a_user, l_install_id, fd.string_item ("info"))
						err := es_cloud_api.has_error
					end
				else
					err := True
				end
				if l_install_id = Void or err then
					r := new_error_response ("Error while registering new installation", req, res)
				else
					r := new_response (req, res)
					if l_install_id /= Void then
						--FIXME
						r.add_link ("es:installation", "registered", (api.absolute_url (r.location, Void) + "/" + api.url_encoded (l_install_id)))
					end
				end
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

