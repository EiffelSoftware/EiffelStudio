note
	description: "Summary description for {ES_CLOUD_MODULE_ADMINISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [ES_CLOUD_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_FORM_ALTER

	CMS_HOOK_RESPONSE_ALTER

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin es subscriptions")
			Result.force ("admin es licenses")
			Result.force ("admin es plans")
			Result.force ("admin es organizations")
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			org_hlr: ES_CLOUD_ORGANIZATIONS_ADMIN_HANDLER
		do
			if attached module.es_cloud_api as l_es_cloud_api then
				create org_hlr.make (l_es_cloud_api)
				org_hlr.setup_router (a_router, "/cloud/organizations/")
				a_router.handle ("/cloud/subscriptions/", create {ES_CLOUD_SUBSCRIPTIONS_ADMIN_HANDLER}.make (l_es_cloud_api), a_router.methods_get_post)
				a_router.handle ("/cloud/licenses/", create {ES_CLOUD_LICENSES_ADMIN_HANDLER}.make (l_es_cloud_api, Current), a_router.methods_get) --_post)
				a_router.handle ("/cloud/licenses/{license}", create {ES_CLOUD_LICENSES_ADMIN_HANDLER}.make (l_es_cloud_api, Current), a_router.methods_get_post)
				a_router.handle ("/cloud/installations/", create {ES_CLOUD_INSTALLATIONS_ADMIN_HANDLER}.make (l_es_cloud_api), a_router.methods_get_post)
				a_router.handle ("/cloud/plans/", create {ES_CLOUD_PLANS_ADMIN_HANDLER}.make (l_es_cloud_api), a_router.methods_get_post)
				a_router.handle ("/cloud/plans/{pid}", create {ES_CLOUD_PLANS_ADMIN_HANDLER}.make (l_es_cloud_api), a_router.methods_get_post)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_form_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			module.response_alter (a_response)
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/es_cloud-admin.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
			l_parent: CMS_LINK_COMPOSITE
		do
				 -- Add the link to the taxonomy to the main menu
			if a_response.has_permission ("admin subscriptions") then
				l_parent := a_menu_system.management_menu.new_composite_item ("EiffelStudio", a_response.api.administration_path_location ("cloud/"))

				lnk := a_response.api.administration_link ("Plans", "cloud/plans/")
				l_parent.extend (lnk)

				lnk := a_response.api.administration_link ("Licenses", "cloud/licenses/")
				l_parent.extend (lnk)

				lnk := a_response.api.administration_link ("Subscriptions", "cloud/subscriptions/")
				l_parent.extend (lnk)

				lnk := a_response.api.administration_link ("Organizations", "cloud/organizations/")
				l_parent.extend (lnk)

			end
		end

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
			-- Hook execution on form `a_form' and its associated data `a_form_data',
			-- for related response `a_response'.
		local
			fset, lic_fset: WSF_FORM_FIELD_SET
			s: STRING
			l_license: detachable ES_CLOUD_LICENSE
		do
			if
				attached module.es_cloud_api as l_cloud_api and then
				attached a_form.id as l_form_id
			then
				if l_form_id.same_string ("admin-view-user") then
					if
						attached cloud_user_from_form (a_form, a_response) as l_user
					then
						create fset.make
						fset.set_legend ("User licenses")
						if attached l_cloud_api.user_licenses (l_user) as l_licenses then
							across
								l_licenses as ic
							loop
								l_license := ic.item.license
								create lic_fset.make
								lic_fset.add_css_style ("margin-bottom: 1em; border: solid 1px blue;")
								fset.extend (lic_fset)
								create s.make_empty
								s.append ("<div class=%"license")
								if l_license.is_expired then
									s.append (" expired")
								end
								if l_license.is_fallback then
									s.append (" fallback")
								end
								s.append ("%"><strong>")
								s.append ("<a href=%"" + l_cloud_api.cms_api.location_url (module.license_location (l_license), Void) + "%">")
								s.append (html_encoded (l_license.key))
								s.append ("</a>")
								s.append ("</strong>: <span class=%"plan%">" + html_encoded (l_license.plan.title_or_name) + "</span>")
								s.append ("<br/>")
								s.append (" since  <span class=%"date%">")
								s.append (date_time_to_string (l_license.creation_date))
								s.append ("</span>")
								if attached l_license.expiration_date as dt then
									s.append (" until <span class=%"date%">")
									s.append (date_time_to_string (dt))
									s.append ("</span>")
									if l_license.is_expired then
										s.append (" <span class=%"expired%">(Expired)</span>")
									end
								end
								if attached l_license.fallback_date as l_fb then
									s.append (" <span class=%"fallback%">(Fallback since " + date_time_to_string (l_fb) + ")</span>")
								end

								if attached l_license.platforms_as_csv_string as pf then
									s.append (" <span class=%"platform%">[platforms=" +  html_encoded (pf) + "]</span>")
								end
								if attached l_license.version as l_version then
									s.append (" <span class=%"version%">[version=" +  html_encoded (l_version) + "]</span>")
								end
								s.append ("</div>")
								lic_fset.extend_html_text (s)
							end
						end
						a_form.extend (fset)
					end
--				elseif l_form_id.same_string ("edit-user") then
--					if
--						a_response.has_permission ("admin es licenses")
--					then
--						if
--							attached cloud_user_from_form (a_form, a_response) as l_user and then
--							a_form_data = Void
--						then
--							create fset.make
--							fset.set_legend ("Current licenses")
--							a_form.extend (fset)
--							across
--								l_cloud_api.user_licenses (l_user) as ic
--							loop
--								l_license := ic.item.license
--								add_license_form_part_to (l_license, fset, l_cloud_api)
--							end
--							add_license_form_part_to (Void, fset, l_cloud_api)
--							a_form.validation_actions.extend (agent license_form_validation_action (?, l_user, l_license, l_cloud_api))
--						end
--					end
				end
			end
		end

	license_form_validation_action (fd: WSF_FORM_DATA; a_user: detachable ES_CLOUD_USER; a_lic: detachable ES_CLOUD_LICENSE; a_cloud_api: ES_CLOUD_API)
		local
			n: INTEGER
			s_nb: STRING_32
			orig: DATE_TIME
			dt: DATE_TIME
			y,mo: INTEGER
			nb_months: INTEGER
			nb_days: INTEGER
			i: INTEGER
			l_lic_id: INTEGER_64
			l_var_prefix: STRING_32
			lic: detachable ES_CLOUD_LICENSE
			l_is_update: BOOLEAN
		do
			if attached fd.string_item ("es-lic-op") as l_op then
				i := l_op.index_of ('#', 1)
				if i > 0 then
					l_lic_id := l_op.substring (i + 1, l_op.count).to_integer_64
				end
				if l_lic_id > 0 then
					l_is_update := True
					l_var_prefix := "es-lic-" + l_lic_id.out
					lic := a_cloud_api.license (l_lic_id)
				else
					l_var_prefix := "es-new-lic"
				end
				if lic = Void or else (a_user /= Void implies a_cloud_api.user_has_license (a_user, lic.id)) then
					if
						attached fd.table_item (l_var_prefix) as l_lic_data
					then
						if
							attached {WSF_STRING} l_lic_data.value ("plan") as p_plan and then
							attached a_cloud_api.plan_by_name (p_plan.value) as l_new_plan
						then
							if lic = Void then
								lic := a_cloud_api.new_license_for_plan (l_new_plan)
							else
									-- !!! Change plan ????
								lic.set_plan (l_new_plan)
							end

							if attached {WSF_STRING} l_lic_data.value ("key") as p_key then
								check lic /= Void implies p_key.is_case_insensitive_equal (lic.key) end
							end
							if attached {WSF_STRING} l_lic_data.value ("platforms") as p_platforms then
								if p_platforms.is_empty then
									lic.set_platforms_restriction (Void)
								else
									lic.set_platforms_restriction (p_platforms.value)
								end
							end
							if attached {WSF_STRING} l_lic_data.value ("version") as p_version then
								if p_version.is_empty then
									lic.set_version (Void)
								else
									lic.set_version (p_version.value)
								end
							end
							if
								attached {WSF_STRING} l_lic_data.value ("expiration") as p_expiration and then
								attached yyyy_mm_dd_to_date (p_expiration.value) as l_exp_date
							then
								lic.set_expiration_date (create {DATE_TIME}.make_by_date (l_exp_date))
							elseif
								attached {WSF_STRING} l_lic_data.value ("duration-in-month") as p_months
							then
								s_nb := p_months.value
								if s_nb.is_integer then
									nb_months := s_nb.to_integer --months
								elseif s_nb.is_real then
									nb_days := (31 * s_nb.to_real).truncated_to_integer --days
								end
								orig := lic.expiration_date
								if orig = Void then
									orig := lic.creation_date
									create orig.make_by_date_time (orig.date, orig.time)
									if lic.days_remaining > 0 then
										orig.day_add (lic.days_remaining)
									end
								end
								create dt.make_by_date_time (orig.date, orig.time)
								if nb_months > 0 then
									n := nb_months
									y := dt.year
									mo := dt.month + n
									if mo <= 12 then
									else
										y := y + mo // 12
										mo := mo \\ 12
									end
									create dt.make_by_date_time (create {DATE}.make (y, mo, dt.day), dt.time)
									lic.set_expiration_date (dt)
								elseif nb_days > 0 then
									dt.day_add (nb_days)
									lic.set_expiration_date (dt)
								end

							end
							if l_is_update then
								a_cloud_api.update_license (lic, a_user)
							else
								a_cloud_api.save_new_license (lic, a_user)
							end
						end
					end
				end
			else
				if
					a_cloud_api.cms_api.has_permission (module.perm_manage_es_licenses) and then
					attached fd.integer_item ("es-lic-lid") as lid and then
					attached a_cloud_api.license (lid) as l_lic
				then
					if attached fd.string_item ("es-lic-op-suspend") then
						a_cloud_api.suspend_license (l_lic)
					elseif attached fd.string_item ("es-lic-op-resume") then
						a_cloud_api.resume_license (l_lic)
					elseif attached fd.string_item ("es-lic-op-discard") then
						a_cloud_api.discard_license (l_lic)
					end
				end
			end
		end

	add_assign_email_license_form_part_to (a_license: ES_CLOUD_EMAIL_LICENSE; ftarget: WSF_FORM_COMPOSITE; a_cloud_api: ES_CLOUD_API)
		local
			d: WSF_FORM_DIV
			l_user_tf: WSF_FORM_TEXT_INPUT
			l_submit: WSF_FORM_SUBMIT_INPUT
			fset: WSF_FORM_FIELD_SET
		do
			create fset.make
			fset.set_legend ("Assign this license to a user")
			fset.set_legend ("The license is currently associated to email "+ html_encoded (a_license.email) + " .")
			ftarget.extend (fset)

			create d.make
			d.add_css_class ("horizontal")
			fset.extend (d)
			create l_user_tf.make ("user-assignee")
			d.extend (l_user_tf)
			l_user_tf.set_label ("Username or uid")
			create l_submit.make_with_text ("op", "Assign")
			d.extend (l_submit)
			l_submit.set_validation_action (agent (i_email_lic: ES_CLOUD_EMAIL_LICENSE; i_fd: WSF_FORM_DATA; i_a_cloud_api: ES_CLOUD_API)
					do
						if
							attached i_fd.string_item ("op") as l_op and then l_op.is_case_insensitive_equal_general ("Assign") and then
							attached i_fd.string_item ("user-assignee") as l_uid
						then
							if attached i_a_cloud_api.cms_api.user_api.user_by_id_or_name (l_uid) as l_assignee then
								i_a_cloud_api.move_email_license_to_user (i_email_lic, l_assignee)
							else
								i_fd.report_invalid_field ("user-assignee", "User not found")
							end
						end
					end(a_license, ?, a_cloud_api)
				)
		end

	add_license_form_part_to (a_license: detachable ES_CLOUD_LICENSE; fset: WSF_FORM_FIELD_SET; a_cloud_api: ES_CLOUD_API)
		local
			lic_fset: WSF_FORM_FIELD_SET
--			r: WSF_FORM_RADIO_INPUT
			h: WSF_FORM_DIV
			l_select: WSF_FORM_SELECT
			l_select_opt: WSF_FORM_SELECT_OPTION
			num: WSF_FORM_NUMBER_INPUT
			exp: WSF_FORM_DATE_INPUT
			txt: WSF_FORM_TEXT_INPUT
			s: STRING
			l_submit: WSF_FORM_SUBMIT_INPUT
			l_plan: detachable ES_CLOUD_PLAN
			l_var_prefix: STRING_8
		do
			create lic_fset.make
			lic_fset.add_css_style ("padding-left: 2rem; margin-bottom: 1em;")
			fset.extend (lic_fset)

			create s.make_empty

			if a_license = Void then
				s.append ("<p>New license ...</p>")
				lic_fset.extend_html_text (s)
				l_var_prefix := "es-new-lic"
			else
				l_var_prefix := "es-lic-" + a_license.id.out
				l_plan := a_license.plan
				lic_fset.extend (create {WSF_FORM_HIDDEN_INPUT}.make_with_text (l_var_prefix + "[key]", a_license.key))
				s.append ("<p>License <strong>" + html_encoded (a_license.key) + "</strong> of product <strong>" + html_encoded (l_plan.title_or_name) + "</strong>")
				if attached a_license.expiration_date as dt then
					s.append (" until ")
					s.append (date_time_to_string (dt))
				end
				s.append ("</p>")
				lic_fset.extend_html_text (s)
			end

			create l_select.make (l_var_prefix + "[plan]")
			l_select.set_label ("Plan")
			lic_fset.extend (l_select)
			across
				a_cloud_api.plans as pl_ic
			loop
				create l_select_opt.make (pl_ic.item.name, pl_ic.item.title_or_name)
				if l_plan /= Void and then pl_ic.item.same_plan (l_plan) then
					l_select_opt.set_is_selected (True)
				end
				l_select.add_option (l_select_opt)
			end
--			across
--				a_cloud_api.plans as pl_ic
--			loop
--				create r.make_with_value (l_var_prefix + "[plan]", pl_ic.item.name.as_string_32)
--				r.set_title (pl_ic.item.title_or_name)
--				if l_plan /= Void and then pl_ic.item.same_plan (l_plan) then
--					r.set_checked (True)
--				end
--				lic_fset.extend (r)
--			end

			create txt.make (l_var_prefix + "[platforms]")
			txt.set_label ("Platforms")
			txt.set_description ("License for specific platforms (comma separated value)")
			if a_license /= Void and then attached a_license.platforms_as_csv_string as pf then
				txt.set_text_value (pf)
			end
			lic_fset.extend (txt)
			create txt.make (l_var_prefix + "[version]")
			txt.set_label ("Version")
			txt.set_description ("License for specific version")
			if a_license /= Void and then attached a_license.version as pv then
				txt.set_text_value (pv)
			end
			lic_fset.extend (txt)

			create num.make (l_var_prefix + "[duration-in-month]")
			num.set_min (0)
			num.set_max (5*12)
			num.set_step (0.5)
			num.set_label ("Additional time")
			num.set_size (8)
			num.set_description ("number of additional months.")
			lic_fset.extend (num)


			create exp.make (l_var_prefix + "[expiration]")
			exp.set_label ("Expiration date")
			exp.set_description ("Expiration date")
			if a_license /= Void and then attached a_license.expiration_date as l_exp_date then
				exp.set_description ("Current expiration date: " + l_exp_date.out + "%N")
			end
			lic_fset.extend (exp)
			create h.make
			h.add_css_class ("horizontal")
			lic_fset.extend (h)
			if a_license /= Void then
				lic_fset.extend (create {WSF_FORM_HIDDEN_INPUT}.make_with_text ("es-lic-lid", a_license.id.out))
				if a_license.is_suspended then
					create l_submit.make_with_text ("es-lic-op-resume", "Resume License")
					h.extend (l_submit)
				else
					create l_submit.make_with_text ("es-lic-op", "Save License #" + a_license.id.out)
					h.extend (l_submit)

					create l_submit.make_with_text ("es-lic-op-suspend", "Suspend License")
					h.extend (l_submit)
				end
			else
				create l_submit.make_with_text ("es-lic-op", "Save License")
				h.extend (l_submit)
			end
		end

	cloud_user_from_form (a_form: CMS_FORM; a_response: CMS_RESPONSE): detachable ES_CLOUD_USER
		do
			if
				attached a_form.fields_by_name ("user-id") as lst and then
				attached {WSF_FORM_HIDDEN_INPUT} lst.first as l_field and then
				attached l_field.default_value as l_user_id and then
				attached a_response.api.user_api.user_by_id_or_name (l_user_id) as u
			then
				create Result.make (u)
			end
		end

	yyyy_mm_dd_to_date (s: READABLE_STRING_GENERAL): detachable DATE
			-- YYYY-mm-dd to DATE object.
		local
			i,j: INTEGER
		do
			i := s.index_of ('-', 1)
			if i = 5 then
				j := s.index_of ('-', i + 1)
				if j > 0 then
					create Result.make (s.substring (1, i - 1).to_integer, s.substring (i + 1, j - 1).to_integer, s.substring (j + 1, s.count).to_integer)
				end
			end
		end

end
