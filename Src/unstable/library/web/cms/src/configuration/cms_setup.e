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
					if
						attached a_collection.item (ic.item) as mod and then
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

	site_email: READABLE_STRING_8
			-- Admin email address for the site.
			-- Mainly used for internal notification.

	site_url: detachable READABLE_STRING_8
			-- Optional url of current CMS site.

	front_page_path: detachable READABLE_STRING_8
			-- Optional path defining the front page.
			-- By default "" or "/".

feature -- Query

	text_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Configuration value associated with `a_name', if any.
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

feature -- Access: Theme

	site_location: PATH
			-- Path to CMS site root dir.

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
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
