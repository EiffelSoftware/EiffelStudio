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

	description: STRING
			-- Description of the module.

	package: STRING
			--

	version: STRING
			-- Version od the module?

feature {CMS_API} -- Module Initialization

	initialize (api: CMS_API)
			-- Initialize Current module with `api'.
		require
			is_enabled: is_enabled
		do
				-- Redefine to process specific module initialization.
		end

feature {CMS_API} -- Access: API

	module_api: detachable CMS_MODULE_API
			-- Eventual module api.

feature {CMS_API} -- Module management

	is_installed (api: CMS_API): BOOLEAN
			-- Is Current module installed?
		do
			Result := is_enabled
				-- FIXME: implement proper installation status.
		end

	install (api: CMS_API)
		require
			is_not_installed: not is_installed (api)
		do
				-- Not Yet Supported
		end

	uninstall (api: CMS_API)
		require
			is_installed: is_installed (api)
		do
				-- Not Yet Supported
		end

feature -- Router

	router (a_api: CMS_API): WSF_ROUTER
			-- Router configuration.
		require
			is_enabled: is_enabled
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

end
