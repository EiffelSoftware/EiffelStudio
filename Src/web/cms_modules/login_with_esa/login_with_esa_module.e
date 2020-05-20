note
	description: "Summary description for {LOGIN_WITH_ESA_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_MODULE

inherit
	CMS_MODULE
		rename
			module_api as login_with_esa_api
		redefine
			permissions,
			initialize,
			install,
			filters,
			setup_hooks,
			login_with_esa_api
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_AUTO_REGISTER

	CMS_WITH_WEBAPI

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Login with ESA account"
			package := "auth"
			add_dependency ({CMS_AUTHENTICATION_MODULE})
		end

feature -- Access

	name: STRING = "login_with_esa"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_use_login_with_esa)
			Result.force (perm_register_with_esa)
		end

	perm_use_login_with_esa: STRING = "use login_with_esa"
	perm_register_with_esa: STRING = "register with esa"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_login_with_esa_api: like login_with_esa_api
		do
			Precursor (api)
			create l_login_with_esa_api.make (api)
			login_with_esa_api := l_login_with_esa_api
			api.user_api.register_credential_validation (create {LOGIN_WITH_ESA_CREDENTIAL_VALIDATION}.make (l_login_with_esa_api))
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
				-- Schema
--			if attached api.storage.as_sql_storage as l_sql_storage then
--				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)
--				if l_sql_storage.has_error then
--					api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
--				else
					Precursor {CMS_MODULE} (api)
--				end
--			end
			if
				is_installed (api) and then
				attached api.user_api.anonymous_user_role as ano
			then
				ano.add_permission (perm_use_login_with_esa)
				ano.add_permission (perm_register_with_esa)
				api.user_api.save_user_role (ano)
			end
		end

feature {CMS_EXECUTION} -- Administration

	webapi: LOGIN_WITH_ESA_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, LOGIN_WITH_ESA_MODULE_WEBAPI} -- Access: API

	login_with_esa_api: detachable LOGIN_WITH_ESA_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached login_with_esa_api as l_esa_api then
				a_router.handle ("/" + register_location, create {LOGIN_WITH_ESA_REGISTER_HANDLER}.make (Current, l_esa_api), a_router.methods_get_post)
			end
		end

	register_location: STRING = "esa/register"

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached login_with_esa_api as l_esa_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {LOGIN_WITH_ESA_FILTER}.make (a_api, l_esa_api))
			end
		end

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			Precursor (a_hooks)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if not a_response.api.user_is_authenticated then
				create lnk.make ("Register", "/" + register_location)
				lnk.set_weight (99)
				a_menu_system.primary_menu.extend (lnk)
			end
		end

end
