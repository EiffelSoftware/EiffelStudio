note
	description: "Summary description for {ES_CLOUD_PROFILES_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PROFILES_HANDLER

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
				if req.is_get_request_method then
					get_cloud_profiles (req, res)
				else
					send_bad_request (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	get_cloud_profiles (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			nb: INTEGER
			l_profile: ES_CLOUD_USER_PROFILE
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_show_all: BOOLEAN
			lst: ITERABLE [ES_CLOUD_USER_PROFILE]
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title ("Profiles...")
			s := ""

			l_show_all := attached {WSF_STRING} req.query_parameter ("show") as p and then p.same_string ("all")

			if not l_show_all then
				create s_pager.make_empty
				create l_page_helper.make (req.percent_encoded_path_info + "?page={page}&size={size}", api.user_api.users_count.as_natural_64, 25)
				l_page_helper.get_setting_from_request (req)
				if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
					l_page_helper.append_to_html (r, s_pager)
					if l_page_helper.page_size > 25 then
						s.append (s_pager)
					end
				end
				lst := es_cloud_api.cloud_user_profiles (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size))
			else
				lst := es_cloud_api.cloud_user_profiles (Void) -- all profiles!
			end
			if lst /= Void then
				across
					lst as ic
				loop
					l_profile := ic.item
					if not l_profile.is_empty then
						nb := nb + 1
						s.append ("<div>View profile for: ")
						s.append ("<a href=%""+ api.url (module.user_cloud_profile_location (l_profile.cms_user), Void) + "" +"%" class=%"button%">&gt;&gt; View " + html_encoded (api.real_user_display_name (l_profile.cms_user)) + "</a>")
						s.append ("</div>%N")
					else
						s.append ("<div>No profile for:")
						s.append ("<a href=%""+ api.url (module.user_cloud_profile_location (l_profile.cms_user), Void) + "" +"%" class=%"button%">&gt;&gt; View " + html_encoded (api.real_user_display_name (l_profile.cms_user)) + "</a>")
						s.append ("</div>%N")
					end
				end
			end
			if l_show_all and nb = 0 then
				r.add_message ("No public profile", Void)
			end
			if s_pager /= Void then
				s.append (s_pager)
				s.append (" <a class=%"button%" href=%"" + req.percent_encoded_path_info + "?show=all%">Show all</a>")
			end

			r.set_main_content (s)
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

