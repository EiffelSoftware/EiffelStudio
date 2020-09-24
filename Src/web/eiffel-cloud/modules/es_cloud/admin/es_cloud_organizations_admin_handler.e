note
	description: "Summary description for {ES_CLOUD_ORGANIZATIONS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ORGANIZATIONS_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature -- Setup

	setup_router (a_router: WSF_ROUTER; a_base_url: STRING)
		do
			a_router.handle (a_base_url + "{oid}/owners/", Current, a_router.methods_put_post + a_router.methods_delete)
			a_router.handle (a_base_url + "{oid}/managers/", Current, a_router.methods_put_post + a_router.methods_delete)
			a_router.handle (a_base_url + "{oid}/members/", Current, a_router.methods_put_post + a_router.methods_delete)
			a_router.handle (a_base_url + "{oid}/plans/", Current, a_router.methods_post)
			a_router.handle (a_base_url + "{org}/", Current, a_router.methods_get_post)
			a_router.handle (a_base_url, Current, a_router.methods_get_post)
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_organization: detachable ES_CLOUD_ORGANIZATION
		do
			if attached {WSF_STRING} req.path_parameter ("oid") as p_oid then
				if attached es_cloud_api.organization (p_oid.value) as org then
					if
						api.has_permission ("manage es organizations") or else
						es_cloud_api.is_current_user_organization_manager_of (org)
					then
						if req.percent_encoded_path_info.ends_with ("/owners/") then
							if
								api.has_permission ("manage es organizations")
								or else es_cloud_api.is_current_user_organization_owner_of (org)
							then
								handle_membership (org, org.role_owner_id, req, res)
							else
								send_access_denied (req, res)
							end
						elseif req.percent_encoded_path_info.ends_with ("/managers/") then
							handle_membership (org, org.role_manager_id, req, res)
						elseif req.percent_encoded_path_info.ends_with ("/members/") then
							handle_membership (org, org.role_member_id, req, res)
						elseif req.percent_encoded_path_info.ends_with ("/plans/") then
							if api.has_permission ("admin es subscriptions") then
								handle_plan (org, req, res)
							else
								send_access_denied (req, res)
							end
						else
							send_bad_request (req, res)
						end
					else
						send_access_denied (req, res)
					end
				else
					send_not_found_with_message ("Organization %""+ html_encoded (p_oid.value) +"%" not found", req, res)
				end
			elseif req.is_get_request_method then
				if attached {WSF_STRING} req.path_parameter ("org") as p_org then
					l_organization := es_cloud_api.organization (p_org.value)
					if l_organization = Void then
						send_bad_request (req, res)
					elseif
						api.has_permission ("manage es organizations") or else
						es_cloud_api.is_current_user_organization_manager_of (l_organization)
					then
						display_organization (l_organization, req ,res)
					else
						send_access_denied (req, res)
					end
				elseif api.has_permission ("manage es organizations") then
					display_organizations (req, res)
				else
					send_access_denied (req, res)
				end
			elseif req.is_post_request_method then
				post_organization (req, res)
			else
				send_bad_request (req, res)
			end
		end

feature {NONE} -- Authorized request handling		

	handle_membership (org: ES_CLOUD_ORGANIZATION; role: INTEGER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: like new_edit_membership_form
			uid, l_op: READABLE_STRING_GENERAL
			l_user: ES_CLOUD_USER
			r: like new_generic_response
			oid: INTEGER_64
			l_role: INTEGER
		do
			r := new_generic_response (req, res)
			f := new_edit_membership_form (req, org, Void, role)
			add_primary_tabs (r)
			f.process (r)
			if attached f.last_data as fd then
				oid := fd.integer_item ("oid")
				check oid = org.id end
				uid := fd.string_item ("uid")
				l_op := fd.string_item ("op")
				if uid /= Void and then attached api.user_api.user_by_id_or_name (uid) as u then
					create l_user.make (u)
				end
				l_role := fd.integer_item ("role")
				if l_user /= Void then
					if
						req.is_delete_request_method
						or (req.is_post_request_method and then
							l_op /= Void and then l_op.is_case_insensitive_equal ("Remove")
							)
					then
						if role /= {ES_CLOUD_ORGANIZATION}.role_member_id then
							es_cloud_api.update_membership (org, l_user, {ES_CLOUD_ORGANIZATION}.role_member_id)
							r.set_main_content ("Membership set to member.")
						else
							es_cloud_api.discard_membership (org, l_user, role)
							r.set_main_content ("Membership removed.")
						end
						r.set_redirection (api.administration_path ("/cloud/organizations/" + url_encoded (org.name) + "/"))
						r.execute
					elseif req.is_put_post_request_method then
						es_cloud_api.update_membership (org, l_user, role)
						r.set_main_content ("Membership updated.")
						r.set_redirection (api.administration_path ("/cloud/organizations/" + url_encoded (org.name) + "/"))
						r.execute
					else
						send_bad_request (req, res)
					end
				else
					if uid /= Void then
						send_not_found_with_message ("User %""+ html_encoded (uid) +"%" not found", req, res)
					else
						send_bad_request (req, res)
					end
				end
			else
				send_bad_request (req, res)
			end
		end

	handle_plan (org: ES_CLOUD_ORGANIZATION; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: like new_edit_membership_form
			r: like new_generic_response
			oid: INTEGER_64
		do

			r := new_generic_response (req, res)
			f := new_plan_form (req, org, Void)
			add_primary_tabs (r)
			f.process (r)
			if attached f.last_data as fd then
				oid := fd.integer_item ("oid")
				check oid = org.id end
				if req.is_put_post_request_method then
					r.set_main_content ("organization plan updated.")
					r.set_redirection (api.administration_path ("/cloud/organizations/" + url_encoded (org.name) + "/"))
					r.execute
				else
					send_bad_request (req, res)
				end
			else
				send_bad_request (req, res)
			end
		end

	display_organization (org: ES_CLOUD_ORGANIZATION; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			l_is_owner_or_has_manage_permissions: BOOLEAN
		do
			r := new_generic_response (req, res)
			add_primary_tabs (r)

			create s.make_from_string ("<div class=%"es-organizations%">")
			s.append ("<h1>organization: " + html_encoded (org.name) + "</h1>")
			if attached org.title as l_title then
				s.append ("<h2>" + html_encoded (l_title) + "</h2>")
			end

			s.append ("<h3>Owner(s)</h3>")
			s.append ("<ul class=%"owners%">")
			if
				api.has_permission ("manage es organizations")
				or else es_cloud_api.is_current_user_organization_owner_of (org)
			then
				l_is_owner_or_has_manage_permissions := True
			end
			if attached es_cloud_api.organization_owners (org) as l_owners then
				across
					l_owners as ic
				loop
					s.append ("<li>")
					s.append (api.user_html_link (ic.item))
					if
						l_is_owner_or_has_manage_permissions and then
						attached new_delete_membership_form (req, org, ic.item, org.role_owner_id) as f
					then
						f.append_to_html (r.wsf_theme, s)
					end
					s.append ("</li>")
				end
			end
			if
				l_is_owner_or_has_manage_permissions and then
				attached new_edit_membership_form (req, org, Void, org.role_owner_id) as f
			then
				f.append_to_html (r.wsf_theme, s)
			end
			s.append ("</ul>")

			s.append ("<h3>Manager(s)</h3>")
			s.append ("<ul class=%"managers%">")
			if attached es_cloud_api.organization_managers (org) as l_managers then
				across
					l_managers as ic
				loop
					s.append ("<li>")
					s.append (api.user_html_link (ic.item))
					if attached new_delete_membership_form (req, org, ic.item, org.role_manager_id) as f then
						f.append_to_html (r.wsf_theme, s)
					end
					s.append ("</li>")
				end
			end
			if attached new_edit_membership_form (req, org, Void, org.role_manager_id) as f then
				f.append_to_html (r.wsf_theme, s)
			end
			s.append ("</ul>")


			s.append ("<h3>Member(s)</h3>")
			s.append ("<ul class=%"members%">")
			if attached es_cloud_api.organization_members (org) as l_members then
				across
					l_members as ic
				loop
					s.append ("<li>")
					s.append (api.user_html_link (ic.item))
					if attached new_delete_membership_form (req, org, ic.item, org.role_member_id) as f then
						f.append_to_html (r.wsf_theme, s)
					end
					s.append ("</li>")
				end
			end
			if attached new_edit_membership_form (req, org, Void, org.role_member_id) as f then
				f.append_to_html (r.wsf_theme, s)
			end
			s.append ("</ul>")

			if api.has_permission ("admin es subscriptions") then
				s.append ("<hr/>")
				if attached new_plan_form (req, org, es_cloud_api.organization_subscription (org)) as f then
					f.append_to_html (r.wsf_theme, s)
				end
			end

			s.append ("</div>")
			r.set_main_content (s)
			r.execute
		end

	display_organizations (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			l_organization: ES_CLOUD_ORGANIZATION
		do
			r := new_generic_response (req, res)
			add_primary_tabs (r)

			create s.make_from_string ("<h1>organizations</h1>")
			s.append ("<table class=%"with_border%" style=%"border: solid 1px black%">")
			s.append ("<tr><th>organizations</th><th>Members</th></tr>")
			if attached es_cloud_api.organizations as l_organizations then
				across
					l_organizations as ic
				loop
					l_organization := ic.item
					s.append ("<tr>")
					s.append ("<td>")
					s.append ("<a href=%""+ api.administration_path ("/cloud/organizations/" + url_encoded (ic.item.name) + "/") + "%">")
					s.append (html_encoded (ic.item.name))
					s.append ("</a></td>")

					s.append ("<td>")
					if attached es_cloud_api.organization_members (l_organization) as l_members then
						s.append (l_members.count.out + " members")
					end
					s.append ("</td>")
					s.append ("</tr>")
				end
			end
			s.append ("</table>%N")

			if api.has_permission ("admin es organizations") then
				if attached new_edit_org_form (req, Void) as f then
					f.append_to_html (r.wsf_theme, s)
				end
			end

			r.set_main_content (s)
			r.execute
		end

	post_organization (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			l_org: detachable ES_CLOUD_ORGANIZATION
			l_org_name, l_org_title, l_org_description, l_org_data, l_op: detachable READABLE_STRING_32
			l_org_id: INTEGER
			s: STRING
			f: like new_edit_org_form
		do
			f := new_edit_org_form (req, Void)
			r := new_generic_response (req, res)
			create s.make_empty
			f.process (r)
			if attached f.last_data as fd then
				l_org_id := fd.integer_item ("id")
				l_org_name := fd.string_item ("name")
				l_org_title := fd.string_item ("title")
				l_org_description := fd.string_item ("description")
				l_org_data := fd.string_item ("data")
				l_op := fd.string_item ("op")
				if l_org_id /= 0 then
					l_org := es_cloud_api.organization (l_org_id.out)
				end
				if
					api.has_permission ("manage es organizations") or else
					(l_org /= Void and then es_cloud_api.is_current_user_organization_manager_of (l_org))
				then
					if l_org_name = Void then
						fd.report_invalid_field ("name", "Missing name")
					else
						if l_org = Void then
							l_org := es_cloud_api.organization (l_org_name)
						end
						if l_op /= Void and then l_op.same_string (delete_org_text) then
							if l_org /= Void then
								es_cloud_api.delete_organization (l_org)
								if es_cloud_api.has_error then
									fd.report_error ("Issue while deleting organization!")
								else
									r.add_success_message ("organization successfully deleted.")
									r.set_redirection (api.administration_path ("/cloud/organizations/"))
								end
							else
								fd.report_error ("Can not delete organization!")
							end
						else
							if l_org /= Void then
								r.add_warning_message ("Updating existing organization.")
							else
								create l_org.make (l_org_id, l_org_name)
							end
							l_org.set_title (l_org_title)
							l_org.set_description (l_org_description)
							l_org.set_data (l_org_data)
							es_cloud_api.save_organization (l_org)
							if es_cloud_api.has_error then
								fd.report_error ("Issue while saving organization!")
							else
								r.add_success_message ("organization successfully saved.")
								r.set_redirection (api.administration_path ("/cloud/organizations/"))
							end
						end
					end
					if fd.has_error then
						f.append_to_html (r.wsf_theme, s)
					end
					r.set_main_content (s)
					r.execute
				else
					send_access_denied (req, res)
				end
			else
				send_bad_request (req, res)
			end
		end

feature {NONE} -- Web Forms

	new_edit_membership_form (req: WSF_REQUEST; org: ES_CLOUD_ORGANIZATION; u: detachable ES_CLOUD_USER; a_role: INTEGER): CMS_FORM
		local
			hf: WSF_FORM_HIDDEN_INPUT
			tf: WSF_FORM_TEXT_INPUT
			l_submit: WSF_FORM_SUBMIT_INPUT
		do
			inspect
				a_role
			when {ES_CLOUD_ORGANIZATION}.role_owner_id then
				create Result.make (req.percent_encoded_path_info + "owners/", "es-cloud-edit-org-item")
			when {ES_CLOUD_ORGANIZATION}.role_manager_id then
				create Result.make (req.percent_encoded_path_info + "managers/", "es-cloud-edit-org-item")
			else
				create Result.make (req.percent_encoded_path_info + "members/", "es-cloud-edit-org-item")
			end
			Result.set_method_post

			create hf.make ("oid")
			hf.set_text_value (org.id.out)
			Result.extend (hf)
			create hf.make ("role")
			hf.set_text_value (a_role.out)
			Result.extend (hf)

			if u /= Void then
				create hf.make ("uid")
				hf.set_text_value (u.id.out)
				Result.extend (hf)
			else
				create tf.make ("uid")
				tf.set_placeholder ("Username")
--				tf.set_label ("Add user")
				tf.set_size (20)
				Result.extend (tf)
			end

			inspect
				a_role
			when {ES_CLOUD_ORGANIZATION}.role_owner_id then
				create l_submit.make_with_text ("op", "Add Owner")
			when {ES_CLOUD_ORGANIZATION}.role_manager_id then
				create l_submit.make_with_text ("op", "Add Manager")
			else
				create l_submit.make_with_text ("op", "Add Member")
			end
			Result.extend (l_submit)
		end

	new_delete_membership_form (req: WSF_REQUEST; org: ES_CLOUD_ORGANIZATION; u: ES_CLOUD_USER; a_role: INTEGER): CMS_FORM
		local
			hf: WSF_FORM_HIDDEN_INPUT
			l_submit: WSF_FORM_SUBMIT_INPUT
		do
			inspect
				a_role
			when {ES_CLOUD_ORGANIZATION}.role_owner_id then
				create Result.make (req.percent_encoded_path_info + org.id.out + "/owners/", "es-cloud-del-org-item")
			when {ES_CLOUD_ORGANIZATION}.role_manager_id then
				create Result.make (req.percent_encoded_path_info + org.id.out + "/managers/", "es-cloud-del-org-item")
			else
				create Result.make (req.percent_encoded_path_info + org.id.out + "/members/", "es-cloud-del-org-item")
			end
			Result.set_method_post

			create hf.make ("oid")
			hf.set_text_value (org.id.out)
			Result.extend (hf)
			create hf.make ("uid")
			hf.set_text_value (u.id.out)
			Result.extend (hf)

			create hf.make ("role")
			hf.set_text_value (a_role.out)
			Result.extend (hf)

			create l_submit.make_with_text ("op", "Remove")
			Result.extend (l_submit)
		end

feature {NONE} -- Implementation: organization with plan

	new_plan_form (req: WSF_REQUEST; org: ES_CLOUD_ORGANIZATION; a_plan_sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION): CMS_FORM
		do
			create Result.make (req.percent_encoded_path_info + org.id.out + "/plans/", "es-cloud-org-plan")
			add_plan_form_to (req, org, a_plan_sub, Result)
		end

	add_plan_form_to (req: WSF_REQUEST; org: ES_CLOUD_ORGANIZATION; a_plan_sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION; f: CMS_FORM)
		local
			fset: WSF_FORM_FIELD_SET
			hf: WSF_FORM_HIDDEN_INPUT
			r: WSF_FORM_RADIO_INPUT
			num: WSF_FORM_NUMBER_INPUT
			s: STRING
			l_submit: WSF_FORM_SUBMIT_INPUT
			l_sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION
			l_plan: detachable ES_CLOUD_PLAN
		do
			create fset.make
			fset.set_legend ("Subscription plan")

			create hf.make ("oid")
			hf.set_text_value (org.id.out)
			fset.extend (hf)

			l_sub := a_plan_sub
			if l_sub /= Void then
				l_plan := l_sub.plan
				create s.make_empty
				s.append ("<p>Current plan: <strong>" + html_encoded (l_plan.title_or_name) + "</strong>")
				if attached l_sub.expiration_date as dt then
					s.append (" until ")
					s.append (date_time_to_string (dt))
				end
				s.append ("</p>")
				fset.extend_html_text (s)
			end
			across
				es_cloud_api.plans as ic
			loop
				create r.make_with_value ("es-plan", ic.item.name.as_string_32)
				r.set_title (ic.item.title_or_name)
				if ic.item.same_plan (l_plan) then
					r.set_checked (True)
				end
				fset.extend (r)
			end
			create num.make ("es-plan-duration-in-month")
			num.set_min (0)
			num.set_max (5*12)
			num.set_step (0.5)
			num.set_label ("Additional time")
			num.set_size (3)
			num.set_description ("number of additional months.")
			fset.extend (num)
			create l_submit.make_with_text ("op", "Save plan")
			fset.extend (l_submit)
			f.extend (fset)

			f.validation_actions.extend (agent (i_fd: WSF_FORM_DATA; i_org: ES_CLOUD_ORGANIZATION; i_sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION; i_cloud_api: ES_CLOUD_API)
					local
						n: INTEGER
						orig: DATE_TIME
						dt: DATE_TIME
						y,mo: INTEGER
						nb_months: INTEGER
						nb_days: INTEGER
					do
							-- Only update plan, if validated via the [Save plan] button!
						if
							attached i_fd.string_item ("op") as l_op and then
							l_op.same_string ("Save plan") and then
							attached i_fd.string_item ("es-plan") as l_plan_name and then
							attached i_cloud_api.plan_by_name (l_plan_name) as l_new_plan
						then
							if
								attached i_fd.string_item ("es-plan-duration-in-month") as s_nb
							then
								if s_nb.is_integer then
									nb_months := s_nb.to_integer --months
								elseif s_nb.is_real then
									nb_days := (31 * s_nb.to_real).truncated_to_integer --days
								end
							end
							if i_sub /= Void and then i_sub.plan.same_plan (l_new_plan) then
								orig := i_sub.creation_date
								nb_days := nb_days + i_sub.days_remaining
							else
								create orig.make_now_utc
							end
							if nb_months > 0 then
								n := nb_months
								y := orig.year
								mo := orig.month + n
								if mo <= 12 then
								else
									y := y + mo // 12
									mo := mo \\ 12
								end
								create dt.make_by_date_time (create {DATE}.make (y, mo, orig.day), orig.time)
								n := (dt.relative_duration (orig).seconds_count // 3600 // 24).to_integer
								nb_days := nb_days + n
							end
							i_cloud_api.subscribe_organization_to_plan (i_org, l_new_plan, nb_days)
						end
					end(?, org, l_sub, es_cloud_api)
				)
		end

feature {NONE} -- Implementation: organization		

	new_edit_org_form (req: WSF_REQUEST; org: detachable ES_CLOUD_ORGANIZATION): CMS_FORM
		local
			hf: WSF_FORM_HIDDEN_INPUT
			tf: WSF_FORM_TEXT_INPUT
			l_area: WSF_FORM_TEXTAREA
			l_submit: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "es-cloud-edit-org")
			Result.extend_html_text ("<h1>Create a new organization...</h1>")
			create hf.make ("id")
			if org /= Void and then org.has_id then
				hf.set_text_value (org.id.out)
			end
			Result.extend (hf)

			create tf.make ("name")
			if org /= Void then
				tf.set_text_value (org.name.as_string_32)
			end
			tf.set_label ("Name")
			tf.set_size (20)
			Result.extend (tf)
			create tf.make ("title")
			if org /= Void and then attached org.title as l_title then
				tf.set_text_value (l_title)
			end
			tf.set_label ("Title")
			tf.set_size (20)
			Result.extend (tf)

			create l_area.make ("description")
			if org /= Void and then attached org.description as l_desc then
				l_area.set_text_value (l_desc)
			end
			l_area.set_label ("Description")
			l_area.set_cols (60)
			l_area.set_rows (5)
			Result.extend (l_area)

			create tf.make ("data")
			if org /= Void and then attached org.data as l_data then
				tf.set_text_value (l_data)
			end
			tf.set_label ("Data")
			tf.set_size (70)
			Result.extend (tf)

			if org /= Void then
				create l_submit.make_with_text ("op", save_org_text)
				Result.extend (l_submit)
				if attached es_cloud_api.organization_members (org) as lst and then not lst.is_empty then
					Result.extend_raw_text ("organization has " + lst.count.out + " member(s).")
				else
					create l_submit.make_with_text ("op", delete_org_text)
					Result.extend (l_submit)
				end
			else
				create l_submit.make_with_text ("op", create_org_text)
				Result.extend (l_submit)
			end
		end

	save_org_text: STRING = "Save organization"
	create_org_text: STRING = "Create organization"
	delete_org_text: STRING = "Delete organization"

end
