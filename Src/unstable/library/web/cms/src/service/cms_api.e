note
	description: "API for a CMS"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API

inherit
	ANY

	REFACTORING_HELPER

	CMS_ENCODERS

create
	make

feature {NONE} -- Initialize

	make (a_setup: CMS_SETUP)
			-- Create the API service with a setup  `a_setup'
		do
			setup := a_setup
			create error_handler.make
			create {CMS_ENV_LOGGER} logger.make
			initialize
		ensure
			setup_set: setup = a_setup
			error_handler_set: not error_handler.has_error
		end

	initialize
				-- Initialize the persitent layer.
		local
			l_module: CMS_MODULE
		do
			if attached setup.storage (error_handler) as l_storage then
				storage := l_storage
			else
				create {CMS_STORAGE_NULL} storage
			end
			storage.set_api (Current)

			across
				setup.enabled_modules as ic
			loop
				l_module := ic.item
					-- FIXME: should we initialize first, and then install
					-- or the reverse, or merge installation and initialization
					-- and leave the responsability to the module to know
					-- if this is installed or not...
				if not l_module.is_installed (Current) then
					l_module.install (Current)
				end
				l_module.initialize (Current)
			end
		end

feature -- Access

	setup: CMS_SETUP
			-- CMS setup.

	logger: CMS_LOGGER
			-- Logger

	storage: CMS_STORAGE
			-- Default persistence storage.	

feature -- Formats

	formats: CMS_FORMATS
			-- Available content formats.
		once
			create Result
		end

	format (a_format_name: detachable READABLE_STRING_GENERAL): detachable CONTENT_FORMAT
			-- Content format name `a_format_name' if any.
		do
			Result := formats.item (a_format_name)
		end

feature -- Status Report

	has_error: BOOLEAN
			-- Has error?
		do
			Result := error_handler.has_error
		end

	string_representation_of_errors: STRING_32
			-- String representation of all error(s).
		do
			Result := error_handler.as_string_representation
		end

feature -- Logging

	log	(a_category: READABLE_STRING_8; a_message: READABLE_STRING_8; a_level: INTEGER; a_link: detachable CMS_LINK)
		local
			l_log: CMS_LOG
			m: STRING
		do
			create l_log.make (a_category, a_message, a_level, Void)
			if a_link /= Void then
				l_log.set_link (a_link)
			end
			storage.save_log (l_log)

			create m.make_from_string ("[" + a_category + "] ")
			m.append (a_message)
			if a_link /= Void then
				m.append (" [" + url_encoded (a_link.title) + "]("+ a_link.location +")")
			end

			inspect a_level
				when {CMS_LOG}.level_emergency then
					logger.put_alert (m, Void)
				when {CMS_LOG}.level_alert then
					logger.put_alert (m, Void)
				when {CMS_LOG}.level_critical then
					logger.put_critical (m, Void)
				when {CMS_LOG}.level_error then
					logger.put_error (m, Void)
				when {CMS_LOG}.level_warning then
					logger.put_warning (m, Void)
				when {CMS_LOG}.level_notice then
					logger.put_information (m, Void)
				when {CMS_LOG}.level_info then
					logger.put_information (m, Void)
				when {CMS_LOG}.level_debug then
					logger.put_debug (m, Void)
				else
					logger.put_debug (m, Void)
			end
		end

feature -- Permissions system

	user_has_permission (a_user: detachable CMS_USER; a_permission: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Anonymous or user `a_user' has permission for `a_permission'?
			--| `a_permission' could be for instance "create page".
		do
			Result := user_api.user_has_permission (a_user, a_permission)
		end

feature -- Query: module

	module (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE
			-- Enabled module typed `a_type', if any.
			--| usage: if attached module ({FOO_MODULE}) as mod then ...
		local
--			t: STRING_8
			l_type: TYPE [detachable CMS_MODULE]
		do
--			t := type_name_without_annotation (a_type)

			across
				setup.modules as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not Result.is_enabled then
					Result := Void
				else
					l_type := Result.generating_type
					if a_type ~ l_type then
							-- Found
					elseif
						attached a_type.attempt (Result) and then attached l_type.generating_type.attempt (a_type)
					then
							-- Found
--					elseif t.same_string (type_name_without_annotation (l_type)) then
--							-- Found
					else
						Result := Void
					end
				end
			end
		ensure
			Result /= Void implies (Result.is_enabled) -- and a_type.is_conforming_to (Result.generating_type))
		end

	module_api (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE_API
			-- Enabled module API associated with module typed `a_type'.
		do
			if attached module (a_type) as mod then
				if mod.is_enabled then
					if not mod.is_initialized then
						mod.initialize (Current)
					end
					Result := mod.module_api
				end
			end
		end

	module_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_MODULE
			-- Enabled module named `a_name', if any.
		do
			across
				setup.modules as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if
					not Result.is_enabled
					or else not Result.name.is_case_insensitive_equal_general (a_name)
				then
					Result := Void
				end
			end
		ensure
			Result /= Void implies (Result.is_enabled and Result.name.is_case_insensitive_equal_general (a_name))
		end

	module_api_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_MODULE_API
			-- Enabled module API associated with module named `a_name'.
		do
			if attached module_by_name (a_name) as mod then
				Result := mod.module_api
			end
		end

feature -- Query: API

	user_api: CMS_USER_API
		local
			l_api: like internal_user_api
		do
			l_api := internal_user_api
			if l_api = Void then
				create l_api.make (Current)
				internal_user_api := l_api
			end
			Result := l_api
		end

feature -- Path aliases	

	is_valid_path_alias (a_alias: READABLE_STRING_8): BOOLEAN
		do
			Result := a_alias.is_empty or else not a_alias.starts_with_general ("/")
		end

	set_path_alias (a_source, a_alias: READABLE_STRING_8; a_keep_previous: BOOLEAN)
			-- Set `a_alias' as alias of `a_source',
			-- and eventually unset previous alias if any.
		require
			valid_alias: is_valid_path_alias (a_alias)
		local
			l_continue: BOOLEAN
		do
			if attached storage.path_alias (a_source) as l_existing_alias then
				if a_alias.same_string (l_existing_alias) then
						-- Already aliased as expected
				else
						-- New alias
					if a_keep_previous then
						l_continue := True
					else
						storage.replace_path_alias (a_source, l_existing_alias, a_alias)
					end
				end
			elseif a_alias.is_whitespace then
					-- Ignore
			elseif a_source.same_string (a_alias) then
					-- No need for alias
			else
				l_continue := True
			end
			if l_continue then
				storage.set_path_alias (a_source, a_alias)
			end
		end

	unset_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
		do
			storage.unset_path_alias (a_source, a_alias)
		end

	path_alias (a_source: READABLE_STRING_8): READABLE_STRING_8
			-- Path alias associated with `a_source' or the source itself.
		do
			Result := a_source
			if attached storage.path_alias (Result) as l_path then
				Result := l_path
			end
		end

	source_of_path_alias (a_alias: READABLE_STRING_8): READABLE_STRING_8
			-- Resolved path for alias `a_alias'.
			--| the CMS supports aliases for path, and then this function simply returns
			--| the effective target path/url for this `a_alias'.
			--| For instance: articles/2015/may/this-is-an-article can be an alias to node/123
			--| This function will return "node/123".
			--| If the alias is bad (i.e does not alias real path), then this function
			--| returns the alias itself.
		do
			Result := a_alias
			if attached storage.source_of_path_alias (Result) as l_path then
				Result := l_path
			end
		end

feature -- Element Change: Error

	reset_error
			-- Reset error handler.
		do
			error_handler.reset
		end

feature {NONE}-- Implemenation

	error_handler: ERROR_HANDLER
			-- Error handler.

	internal_user_api: detachable like user_api
			-- Cached value for `user_api'.

	type_name_without_annotation (a_type: TYPE [detachable ANY]): STRING
			-- Type name for `a_type, without any annotation.
			-- Used by `module' to search by type.
		local
			i,j,n: INTEGER
			c: CHARACTER
		do
			create Result.make_from_string (a_type.name)
			from
				i := 1
				n := Result.count
			until
				i > n
			loop
				c := Result[i]
				if c = '!' or c = '?' then
					Result.remove (i)
					n := n - 1
				elseif c.is_lower then
					j := Result.index_of (' ', i + 1)
					if j > 0 then
						Result.remove_substring (i, j)
						n := n - (j - i)
					end
				else
					i := i + 1
				end
			end
			if Result.starts_with ("!") or Result.starts_with ("?") then
				Result.remove_head (1)
			elseif Result.starts_with ("detachable ") then
				Result.remove_head (11)
			end
		end

feature -- Environment

	module_configuration (a_module_name: READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader for `a_module', and if `a_name' is set, using name `a_name'.
		local
			p, l_path: PATH
			ut: FILE_UTILITIES
		do
			p := setup.environment.config_path.extended ("modules").extended (a_module_name)
			if a_name = Void then
				p := p.extended (a_module_name)
			else
				p := p.extended (a_name)
			end
			l_path := p.appended_with_extension ("json")
			if ut.file_path_exists (l_path) then
				create {JSON_CONFIG} Result.make_from_file (l_path)
			else
				l_path := p.appended_with_extension ("ini")
				if ut.file_path_exists (l_path) then
					create {INI_CONFIG} Result.make_from_file (l_path)
				end
			end
			if Result = Void and a_name /= Void then
					-- Use sub config from default?
				if attached {CONFIG_READER} module_configuration (a_module_name, Void) as cfg then
					Result := cfg.sub_config (a_name)
				else
					-- Maybe try to use the global cms.ini ?	
				end
			end
		end

end

