note
	description: "Summary description for {ES_CLOUD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_MODULE

inherit
	CMS_MODULE
		rename
			module_api as es_cloud_api
		redefine
			initialize,
			install,
			setup_hooks,
			es_cloud_api,
			permissions
		end

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_WITH_WEBAPI

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "ES Cloud"
			package := "EiffelStudio"
		end

feature -- Access

	name: STRING = "es_cloud"

feature {CMS_MODULE} -- Access control

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>
		do
			Result := Precursor
			Result.force ("manager es accounts")
			Result.force ("view es account")
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_es_cloud_api: like es_cloud_api
		do
			Precursor (api)
			if es_cloud_api = Void then
				create l_es_cloud_api.make (api)
				es_cloud_api := l_es_cloud_api
			end
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			pl: ES_CLOUD_PLAN
			l_es_cloud_api: like es_cloud_api
		do
				-- Schema
			if attached api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)

				if l_sql_storage.has_error then
					api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
				else
					Precursor {CMS_MODULE} (api)
				end
			end
			if is_installed (api) then
				create l_es_cloud_api.make (api)
				es_cloud_api := l_es_cloud_api
				create pl.make ("free")
				pl.set_title ("Free")
				l_es_cloud_api.save_plan (pl)

				if attached api.user_api.anonymous_user_role as l_anonymous_role then
						-- By default, add extra permissions to anonymous role.
					l_anonymous_role.add_permission ("use jwt_auth")
					api.user_api.save_user_role (l_anonymous_role)
				end
			end
		end

feature {NONE} -- Administration

	administration: ES_CLOUD_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature {NONE} -- Webapi

	webapi: ES_CLOUD_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, CMS_MODULE} -- Access: API

	es_cloud_api: detachable ES_CLOUD_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached es_cloud_api as l_mod_api then
				a_router.handle ("/cloud", create {ES_CLOUD_HANDLER}.make (l_mod_api), a_router.methods_get)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
--			a_hooks.subscribe_to_form_alter_hook (Current)
		end

feature -- Hook

	response_alter (a_response: CMS_RESPONSE)
		local
			b: CMS_CONTENT_BLOCK
		do
			if a_response.is_front then
				a_response.set_value (a_response.url ("/cloud", Void), "escloud_url")
--				create b.make_raw ("Welcome", Void, "<h1>Hello EiffelStudio users</h1><p><a href=%""+ a_response.url ("/cloud", Void) +"%">Go to Cloud page...</a>", Void)
--				a_response.add_block (b, "content")
			end
		end


end
