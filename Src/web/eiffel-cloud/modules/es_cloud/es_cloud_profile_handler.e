note
	description: "Summary description for {ES_CLOUD_PROFILE_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PROFILE_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_module: ES_CLOUD_MODULE; a_mod_api: ES_CLOUD_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			module := a_module
			es_cloud_api := a_mod_api
		end

feature -- API

	module: ES_CLOUD_MODULE

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if api.has_permissions (<<{ES_CLOUD_MODULE}.perm_view_cloud_profiles, {ES_CLOUD_MODULE}.perm_view_es_accounts, {ES_CLOUD_MODULE}.perm_manage_es_accounts>>) then
				if
					attached {WSF_STRING} req.path_parameter ("account_id") as p_acc and then
					attached es_cloud_api.cloud_user (p_acc.value) as u
				then
					if req.is_get_request_method then
						get_cloud_account (u, req, res)
					elseif req.is_post_request_method then
						post_cloud_account (u, req, res)
					else
						send_bad_request (req, res)
					end
				else
					send_not_found (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	post_cloud_account (a_cloud_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: like new_edit_form
			l_prof: ES_CLOUD_USER_PROFILE
			r: like new_generic_response
			s: STRING_8
		do
			l_prof := es_cloud_api.cloud_user_profile (a_cloud_user)
			if l_prof = Void then
				create l_prof.make (a_cloud_user)
			end

			f := new_edit_form (l_prof, req)

			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded (api.real_user_display_name (a_cloud_user.cms_user)))
			create s.make_empty
			s.append ("<p class=%"es-message%">User "+ api.html_encoded (api.real_user_display_name (a_cloud_user.cms_user)) +"</p>")

			f.process (r)
			if
				attached f.last_data as fd and then
				attached fd.item_same_string ("op", "Apply")
			then
				fd.apply_to_associated_form
				if attached fd.string_item ("about_wikitext") as wk then
					l_prof.set_about_wikitext (wk)
				end
				es_cloud_api.save_cloud_user_profile (l_prof)
				r.set_redirection (req.percent_encoded_path_info)
			else
				f.append_to_html (r.wsf_theme, s)
			end
			r.execute
		end

	get_cloud_account (a_cloud_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			l_is_editing: BOOLEAN
			l_is_own_profile: BOOLEAN
			l_profile: ES_CLOUD_USER_PROFILE
			f: like new_edit_form
		do
			l_is_own_profile := a_cloud_user.cms_user.same_as (api.user)
			if attached req.query_parameter ("edit") as v and then v.is_case_insensitive_equal ("yes") then
				l_is_editing := l_is_own_profile or api.user_is_administrator
			end
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded (api.real_user_display_name (a_cloud_user.cms_user)))
			s := ""

			l_profile := es_cloud_api.cloud_user_profile (a_cloud_user)

			if l_is_editing then
				f := new_edit_form (l_profile, req)
				f.append_to_html (r.wsf_theme, s)
			else
				s.append ("<div id=%"cloud_profile%">%N")
				if
					l_profile /= Void and then
					attached l_profile.about_wikitext as wk
				then
					s.append ("<div class=%"overview%">")
					if attached api.format ({WIKITEXT_FORMAT}.name) as ft then
						ft.append_formatted_to (wk, s)
					else
						s.append ("<code>")
						s.append (html_encoded (wk))
						s.append ("</code>")
					end
					s.append ("</div>%N")
				end
				if l_is_own_profile then
					s.append ("<a href=%""+ api.url (module.user_cloud_profile_location (a_cloud_user.cms_user), Void) + "?edit=yes" +"%" class=%"button%">&gt;&gt; Edit your profile</a>")
				end
				s.append ("</div>%N")

				if api.has_permission ({CMS_AUTHENTICATION_MODULE}.perm_view_users) then
					s.append ("<div><a href=%""+ api.url ("user/" + a_cloud_user.id.out, Void) +"%">View user "+ html_encoded (api.real_user_display_name (a_cloud_user.cms_user)) +"</a></div>")
				end
			end
			r.set_main_content (s)
			r.execute
		end

	new_edit_form (p: detachable ES_CLOUD_USER_PROFILE; req: WSF_REQUEST): CMS_FORM
		local
			f_submit: WSF_FORM_SUBMIT_INPUT
			f_txt: WSF_FORM_TEXTAREA
		do
			create Result.make (req.percent_encoded_path_info, "cloud_account_edit")

			create f_txt.make ("about_wikitext")
			f_txt.set_cols (60)
			f_txt.set_rows (20)
			if p /= Void and then attached p.about_wikitext as wk and then not wk.is_whitespace then
				f_txt.set_text_value (wk)
			else
				f_txt.set_text_value (es_cloud_api.default_cloud_user_profile_about_content)
			end
			f_txt.set_label ("Edit your overview")
			if attached api.format ({WIKITEXT_FORMAT}.name) as ft then
				f_txt.set_description ("Use the wikitext syntax...%N<ul>" + ft.html_help + "</ul>")
				f_txt.set_collapsed_description ("Use the wikitext syntax...")
				f_txt.set_description_collapsible (True)
			end
			Result.extend (f_txt)
			create f_submit.make_with_text ("op", "Apply")
			Result.extend (f_submit)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

