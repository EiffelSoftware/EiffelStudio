note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MODULE_ADMINISTRATION [G -> CMS_MODULE]

inherit
	CMS_MODULE
		rename
			is_initialized as module_is_initialized,
			is_enabled as module_is_enabled
		redefine
			module_api
		end

feature {NONE} -- Initialization

	make (a_module: G)
			-- Initialize `Current'.
		do
			module := a_module
			version := a_module.version
			description := a_module.description
			package := a_module.package

			module_is_initialized := a_module.is_initialized
			module_is_enabled := a_module.is_enabled
		end

feature -- Access

	module: G

	name: STRING
		do
			Result := module.name
		end

feature -- Status		

	is_initialized: BOOLEAN
			-- Is Current module initialized?		
		do
			Result := module.is_initialized
		end

	is_enabled: BOOLEAN
			-- Is Current module enabled?
		do
			Result := module.is_enabled
		end

feature {CMS_API, CMS_MODULE_ADMINISTRATION, CMS_MODULE_WEBAPI} -- Access: API

	module_api: detachable CMS_MODULE_API
			-- Eventual module api.
		do
			Result := module.module_api
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if a_router.base_url /= Void then
				setup_administration_router (a_router, a_api)
			end
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Setup url dispatching for Current module administration.
			-- (note: `a_router` is already based with admin path prefix).
		require
			is_initialized: is_initialized
			router_has_base_url: a_router.base_url /= Void
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
