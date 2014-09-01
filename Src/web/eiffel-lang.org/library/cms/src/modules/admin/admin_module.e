note
	description: "Summary description for {ADMIN_MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_MODULE

inherit
	CMS_MODULE
		redefine
			permissions
		end

	CMS_HOOK_MENU_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "admin"
			version := "1.0"
			description := "Set of service to administrate the site"
			package := "core"

			enable
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		do
			service := a_service
			a_service.map_uri ("/admin/", agent handle_admin (a_service, ?, ?))
			a_service.map_uri ("/admin/users/", agent handle_admin_users (a_service, ?, ?))
			a_service.map_uri ("/admin/roles/", agent handle_admin_user_roles (a_service, ?, ?))
			a_service.map_uri ("/admin/blocks/", agent handle_admin_blocks (a_service, ?, ?))
			a_service.map_uri ("/admin/modules/", agent handle_admin_modules (a_service, ?, ?))
			a_service.map_uri ("/admin/logs/", agent handle_admin_logs (a_service, ?, ?))
			a_service.map_uri_template ("/admin/log/{log-id}", agent handle_admin_log_view (a_service, ?, ?))

			a_service.add_menu_alter_hook (Current)
		end

feature -- Hooks

	menu_alter (a_menu_system: CMS_MENU_SYSTEM; a_execution: CMS_EXECUTION)
		local
			lnk: CMS_LOCAL_LINK
		do
			create lnk.make ("Administer", "/admin/")
			lnk.set_permission_arguments (<<"administer">>)
			a_menu_system.management_menu.extend (lnk)
		end

	permissions (a_service: CMS_SERVICE): LIST [CMS_PERMISSION]
		do
			Result := Precursor (a_service)
			Result.extend ("administer")
			Result.extend ("administer users")
			Result.extend ("administer user roles")
			Result.extend ("administer content")
			Result.extend ("administer logs")
			Result.extend ("administer blocks")
			Result.extend ("administer modules")
		end

feature -- Handler		

	handle_admin (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ADMIN_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_admin_users (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ADMIN_USERS_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_admin_user_roles (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ADMIN_USER_ROLES_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_admin_blocks (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ADMIN_BLOCKS_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_admin_modules (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ADMIN_MODULES_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_admin_logs (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ADMIN_LOGS_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_admin_log_view (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {LOG_VIEW_CMS_EXECUTION}.make (req, res, cms)).execute
		end


end
