note
	description: "Describe module features that adds one or more features to your web site."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MODULE

inherit
	REFACTORING_HELPER

	CMS_ENCODERS

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
			-- Version of the module?

	dependencies: detachable LIST [TUPLE [module_type: TYPE [CMS_MODULE]; is_required: BOOLEAN]]
			-- Optional declaration for dependencies.

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		require
			is_initialized: is_initialized
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} Result.make (0)
		end

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
			-- Add required dependency using type of module `a_type'.
		do
			put_dependency (a_type, True)
		end

	put_dependency (a_type: TYPE [CMS_MODULE]; is_required: BOOLEAN)
			-- Add required or optional dependency using type of module `a_type', based on `is_required' value.
		local
			lst: like dependencies
		do
			lst := dependencies
			if lst = Void then
				create {ARRAYED_LIST [TUPLE [module_type: TYPE [CMS_MODULE]; is_required: BOOLEAN]]} lst.make (1)
				dependencies := lst
			end
			lst.force ([a_type, is_required])
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
			if attached api.storage.custom_value ("is_initialized", "module-" + name) as v then
				if v.is_case_insensitive_equal_general (version) then
					Result := True
				elseif v.is_case_insensitive_equal_general ("yes") then
						-- Backward compatibility.
					Result := True
				elseif v.is_case_insensitive_equal_general ("no") then
						-- Probably a module that was installed, but now uninstalled.
					Result := False
				else
						-- Maybe a different version is installed.
						-- For now, let's assume this is installed.
					Result := True
				end
			end
		end

	install (api: CMS_API)
		require
			is_not_installed: not is_installed (api)
		do
			api.storage.set_custom_value ("is_initialized", version, "module-" + name)
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
		obsolete
			"!UNSAFE!: it is highly recommended to update this module and use setup_hooks [Dec/2015]."
		require
			is_enabled: is_enabled
		do
			setup_hooks (a_response.api.hooks)
		end

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
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

invariant
	name_set: not name.is_whitespace
	version_set: not version.is_whitespace

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
