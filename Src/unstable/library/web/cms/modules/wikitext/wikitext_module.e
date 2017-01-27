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
		local
			f: CMS_FORMAT
		do
			Precursor (api)

			create f.make_from_format (create {WIKITEXT_FORMAT})
			api.formats.extend (f)
				-- FIXME!!!
			across
				api.content_types as ic
			loop
				ic.item.extend_format (f)
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
