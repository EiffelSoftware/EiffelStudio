note
	description: "Summary description for {ES_CLOUD_LICENSES_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSES_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER
		rename
			make as make_admin_handler
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Creation

	make (a_es_cloud_api: ES_CLOUD_API; a_admin_module: ES_CLOUD_MODULE_ADMINISTRATION)
		do
			admin_module := a_admin_module
			make_admin_handler (a_es_cloud_api)
		end

feature -- Access

	admin_module: ES_CLOUD_MODULE_ADMINISTRATION

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
		do
			if attached {WSF_STRING} req.path_parameter ("license") as p_license then
				handle_license (p_license.value, req, res)
			elseif req.is_post_request_method then
				handle_licenses_group_action (req, res)
			else
				handle_licenses_list (req, res)
			end
		end

	handle_license (a_lic_id: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			lic: ES_CLOUD_LICENSE
			l_email_lic: detachable ES_CLOUD_EMAIL_LICENSE
			s: STRING
			r: like new_generic_response
			f: CMS_FORM
			fset: WSF_FORM_FIELD_SET
			l_user: detachable ES_CLOUD_USER
		do
			if api.has_permission ("admin es licenses") then
				lic := es_cloud_api.license_by_key (a_lic_id)
				if lic = Void and a_lic_id.is_integer_64 then
					lic := es_cloud_api.license (a_lic_id.to_integer_64)
				end
				if lic = Void then
					send_not_found (req, res)
				else
					l_user := es_cloud_api.user_for_license (lic)

					r := new_generic_response (req, res)
					create s.make_empty

						-- Edit form
					create f.make (r.absolute_url (req.percent_encoded_path_info, Void), "edit-license")
					f.set_method_post
					if l_user = Void then
						l_email_lic := es_cloud_api.email_license (lic)
					end
					if l_email_lic /= Void then
						admin_module.add_assign_email_license_form_part_to (l_email_lic, f, es_cloud_api)
					end

					create fset.make
					fset.set_legend ("Edit license " + html_encoded (lic.key))
					f.extend (fset)
					admin_module.add_license_form_part_to (lic, fset, es_cloud_api)
					if req.is_post_request_method then
						f.validation_actions.extend (agent admin_module.license_form_validation_action (?, l_user, lic, es_cloud_api))
						f.process (r)
						if attached es_cloud_api.license_by_key (lic.key) as l_updated_lic then
							lic := l_updated_lic
						end
						es_cloud_api.append_license_to_html (lic, l_user, Void, s)

							-- Update form with fresh data.
						create f.make (r.absolute_url (req.percent_encoded_path_info, Void), "edit-license")
						f.set_method_post
						if l_email_lic /= Void then
							admin_module.add_assign_email_license_form_part_to (l_email_lic, f, es_cloud_api)
						end

						create fset.make
						f.extend (fset)
						admin_module.add_license_form_part_to (lic, fset, es_cloud_api)

						f.append_to_html (r.wsf_theme, s)
					else
						es_cloud_api.append_license_to_html (lic, l_user, Void, s)
						f.append_to_html (r.wsf_theme, s)
					end

					r.set_main_content (s)
					r.execute
				end
			end
		end

	handle_licenses_list (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			lic: detachable ES_CLOUD_LICENSE
			s: STRING
			l_user: ES_CLOUD_USER
			l_plan_filter: detachable READABLE_STRING_GENERAL
			l_expiring_before_n_days_filter: INTEGER
			l_inc_expired, l_only_expired: BOOLEAN
			l_org: ES_CLOUD_ORGANIZATION
			l_email, l_user_email: READABLE_STRING_8
--			orgs: detachable LIST [ES_CLOUD_ORGANIZATION]
			lics: LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER; email: detachable READABLE_STRING_8; org: detachable ES_CLOUD_ORGANIZATION]]
			f: CMS_FORM
			f_select: WSF_FORM_SELECT
			f_opt: WSF_FORM_SELECT_OPTION
			f_div: WSF_WIDGET_DIV
			f_cb: WSF_FORM_CHECKBOX_INPUT
		do
			if api.has_permissions (<< {ES_CLOUD_MODULE}.perm_manage_es_accounts, {ES_CLOUD_MODULE}.perm_manage_es_licenses >>) then
				r := new_generic_response (req, res)
				add_primary_tabs (r)

				if attached {WSF_STRING} req.query_parameter ("plan") as p_plan then
					l_plan_filter := p_plan.value
					if l_plan_filter.is_whitespace then
						l_plan_filter := Void
					end
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
				if attached {WSF_STRING} req.query_parameter ("only_expired") as p_only_expired then
					l_only_expired := p_only_expired.is_case_insensitive_equal ("yes")
					if l_only_expired then
						l_expiring_before_n_days_filter := 0
						l_inc_expired := True
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

					-- Licenses already expired?
				if l_expiring_before_n_days_filter = 0 then
					f.extend_html_text (" | ")
					create f_cb.make_with_value ("only_expired", "yes")
					f_cb.set_title ("only expired")
					f_cb.set_checked (l_only_expired)

					f_cb.add_html_attribute ("onchange", "this.form.submit();")
					create f_div.make
					f.extend (f_div)
					f_div.add_css_style ("display: inline-block")
					f_div.extend (f_cb)
				end

					-- Licenses expiring before 7 days ?
				if not l_only_expired then
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
					f_cb.set_title ("with expired licenses")
					f_cb.add_html_attribute ("onchange", "this.form.submit();")

					create f_div.make
					f.extend (f_div)
					f_div.add_css_style ("display: inline-block")
					f_div.extend (f_cb)

				end

				f.append_to_html (r.wsf_theme, s)

				if l_expiring_before_n_days_filter > 0 then
					s.append ("<br/>Currently listing licenses expiring before " + l_expiring_before_n_days_filter.out + " days.")
				end

					-- Filter licenses
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
				if l_only_expired then
					from
						lics.start
					until
						lics.after
					loop
						lic := lics.item.license
						if lic.is_expired then
								--Keep
							lics.forth
						elseif lic.expiration_date = Void then
								-- No expiration
							lics.remove
						else
							lics.remove
						end
					end
				elseif l_expiring_before_n_days_filter > 0 then
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

					-- Display...				
				s.append ("<form action=%"" + req.percent_encoded_path_info + "%" method=%"post%" class=%"roc-select-all%">%N")
				across
					req.query_parameters as ic
				loop
					if attached {WSF_STRING} ic.item as q then
						s.append ("<input type=%"hidden%" name=%"" + q.url_encoded_name + "%" value =%"" + q.url_encoded_value + "%" />%N")
					end
				end
				s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Entity</th><th>Owner</th><th>Plan</th><th>Conditions</th><th>Until</th><th>Last</th><th>organization(s)</th>")
				s.append ("</tr>")
				across
					lics as ic
				loop
					lic := ic.item.license
					l_user := ic.item.user
					l_email := ic.item.email
					l_org :=  ic.item.org
					if lic /= Void then
						s.append ("<tr><td>")
						s.append ("<input type=%"checkbox%" name=%"licenses[" + url_encoded (lic.key) + "]%"/> ")
						s.append ("<a href=%"")
						s.append (api.location_url (r.location + url_encoded (lic.key), Void))
						s.append ("%">")
						s.append (html_encoded (lic.key))
						s.append ("</a>")
						s.append ("<!-- " + lic.id.out + " -->")
						s.append ("</td>")
						if l_user /= Void then
							s.append ("<td class=%"user%">")
							l_user_email := l_user.cms_user.email
							if l_user_email = Void then
								l_user.update_user (api)
								l_user_email := l_user.cms_user.email
							end
							s.append ("<a href=%"")
							s.append (es_cloud_api.account_administration_url (l_user))
							s.append_character ('%"')
							if l_user_email /= Void then
								s.append (" title=%"" + html_encoded (l_user_email) + "%"")
							end
							s.append_character ('>')
							s.append (html_encoded (api.real_user_display_name (l_user)))
							s.append ("</a>")
							if l_user_email /= Void then
								s.append (" <span class=%"email%">&lt;")
								s.append (html_encoded (l_user_email))
								s.append ("&gt;</span>")
							end
						elseif l_org /= Void then
							s.append ("<td class=%"organization%">")
							s.append ("[ORG] <a href=%"")
							s.append (api.administration_path ("cloud/organizations/" + l_org.id.out + "/"))
							s.append ("%">")
							s.append (html_encoded (l_org.title_or_name))
							s.append ("</a>")
						elseif l_email /= Void then
							s.append ("<td class=%"email%">")
							s.append (html_encoded (l_email))
						else
							s.append ("<td>")
						end
						s.append ("</td>")

						if attached lic.plan as l_plan then
							s.append ("<td>") -- Plan
							s.append (html_encoded (l_plan.title_or_name))
							s.append ("</td>")

							s.append ("<td>") -- Conditions
							if attached lic.platforms_as_csv_string as l_platforms then
								s.append (" platforms:" + html_encoded (l_platforms))
							end
							if attached lic.version as l_version then
								s.append (" version:" + html_encoded (l_version))
							end
							s.append ("</td>")
							if lic.is_active then
								if attached lic.expiration_date as dt then
									if lic.days_remaining < 10 then
										s.append ("<td class=%"warning%">") -- Until
									else
										s.append ("<td>") -- Until
									end
									s.append (html_encoded (date_time_to_string (dt)))
									s.append (" ( " + lic.days_remaining.out + " days remaining )")
								else
									s.append ("<td>") -- Until
									s.append ("<strong>ACTIVE</strong>")
									s.append (" (since ")
									s.append (html_encoded (date_time_to_string (lic.creation_date)))
									s.append (")")
								end
							elseif lic.is_suspended then
								s.append ("<td class=%"suspended%">")
								s.append ("<strong>SUSPENDED</strong>")
							else

								s.append ("<td class=%"expired%">") -- Until

								s.append ("<strong>EXPIRED</strong>")
								if attached lic.expiration_date as dt then
									s.append (" (since ")
									s.append (html_encoded (date_time_to_string (dt)))
									s.append (")")
								end
							end
							s.append ("</td>")
							s.append ("<td>") -- Last
							if
								attached {ES_CLOUD_SESSION} es_cloud_api.last_license_session (lic) as l_last and then
								attached l_last.last_date as dt
							then
								s.append ("<time class=%"timeago%" datetime=%"" + date_time_to_timestamp_string (dt) + "%">")
								s.append (html_encoded (date_time_to_string (dt)))
								s.append ("</time>")
							end
							s.append ("<a href=%"")
							s.append (api.location_url ("activities/" + url_encoded (lic.key), Void))
							s.append ("%">...</a>")
							s.append ("</td>")
						else
							s.append ("<td></td>") -- Plan
							s.append ("<td></td>") -- Conditions
							s.append ("<td></td>") -- Until
							s.append ("<td></td>") -- Last
						end
--						if l_user /= Void and orgs /= Void then
--							s.append ("<td>")
--							across
--								orgs as o_ic
--							loop
--								s.append ("<a href=%"")
--								s.append (api.administration_path ("cloud/organizations/" + o_ic.item.id.out + "/"))
--								s.append ("%">")
--								s.append (html_encoded (o_ic.item.name))
--								s.append ("</a> ")
--							end
--							s.append ("</td>")
--						else

						if l_org /= Void then
							s.append ("<td class=%"organization%">")
							s.append ("<a href=%"")
							s.append (api.administration_path ("cloud/organizations/" + l_org.id.out + "/"))
							s.append ("%">")
							s.append (html_encoded (l_org.title_or_name))
							s.append ("</a>")
							s.append ("</td>")
						else
							s.append ("<td></td>") -- Organization
						end

						s.append ("</tr>")
					end
				end
				s.append ("</table>%N")
				s.append ("<input type=%"submit%" name=%"group_action%" value=%"Group-Action%" /></form>")
				s.append ("<br/>%N")

				s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>organizations</th><th>Plan</th><th>Until</th>")
	--			s.append ("<th>Action</th>")
				s.append ("</tr>")
				across
					es_cloud_api.organizations as ic
				loop
--					sub := es_cloud_api.organization_subscription (ic.item)
--					if
--						l_plan_filter = Void
--						or else (sub /= Void and then l_plan_filter.is_case_insensitive_equal (sub.plan.name))
--					then
--						s.append ("<tr><td><a href=%"")
--						s.append (api.administration_path ("cloud/organizations/" + ic.item.id.out + "/"))
--						s.append ("%">")
--						s.append (html_encoded (ic.item.name))
--						s.append ("</a></td>")

--						if sub /= Void then
--							s.append ("<td>")
--							s.append (html_encoded (sub.plan.title_or_name))
--							s.append ("</td>")
--							s.append ("<td>")
--							if sub.is_active then
--								if attached sub.expiration_date as dt then
--									s.append (html_encoded (date_time_to_string (dt)))
--									s.append (" ( " + sub.days_remaining.out + " days remaining )")
--								else
--									s.append ("<strong>ACTIVE</strong>")
--									s.append (" (since ")
--									s.append (html_encoded (date_time_to_string (sub.creation_date)))
--									s.append (")")
--								end
--							else
--								s.append ("<strong>EXPIRED</strong>")
--								if attached sub.expiration_date as dt then
--									s.append (" (since ")
--									s.append (html_encoded (date_time_to_string (dt)))
--									s.append (")")
--								end
--							end
--							s.append ("</td>")
--		--					s.append ("<td>")
--		--					s.append ("Cancel | Upgrade")
--		--					s.append ("</td>")
--						else
--							s.append ("<td>")
--							s.append ("</td>")
--							s.append ("<td>")
--							s.append ("</td>")
--		--					s.append ("<td>")
--		--					s.append ("Upgrade")
--		--					s.append ("</td>")
--						end

--						s.append ("</tr>")
--					end
				end
				s.append ("</table>%N")

				r.set_main_content (s)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

	handle_licenses_group_action (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			l_licenses: STRING_TABLE [ES_CLOUD_LICENSE]
			lic: ES_CLOUD_LICENSE
			s,t: STRING
			s_nb: READABLE_STRING_32
			nb_months, nb_days: INTEGER
			f: CMS_FORM
			h: WSF_FORM_HIDDEN_INPUT
			tf: WSF_FORM_TEXT_INPUT
			l_submit: WSF_FORM_SUBMIT_INPUT
			l_choices: WSF_FORM_SELECT
			l_ch: WSF_FORM_SELECT_OPTION
			fset: WSF_FORM_FIELD_SET
			l_trial_plan: detachable ES_CLOUD_PLAN
			l_all_expired, l_all_expired_soon: BOOLEAN
			l_expiring_before_n_days: INTEGER
			l_export: STRING_32
		do
			if api.has_permission ("admin es licenses") then
				if
					attached {WSF_STRING} req.form_parameter ("group_action") as p_action and then
					attached {WSF_TABLE} req.form_parameter ("licenses") as p_lics
				then
					create l_licenses.make (p_lics.count)

					if attached {WSF_STRING} req.form_parameter ("expiring_before_n_days") as p_expiring_before_n_days then
						l_all_expired_soon := True
						l_expiring_before_n_days := p_expiring_before_n_days.integer_value
					else
						l_all_expired_soon := False
					end

					l_all_expired := True
					across
						p_lics as ic
					loop
						lic := es_cloud_api.license_by_key (ic.key)
						if lic /= Void then
							l_all_expired := l_all_expired and lic.is_expired and not lic.is_suspended
							l_all_expired_soon := l_all_expired_soon and then
									(
										not lic.is_expired and then not lic.is_suspended and then
										lic.expiration_date /= Void and then
										lic.days_remaining <= l_expiring_before_n_days
									)
							l_licenses [ic.key] := lic
						end
					end
					l_all_expired_soon := l_all_expired_soon and not l_all_expired

					r := new_generic_response (req, res)
					if
						p_action.same_string ("Extend") and then
						attached {WSF_STRING} req.form_parameter ("duration-in-month") as p_duration_in_months
					then
						s_nb := p_duration_in_months.value
						if s_nb.is_integer then
							nb_months := s_nb.to_integer --months
						elseif s_nb.is_real then
							nb_days := (31 * s_nb.to_real).truncated_to_integer --days
						end
						across
							l_licenses as ic
						loop
							lic := ic.item
							es_cloud_api.save_license_with_duration_extension (lic, 0, nb_months, nb_days)
							r.add_notice_message ("License " + html_encoded (ic.key) + ": expires in " + lic.days_remaining.out + " days")
						end
					elseif
						p_action.same_string ("Change Plan") and then
						attached {WSF_STRING} req.form_parameter ("new_plan") as p_new_plan_name
					then
						if attached es_cloud_api.plan_by_name (p_new_plan_name.string_representation) as pl then
							across
								l_licenses as ic
							loop
								lic := ic.item
								if not lic.plan.same_plan (pl) then
									lic.set_plan (pl)
									es_cloud_api.save_license (lic)
									r.add_notice_message ("License " + html_encoded (lic.key) + " udpated to plan %"" + html_encoded (pl.title_or_name)+ "%"")
								end
							end
						else
							r.add_error_message ("Could not find plan %"" + html_encoded (p_new_plan_name.string_representation) + "%".")
						end
					elseif
						p_action.same_string (form_submit_label_export_to_csv)
					then
						create l_export.make_from_string ("license_key,status,days_remaining,username,email,profilename,%N")
						across
							l_licenses as ic
						loop
							lic := ic.item
							l_export.append (lic.key)
							l_export.append_character (',')
							if lic.is_expired then
								l_export.append ("expired,,") -- status, no days
							elseif lic.expiration_date /= Void then
								l_export.append_character (',') -- status
								l_export.append (lic.days_remaining.out)
								l_export.append_character (',') -- days
							else
								l_export.append ("?,,") -- no status, no days
							end
							if attached {ES_CLOUD_USER} es_cloud_api.user_for_license (lic) as l_lic_user then
								l_export.append_character ('%"')
								l_export.append (l_lic_user.cms_user.name)
								l_export.append_character ('%"')
								l_export.append_character (',') -- name
								if attached l_lic_user.cms_user.email as l_email then
									l_export.append (l_email)
								end
								l_export.append_character (',') -- email
								if attached l_lic_user.cms_user.profile_name as l_profilename then
									l_export.append_character ('%"')
									l_export.append (l_profilename)
									l_export.append_character ('%"')
								end
								l_export.append_character (',') -- profilename
							else
								l_export.append_character (',') -- name
								l_export.append_character (',') -- email
								l_export.append_character (',') -- profilename
							end
							l_export.append_character ('%N')
						end
					elseif
						l_all_expired and then
						p_action.same_string (form_submit_label_send_message_for_expired_licenses)
					then
						es_cloud_api.send_message_to_expired_licenses (l_licenses)
					elseif
						l_all_expired_soon and then
						p_action.same_string (form_submit_label_send_message_for_soon_expired_licenses)
					then
						es_cloud_api.send_message_to_licenses_expiring_soon (l_licenses)
					end

					create s.make_from_string ("<h1>Action: " + html_encoded (p_action.string_representation) + "</h1>%N")
					s.append ("<div><a href=%"" + req.percent_encoded_path_info + "%">Return to licenses list</a></div>%N")

					create f.make (req.percent_encoded_path_info, Void)
					f.set_method_post
					across
						l_licenses as ic
					loop
						lic := ic.item
						f.extend_html_text ("<li>")
						create h.make_with_text ("licenses[" + url_encoded (lic.key) + "]", "on")
						f.extend (h)
						create t.make_empty
						if attached es_cloud_api.user_for_license (lic) as l_user then
							es_cloud_api.append_one_line_license_view_to_html (lic, l_user, admin_module.module, t)
						else
							t.append (html_encoded (ic.key))
						end
						f.extend_html_text (t)
						f.extend_html_text ("</li>")
					end
					create fset.make
					fset.set_legend ("Extending license duration")
					f.extend (fset)
					create tf.make ("duration-in-month")
					tf.set_label ("Extend license duration")
					tf.set_description ("Add N months to license duration ...")
					fset.extend (tf)
					create l_submit.make_with_text ("group_action", "Extend")
					fset.extend (l_submit)

					create fset.make
					fset.set_legend ("Change license plan")
					f.extend (fset)
					create l_choices.make ("new_plan")
					l_trial_plan := es_cloud_api.trial_plan
					across
						es_cloud_api.plans as ic
					loop
						create l_ch.make (ic.item.name, ic.item.title_or_name)
						if l_trial_plan /= Void and then l_trial_plan.same_plan (ic.item) then
							l_ch.set_is_selected (True)
						end
						l_choices.add_option (l_ch)
					end
					fset.extend (l_choices)
					create l_submit.make_with_text ("group_action", "Change Plan")
					fset.extend (l_submit)


					if l_all_expired then
						create fset.make
						fset.set_legend ("Expired license(s)")
						f.extend (fset)
						create l_submit.make_with_text ("group_action", form_submit_label_send_message_for_expired_licenses)
						fset.extend (l_submit)
					end

					if l_all_expired_soon then
						create fset.make
						fset.set_legend ("License(s) expiring soon")
						fset.extend_html_text ("<em>in less than " + l_expiring_before_n_days.out + " days</em>")
						fset.extend_hidden_input ("expiring_before_n_days", l_expiring_before_n_days.out)
						f.extend (fset)
						create l_submit.make_with_text ("group_action", form_submit_label_send_message_for_soon_expired_licenses)
						fset.extend (l_submit)
					end

					create fset.make
					fset.set_legend ("Export list to table")
					f.extend (fset)
					create l_submit.make_with_text ("group_action", form_submit_label_export_to_csv)
					fset.extend (l_submit)
					if l_export /= Void and then not l_export.is_whitespace then
						fset.extend_html_text ("<pre>")
						fset.extend_raw_text (l_export)
						fset.extend_html_text ("</pre>")
					end
					f.append_to_html (r.wsf_theme, s)
					r.set_main_content (s)
					r.execute
				else
					send_bad_request (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	form_submit_label_export_to_csv: STRING = "Export to CSV"

	form_submit_label_send_message_for_expired_licenses: STRING = "Send messages for expired licenses"

	form_submit_label_send_message_for_soon_expired_licenses: STRING = "Send messages for licenses about to expire"

invariant

end
