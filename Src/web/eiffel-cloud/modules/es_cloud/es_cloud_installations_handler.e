note
	description: "Summary description for {ES_CLOUD_INSTALLATIONS_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATIONS_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod: ES_CLOUD_MODULE; a_mod_api: ES_CLOUD_API)
		do
			es_cloud_module := a_mod
			make_with_cms_api (a_mod_api.cms_api)
			es_cloud_api := a_mod_api
		end

feature -- API

	es_cloud_module: ES_CLOUD_MODULE

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				if attached req.path_parameter ("installation_id") as l_inst_id then
					process_installation_get (l_inst_id.string_representation, req, res)
				else
					process_installations_get (req, res)
				end
			else
				send_bad_request (req, res)
			end
		end

	process_installation_get (a_inst_id: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
		do
			if
				attached api.user as u and then
				attached es_cloud_api.user_installation (u, a_inst_id) as inst
			then
				r := new_generic_response (req, res)
				r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
				r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
				r.set_title ("Installation")
				s := ""
				s.append ("<div class=%"es-installation%">")
				append_installation_to_html (inst, u, s)
				s.append ("</div>") -- es-installation
				r.set_main_content (s)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

	process_installations_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			ago: DATE_TIME_AGO_CONVERTER
			inst: ES_CLOUD_INSTALLATION
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("EiffelStudio Installations")
			s := ""

			create ago.make

			if attached api.user as u then
				s.append ("<div class=%"es-user%"><strong>Account:</strong> "+ api.html_encoded (api.real_user_display_name (u)) +"</div>")

					-- List of licenses
				s.append ("<div class=%"es-installations%"><ul>")
				if attached es_cloud_api.user_installations (u) as lst and then not lst.is_empty then
					across
						lst as inst_ic
					loop
						inst := inst_ic.item
						if u /= Void then
							s.append ("<li class=%"es-installation discardable%" data-user-id=%"" + u.id.out + "%" data-installation-id=%"" + url_encoded (inst.id) + "%" >")
						else
							s.append ("<li class=%"es-installation discardable%">")
						end
						if es_cloud_module /= Void then
							s.append ("<a href=%"" + api.location_url (es_cloud_module.installation_location (inst), Void) + "%">")
							s.append (html_encoded (inst.id))
							s.append ("</a></li>%N")
						else
							s.append (html_encoded (inst.id))
						end
					end
				end
				s.append ("</ul></div>")
			else
				s.append ("<p>Please Login or Register...</p>")
			end
			r.set_main_content (s)
			r.execute
		end

	append_installation_to_html (inst: ES_CLOUD_INSTALLATION; u: ES_CLOUD_USER; s: STRING_8)
		local
			l_inst_lic,
			lic: ES_CLOUD_LICENSE
		do
			-- FIXME jfiat [2024/01/26] : es_cloud_api.append_license_to_html (lic, u, es_cloud_module, s)
			s.append ("<div class=%"es-installation%"><p><strong>")
			s.append (percent_encoded (inst.id))
			s.append ("</strong>:")
			if inst.is_active then
				s.append (" <span class=%"status success%">(Active)</span>")
			end
			s.append ("</p>")
			l_inst_lic := es_cloud_api.license (inst.license_id)
			if l_inst_lic /= Void then
				s.append ("<div class=%"title%">Associated license</div><div class=%"es-licenses%">%N")
				es_cloud_api.append_one_line_license_view_to_html (l_inst_lic, u, es_cloud_module, s)
				s.append ("</div>")
			end
			if attached es_cloud_api.other_adapted_licenses (u, inst) as lst then
				s.append ("<div class=%"title%">Available license(s)</div>%N")
				s.append ("<div class=%"es-adapted-licenses%"><ul>%N")
				across
					lst as ic
				loop
					lic := ic.item
					if l_inst_lic /= Void then
						s.append ("<li class=%"available%""
										+" data-user-id=%""+ u.id.out +"%" data-installation-id=%""+percent_encoded (inst.id)+"%""
										+" data-license-id=%""+ percent_encoded (l_inst_lic.key) +"%""
										+" data-new-license-id=%""+ percent_encoded (lic.key) +"%""
										+">")
					else
						s.append ("<li>")
					end

					es_cloud_api.append_one_line_license_view_to_html (lic, u, es_cloud_module, s)
					s.append ("</li>%N")
				end
				s.append ("</ul></div>")
			end
			s.append ("</div>")
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

