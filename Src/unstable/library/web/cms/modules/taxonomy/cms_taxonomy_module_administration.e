note
	description: "Summary description for {CMS_TAXONOMY_MODULE_ADMINISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TAXONOMY_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [CMS_TAXONOMY_MODULE]
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
			Result.force ("admin taxonomy")
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
		do
			if attached module.taxonomy_api as l_taxonomy_api then
				configure_web_admin (a_api, l_taxonomy_api, a_router)
			end
		end

	configure_web_admin (a_api: CMS_API; a_taxonomy_api: CMS_TAXONOMY_API; a_router: WSF_ROUTER)
			-- Configure router mapping for web interface.
		local
			l_taxonomy_handler: TAXONOMY_TERM_ADMIN_HANDLER
			l_voc_handler: TAXONOMY_VOCABULARY_ADMIN_HANDLER
		do
			a_router.handle ("/taxonomy/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_taxonomy (?, ?, a_api)), a_router.methods_get)

			create l_taxonomy_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/taxonomy/term/", l_taxonomy_handler, a_router.methods_get_post)
			a_router.handle ("/taxonomy/term/{termid}", l_taxonomy_handler, a_router.methods_get_post)

			create l_voc_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/taxonomy/vocabulary/", l_voc_handler, a_router.methods_get_post)
			a_router.handle ("/taxonomy/vocabulary/{vocid}", l_voc_handler, a_router.methods_get_post)
		end

feature -- Handler

	handle_admin_taxonomy (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			l_page: CMS_RESPONSE
			lnk: CMS_LOCAL_LINK
		do
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			create lnk.make ("Admin Vocabularies", api.administration_path_location ("taxonomy/vocabulary/"))
			l_page.add_to_primary_tabs (lnk)

			create lnk.make ("Create terms", api.administration_path_location ("taxonomy/term/"))
			l_page.add_to_primary_tabs (lnk)

			l_page.execute
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			module.response_alter (a_response)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
		do
				 -- Add the link to the taxonomy to the main menu
			if a_response.has_permission ("admin taxonomy") then
				create lnk.make ("Taxonomy", a_response.api.administration_path_location ("taxonomy/"))
				a_menu_system.management_menu.extend_into (lnk, "Admin", a_response.api.administration_path_location (""))
			end
		end

end
