note
	description: "Summary description for {ES_CLOUD_STATISTICS_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STATISTICS_HANDLER

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
			if api.has_permission ({ES_CLOUD_MODULE}.perm_access_es_stats) then
				if req.is_get_request_method then
					process_get (req, res)
				else
					send_bad_request (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	process_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			lic: ES_CLOUD_LICENSE
			f: CMS_FORM
			f_select: WSF_FORM_SELECT
			f_opt: WSF_FORM_SELECT_OPTION
			f_div: WSF_WIDGET_DIV
			f_cb: WSF_FORM_CHECKBOX_INPUT
			l_plan_filter: detachable READABLE_STRING_GENERAL
			l_expiring_before_n_days_filter: INTEGER
			lics: LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER; email: detachable READABLE_STRING_8; org: detachable ES_CLOUD_ORGANIZATION]]
			s: STRING
			l_inc_expired: BOOLEAN
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("EiffelStudio Statistics")
			s := ""

			if attached {WSF_STRING} req.query_parameter ("plan") as p_plan then
				l_plan_filter := p_plan.value
			end

			if attached {WSF_STRING} req.query_parameter ("with_expired") as p_include_expired then
				l_inc_expired := p_include_expired.is_case_insensitive_equal ("yes")
			end

			if attached {WSF_STRING} req.query_parameter ("expiring_before_n_days") as p_expiring_before_n_days then
				l_expiring_before_n_days_filter := p_expiring_before_n_days.value.to_integer_32
				if l_expiring_before_n_days_filter <= 0 then
					l_expiring_before_n_days_filter := 0
				end
			end
			if l_plan_filter /= Void then
				if l_plan_filter.is_case_insensitive_equal ("$") then
					create s.make_from_string ("<h1>Licenses for priced plans</h1>")
				else
					create s.make_from_string ("<h1>Licenses for plan %"" + html_encoded (l_plan_filter) + "%"</h1>")
				end
			else
				create s.make_from_string ("<h1>Licenses</h1>")
			end

			s.append ("Filters: ")
			create f.make (req.percent_encoded_path_info, "licenses-filter")
			f.set_method_get
			f.add_css_style ("display: inline-block")
			if attached es_cloud_api.sorted_plans as l_sorted_plans then
				create f_div.make
				f.extend (f_div)
				f_div.add_css_style ("display: inline-block")
				create f_select.make ("plan")
				f_div.extend (f_select)
				create f_opt.make ("", "All plans")
				f_select.add_option (f_opt)
				create f_opt.make ("$", "has price")
				f_select.add_option (f_opt)
				if l_plan_filter /= Void and then l_plan_filter.is_case_insensitive_equal ("$") then
					f_opt.set_is_selected (True)
				end
				across
					l_sorted_plans as ic
				loop
					create f_opt.make (ic.item.name, ic.item.title_or_name)
					f_select.add_option (f_opt)
					if l_plan_filter /= Void and then l_plan_filter.is_case_insensitive_equal (ic.item.name) then
						f_opt.set_is_selected (True)
					end
				end
				f_select.add_html_attribute ("onchange", "this.form.submit();")
			end
			if l_expiring_before_n_days_filter > 0 or l_plan_filter /= Void  then
				f.extend_html_text (" | <a href=%"" + req.script_url (req.percent_encoded_path_info) + "%">All the licenses</a>")
			end

				-- Licenses expiring before 7 days ?
			f.extend_html_text (" | ")
			if l_expiring_before_n_days_filter > 0 then
				create f_cb.make_with_value ("expiring_before_n_days", l_expiring_before_n_days_filter.out)
				f_cb.set_title ("expiring before " + l_expiring_before_n_days_filter.out + " days")
				f_cb.set_checked (True)
			else
				create f_cb.make_with_value ("expiring_before_n_days", "7")
				f_cb.set_title ("expiring before 7 days")
			end
			f_cb.add_html_attribute ("onchange", "this.form.submit();")
			create f_div.make
			f.extend (f_div)
			f_div.add_css_style ("display: inline-block")
			f_div.extend (f_cb)

				-- Include expired licenses?
			f.extend_html_text (" | ")
			create f_cb.make_with_value ("with_expired", "yes")
			if l_inc_expired then
				f_cb.set_checked (True)
			end
			f_cb.set_title ("expired licenses")
			f_cb.add_html_attribute ("onchange", "this.form.submit();")
			create f_div.make
			f.extend (f_div)
			f_div.add_css_style ("display: inline-block")
			f_div.extend (f_cb)

			f.append_to_html (r.wsf_theme, s)

			if l_expiring_before_n_days_filter > 0 then
				s.append ("<br/>Currently listing licenses expiring before " + l_expiring_before_n_days_filter.out + " days.")
			end

				-- List of licenses
			s.append ("<div class=%"es-licenses es-stats%">")
			if l_plan_filter /= Void then
				if l_plan_filter.is_case_insensitive_equal ("$") then
					lics := es_cloud_api.licenses
					from
						lics.start
					until
						lics.after
					loop
						if lics.item.license.plan.has_price then
							lics.forth
						else
							lics.remove
						end
					end
				elseif attached es_cloud_api.plan_by_name (l_plan_filter) as pl then
					lics := es_cloud_api.licenses_for_plan (pl)
				else
					lics := es_cloud_api.licenses
				end
			else
				lics := es_cloud_api.licenses
			end
			if l_expiring_before_n_days_filter > 0 then
				from
					lics.start
				until
					lics.after
				loop
					lic := lics.item.license
					if lic.is_expired and l_inc_expired then
							--Keep
						lics.forth
					elseif lic.expiration_date = Void then
							-- No expiration
						lics.remove
					elseif lic.days_remaining <= l_expiring_before_n_days_filter then
							--Keep
						lics.forth
					else
						lics.remove
					end
				end
			end
			if not l_inc_expired then
				from
					lics.start
				until
					lics.after
				loop
					if lics.item.license.is_expired then
						lics.remove
					else
						lics.forth
					end
				end
			end

			if lics /= Void and then not lics.is_empty then
				s.append ("<div class=%"count%">Count="+ lics.count.out + "</div>")
				across
					lics as ic
				loop
					lic := ic.item.license
					if attached lic then
						append_license_to_html (lic, ic.item.user, ic.item.email, s)
					end
				end
			end
			s.append ("</div>")

			r.set_main_content (s)
			r.execute
		end

	append_license_to_html (lic: ES_CLOUD_LICENSE; u: detachable ES_CLOUD_USER; a_email: detachable READABLE_STRING_8; s: STRING_8)
		local
			l_plan: detachable ES_CLOUD_PLAN
			l_email: READABLE_STRING_8
		do
			l_email := a_email
			if l_email = Void and u /= Void then
				u.update_user (api)
				l_email := u.cms_user.email
			end
			l_plan := lic.plan
			s.append ("<div class=%"es-license%">")
			s.append ("<span class=%"title%">")
			s.append (html_encoded (l_plan.title_or_name))
			s.append ("</span> ")
			s.append ("<div class=%"license-id%">License: <span class=%"id%">")
			s.append ("<a href=%"" + api.location_url (es_cloud_module.license_location (lic), Void) + "%">")
			s.append (html_encoded (lic.key))
			s.append ("</a>")
			s.append ("</span>")
			if lic.platforms /= Void or lic.version /= Void then
				s.append ("<span class=%"condition%">")
				if attached lic.platforms_as_csv_string as l_platforms then
					s.append (" platforms:" + html_encoded (l_platforms))
				end
				if attached lic.version as l_version then
					s.append (" version:" + html_encoded (l_version))
				end
				s.append ("</span>")
			end
			s.append ("</div>")
			if u /= Void then
				s.append ("<span class=%"user%">User ")
				if api.has_permission ({ES_CLOUD_MODULE}.perm_manage_es_accounts) then
					s.append (es_cloud_api.account_html_administration_link (u))
				elseif api.has_permission ({ES_CLOUD_MODULE}.perm_view_es_accounts) then
					s.append (es_cloud_api.account_html_link (u))
				elseif api.has_permission ({CMS_CORE_MODULE}.perm_view_users) then
					s.append (api.user_html_link (u))
				else
					s.append (html_encoded (api.real_user_display_name (u)))
				end
				if l_email /= Void then
					s.append (" &lt;")
					s.append (html_encoded (l_email))
					s.append ("&gt;")
				end
				s.append ("</span> ")
			elseif l_email /= Void then
				s.append ("<span class=%"email%">Email ")
				s.append (" &lt;")
				s.append (html_encoded (l_email))
				s.append ("&gt;")
				s.append ("</span> ")
			end
			s.append ("<span class=%"details%">")
			s.append ("<span class=%"date%">Created: ")
			s.append (date_time_to_iso8601_string (lic.creation_date))
			s.append ("</span>")
			if lic.is_active then
				if attached lic.expiration_date as exp then
					s.append ("<span class=%"expiration%">")
					s.append (lic.days_remaining.out)
					s.append (" days remaining")
					s.append ("</span>")
				else
					s.append ("<span class=%"status%">Active</span>")
				end
			elseif lic.is_fallback then
				s.append ("<span class=%"status%">Fallback license</span>")
			else
				s.append ("<span class=%"status warning%">Expired</span>")
			end
			if lic.plan.has_price and then attached es_cloud_api.license_subscription (lic) as sub then
				s.append ("<span class=%"status payment%">")
				if sub.is_onetime then
					s.append ("one-time")
				elseif sub.is_monthly then
					s.append ("monthly")
				elseif sub.is_yearly then
					s.append ("yearly")
				elseif sub.is_weekly then
					s.append ("weekly")
				elseif sub.is_daily then
					s.append ("daily")
				else
--					if attached sub.subscription_reference as ref then
--						s.append (html_encoded (ref))
--						s.append (",")
--					end
--					s.append ("type#" + sub.interval_type.out + ",interval#" + sub.interval_count.out)
				end
				s.append ("</span>")
			end
			s.append ("</div>")
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

