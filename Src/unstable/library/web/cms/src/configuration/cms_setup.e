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
			site_name := text_item_or_default ("site.name", "Another Eiffel ROC Website")

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
				l_email := site_name + " <" + l_email + ">"
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
			theme_name := text_item_or_default ("theme", "default")

			debug ("refactor_fixme")
				fixme ("Review export clause for configuration and environment")
			end

			theme_location := themes_location.extended (theme_name)
		end

feature -- Access

	environment: CMS_ENVIRONMENT
			-- CMS environment.	

	layout: CMS_ENVIRONMENT
			-- CMS environment.
		obsolete "use `environment' [april-2015]"
		do
			Result := environment
		end

feature {CMS_API} -- API Access		

	enabled_modules: CMS_MODULE_COLLECTION
			-- List of enabled modules.
		local
			l_module: CMS_MODULE
		do
			create Result.make (modules.count)
			across
				modules as ic
			loop
				l_module := ic.item
				update_module_status_from_configuration (l_module)
				if l_module.is_enabled then
					Result.extend (l_module)
				end
			end
			across
				Result as ic
			loop
				l_module := ic.item
				update_module_status_within (l_module, Result)
				if not l_module.is_enabled then
					Result.remove (l_module)
				end
			end
		ensure
			only_enabled_modules: across Result as ic all ic.item.is_enabled end
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
				-- By default enabled.
			if false and attached text_item ("modules.*") as l_mod_status then
				dft := l_mod_status.is_case_insensitive_equal_general ("on")
			else
				dft := True
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

feature -- Settings

	is_debug: BOOLEAN
			-- Is debug mode enabled?

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

feature -- Access: Theme

	site_location: PATH
			-- Path to CMS site root dir.

	temp_location: PATH
			-- Path to folder used as temporary dir.
			-- (Mainly for uploaded file).

	files_location: PATH
			-- Path to public "files" dir.			

	modules_location: PATH
			-- Path to modules.	

	themes_location: PATH
			-- Path to themes.

	theme_location: PATH
			-- Path to a active theme.

	theme_information_location: PATH
			-- Active theme informations.
		do
			Result := theme_location.extended ("theme.info")
		end

	theme_name: READABLE_STRING_32
			-- theme name.

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

	storage (a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE
			-- CMS Storage object defined according to the configuration or default.
			-- Use `a_error_handler' to get eventual error information occurred during the storage
			-- initialization.
		local
			retried: BOOLEAN
			l_message: STRING
		do
			if not retried then
				to_implement ("Refactor database setup")
				if
					attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (environment.application_config_path) as l_database_config and then
					attached storage_drivers.item (l_database_config.driver) as l_builder
				then
					Result := l_builder.storage (Current, a_error_handler)
				end
			else
				to_implement ("Workaround code, persistence layer does not implement yet this kind of error handling.")
					-- error handling.
				create l_message.make (1024)
				if attached ((create {EXCEPTION_MANAGER}).last_exception) as l_exception then
					if attached l_exception.description as l_description then
						l_message.append (l_description.as_string_32)
						l_message.append ("%N%N")
					elseif attached l_exception.trace as l_trace then
						l_message.append (l_trace)
						l_message.append ("%N%N")
					else
						l_message.append (l_exception.out)
						l_message.append ("%N%N")
					end
				else
					l_message.append ("The application crash without available information")
					l_message.append ("%N%N")
				end
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
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
