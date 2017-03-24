note
	description: "Summary description for {CMS_AUTHENTICATION_MODULE_ADMINISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [CMS_AUTHENTICATION_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin registration")
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle ("/pending-registrations/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_pending_registrations (?, ?, a_api)), a_router.methods_get)
		end

feature -- Request handling

	handle_admin_pending_registrations (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			l_response: CMS_RESPONSE
			s: STRING
			u: CMS_TEMP_USER
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_count: INTEGER
			l_user_api: CMS_USER_API
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			create {FORBIDDEN_ERROR_CMS_RESPONSE} l_response.make (req, res, api)
			if
				l_response.has_permission ("admin registration")
			then
				l_user_api := api.user_api

				l_count := l_user_api.temp_users_count

				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

				create s.make_empty
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " Pending Registrations")
				else
					l_response.set_title ("Listing " + l_count.out + " Pending Registration")
				end

				create s_pager.make_empty
				create l_page_helper.make (api.administration_path_location ("pending-registrations/?page={page}&size={size}"), l_user_api.temp_users_count.as_natural_64, 25) -- FIXME: Make this default page size a global CMS settings
				l_page_helper.get_setting_from_request (req)
				if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
					l_page_helper.append_to_html (l_response, s_pager)
					if l_page_helper.page_size > 25 then
						s.append (s_pager)
					end
				end

				if attached l_user_api.temp_recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size)) as lst then
					s.append ("<ul class=%"cms-temp-users%">%N")
					across
						lst as ic
					loop
						u := ic.item
						s.append ("<li class=%"cms_temp_user%">")
						s.append ("User:" + html_encoded (u.name))
						s.append ("<ul class=%"cms_temp_user_details%">")
						if attached u.personal_information as l_information then
							s.append ("<li class=%"cms_temp_user_detail_information%">")
							s.append (html_encoded (l_information))
							s.append ("</li>%N")
						end
						if attached u.email as l_email then
							s.append ("<li class=%"cms_temp_user_detail_email%">")
							s.append (l_email)
							s.append ("</li>%N")
						end
						if attached l_user_api.token_by_temp_user_id (u.id) as l_token then
							s.append ("<li>")
							s.append ("<a href=%"")
							s.append (req.absolute_script_url ("/account/activate/" + l_token))
							s.append ("%">")
							s.append (html_encoded ("Activate"))
							s.append ("</a>")
							s.append ("</li>%N")
							s.append ("<li>")
							s.append ("<a href=%"")
							s.append (req.absolute_script_url ("/account/reject/" + l_token))
							s.append ("%">")
							s.append (html_encoded ("Reject"))
							s.append ("</a>")
							s.append ("</li>%N")
						end
						s.append ("</ul>%N")
						s.append ("</li>%N")
					end
					s.append ("</ul>%N")
				end
					-- Again the pager at the bottom, if needed
				s.append (s_pager)

				l_response.set_main_content (s)
				l_response.execute
			else
				l_response.execute
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (module)
			a_hooks.subscribe_to_value_table_alter_hook (module)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
				 -- Add the link to the taxonomy to the main menu
			if a_response.has_permission ("admin registration") then
				create lnk.make ("Registration", a_response.api.administration_path_location ("pending-registrations/"))
				a_menu_system.management_menu.extend_into (lnk, "Admin", a_response.api.administration_path_location (""))
			end
		end

end
