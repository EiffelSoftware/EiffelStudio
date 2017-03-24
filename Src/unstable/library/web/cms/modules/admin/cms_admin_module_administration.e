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

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("access admin")
			Result.force ("admin users")
			Result.force ("admin roles")
			Result.force ("admin modules")
			Result.force ("admin cache")
			Result.force ("admin core caches")
			Result.force ("clear blocks cache")
			Result.force ("admin export")
			Result.force ("admin import")
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			l_admin_handler: CMS_ADMIN_HANDLER

			l_modules_handler: CMS_ADMIN_MODULES_HANDLER
			l_users_handler: CMS_ADMIN_USERS_HANDLER
			l_roles_handler: CMS_ADMIN_ROLES_HANDLER

			l_user_handler: CMS_USER_HANDLER
			l_role_handler:	CMS_ROLE_HANDLER
			l_admin_logs_handler: CMS_LOGS_HANDLER

			l_admin_cache_handler: CMS_ADMIN_CACHE_HANDLER
			l_admin_export_handler: CMS_ADMIN_EXPORT_HANDLER
			l_admin_import_handler: CMS_ADMIN_IMPORT_HANDLER
			l_admin_path_alias_handler: CMS_ADMIN_PATH_ALIAS_HANDLER

			l_uri_mapping: WSF_URI_MAPPING
		do
			create l_admin_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("", l_admin_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_modules_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/modules", l_modules_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_users_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/users", l_users_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_roles_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/roles", l_roles_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			create l_admin_logs_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/logs", l_admin_logs_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

			create l_admin_path_alias_handler.make (a_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/path_alias", l_admin_path_alias_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)


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
		end

	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/admin.css", Void), Void)
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

				create lnk.make ("Module", l_api.administration_path_location ("modules"))
				lnk.set_permission_arguments (<<"manage module">>)
				admin_lnk.extend (lnk)

					-- Per module cache permission!
				create lnk.make ("Cache", l_api.administration_path_location ("cache"))
				lnk.set_permission_arguments (<<"admin cache">>)
				admin_lnk.extend (lnk)

					-- Per module export permission!
				create lnk.make ("Export", l_api.administration_path_location ("export"))
				lnk.set_permission_arguments (<<"admin export">>)
				admin_lnk.extend (lnk)
					-- Per module import permission!
				create lnk.make ("Import", l_api.administration_path_location ("import"))
				lnk.set_permission_arguments (<<"admin import">>)
				admin_lnk.extend (lnk)
			end
		end


end
