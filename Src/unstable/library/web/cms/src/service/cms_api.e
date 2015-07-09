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
				-- Initialize formats.
			initialize_formats

				-- Initialize storage.
			if attached setup.storage (error_handler) as l_storage then
				storage := l_storage
			else
				create {CMS_STORAGE_NULL} storage
			end

				-- Complete storage setup.
			storage.set_api (Current)

				-- Initialize enabled modules.
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

	initialize_formats
			-- Initialize content formats.
		local
			f: CMS_FORMAT
		do
				-- Initialize built-in formats
			create formats.make (4)
			create f.make_from_format (create {PLAIN_TEXT_CONTENT_FORMAT})
			formats.extend (f)
			create f.make_from_format (create {FILTERED_HTML_CONTENT_FORMAT})
			formats.extend (f)
			create f.make_from_format (create {FULL_HTML_CONTENT_FORMAT})
			formats.extend (f)
			create f.make ("cms_editor", "CMS HTML content")
			formats.extend (f)
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

feature -- Emails

	new_email (a_to_address: READABLE_STRING_8; a_subject: READABLE_STRING_8; a_content: READABLE_STRING_8): CMS_EMAIL
			-- New email object.
		do
			create Result.make (setup.site_email, a_to_address, a_subject, a_content)
		end

	process_email (e: CMS_EMAIL)
			-- Process email `e'.
		do
			reset_error
			setup.mailer.safe_process_email (e)
			if setup.mailer.has_error then
				error_handler.add_custom_error (0, "Mailer error", "Error occurred while processing email.")
			end
		end

	process_emails (lst: ITERABLE [CMS_EMAIL])
			-- Process collection of email `lst'.	
		do
			reset_error
			setup.mailer.process_emails (lst)
			if setup.mailer.has_error then
				error_handler.add_custom_error (0, "Mailer error", "Error occurred while processing emails.")
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
			l_type: TYPE [detachable CMS_MODULE]
		do
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

	location_alias (a_source: READABLE_STRING_8): READABLE_STRING_8
			-- Location alias associated with `a_source' or the source itself.
		do
			Result := a_source
			if attached storage.path_alias (Result) as l_path then
				Result := l_path
				if Result.starts_with ("/") then
					Result := Result.substring (2, Result.count)
				end
			end
		end

	path_alias (a_source: READABLE_STRING_8): READABLE_STRING_8
			-- Path alias associated with `a_source' or the source itself.
		do
			Result := a_source
			if attached storage.path_alias (Result) as l_path then
				Result := "/" + l_path
			end
		end

	source_of_path_alias (a_alias: READABLE_STRING_8): detachable READABLE_STRING_8
			-- Resolved path for alias `a_alias'.
			--| the CMS supports aliases for path, and then this function simply returns
			--| the effective target path/url for this `a_alias'.
			--| For instance: articles/2015/may/this-is-an-article can be an alias to node/123
			--| This function will return "node/123".
			--| If the alias is bad (i.e does not alias real path), then this function
			--| returns Void.
		do
			if attached storage.source_of_path_alias (a_alias) as l_source_path then
				Result := l_source_path
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

feature -- Environment/ theme

	site_location: PATH
			-- CMS site location.
		do
			Result := setup.site_location
		end

	files_location: PATH
			-- CMS public files location.
		do
			Result := setup.files_location
		end

	theme_location: PATH
			-- Active theme location.
		do
			Result := setup.theme_location
		end

	theme_assets_location: PATH
			-- assets (js, css, images, etc).
		do
			debug ("refactor_fixme")
				fixme ("Check if we really need it")
			end
				-- Check how to get this path from the CMS_THEME information.
			Result := theme_location.extended ("assets")
		end

feature -- Environment/ module		

	module_configuration_by_name (a_module_name: READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader for `a_module', and if `a_name' is set, using name `a_name'.
		local
			p, l_path: detachable PATH
			l_name: READABLE_STRING_GENERAL
			ut: FILE_UTILITIES
		do
			if a_name = Void then
				l_name := a_module_name
			else
				l_name := a_name
			end
			p := module_location_by_name (a_module_name).extended ("config").extended (l_name)

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
				if attached {CONFIG_READER} module_configuration_by_name (a_module_name, Void) as cfg then
					Result := cfg.sub_config (a_name)
				else
					-- Maybe try to use the global cms.ini ?
				end
			end
		end

	modules_location: PATH
			-- Directory containing cms modules.
		do
			Result := setup.modules_location
		end

	module_location (a_module: CMS_MODULE): PATH
			-- Location associated with `a_module'.
		do
			Result := module_location_by_name (a_module.name)
		end

	module_location_by_name (a_module_name: READABLE_STRING_GENERAL): PATH
			-- Location associated with `a_module_name'.
		do
			Result := modules_location.extended (a_module_name)
		end

	module_resource_location (a_module: CMS_MODULE; a_resource: PATH): PATH
			-- Location of resource `a_resource' for `a_module'.
		do
				--| site/modules/$modname/$a_name.json
			Result := module_resource_location_by_name (a_module.name, a_resource)
		end

	module_resource_location_by_name (a_module_name: READABLE_STRING_GENERAL; a_resource: PATH): PATH
			-- Location of resource `a_resource' for `a_module'.
		do
				--| site/modules/$modname/$a_name.json
			Result := module_location_by_name (a_module_name).extended_path (a_resource)
		end

feature -- Environment/ modules and theme

	module_theme_resource_location (a_module: CMS_MODULE; a_resource: PATH): detachable PATH
			-- Theme resource location of `a_resource' for module `a_module', if exists.
			-- By default, located under the module location folder, but could be overriden
			-- from files located under modules subfolder of active `theme_location'.
			--| First search in themes/$theme/modules/$a_module.name/$a_resource,
			--| and if not found then search in
			--| modules/$a_module_name/$a_resource.
		local
			ut: FILE_UTILITIES
		do
				-- Check first in selected theme folder.
			Result := module_theme_location (a_module).extended_path (a_resource)
			if not ut.file_path_exists (Result) then
					-- And if not found, look into site/modules/$a_module.name/.... folders.
				Result := module_resource_location (a_module, a_resource)
				if not ut.file_path_exists (Result) then
					Result := Void
				end
			end
		end

	module_theme_resource_location_by_name (a_module_name: READABLE_STRING_GENERAL; a_resource: PATH): detachable PATH
			-- Theme resource location of `a_resource' for module named `a_module_name', if exists.
			-- By default, located under the module location folder, but could be overriden
			-- from files located under modules subfolder of active `theme_location'.
			--| First search in themes/$theme/modules/$a_module.name/$a_resource,
			--| and if not found then search in
			--| modules/$a_module_name/$a_resource.
		local
			ut: FILE_UTILITIES
		do
				-- Check first in selected theme folder.
			Result := module_theme_location_by_name (a_module_name).extended_path (a_resource)
			if not ut.file_path_exists (Result) then
					-- And if not found, look into site/modules/$a_module.name/.... folders.
				Result := module_resource_location_by_name (a_module_name, a_resource)
				if not ut.file_path_exists (Result) then
					Result := Void
				end
			end
		end

	module_theme_location (a_module: CMS_MODULE): PATH
			-- Location for overriden files associated with `a_module_name'.
		do
			Result := module_theme_location_by_name (a_module.name)
		end

	module_theme_location_by_name (a_module_name: READABLE_STRING_GENERAL): PATH
			-- Location for overriden files associated with `a_module_name'.
		do
			Result := theme_location.extended ("modules").extended (a_module_name)
		end

	module_configuration (a_module: CMS_MODULE; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
		do
			Result := module_configuration_by_name (a_module.name, a_name)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

