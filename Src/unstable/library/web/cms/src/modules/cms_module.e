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
