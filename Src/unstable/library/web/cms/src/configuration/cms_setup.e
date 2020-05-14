note
	description: "[
		Class that enable to set basic configuration, application environment, core modules and themes.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SETUP

inherit
	REFACTORING_HELPER

feature {NONE} -- Initialization	

	initialize
		local
			l_url: like site_url
			s, l_email: detachable READABLE_STRING_8
			utf: UTF_CONVERTER
		do
			site_location := environment.path

				-- Debug mode.
			is_debug := attached string_8_item ("site.debug") as l_debug and then l_debug.is_case_insensitive_equal_general ("yes")

				--| Site id, used to identified a site, this could be set to a uuid, or else
			site_id := string_8_item_or_default ("site.id", "_ROC_CMS_NO_ID_")

				-- Site url: optional, but ending with a slash
			l_url := string_8_item ("site_url")
			if l_url /= Void and then not l_url.is_empty then
				if l_url [l_url.count] /= '/' then
					l_url := l_url + "/"
				end
			end
			site_url := l_url

				-- Site name
			site_name := text_item_or_default ("site.name", "Your ROC CMS")

				-- Website email used to send email.
				-- used as real "From:" email.
				-- Any "From:" header passed to the CMS email sender will appear as "Reply-To:"
				-- or ignored if a reply-to header is already set.
			l_email := string_8_item ("site.email")
			if l_email = Void then
					-- FIXME: find better default value!
					-- Or handler configuration error (missing value)!!!
				l_email := string_8_item_or_default ("mailer.from", "webmaster")
			end
			if l_email.has ('<') then
				l_email := utf.string_32_to_utf_8_string_8 (site_name) + " <" + l_email + ">"
			end
			site_email := l_email

				-- Email address for current web site
			site_notification_email := string_8_item_or_default ("notification.email", site_email)
				-- Email subject tuning.
			s := string_8_item ("mailer.subject_prefix")
			if s /= Void and then not s.ends_with_general (" ") then
				s := s + " "
			end
			site_email_subject_prefix := s


				-- Location for public files
			if attached text_item ("files-dir") as l_files_dir then
				create files_location.make_from_string (l_files_dir)
			else
				files_location := site_location.extended ("files")
			end

				-- Location for temp files
			if attached text_item ("temp-dir") as l_temp_dir then
				create temp_location.make_from_string (l_temp_dir)
			else
				temp_location := site_location.extended ("temp")
			end

				-- Location for cache folder
			if attached text_item ("cache-dir") as l_cache_dir then
				create cache_location.make_from_string (l_cache_dir)
			else
				cache_location := temp_location.extended ("cache")
			end

				-- Location for modules folders.
			if attached text_item ("modules-dir") as l_modules_dir then
				create modules_location.make_from_string (l_modules_dir)
			else
				modules_location := environment.modules_path
			end

				-- Location for themes folders.
			if attached text_item ("themes-dir") as l_themes_dir then
				create themes_location.make_from_string (l_themes_dir)
			else
				themes_location := environment.themes_path
			end

				-- Selected theme's name
			site_theme_name := text_item_or_default ("site.theme", "default")
			set_theme (site_theme_name)


				-- Webapi
			webapi_enabled := string_8_item_or_default ("webapi.mode", "off").is_case_insensitive_equal_general ("on")

			l_url := string_8_item ("webapi.base_path")
			if l_url /= Void and then not l_url.is_empty then
				if l_url [l_url.count] = '/' then
					l_url := l_url.substring (1, l_url.count - 1)
				end
				if l_url [1] /= '/' then
					l_url := "/" + l_url
				end
				create webapi_base_path.make_from_string (l_url)
			else
				create webapi_base_path.make_from_string (default_webapi_base_path)
			end


				-- Administration
			l_url := string_8_item ("administration.base_path")
			if l_url /= Void and then not l_url.is_empty then
				if l_url [l_url.count] = '/' then
					l_url := l_url.substring (1, l_url.count - 1)
				end
				if l_url [1] /= '/' then
					l_url := "/" + l_url
				end
				create administration_base_path.make_from_string (l_url)
			else
				create administration_base_path.make_from_string (default_administration_base_path)
			end
			administration_theme_name := text_item_or_default ("administration.theme", theme_name) -- TODO: Default to builtin theme?

		end

feature -- Access

	environment: CMS_ENVIRONMENT
			-- CMS environment.	

	layout: CMS_ENVIRONMENT
			-- CMS environment.
		obsolete "use `environment' [2017-05-31]"
		do
			Result := environment
		end

feature {CMS_API} -- API Access		

	frozen fill_enabled_modules (api: CMS_API)
			-- List of enabled modules.
		local
			l_enabled_modules: CMS_MODULE_COLLECTION
			l_modules_to_remove: CMS_MODULE_COLLECTION
			l_module: CMS_MODULE
			l_core: CMS_CORE_MODULE
		do
			l_enabled_modules := api.enabled_modules

				-- Include required CORE module
			create l_core.make
			l_core.enable
			l_enabled_modules.extend (l_core)

				-- Includes other modules.
			across
				modules as ic
			loop
				l_module := ic.item
				update_module_status_from_configuration (l_module)
				if not l_module.is_enabled then
					if
						api.is_module_enabled (l_module) -- Check from storage!
					then
						l_module.enable
					end
				end
				if l_module.is_enabled then
					l_enabled_modules.extend (l_module)
				end
			end
			across
				l_enabled_modules as ic
			loop
				l_module := ic.item
				update_module_status_within (l_module, l_enabled_modules)
				if not l_module.is_enabled then -- Check from storage!
					if l_modules_to_remove = Void then
						create l_modules_to_remove.make (1)
					end
					l_modules_to_remove.extend (l_module)
				end
			end
			if l_modules_to_remove /= Void then
				across
					l_modules_to_remove as ic
				loop
					l_enabled_modules.remove (ic.item)
				end
			end
		ensure
			only_enabled_modules: across api.enabled_modules as ic all ic.item.is_enabled end
		end

feature {CMS_MODULE, CMS_API, CMS_SETUP_ACCESS} -- Restricted access

	modules: CMS_MODULE_COLLECTION
			-- List of available modules.
		deferred
		end

feature {NONE} -- Implementation: update		

	update_module_status_within (a_module: CMS_MODULE; a_collection: CMS_MODULE_COLLECTION)
			-- Update status of module `a_module', taking into account its dependencies within the collection `a_collection'.
		require
			a_module_is_enabled: a_module.is_enabled
		do
			if attached a_module.dependencies as deps then
				across
					deps as ic
				until
					not a_module.is_enabled
				loop
					if ic.item.is_required then
						if
							attached a_collection.item (ic.item.module_type) as mod and then
							mod.is_enabled
						then
							update_module_status_within (mod, a_collection)
						else
								--| dependency not found or disabled
							a_module.disable
						end
					end
				end
			end
		end

	update_module_status_from_configuration (m: CMS_MODULE)
			-- Update status of module `m' according to configuration.
		local
			b: BOOLEAN
			dft: BOOLEAN
		do
				-- By default, keep previous status.
			if attached text_item ("modules.*") as l_mod_status then
				dft := l_mod_status.is_case_insensitive_equal_general ("on")
			else
				dft := m.is_enabled
			end
			if attached text_item ("modules." + m.name) as l_mod_status then
				b := l_mod_status.is_case_insensitive_equal_general ("on")
			else
				b := dft
			end
			if b then
				m.enable
			else
				m.disable
			end
		end

feature -- Access: Site

	site_id: READABLE_STRING_8
			-- String identifying current CMS.
			-- This could be used in webform, for cookie name, ...

	site_name: READABLE_STRING_32
			-- Name of the site.

	utf_8_site_name: READABLE_STRING_8
			-- `site_name' encoded with UTF-8.
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_32_string_to_utf_8_string_8 (site_name)
		end

	site_front_page_properties: detachable STRING_TABLE [READABLE_STRING_32]
			-- Optional site properties.
		do
			Result := text_table_item ("site.front.property")
		end

	site_properties: detachable STRING_TABLE [READABLE_STRING_32]
			-- Optional site properties.
		do
			Result := text_table_item ("site.property")
		end

	site_property (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			Result := text_item ({STRING_32} "site." + a_name.as_string_32)
			if Result = Void and then attached site_properties as props then
				Result := props.item (a_name)
			end
		end

	site_description: detachable READABLE_STRING_32
			-- Optional site description.
		do
			Result := site_property ("description")
		end

	site_headline: detachable READABLE_STRING_32
			-- Optional site headline.	
		do
			Result := site_property ("headline")
		end

	site_keywords: detachable READABLE_STRING_32
			-- Optional site comma separated keywords.
		do
			Result := site_property ("keywords")
		end

	site_email: READABLE_STRING_8
			-- Website email address.
			-- Used as "From:" address when the site is sending emails
			-- cf: `CMS_SETUP.mailer'.

	site_notification_email: READABLE_STRING_8
			-- Email address receiving internal notification.

	site_email_subject_prefix: detachable READABLE_STRING_8
			-- Optional prefix for any email sent by Current site.

	site_url: detachable READABLE_STRING_8
			-- Optional url of current CMS site.

	front_page_path: detachable READABLE_STRING_8
			-- Optional path defining the front page.
			-- By default "" or "/".

	webapi_enabled: BOOLEAN
			-- Is WebAPI enabled?

	webapi_base_path: IMMUTABLE_STRING_8
			-- Web API base url, default=`default_webapi_base_path`.

	administration_base_path: IMMUTABLE_STRING_8
			-- Administration base url, default=`default_administration_base_path`.

	site_auth_max_age (a_auth: READABLE_STRING_GENERAL): INTEGER
			-- `Max-Age` for session based authentication.
		local
			s_max_age: READABLE_STRING_8
		do
			s_max_age := string_8_item ({STRING_32} "auth." + a_auth + {STRING_32} ".max_age")
			if s_max_age = Void then
				s_max_age := string_8_item ("auth.max_age")
			end
			if s_max_age /= Void and then s_max_age.is_integer then
				Result := s_max_age.to_integer
			else
				Result := 604800 --| 7 days: 7 * 24(h) *60(min) *60(sec)
			end
		end

	site_auth_token (a_auth: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- token for cookie related to session based authentication.
		do
			Result := string_8_item ({STRING_32} "auth." + a_auth.to_string_32 + {STRING_32} ".token")
			if Result = Void then
				Result := string_8_item ("auth.token")
			end
		end

feature {NONE} -- Constants

	default_webapi_base_path: STRING = "/api"

	default_administration_base_path: STRING = "/admin"

feature -- Settings

	is_debug: BOOLEAN
			-- Is debug mode enabled?

	set_site_mode
			-- Switch to site mode.
			--| 	- Change theme
			--| 	- ..
		do
			if is_theme_valid (site_theme_name) then
				set_theme (site_theme_name)
			-- else Keep previous theme!
			end
		end

	set_webapi_mode
			-- Switch to webapi mode.
		do
			set_site_mode
		end

	set_administration_mode
			-- Switch to administration mode.
			--| 	- Change theme
			--| 	- ..
		do
			if is_theme_valid (administration_theme_name) then
				set_theme (administration_theme_name)
			-- else Keep previous theme!
			end
		end

	set_theme (a_name: READABLE_STRING_GENERAL)
			-- Set theme to `a_name`.
		do
			theme_name := a_name.as_string_32
			theme_location := theme_location_for (theme_name)
		end

feature -- Query

	text_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Configuration value associated with `a_name', if any.
		deferred
		end

	text_list_item (a_name: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
			-- Configuration values associated with `a_name', if any.
		deferred
		end

	text_table_item (a_name: READABLE_STRING_GENERAL): detachable STRING_TABLE [READABLE_STRING_32]
			-- Configuration indexed values associated with `a_name', if any.
		deferred
		end

	text_item_or_default (a_name: READABLE_STRING_GENERAL; a_default_value: READABLE_STRING_GENERAL): READABLE_STRING_32
			-- `text_item' associated with `a_name' or if none, `a_default_value'.
		do
			if attached text_item (a_name) as v then
				Result := v
			else
				Result := a_default_value.as_string_32
			end
		end

	string_8_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- Configuration value associated with `a_name', if any.
		deferred
		end

	string_8_item_or_default (a_name: READABLE_STRING_GENERAL; a_default_value: READABLE_STRING_8): READABLE_STRING_8
			-- `string_8_item' associated with `a_name' or if none, `a_default_value'.
		do
			if attached string_8_item (a_name) as v then
				Result := v
			else
				Result := a_default_value
			end
		end

feature -- Access: directory

	site_location: PATH
			-- Path to CMS site root dir.

	temp_location: PATH
			-- Path to folder used as temporary dir.
			-- (Mainly for uploaded file).

	files_location: PATH
			-- Path to public "files" dir.

	cache_location: PATH
			-- Path to internal cache dir.

	modules_location: PATH
			-- Path to modules.	

	themes_location: PATH
			-- Path to themes.

	system_info: STRING_TABLE [READABLE_STRING_32]
		local
			s: STRING_32
		do
			create Result.make (10)
			Result["Current direction"] := (create {EXECUTION_ENVIRONMENT}).current_working_path.name
			Result["Site"] := site_location.name
			Result["Cache"] := cache_location.name
			Result["Files"] := files_location.name
			Result["Temp"] := temp_location.name
			if attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (environment.application_config_path) as l_database_config then
				Result["Storage.connection_string"] := l_database_config.connection_string
			end
			create s.make (10)
			across
				storage_drivers as ic
			loop
				if s.count > 1 then
					s.append_character (',')
				end
				s.append_character (' ')
				s.append_string_general (ic.key)
			end
			Result["Storage.availables"] := s
		end

feature -- Access: theme

	theme_location: PATH
			-- Path to a active theme.

	is_theme_valid (a_theme_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_theme_name` exists?
		local
			fu: FILE_UTILITIES
		do
			Result := fu.directory_path_exists (theme_location_for (a_theme_name))
		end

	theme_information_location: PATH
			-- Active theme informations.
		do
			Result := theme_location.extended ("theme.info")
		end

	theme_name: READABLE_STRING_32
			-- theme name.

	site_theme_name: READABLE_STRING_32
			-- Site theme name.

	administration_theme_name: READABLE_STRING_32
			-- Administration theme name.
			-- Default: same as site theme.
			-- TODO: change to builtin "admin" theme?

	theme_location_for (a_theme_name: READABLE_STRING_GENERAL): PATH
			-- Theme directory location for theme `a_theme_name`.
		do
			Result := themes_location.extended (a_theme_name)
		end

feature -- Access

	mailer: NOTIFICATION_MAILER
			-- Email processor.
		deferred
		end

feature -- Access: storage

	storage_drivers: STRING_TABLE [CMS_STORAGE_BUILDER]
			-- Table of available storage drivers.
			-- i.e: mysql, sqlite, ...
		deferred
		end

	storage_configuration_driver: detachable READABLE_STRING_32
		do
			if attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (environment.application_config_path) as l_database_config then
				Result := l_database_config.driver
			end
		end

	storage (a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE
			-- CMS Storage object defined according to the configuration or default.
			-- Use `a_error_handler' to get eventual error information occurred during the storage
			-- initialization.
		local
			retried: BOOLEAN
			l_message: STRING_32
		do
			if not retried then
				debug
					to_implement ("Refactor database setup")
				end
				if
					attached storage_configuration_driver as l_db_driver and then
					attached storage_drivers.item (l_db_driver) as l_builder
				then
					Result := l_builder.storage (Current, a_error_handler)
					if Result = Void and not a_error_handler.has_error then
						a_error_handler.add_custom_error (0, "Database storage not found", l_message)
					end
				elseif not a_error_handler.has_error then
					a_error_handler.add_custom_error (0, "Database driver not found", l_message)
				end
			else
				debug
					to_implement ("Workaround code, persistence layer does not implement yet this kind of error handling.")
				end
					-- error handling.
				create l_message.make (1024)
				if attached (create {EXCEPTION_MANAGER}).last_exception as l_exception then
					if attached l_exception.description as l_description then
						l_message.append (l_description)
					elseif attached l_exception.trace as l_trace then
						l_message.append (l_trace)
					else
						l_message.append_string_general (l_exception.out)
					end
				else
					l_message.append_string_general ("The application crash without available information")
				end
				l_message.append_character ('%N')
				l_message.append_character ('%N')
				a_error_handler.add_custom_error (0, " Database Connection ", l_message)
			end
		rescue
			retried := True
			retry
		end

feature -- Status Report: Modules

	module_registered (m: CMS_MODULE): BOOLEAN
			-- Is the module `m' registered?
		do
			Result := modules.has (m)
		end

	module_with_same_type_registered (m: CMS_MODULE): BOOLEAN
			-- Is there a module `m' already registered with the same type?
		do
			Result := modules.has_module_with_same_type (m)
		end

feature -- Element change

	register_module (m: CMS_MODULE)
			-- Add module `m' to `modules'.
		require
			module_not_registered: not module_registered (m)
			no_module_with_same_type_registered: not module_with_same_type_registered (m)
		deferred
		ensure
			module_registered: module_registered (m)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
