note
	description: "[
			Taxonomy module managing vocabularies and terms.
		]"
	date: "$Date$"
	revision: "$Revision 96616$"

class
	CMS_TAXONOMY_MODULE

inherit
	CMS_MODULE_WITH_SQL_STORAGE
		rename
			module_api as taxonomy_api
		redefine
			setup_hooks,
			initialize,
			install,
			taxonomy_api,
			permissions
		end

	CMS_ADMINISTRABLE

	CMS_HOOK_RESPONSE_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Taxonomy solution"
			package := "core"
		end

feature -- Access

	name: STRING = "taxonomy"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("update any taxonomy")
			Result.force ("update page taxonomy") -- related to node module
			Result.force ("update blog taxonomy") -- related to blog module
		end

feature {CMS_EXECUTION} -- Administration

	administration: CMS_TAXONOMY_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			create taxonomy_api.make (api)
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			voc: CMS_VOCABULARY
			l_taxonomy_api: like taxonomy_api
		do
			Precursor (api)
			if is_installed (api) then
					-- Populate
				create l_taxonomy_api.make (api)
				create voc.make ("Tags")
				voc.set_description ("Enter comma separated tags.")
				l_taxonomy_api.save_vocabulary (voc)
				voc.set_is_tags (True)
				l_taxonomy_api.associate_vocabulary_with_type (voc, "page")
			end
		end

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Access: API

	taxonomy_api: detachable CMS_TAXONOMY_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached taxonomy_api as l_taxonomy_api then
				configure_web (a_api, l_taxonomy_api, a_router)
			else
					-- Issue with api/dependencies,
					-- thus Current module should not be used!
					-- thus no url mapping
			end
		end

	configure_web (a_api: CMS_API; a_taxonomy_api: CMS_TAXONOMY_API; a_router: WSF_ROUTER)
			-- Configure router mapping for web interface.
		local
			l_taxonomy_handler: TAXONOMY_HANDLER
			l_voc_handler: TAXONOMY_VOCABULARY_HANDLER
		do
			create l_taxonomy_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/taxonomy/term/{termid}", l_taxonomy_handler, a_router.methods_get)

			create l_voc_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/taxonomy/vocabulary/", l_voc_handler, a_router.methods_get)
			a_router.handle ("/taxonomy/vocabulary/{vocid}", l_voc_handler, a_router.methods_get)
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_response_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/taxonomy.css", Void), Void)
		end

end
