note
	description: "CMS module that bring support for path aliases."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKITEXT_MODULE

inherit
	CMS_MODULE
		rename
			module_api as wikitext_api
		redefine
			initialize,
			setup_hooks
		end

	CMS_HOOK_RESPONSE_ALTER


create
	make

feature {NONE} -- Initialization

	make
			-- Create Current module, disabled by default.
		do
			version := "1.0"
			description := "Wikitext module"
			package := "filter"
		end

feature -- Access

	name: STRING = "wikitext"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)

			api.content_filters.extend (create {WIKITEXT_FILTER})
			if api.format ({WIKITEXT_FORMAT}.name) = Void then
				api.formats.extend (api.new_format ("wikitext", "Wikitext rendered as HTML", <<{WIKITEXT_FILTER}.name>>))
			end
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Setup url dispatching for Current module.
		do
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_response_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/wikitext.css", Void), Void)
		end

end
