note
	description: "API for a CMS"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API

inherit
	CMS_HOOK_EXPORT
	CMS_API_EXPORT_IMP

	CMS_HOOK_IMPORT
	CMS_API_IMPORT_IMP

	CMS_ENCODERS

	CMS_URL_UTILITIES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialize

	make (a_setup: CMS_SETUP; req: WSF_REQUEST)
			-- Create the API service with a setup `a_setup'
			-- and request `req'.
		do
			request := req
			setup := a_setup
			create error_handler.make
			create {CMS_ENV_LOGGER} logger.make
			create hooks.make
			initialize
		ensure
			setup_set: setup = a_setup
			error_handler_set: not error_handler.has_error
		end

	initialize
				-- Initialize the persitent layer.
		local
			l_module: CMS_MODULE
			l_enabled_modules: CMS_MODULE_COLLECTION
			l_uninstalled_mods: detachable ARRAYED_LIST [CMS_MODULE]
			s: IMMUTABLE_STRING_8
		do
				-- Initialize site_url
			initialize_site_url

				-- Administration backend
			s := setup.administration_base_path
			administration_base_path_location := s.shared_substring (2, s.count)

				-- Initialize formats.
			initialize_formats
				-- Initialize contents.
			initialize_content_types

				-- Initialize storage.
			if attached setup.storage (error_handler) as l_storage then
				storage := l_storage
			else
				create {CMS_STORAGE_NULL} storage
			end

				-- Keep enable modules list.
			create l_enabled_modules.make (setup.modules.count)
			enabled_modules := l_enabled_modules
			setup.fill_enabled_modules (Current)

				-- Complete storage setup.
			storage.set_api (Current)

				-- Initialize enabled modules.
			across
				l_enabled_modules as ic
			loop
				l_module := ic.item
					-- FIXME: should we initialize first, and then install
					-- or the reverse, or merge installation and initialization
					-- and leave the responsability to the module to know
					-- if this is installed or not...
				if attached {CMS_CORE_MODULE} l_module as l_core_module then
					if not l_core_module.is_installed (Current) then
						l_core_module.install (Current)
					end
				end
--				if not l_module.is_installed (Current) then
--					l_module.install (Current)
--				end
				if l_module.is_installed (Current) then
					l_module.initialize (Current)
				else
					if l_uninstalled_mods = Void then
						create l_uninstalled_mods.make (1)
					end
					l_uninstalled_mods.force (l_module)
				end
			end
			if l_uninstalled_mods /= Void then
				across
					l_uninstalled_mods as ic
				loop
					l_enabled_modules.remove (ic.item)
				end
			end

				-- hooks initialization, is done after site/admin switch.
		end

	initialize_site_url
				-- Initialize site and base url.
		local
			l_url: detachable STRING_8
			i,j: INTEGER
		do
				--| WARNING: do not use `absolute_url' and `url', since it relies on site_url and base_url.
			if attached setup.site_url as l_site_url and then not l_site_url.is_empty then
				create l_url.make_from_string (l_site_url)
			else
				l_url := request.absolute_script_url ("/")
			end
			check is_not_empty: not l_url.is_empty end
			if l_url [l_url.count] /= '/' then
				l_url.append_character ('/')
			end
			site_url := l_url
			i := l_url.substring_index ("://", 1)
			if i > 0 then
				j := l_url.index_of ('/', i + 3)
				if j > 0 then
					base_url := l_url.substring (j, l_url.count)
				end
			end
		ensure
			site_url_set: site_url /= Void
			site_url_ends_with_slash: site_url.ends_with_general ("/")
		end

	initialize_content_types
			-- Initialize content types.
		do
			create content_types.make (1)
			create content_type_webform_managers.make (1)
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

feature {CMS_ACCESS} -- Module management		

	install_all_modules
			-- Install CMS or uninstalled module which are enabled.
		local
			l_module: CMS_MODULE
		do
			across
				setup.modules as ic
			loop
				l_module := ic.item
					-- FIXME: should we initialize first, and then install
					-- or the reverse, or merge installation and initialization
					-- and leave the responsability to the module to know
					-- if this is installed or not...
				if l_module.is_enabled and not l_module.is_installed (Current) then
					install_module (l_module)
				end
			end
		end

 	installed_module_version (m: CMS_MODULE): detachable READABLE_STRING_32
 		require
 			module_installed: is_module_installed (m)
 		do
 			Result := m.installed_version (Current)
 		end

	install_module (m: CMS_MODULE)
			-- Install module `m'.
		require
			module_not_installed: not is_module_installed (m)
		do
			m.install (Current)
			if m.is_enabled then
				m.initialize (Current)
			end
		end

	uninstall_module (m: CMS_MODULE)
			-- Uninstall module `m'.
		require
			module_installed: is_module_installed (m)
		do
			m.uninstall (Current)
		end

	enable_module (m: CMS_MODULE)
			-- Enable module `m'.
		do
			m.update_status_in_storage (True, Current)
		ensure
			module_enabled: is_module_enabled (m)
		end

	disable_module (m: CMS_MODULE)
			-- Disable module `m'.
		do
			m.update_status_in_storage (False, Current)
		ensure
			module_disabled: not is_module_enabled (m)
		end

feature -- Access

	setup: CMS_SETUP
			-- CMS setup.

	logger: CMS_LOGGER
			-- Logger

	storage: CMS_STORAGE
			-- Default persistence storage.	

feature -- Access: url			

	base_url: detachable IMMUTABLE_STRING_8
			-- Base url if any.
			--| Usually it is Void, but it could be
			--|  /project/demo/

	site_url: IMMUTABLE_STRING_8
			-- Site url

	is_administration_request (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.percent_encoded_path_info.starts_with_general (setup.administration_base_path)
		end

	administration_path (a_relative_path: detachable READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (setup.administration_base_path)
			if a_relative_path /= Void then
				if a_relative_path.is_empty then
					Result.append_character ('/')
				else
					if a_relative_path[1] /= '/' then
						Result.append_character ('/')
					end
					Result.append (a_relative_path)
				end
			end
		end

	administration_path_location (a_relative_location: detachable READABLE_STRING_8): STRING_8
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			create Result.make_from_string (administration_base_path_location)
			if a_relative_location /= Void then
				if a_relative_location.is_empty then
					Result.append_character ('/')
				else
					if a_relative_location[1] /= '/' then
						Result.append_character ('/')
					end
					Result.append (a_relative_location)
				end
			end
		end

feature {NONE} -- Url implementation.		

	administration_base_path_location: IMMUTABLE_STRING_8
			-- Administration path without first slash!

feature -- CMS links

	administration_link (a_title: READABLE_STRING_GENERAL; a_relative_location: detachable READABLE_STRING_8): CMS_LOCAL_LINK
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			Result := local_link (a_title, administration_path_location (a_relative_location))
		end

	local_link (a_title: READABLE_STRING_GENERAL; a_location: READABLE_STRING_8): CMS_LOCAL_LINK
		do
			create Result.make (a_title, a_location)
		end

	user_local_link (u: CMS_USER; a_opt_title: detachable READABLE_STRING_GENERAL): CMS_LOCAL_LINK
		do
			if a_opt_title /= Void then
				create Result.make (a_opt_title, user_url (u))
			else
				create Result.make (user_display_name (u), user_url (u))
			end
		end

	user_html_link (u: CMS_USER): STRING
		require
			u_with_name: not u.name.is_whitespace
		do
			Result := link (user_display_name (u), "user/" + u.id.out, Void)
		end

feature -- Helpers: URLs	

	location_absolute_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- Absolute URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := absolute_url (a_location, opts)
		end

	location_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := url (a_location, opts)
		end

	user_url (u: CMS_USER): like url
		require
			u_with_id: u.has_id
		do
			Result := location_url ("user/" + u.id.out, Void)
		end

feature -- Helpers: html links

	user_display_name (u: CMS_USER): READABLE_STRING_32
		do
			Result := user_api.user_display_name (u)
		end

feature -- Settings

	switch_to_administration_mode
		do
			setup.set_administration_mode
			is_administration_mode := True
		end

	is_administration_mode: BOOLEAN
			-- Is administration mode?

	is_debug: BOOLEAN
			-- Is debug mode enabled?
		do
			Result := setup.is_debug
		end

feature {NONE} -- Access: request

	request: WSF_REQUEST
			-- Associated http request.
			--| note: here for the sole purpose of CMS_API.

feature -- Content

	content_types: ARRAYED_LIST [CMS_CONTENT_TYPE]
			-- Available content types	

	add_content_type (a_type: CMS_CONTENT_TYPE)
			-- Register content type `a_type'.
		do
			content_types.force (a_type)
		end

	content_type (a_name: READABLE_STRING_GENERAL): detachable CMS_CONTENT_TYPE
			-- Content type named `a_named' if any.
		do
			across
				content_types as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

feature -- Content type webform

	content_type_webform_managers: ARRAYED_LIST [CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT]]
			-- Available content types

	add_content_type_webform_manager (a_manager: CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT])
			-- Register webform manager `a_manager'.
		do
			content_type_webform_managers.force (a_manager)
		end

	content_type_webform_manager (a_content_type: CMS_CONTENT_TYPE): detachable CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT]
			-- Web form manager for content type `a_content_type' if any.
		do
			Result := content_type_webform_manager_by_name (a_content_type.name)
		end

	content_type_webform_manager_by_name (a_content_type_name: READABLE_STRING_GENERAL): detachable CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT]
			-- Web form manager for content type named `a_content_type_name' if any.
		do
			across
				content_type_webform_managers as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_content_type_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

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

	logs (a_category: detachable READABLE_STRING_8; a_lower: INTEGER; a_count: INTEGER): LIST [CMS_LOG]
			-- List of recent logs from `a_lower' to `a_lower+a_count'.
			-- If `a_category' is set, filter to return only associated logs.
			-- If `a_count' <= 0 then, return all logs.
		do
			Result := storage.logs (a_category, a_lower, a_count)
		end

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

feature -- Internationalization (i18n)

	translation (a_text: READABLE_STRING_GENERAL; opts: detachable CMS_API_OPTIONS): STRING_32
			-- Translated text `a_text' according to expected context (lang, ...)
			-- and adapt according to options eventually set by `opts'.
		do
			to_implement ("Implement i18n support [2015-may]")
			Result := a_text.as_string_32
		end

	formatted_string (a_text: READABLE_STRING_GENERAL; args: TUPLE): STRING_32
			-- Format `a_text' using arguments `args'.
			--| ex: formatted_string ("hello $1, see page $title.", ["bob", "contact"] -> "hello bob, see page contact"
		local
			l_formatter: CMS_STRING_FORMATTER
		do
			create l_formatter
			Result := l_formatter.formatted_string (a_text, args)
		end

	formatted_date_time_ago (dt: DATE_TIME): STRING_32
			-- Output date `dt` using time ago duration.
		local
			ago: DATE_TIME_AGO_CONVERTER
		do
			create ago.make
			create Result.make (10)
			Result.append_string_general (ago.smart_date_duration (dt))
		end

	formatted_date_time_yyyy_mm_dd (dt: DATE_TIME): STRING_8
			-- Output date `dt` using YYYY-MM-DD
		local
			i: INTEGER
		do
			create Result.make (10)
			Result.append_integer (dt.year)
			Result.append_character ('-')
			i := dt.month
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
			Result.append_character ('-')
			i := dt.day
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
		end

	formatted_date_time_yyyy_mm_dd__hh_min_ss (dt: DATE_TIME): STRING_8
			-- Output date `dt` using YYYY-MM-DD h:min:sec
		local
			i: INTEGER
		do
			create Result.make (19)
			Result.append (formatted_date_time_yyyy_mm_dd (dt))
			Result.append_character (' ')
			i := dt.hour
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
			Result.append_character (':')
			i := dt.minute
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
			Result.append_character (':')
			i := dt.second
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)

		end

feature -- Emails

	new_email (a_to_address: READABLE_STRING_8; a_subject: READABLE_STRING_8; a_content: READABLE_STRING_8): CMS_EMAIL
			-- New email object.
		local
			l_subject: READABLE_STRING_8
		do
			l_subject := a_subject
			if attached setup.site_email_subject_prefix as l_prefix then
				if not l_subject.starts_with (l_prefix) then
					l_subject := l_prefix +  l_subject
				end
			end
			create Result.make (setup.site_email, a_to_address, l_subject, a_content)
		end

	process_email (e: CMS_EMAIL)
			-- Process email `e'.
		do
			log ("mailer", "Send email %"" + e.subject + "%"%N" + e.header, {CMS_LOG}.level_notice, Void)
			reset_error
			prepare_email (e)
			setup.mailer.safe_process_email (e)
			if setup.mailer.has_error then
				error_handler.add_custom_error (0, "Mailer error", "Error occurred while processing email.")
			else
				e.set_is_sent (True)
			end
		end

	process_emails (lst: ITERABLE [CMS_EMAIL])
			-- Process collection of email `lst'.	
		do
			across
				lst as ic
			loop
				process_email (ic.item)
			end
		end

feature {NONE} -- Emails implementation

	prepare_email (e: CMS_EMAIL)
			-- Prepare email `e', and update parameters if needed.
		local
			l_sender, l_from: READABLE_STRING_8
		do
			l_sender := setup.site_email
			l_from := e.from_address
			if not l_sender.is_case_insensitive_equal_general (l_from) then
				e.set_from_address (l_sender)
				if not e.has_header ("Return-Path") then
					e.add_header_line ("Return-path: " + l_from)
				end
				if e.reply_to_address = Void then
					e.set_reply_to_address (l_from)
				else
						--| As a Reply-To address is already set,
						--| ignore previous from address.
				end
			end
		end

feature -- Permissions system

	has_permission (a_permission: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Anonymous or user `user' has permission for `a_permission'?
			--| `a_permission' could be for instance "create page".
		do
			Result := user_has_permission (user, a_permission)
		end

	has_permissions (a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Anonymous or user `user' has any of the permissions `a_permission_list`?
		do
			Result := user_has_permissions (user, a_permission_list)
		end

	user_has_permission (a_user: detachable CMS_USER; a_permission: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Anonymous or user `a_user' has permission for `a_permission'?
			--| `a_permission' could be for instance "create page".
		do
			Result := user_api.user_has_permission (a_user, a_permission)
		end

	user_has_permissions (a_user: detachable CMS_USER; a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does `a_user' has any of the permissions `a_permission_list' ?
		do
			across
				a_permission_list as ic
			until
				Result
			loop
				Result := user_has_permission (a_user, ic.item)
			end
		end

feature -- Query: module

	is_module_installed (a_module: CMS_MODULE): BOOLEAN
			-- Is `a_module' installed?
		do
			Result := a_module.is_installed (Current)
		end

	is_module_enabled (a_module: CMS_MODULE): BOOLEAN
		do
			Result := a_module.is_enabled or a_module.is_enabled_in_storage (Current)
		end

	enabled_modules: CMS_MODULE_COLLECTION

	module (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE
			-- Enabled module typed `a_type', if any.
			--| usage: if attached module ({FOO_MODULE}) as mod then ...
		do
			Result := installed_module (a_type)
			if Result /= Void and then not Result.is_enabled then
				Result := Void
			end
		ensure
			Result /= Void implies (Result.is_enabled) -- and a_type.is_conforming_to (Result.generating_type))
		end

	installed_module (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE
			-- Module typed `a_type', if any.
			-- It may not be enabled!
			--| usage: if attached module ({FOO_MODULE}) as mod then ...
		do
			Result := setup.modules.item (a_type)
		ensure
--FIXME			Result /= Void implies (Result.is_enabled) -- and a_type.is_conforming_to (Result.generating_type))
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

feature -- Hooks

	hooks: CMS_HOOK_CORE_MANAGER
			-- Manager handling hook subscriptions.

feature {CMS_EXECUTION} -- Hooks

	setup_hooks
			-- Set up CMS hooks.
			--| Each module has to opportunity to subscribe to various hooks.
		local
			l_module: detachable CMS_MODULE
			l_hooks: like hooks
		do
			l_hooks := hooks
			setup_core_hooks (l_hooks)
			across
				enabled_modules as ic
			loop
				l_module := ic.item
				if is_administration_mode then
					if attached {CMS_ADMINISTRABLE} l_module as adm then
						l_module := adm.module_administration
					else
						l_module := Void
					end
				end
				if l_module /= Void then
					if attached {CMS_HOOK_AUTO_REGISTER} l_module as l_auto then
						l_auto.auto_subscribe_to_hooks (l_hooks)
					end
					l_module.setup_hooks (l_hooks)
				end
			end
		end

feature {NONE} -- Access: API

	cms_api: CMS_API
		do
			Result := Current
		end

feature -- Access: API

	user_api: CMS_USER_API
			-- API to access user related data.
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

feature -- Hooks

	setup_core_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Register hooks associated with the cms core.
		do
			if is_administration_mode then
				a_hooks.subscribe_to_export_hook (Current)
				a_hooks.subscribe_to_import_hook (Current)
			end
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

feature {NONE}-- Implementation

	error_handler: ERROR_HANDLER
			-- Error handler.

	internal_user_api: detachable like user_api
			-- Cached value for `user_api`.

feature -- Environment/ theme

	site_location: PATH
			-- CMS site location.
		do
			Result := setup.site_location
		end

	temp_location: PATH
			-- CMS temp folder location.
		do
			Result := setup.temp_location
		end

	files_location: PATH
			-- CMS public files location.
		do
			Result := setup.files_location
		end

	cache_location: PATH
			-- CMS internal cache location.
		do
			Result := setup.cache_location
		end

	theme_location: PATH
			-- Active theme location.
		do
			Result := setup.theme_location
		end

	theme_name: READABLE_STRING_32
		do
			Result := setup.theme_name
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

	module_configuration (a_module: CMS_MODULE; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
		do
			Result := module_configuration_by_name (a_module.name, a_name)
		end

	module_configuration_by_name (a_module_name: READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader for `a_module', and if `a_name' is set, using name `a_name'.
		local
			p: detachable PATH
		do
				-- Search first in site/config/modules/$module_name/($app|$module_name).(json|ini)
				-- if none, look as sub configuration if $app /= Void
				-- and then in site/modules/$module_name/config/($app|$module_name).(json|ini)
				-- and if non in sub config if $app /= Void
			p := site_location.extended ("config").extended ("modules").extended (a_module_name)
			Result := module_configuration_by_name_in_location (a_module_name, p, a_name)
			if Result = Void then
				p := module_location_by_name (a_module_name).extended ("config")
				Result := module_configuration_by_name_in_location (a_module_name, p, a_name)
			end
		end

	module_configuration_by_name_in_location (a_module_name: READABLE_STRING_GENERAL; a_dir: PATH; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader from "$a_dir/($a_module_name|$a_name).(json|ini)" location.
		local
			p: PATH
			l_path: PATH
			ut: FILE_UTILITIES
		do
			if a_name = Void then
				p := a_dir.extended (a_module_name)
			else
				p := a_dir.extended (a_name)
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
			if Result = Void then
				if
					a_name /= Void and then
					attached {CONFIG_READER} module_configuration_by_name_in_location (a_module_name, a_dir, Void) as cfg
				then
						-- Use sub config from default.
					Result := cfg.sub_config (a_name)
				end
			elseif Result.has_error then
				log ("modules", "module configuration has error %"" + p.utf_8_name + "%"", {CMS_LOG}.level_error, Void)
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
				--| site/modules/$modname/$a_resource
			Result := module_resource_location_by_name (a_module.name, a_resource)
		end

	module_resource_location_by_name (a_module_name: READABLE_STRING_GENERAL; a_resource: PATH): PATH
			-- Location of resource `a_resource' for `a_module'.
		do
				--| site/modules/$modname/$a_resource
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

feature -- Access: active user

	user_is_authenticated: BOOLEAN
			-- Is user authenticated?
		do
			Result := user /= Void
		ensure
			Result implies user /= Void
		end

	user: detachable CMS_USER
			-- Current user or Void in case of visitor.
		note
			EIS: "eiffel:?class=CMS_BASIC_AUTH_FILTER&feature=execute"
		do
			Result := current_user (request)
		end

	set_user (a_user: CMS_USER)
			-- Set `a_user' as current `user'.
		require
			a_user_attached: a_user /= Void
		do
			set_current_user (request, a_user)
		end

	unset_user
			-- Unset `user'.
		do
			unset_current_user (request)
		end

	record_user_login (a_user: CMS_USER)
			-- Record login event for `a_user'.
		require
			user_has_id: a_user.has_id
		do
			a_user.set_last_login_date_now
			user_api.update_user (a_user)
		end

feature -- Site builtin variables

	builtin_variables: STRING_TABLE [detachable ANY]
			-- Builtin variables , value indexed by name.
		do
			create Result.make (7)

			Result["site_url"] := site_url
			Result["site_email"] := setup.site_email
			Result["site_name"] := setup.site_name
			if attached user as l_user then
				Result["active_user"] := l_user
				Result["user"] := l_user.name
				Result["user_id"] := l_user.id
				Result["user_profile_name"] := user_api.user_display_name (l_user)
			end
		end

feature -- Request utilities		

	execution_variable (a_name: READABLE_STRING_GENERAL): detachable ANY
			-- Execution variable related to `a_name'
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			Result := request.execution_variable (a_name)
		end

	set_execution_variable (a_name: READABLE_STRING_GENERAL; a_value: detachable ANY)
		do
			request.set_execution_variable (a_name, a_value)
		ensure
			param_set: execution_variable (a_name) = a_value
		end

	unset_execution_variable (a_name: READABLE_STRING_GENERAL)
		do
			request.unset_execution_variable (a_name)
		ensure
			param_unset: execution_variable (a_name) = Void
		end


feature {CMS_API_ACCESS, CMS_RESPONSE, CMS_MODULE} -- Request utilities	

	current_user (req: WSF_REQUEST): detachable CMS_USER
			-- Current user or Void in case of Guest user.
		do
			check req = request end
			if attached {CMS_USER} execution_variable (cms_execution_variable_name ("user")) as l_user then
				Result := l_user
			end
		end

	set_current_user (req: WSF_REQUEST; a_user: CMS_USER)
			-- Set `a_user' as `current_user'.
		do
			check req = request end
			set_execution_variable (cms_execution_variable_name ("user"), a_user)
		ensure
			user_set: current_user (req) ~ a_user
		end

	unset_current_user (req: WSF_REQUEST)
			-- Unset current user.
		do
			check req = request end
			req.unset_execution_variable (cms_execution_variable_name ("user"))
		ensure
			user_unset: current_user (req) = Void
		end

feature {NONE} -- Implementation: current user

	cms_execution_variable_name (a_name: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- Execution variable name for `a_name'.
		local
			s32: STRING_32
		do
			create s32.make_from_string_general (once "_roccms_.")
			s32.append_string_general (a_name)
			Result := s32
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

