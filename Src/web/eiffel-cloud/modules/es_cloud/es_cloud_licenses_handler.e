note
	description: "Summary description for {ES_CLOUD_LICENSES_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSES_HANDLER

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
				process_get (req, res)
			elseif req.is_post_request_method then
				process_post (req, res)
			else
				send_bad_request (req, res)
			end
		end

	process_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING_8
--			l_plan: ES_CLOUD_PLAN
		do
			r := new_generic_response (req, res)
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)

			create s.make_empty

			s.append ("<h2>Buy a new license</h2>")

--			s.append ("<div class=%"es-plans%">")
--			s.append ("<strong>Plans</strong><ul>")
--			across
--				es_cloud_api.sorted_plans as ic
--			loop
--				l_plan := ic.item
--				if l_plan.is_public then
--					s.append ("<li class=%"es-plan-box%"><div class=%"title%">")
--					s.append (html_encoded (l_plan.title_or_name))
--					s.append ("</div>")
--					if attached l_plan.description as l_plan_description then
--						s.append ("<div class=%"description%">"+ html_encoded (l_plan_description) + "</div>")
--					end
--					s.append ("</li>")
--				end
--			end
--			s.append ("</ul>")
--			s.append ("</div>")
			if attached es_cloud_module.new_store_block (es_cloud_api, r) as bl then
				r.add_block (bl, "content")
				r.add_style (r.module_resource_url (es_cloud_module, "/files/css/pricing.css", Void), Void)
			end

			r.set_main_content (s)
			r.execute
		end

	process_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_user: ES_CLOUD_USER
			r: like new_generic_response
			s: STRING
			l_plan: detachable ES_CLOUD_PLAN
			l_org: detachable ES_CLOUD_ORGANIZATION
			ago: DATE_TIME_AGO_CONVERTER
			l_user_has_no_license: BOOLEAN
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("EiffelStudio account")
			s := ""

			create ago.make

			if attached api.user as u then
				create l_user.make (u)
				s.append ("<p class=%"es-message%">User "+ api.html_encoded (api.real_user_display_name (u)) +"</p>")
					-- Organisations
				s.append ("<div class=%"es-organizations%">")
				if attached es_cloud_api.user_organizations (l_user) as l_orgs then
					across
						l_orgs as o_ic
					loop
						l_org := o_ic.item
						if es_cloud_api.is_organization_manager (l_user, l_org) then
							s.append ("<p>Manager of organization: <span class=%"es-org-title%">")
							s.append ("<a href=%"" + api.administration_path ("cloud/organizations/?org=" + l_org.id.out) + "%">")
							s.append (html_encoded (l_org.title_or_name))
							s.append ("</a></span></p>")
						else
							s.append ("<p>Member of organization: <span class=%"es-org-title%">")
							s.append (html_encoded (l_org.title_or_name))
							s.append ("</span></p>")
						end
					end
				end
				s.append ("</div>")

					-- Buy new license button
					-- FIXME: remove when licensing is live !
				if attached u.email as l_email and then l_email.ends_with_general ("@eiffel.com") then
					s.append ("<div><div class=%"es-new-license%"><form action=%""+ r.location_url ({ES_CLOUD_MODULE}.licenses_location, Void) +"%" method=%"post%"><input type=%"submit%" class=%"button%" title=%"Buy a new license%" name=%"op%" value=%"Buy new license%"></input></form></div></div>")
				end

				if
					attached l_user.cms_user.email as l_email and then
					attached es_cloud_api.email_licenses (l_email) as lst and then
					not lst.is_empty
				then
					across
						lst as ic
					loop
						es_cloud_api.move_email_license_to_user (ic.item, l_user)
						s.append ("<div>Retrieving license " + html_encoded (ic.item.license.key))
						s.append (" ... </div>")
					end
				end

					-- List of licenses
				s.append ("<div class=%"es-licenses%">")
				if attached es_cloud_api.user_licenses (l_user) as lics and then not lics.is_empty then
					across
						lics as ic
					loop
						if
							attached ic.item as l_user_lic and then
							attached l_user_lic.license as lic
						then
							append_license_to_html (lic, l_user, s)
						end
					end
				else
					s.append ("Please subscribe to a license ...")
					l_user_has_no_license := True
				end
				s.append ("</div>")

				if
					l_user_has_no_license and then
					attached es_cloud_api.user_subscription (l_user) as sub
				then
					s.append ("<div class=%"es-subscription%">")
					l_plan := sub.plan
					s.append ("<p>You are subscribed to plan: <span class=%"es-plan-title%">")
					s.append (html_encoded (l_plan.title_or_name))
					s.append ("</span>")
					s.append ("<ul>")
					if attached {ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION} sub as org_sub then
						s.append (" <li class=%"organization%">As member of organization ")
						s.append (html_encoded (org_sub.organization.title_or_name))
						s.append ("</li>")
					end
					s.append ("<li class=%"creation%">Started ")
					s.append (api.date_time_to_string (sub.creation_date))
					s.append ("</li>")
					if sub.is_active then
						if attached sub.expiration_date as exp then
							s.append ("<li class=%"expiration%">Renewal date ")
							s.append (api.date_time_to_string (exp))
							s.append (" (")
							s.append (sub.days_remaining.out)
							s.append (" days remaining)")
							s.append ("</li>")
						else
							s.append ("<li class=%"status success%">ACTIVE</li>")
						end
					else
						s.append ("<li class=%"status warning%">EXPIRED</li>")
						if attached sub.expiration_date as exp then
							s.append ("<li class=%"expiration%">Expiration date ")
							s.append (api.date_time_to_string (exp))
							s.append ("</li>")
						end
					end
					s.append ("</ul>")
					s.append ("</div>")
					if sub /= Void then
						if attached {ES_CLOUD_LICENSE} es_cloud_api.converted_license_from_user_subscription (sub, Void) as lic then
							s.append ("<div>Subscription converted to license " + html_encoded (lic.key))
							s.append ("</div>")
						end
					end
				end
			else
				s.append ("<p>Please Login or Register...</p>")
			end

			r.set_main_content (s)
			r.execute
		end

	append_license_to_html (lic: ES_CLOUD_LICENSE; u: ES_CLOUD_USER; s: STRING_8)
		local
			l_plan: detachable ES_CLOUD_PLAN
			inst: ES_CLOUD_INSTALLATION
		do
			l_plan := lic.plan
			s.append ("<div class=%"es-license%">")
			s.append ("<div class=%"header%">")
			s.append ("<div class=%"title%">")
			s.append (html_encoded (l_plan.title_or_name))
			s.append ("</div>")
			s.append ("<div class=%"license-id%">License ID: <span class=%"id%">")
			s.append (html_encoded (lic.key))
			s.append ("</span></div>")
			s.append ("</div>") -- header
			s.append ("<div class=%"details%"><ul>")
			s.append ("<li class=%"creation%"><span class=%"title%">Started</span> ")
			s.append (api.date_time_to_string (lic.creation_date))
			s.append ("</li>")
			if lic.is_active then
				if attached lic.expiration_date as exp then
					s.append ("<li class=%"expiration%"><span class=%"title%">Renewal date</span> ")
					s.append (api.date_time_to_string (exp))
					s.append (" (")
					s.append (lic.days_remaining.out)
					s.append (" days remaining)")
					s.append ("</li>")
				else
					s.append ("<li class=%"status success%">ACTIVE</li>")
				end
			elseif lic.is_fallback then
				s.append ("<li class=%"status notice%">Fallback license</li>")
			else
				s.append ("<li class=%"status warning%">EXPIRED</li>")
			end
			if attached lic.platform as l_platform then
				s.append ("<li class=%"limit%"><span class=%"title%">Limited to platform:</span> " + html_encoded (l_platform) + "</li>")
			end
			if attached lic.version as l_product_version then
				s.append ("<li class=%"limit%"><span class=%"title%">Limited to version:</span> " + html_encoded (l_product_version) + "</li>")
			end
			if attached es_cloud_api.license_installations (lic) as lst and then not lst.is_empty then
				s.append ("<li class=%"limit%"><span class=%"title%">Installation(s):</span> " + lst.count.out)
				if l_plan.installations_limit > 0 then
					s.append (" / " + l_plan.installations_limit.out + " device(s)")
					if l_plan.installations_limit.to_integer_32 <= lst.count then
						s.append (" (<span class=%"warning%">No more installation available</span>)")
						s.append ("<p>To install on another device, please revoke one the previous installation(s):</p>")
					end
				end
				s.append ("<div class=%"es-installations%"><ul>")
				across
					lst as inst_ic
				loop
					inst := inst_ic.item
					s.append ("<li class=%"es-installation discardable%" data-user-id=%"" + u.id.out + "%" data-installation-id=%"" + url_encoded (inst.id) + "%" >")
					s.append (html_encoded (inst.id))
					s.append ("</li>%N")
				end
				s.append ("</ul></div>")

				s.append ("</li>")
			elseif l_plan.installations_limit > 0 then
				s.append ("<li class=%"limit warning%">Can be installed on: " + l_plan.installations_limit.out + " device(s)</li>")
			end
			s.append ("<li><a href=%"" + api.location_url (es_cloud_module.license_activities_location (lic), Void) + "%">Associated activities...</a> ")
			s.append ("</li>")

			s.append ("</ul></div>")
			s.append ("</div>")
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

