note
	description: "Summary description for {ES_CLOUD_ACCOUNTS_ADMIN_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ACCOUNTS_ADMIN_HANDLER

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
			r: like new_generic_response
			s: STRING
			l_user: detachable ES_CLOUD_USER
			f: CMS_FORM
		do
			if api.has_permission ("manage es accounts") then
				if
					attached {WSF_STRING} req.path_parameter ("user") as p_user and then
					attached api.user_api.user_by_id_or_name (p_user.value) as l_cms_user
				then
					create l_user.make (l_cms_user)
					r := new_generic_response (req, res)
					add_primary_tabs (r)
					create s.make_from_string ("<h1>Account %"" + api.user_html_administration_link (l_user) + "%"</h1>")

					f := new_license_form (req)

					if req.is_put_post_request_method then
						f.process (r)
						if
							attached f.last_data as fd and then
							fd.is_valid and then
							attached fd.string_item ("new_license_plan") as pl
						then
							add_new_license_to (pl, l_user)
							r.set_redirection (req.percent_encoded_path_info) -- To avoid new license by reloading page!
						end
					end

					s.append ("<h3>Licenses for user " + api.user_html_administration_link (l_user) + "</h3>%N")
					if attached es_cloud_api.user_licenses (l_user) as l_licenses then
						s.append ("<div id=%"es-licenses%">")
						across
							l_licenses as ic
						loop
							es_cloud_api.append_one_line_license_view_to_html (ic.item, l_user, admin_module.module, s)
							s.append ("<a href=%"" + api.location_url (api.administration_path_location (admin_module.admin_license_location (ic.item)), Void) + "%" class=%"button%">EDIT</a>")
--							es_cloud_api.append_short_license_view_to_html (ic.item, l_user, admin_module.module, s)
						end
						s.append ("</div>")
					end

					f.append_to_html (r.wsf_theme, s)


					s.append ("<h3>Informations</h3>%N")
					s.append ("<ul>")
					s.append ("<li><a href=%"" + api.administration_path ("cloud/installations/?user=" + l_user.id.out) + "%">Installations</a></li>")
					s.append ("</ul>")

					r.set_main_content (s)
					r.execute
				else
					send_not_found (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	add_new_license_to (a_plan_id: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER)
		local
			pl: ES_CLOUD_PLAN
			lic: ES_CLOUD_LICENSE
		do
			if a_plan_id.is_integer then
				pl := es_cloud_api.plan (a_plan_id.to_integer_32)
			else
				pl := es_cloud_api.plan_by_name (a_plan_id)
			end
			if pl /= Void then
				lic := es_cloud_api.new_license_for_plan (pl)
				es_cloud_api.save_license (lic)
				es_cloud_api.assign_license_to_user (lic, a_user)
			end
		end

	new_license_form (req: WSF_REQUEST): CMS_FORM
		local
			l_plans_choice: WSF_FORM_SELECT
			l_plan_item: WSF_FORM_SELECT_OPTION
			fset: WSF_FORM_FIELD_SET
			l_submit: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "new_license")
			Result.set_method_post
			create fset.make
			fset.set_legend ("Add new license")
			Result.extend (fset)
			create l_plans_choice.make ("new_license_plan")
			across
				es_cloud_api.sorted_plans as ic
			loop
				if attached ic.item as pl then
					create l_plan_item.make (pl.id.out, pl.title_or_name)
					l_plans_choice.add_option (l_plan_item)
				end
			end
			fset.extend (l_plans_choice)
			create l_submit.make_with_text ("op", "New license")
			fset.extend (l_submit)
		end

end
