note
	description: "Summary description for {CMS_SELF_MODULE_ADMINISTRATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SELF_MODULE_ADMINISTRATION [G -> CMS_MODULE]

inherit
	CMS_MODULE_ADMINISTRATION [G]
		redefine
			setup_hooks,
			filters
		end

create
	make

feature -- Router

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
		do
		end

feature -- Filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Optional list of filter for Current module.
			-- (from CMS_MODULE)
		do
			Result := module.filters (a_api)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			module.setup_hooks (a_hooks)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
