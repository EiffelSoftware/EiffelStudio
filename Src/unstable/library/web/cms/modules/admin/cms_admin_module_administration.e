note
	description: "Summary description for {CMS_ADMIN_MODULE_ADMINISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [CMS_ADMIN_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_FORM_ALTER

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_view_system_info)
			Result.force (perm_access_admin)
			Result.force (perm_admin_users)
			Result.force (perm_admin_roles)
			Result.force (perm_admin_modules)
			Result.force ("admin cache")
			Result.force ("admin core caches")
			Result.force ("clear blocks cache")
			Result.force ("admin export")
			Result.force ("admin import")
			Result.force ("admin formats")
			Result.force (perm_view_logs)
			Result.force (perm_view_mails)
		end

	perm_view_system_info: STRING = "view system info"

	perm_admin_modules: STRING = "admin modules"
	perm_admin_users: STRING = "admin users" -- See {CMS_CORE_MODULE}.perm_admin_users
	perm_admin_roles: STRING = "admin roles"
	perm_access_admin: STRING = "access admin"
	perm_view_logs: STRING = "view logs"
	perm_view_mails: STRING = "view mails"

feature -- Form identifiers

	form_admin_user_view_id: STRING = "admin-view-user"

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			l_admin_handler: CMS_ADMIN_HANDLER

			l_info_handler: CMS_ADMIN_INFO_HANDLER

			l_modules_handler: CMS_ADMIN_MODULES_HANDLER
			l_users_handler: CMS_ADMIN_USERS_HANDLER
			l_roles_handler: CMS_ADMIN_ROLES_HANDLER
			l_formats_handler: CMS_ADMIN_FORMATS_HANDLER

			l_user_handler: CMS_ADMIN_USER_HANDLER
			l_role_handler:	CMS_ROLE_HANDLER
			l_admin_logs_handler: CMS_LOGS_HANDLER
			l_admin_mails_handler: CMS_ADMIN_MAILS_HANDLER

			l_admin_cache_handler: CMS_ADMIN_CACHE_HANDLER
			l_admin_export_handler: CMS_ADMIN_EXPORT_HANDLER
			l_admin_import_handler: CMS_ADMIN_IMPORT_HANDLER
			l_admin_path_alias_handler: CMS_ADMIN_PATH_ALIAS_HANDLER

			l_uri_mapping: WSF_URI_MAPPING
		do
			create l_admin_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("", l_admin_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_info_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/info", l_info_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

			create l_modules_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/modules", l_modules_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_users_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/users", l_users_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_roles_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/roles", l_roles_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_formats_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/formats", l_formats_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)
			create l_uri_mapping.make_trailing_slash_ignored ("/formats", l_formats_handler)
			a_router.handle ("/formats/{format-id}", l_formats_handler, a_router.methods_get_post)
			a_router.handle ("/formats/{format-id}/add", l_formats_handler, a_router.methods_get_post)

			create l_admin_logs_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/logs", l_admin_logs_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

			create l_admin_path_alias_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/path_alias", l_admin_path_alias_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_admin_mails_handler.make (a_api)
			a_router.handle ("/mails/{uid}", l_admin_mails_handler, a_router.methods_get)
			a_router.handle ("/mails", l_admin_mails_handler, a_router.methods_get)

			create l_admin_cache_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/cache", l_admin_cache_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_admin_export_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/export", l_admin_export_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_admin_import_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/import", l_admin_import_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_user_handler.make (a_api)
			a_router.handle ("/add/user", l_user_handler, a_router.methods_get_post)
			a_router.handle ("/user/{id}", l_user_handler, a_router.methods_get)
			a_router.handle ("/user/{id}/edit", l_user_handler, a_router.methods_get_post)
			a_router.handle ("/user/{id}/delete", l_user_handler, a_router.methods_get_post)

			create l_role_handler.make (a_api)
			a_router.handle ("/add/role", l_role_handler, a_router.methods_get_post)
			a_router.handle ("/role/{id}", l_role_handler, a_router.methods_get)
			a_router.handle ("/role/{id}/edit", l_role_handler, a_router.methods_get_post)
			a_router.handle ("/role/{id}/delete", l_role_handler, a_router.methods_get_post)

		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- <Precursor>
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_form_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/admin.css", Void), Void)
			a_response.add_javascript_url (a_response.module_resource_url (Current, "/files/js/admin.js", Void))
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
			admin_lnk: CMS_LINK_COMPOSITE
			l_api: CMS_API
		do
			l_api := a_response.api
			if l_api.user_is_authenticated then
				admin_lnk := a_menu_system.management_menu.new_composite_item ("Admin", l_api.administration_path_location (""))

				if attached admin_lnk.new_composite_item ("Core", l_api.administration_path_location ("#core")) as core_lnk then
					if attached {CMS_LOCAL_LINK} core_lnk as ll then
						ll.set_weight (10)
					end
						-- Global system information
					create lnk.make ("Info", l_api.administration_path_location ("info"))
					lnk.set_permission_arguments (<<perm_view_system_info>>)
					lnk.set_help ("View information about the system")
					lnk.set_weight (-1)
					core_lnk.extend (lnk)

					create lnk.make ("Module", l_api.administration_path_location ("modules"))
					lnk.set_permission_arguments (<<perm_admin_modules>>)
					lnk.set_help ("Manage the modules")
					lnk.set_weight (1)
					core_lnk.extend (lnk)

					create lnk.make ("Users", l_api.administration_path_location ("users"))
					lnk.set_permission_arguments (<<perm_admin_users>>)
					lnk.set_help ("View/Edit/Add Users")
					lnk.set_weight (1)
					core_lnk.extend (lnk)

					create lnk.make ("Roles", l_api.administration_path_location ("roles"))
					lnk.set_permission_arguments (<<perm_admin_roles>>)
					lnk.set_help ("View/Edit/Add Roles")
					lnk.set_weight (1)
					core_lnk.extend (lnk)

					create lnk.make ("Logs", l_api.administration_path_location ("logs"))
					lnk.set_permission_arguments (<<perm_view_logs>>)
					lnk.set_help ("View logs")
					lnk.set_weight (2)
					core_lnk.extend (lnk)

					create lnk.make ("Mails", l_api.administration_path_location ("mails"))
					lnk.set_permission_arguments (<<perm_view_mails>>)
					lnk.set_help ("View mails")
					lnk.set_weight (2)
					core_lnk.extend (lnk)

					create lnk.make ("Path Alias", l_api.administration_path_location ("path_alias"))
					lnk.set_permission_arguments (<<"admin path_alias">>)
					lnk.set_help ("Manage path aliases")
					lnk.set_weight (2)
					core_lnk.extend (lnk)
				end
				if attached admin_lnk.new_composite_item ("Content", l_api.administration_path_location ("#content")) as content_lnk then
					if attached {CMS_LOCAL_LINK} content_lnk as ll then
						ll.set_weight (10)
					end
					create lnk.make ("Nodes", l_api.administration_path_location ("nodes/"))
					lnk.set_permission_arguments (<<"admin node">>)
					lnk.set_help ("Nodes")
					lnk.set_weight (2)
					content_lnk.extend (lnk)

					create lnk.make ("Formats", l_api.administration_path_location ("formats"))
					lnk.set_permission_arguments (<<"admin formats">>)
					lnk.set_help ("Content formats and filters")
					lnk.set_weight (3)
					content_lnk.extend (lnk)

						-- Per module cache permission!
					create lnk.make ("Cache", l_api.administration_path_location ("cache"))
					lnk.set_help ("Clear caches")
					lnk.set_permission_arguments (<<"admin cache">>)
					lnk.set_weight (4)
					content_lnk.extend (lnk)
				end

				if attached admin_lnk.new_composite_item ("Support", l_api.administration_path_location ("#support")) as support_lnk then
					if attached {CMS_LOCAL_LINK} support_lnk as ll then
						ll.set_weight (10)
					end
						-- Per module export permission!
					create lnk.make ("Export", l_api.administration_path_location ("export"))
					lnk.set_help ("Export CMS contents, and modules contents.")
					lnk.set_permission_arguments (<<"admin export">>)
					lnk.set_weight (8)
					support_lnk.extend (lnk)

						-- Per module import permission!
					create lnk.make ("Import", l_api.administration_path_location ("import"))
					lnk.set_help ("Import CMS contents, and modules contents.")
					lnk.set_permission_arguments (<<"admin import">>)
					lnk.set_weight (9)
					support_lnk.extend (lnk)
				end
			end
		end

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
			-- Hook execution on form `a_form' and its associated data `a_form_data',
			-- for related response `a_response'.
		local
			fset: WSF_FORM_FIELD_SET
			l_uid: like {CMS_USER}.id
		do
			if
				attached a_form.id as fid and then
				fid.same_string ({CMS_ADMIN_MODULE_ADMINISTRATION}.form_admin_user_view_id)
			then
				if attached a_response.user as u then
					if a_response.has_permission (perm_view_mails) then
						if attached a_form.fields_by_name ("user-id") as l_uid_fields then
							across
								l_uid_fields as ic
							until
								l_uid /= 0
							loop
								if
									attached {WSF_FORM_INPUT} ic.item as f and then
									attached f.default_value as v
								then
									l_uid := v.to_integer_64
								end
							end
						end
						create fset.make
						fset.set_legend ("Messages")
						fset.extend_html_text ("<a href=%"" + a_response.api.administration_location_url ("mails/" + l_uid.out, Void) + "%">See all mails</a>")
						a_form.prepend (fset)
					end
				end
			end
		end

end
