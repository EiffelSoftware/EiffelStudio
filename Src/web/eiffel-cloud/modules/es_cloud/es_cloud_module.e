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
		do
			Precursor (api)
			create es_cloud_api.make (api)
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
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

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
			-- Hook execution on form `a_form' and its associated data `a_form_data',
			-- for related response `a_response'.
		do

		end

feature -- Hook

	response_alter (a_response: CMS_RESPONSE)
		local
			b: CMS_CONTENT_BLOCK
		do
			if a_response.is_front then
				create b.make_raw ("Welcome", Void, "<h1>Hello EiffelStudio users</h1><p><a href=%""+ a_response.url ("/cloud", Void) +"%">Go to Cloud page...</a>", Void)
				a_response.add_block (b, "content")
			end
		end


end
