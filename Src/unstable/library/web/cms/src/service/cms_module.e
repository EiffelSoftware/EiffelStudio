note
	description: "Describe module features that adds one or more features to your web site."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MODULE

inherit
	REFACTORING_HELPER

feature -- Access

	is_enabled: BOOLEAN
			-- Is the module enabled?

	name: STRING
			-- Name of the module.
		deferred
		end

	description: STRING
			-- Description of the module.

	package: STRING
			-- Associated package.
			-- Mostly to group modules by package/category.

	version: STRING
			-- Version od the module?

	dependencies: detachable LIST [TYPE [CMS_MODULE]]
			-- Optional dependencies.

feature {CMS_API} -- Module Initialization

	initialize (api: CMS_API)
			-- Initialize Current module with `api'.
		require
			is_enabled: is_enabled
			is_not_initialized: not is_initialized
		do
				-- Redefine to process specific module initialization.
			is_initialized := True
		ensure
			is_initialized: is_initialized
		end

	add_dependency (a_type: TYPE [CMS_MODULE])
			-- Add dependency using type of module `a_type'.
		local
			deps: like dependencies
		do
			deps := dependencies
			if deps = Void then
				create {ARRAYED_LIST [TYPE [CMS_MODULE]]} deps.make (1)
				dependencies := deps
			end
			deps.force (a_type)
		end

feature -- Status		

	is_initialized: BOOLEAN
			-- Is Current module initialized?		

feature {CMS_API} -- Access: API

	module_api: detachable CMS_MODULE_API
			-- Eventual module api.
		require
			is_initialized: is_initialized
		do
				-- No API by default.
		end

feature {CMS_API} -- Module management

	is_installed (api: CMS_API): BOOLEAN
			-- Is Current module installed?
		do
			Result := attached api.storage.custom_value ("is_initialized", "module-" + name) as v and then v.is_case_insensitive_equal_general ("yes")
		end

	install (api: CMS_API)
		require
			is_not_installed: not is_installed (api)
		do
			api.storage.set_custom_value ("is_initialized", "yes", "module-" + name)
		end

	uninstall (api: CMS_API)
		require
			is_installed: is_installed (api)
		do
			api.storage.set_custom_value ("is_initialized", "no", "module-" + name)
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Setup url dispatching for Current module.
		require
			is_initialized: is_initialized
		deferred
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		require
			is_enabled: is_enabled
		do
		end

feature -- Filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Optional list of filter for Current module.
		require
			is_enabled: is_enabled
		do
		end

feature -- Settings

	enable
			-- enable the module.
		do
			is_enabled := True
		ensure
			module_enabled: is_enabled
		end

	disable
			-- disable the module.
		do
			is_enabled := False
		ensure
			module_disbaled: not is_enabled
		end

feature -- Hooks

	help_text (a_path: STRING): STRING
		do
			debug ("refactor_fixme")
				to_implement ("Add the corresponing implementation.")
			end
			create Result.make_empty
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
