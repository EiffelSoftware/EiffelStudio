note
	description: "Summary description for {ES_CLOUD_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod_api: ES_CLOUD_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			es_cloud_api := a_mod_api
		end

feature -- API

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				get_cloud (req, res)
--			elseif req.is_post_request_method then
			else
				send_bad_request (req, res)
			end
		end

	get_cloud (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_user: ES_CLOUD_USER
			r: like new_generic_response
			s: STRING
			l_plan: detachable ES_CLOUD_PLAN
			l_org: detachable ES_CLOUD_ORGANIZATION
			l_session: detachable ES_CLOUD_SESSION
			l_sessions: detachable LIST [ES_CLOUD_SESSION]
			inst: ES_CLOUD_INSTALLATION
			l_display_all: BOOLEAN
			k: READABLE_STRING_32
			ago: DATE_TIME_AGO_CONVERTER
			l_can_be_deleted,
			l_user_has_no_license: BOOLEAN
		do
			if attached req.query_parameter ("display") as d and then d.is_case_insensitive_equal ("all") then
				l_display_all := True
			end
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("EiffelStudio account")
			s := ""

			create ago.make

			if attached api.user as u then
				create l_user.make (u)
				s.append ("<p class=%"es-message%">User "+ api.html_encoded (api.real_user_display_name (u)) +"</p>")
					-- Plan
					-- Installation ...
				s.append ("<div class=%"es-installations%">")
				if
					attached es_cloud_api.user_installations (l_user) as l_installations and then
					not l_installations.is_empty
				then
					s.append ("<p>EiffelStudio is installed on " + l_installations.count.out + " devices: ")
					if l_display_all then
						s.append ("<a class=%"note%" href=%"" + req.percent_encoded_path_info + "%">only active sessions</a>")
					else
						s.append ("<a class=%"note%" href=%"" + req.percent_encoded_path_info +"?display=all%">include ended or expired</a>")
					end
					s.append ("<ul>")
					across
						l_installations as ic
					loop
						inst := ic.item
						l_sessions := es_cloud_api.user_sessions (l_user, inst.id, not l_display_all)
						s.append ("<li class=%"es-installation")
						-- FIXME: [2019-10-10]
						l_can_be_deleted := True
						if l_sessions = Void then
							s.append (" never")
						elseif across l_sessions as sess_ic all sess_ic.item.is_ended end then
							s.append (" closed")
						elseif across l_sessions as sess_ic all sess_ic.item.is_expired (es_cloud_api) end then
							s.append (" expired")
						elseif across l_sessions as sess_ic some not sess_ic.item.is_paused end then
							s.append (" active")
							l_can_be_deleted := False
						else
							s.append (" paused")
							l_can_be_deleted := False
						end
						if l_can_be_deleted and then api.has_permission ({ES_CLOUD_MODULE}.perm_discard_own_installations) then
							s.append (" discardable%" data-user-id=%""+ l_user.id.out +"%" data-installation-id=%""+ url_encoded (inst.id) +"%">")
						else
							s.append ("%">")
						end
						s.append (html_encoded (inst.id))
						if attached inst.creation_date as l_creation_date then
							s.append (" <span class=%"creation%" title=%"" + date_time_to_string (l_creation_date) + "%">")
							ago.append_date_to ("", l_creation_date, s)
--							s.append (date_time_to_string (l_creation_date))
							s.append ("</span>")
						end
						if l_sessions /= Void and then not l_sessions.is_empty then
							s.append ("<ul>")
							across
								l_sessions as sess_ic
							loop
								l_session := sess_ic.item
								if l_display_all or not (l_session.is_ended or l_session.is_expired (es_cloud_api)) then
									s.append ("<li class=%"session")
									if l_session.is_paused then
										k := "paused"
										s.append (" paused")
									elseif l_session.is_ended then
										k := "closed"
										s.append (" closed")
									elseif l_session.is_expired (es_cloud_api) then
										k := "expired"
										s.append (" expired")
									else
										k := "active"
										s.append (" active")
									end
									s.append ("%"")
									s.append (" data-session-id=%"" + html_encoded (l_session.id) + "%"")
									s.append (">")
									if attached l_session.title as l_session_title then
										s.append (html_encoded (l_session_title))
									else
										s.append (html_encoded (l_session.id))
									end
									s.append (" <em>")
									s.append (html_encoded (k))
									s.append ("</em>")

									s.append (" <span class=%"creation datetime_ago%" datetime=%""+ date_time_to_timestamp_string (l_session.first_date) +"%" title=%"" + date_time_to_string (l_session.first_date) + "%">")
									ago.append_date_to ("", l_session.first_date, s)
--									s.append (date_time_to_string (l_session.first_date))
									s.append ("</span>")
									s.append (" <span class=%"access datetime_ago%" datetime=%""+ date_time_to_timestamp_string (l_session.last_date) +"%" title=%"" + date_time_to_string (l_session.last_date) + "%">")
									ago.append_date_to ("", l_session.last_date, s)
--									s.append (date_time_to_string (l_session.last_date))
									s.append ("</span>")
									s.append ("</li>")
								end
							end
							s.append ("</ul>")
						end
						s.append ("</li>%N")
					end

					s.append ("</ul></p>")
				else
					s.append ("<p>EiffelStudio is not yet installed.</p>")
				end
				s.append ("</div>")

				s.append ("<div class=%"es-organizations%">")
				if attached es_cloud_api.user_organizations (l_user) as l_orgs then
					across
						l_orgs as o_ic
					loop
						l_org := o_ic.item
						if es_cloud_api.is_organization_manager (l_user, l_org) then
							s.append ("<p>Manager of organization: <span class=%"es-org-title%">")
							s.append ("<a href=%"" + api.administration_path ("cloud/organizations/" + l_org.id.out + "/") + "%">")
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

				s.append ("<div class=%"es-licenses%">")
				if attached es_cloud_api.user_licenses (l_user) as lics and then not lics.is_empty then
					across
						lics as ic
					loop
						if
							attached ic.item as l_user_lic and then
							attached l_user_lic.license as lic
						then
							l_plan := lic.plan
							s.append ("<p>License "+ html_encoded (lic.key) + " for plan <span class=%"es-plan-title%">")
							s.append (html_encoded (l_plan.title_or_name))
							s.append ("</span>")
							s.append ("<ul>")
							s.append ("<li class=%"creation%">Started ")
							s.append (api.date_time_to_string (lic.creation_date))
							s.append ("</li>")
							if lic.is_active then
								if attached lic.expiration_date as exp then
									s.append ("<li class=%"expiration%">Renewal date ")
									s.append (api.date_time_to_string (exp))
									s.append (" (")
									s.append (lic.days_remaining.out)
									s.append (" days remaining)")
									s.append ("</li>")
								else
									s.append ("<li class=%"status success%">ACTIVE</li>")
								end
							elseif lic.is_fallback then
								s.append ("<li class=%"status warning%">Fallback license</li>")
							else
								s.append ("<li class=%"status warning%">EXPIRED</li>")
							end
							if attached lic.platforms_as_csv_string as l_platforms then
								s.append ("<li class=%"limit warning%">Limited to platform(s): " + html_encoded (l_platforms) + "</li>")
							end
							if attached lic.version as l_product_version then
								s.append ("<li class=%"limit warning%">Limited to version: " + html_encoded (l_product_version) + "</li>")
							end
							if attached es_cloud_api.license_installations (lic) as lst and then not lst.is_empty then
								s.append ("<li class=%"limit%">Installation(s): " + lst.count.out)
								if l_plan.installations_limit > 0 then
									s.append (" / " + l_plan.installations_limit.out + " device(s)")
									if l_plan.installations_limit.to_integer_32 <= lst.count then
										s.append (" (<span class=%"warning%">No more installation available</span>)")
										s.append ("<div class=%"es-installations%">To install on another device, please revoke one the previous installation(s):")
									end
								end
								s.append ("<ul>")
								across
									lst as inst_ic
								loop
									inst := inst_ic.item
									s.append ("<li class=%"es-installation discardable%" data-user-id=%"" + u.id.out + "%" data-installation-id=%"" + url_encoded (inst.id) + "%" >")
									s.append (html_encoded (inst.id))
									s.append ("</li>%N")
								end
								s.append ("</ul>")

								s.append ("</li>")
							elseif l_plan.installations_limit > 0 then
								s.append ("<li class=%"limit warning%">Can be installed on: " + l_plan.installations_limit.out + " devices</li>")
							end
							if l_plan.platforms_limit > 0 then
								s.append ("<li class=%"limit warning%">Can be installed on: " + l_plan.platforms_limit.out + " different platforms</li>")
							end

							s.append ("</ul>")
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
					end
					s.append ("</ul>")
					s.append ("</div>")
				end


			else
				s.append ("<p>Please Login or Register...</p>")
			end
			if l_plan = Void then
				s.append ("<div class=%"es-plans%">")
				s.append ("<strong>Plans</strong><ul>")
				across
					es_cloud_api.sorted_plans as ic
				loop
					l_plan := ic.item
					if l_plan.is_public then
						s.append ("<li class=%"es-plan-box%"><div class=%"title%">")
						s.append (html_encoded (l_plan.title_or_name))
						s.append ("</div>")
						if attached l_plan.description as l_plan_description then
							s.append ("<div class=%"description%">"+ html_encoded (l_plan_description) + "</div>")
						end
						s.append ("</li>")
					end
				end
				s.append ("</ul>")
				s.append ("</div>")
			end
			r.set_main_content (s)
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

