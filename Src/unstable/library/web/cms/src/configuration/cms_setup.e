note
	description: "Class that enable to set basic configuration, application layout, core modules and  themes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SETUP

inherit
	REFACTORING_HELPER

feature -- Access

	layout: CMS_LAYOUT
			-- CMS layout.

	is_html: BOOLEAN
			--  api with progressive enhancements css and js, server side rendering.
		deferred
		end

	is_web: BOOLEAN
			-- web: Web Site with progressive enhancements css and js and Ajax calls.
		deferred
		end

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
				if l_module.is_enabled then
					Result.extend (l_module)
				end
			end
		ensure
			only_enabled_modules: across Result as ic all ic.item.is_enabled end
		end

feature {CMS_MODULE} -- Restricted access

	modules: CMS_MODULE_COLLECTION
			-- List of available modules.
		deferred
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
			-- Optional base url of the site.

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

	themes_location: PATH
			-- Path to themes.

	theme_location: PATH
			-- Path to a active theme.

	theme_assets_location: PATH
			-- Path to a active theme assets folder.

	theme_information_location: PATH
			-- Active theme informations.
		do
			Result := theme_location.extended ("theme.info")
		end

	theme_name: READABLE_STRING_32
			-- theme name.

feature -- Access: storage

	storage_drivers: STRING_TABLE [CMS_STORAGE_BUILDER]
		deferred
		end

	storage (a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE
		local
			retried: BOOLEAN
			l_message: STRING
		do
			if not retried then
				to_implement ("Refactor database setup")
				if
					attached (create {APPLICATION_JSON_CONFIGURATION_HELPER}).new_database_configuration (layout.application_config_path) as l_database_config and then
					attached storage_drivers.item (l_database_config.driver) as l_builder
				then
					Result := l_builder.storage (Current)
				end
			else
				to_implement ("Workaround code, persistence layer does not implement yet this kind of error handling.")
					-- error hanling.
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

feature -- Element change

	module_registered (m: CMS_MODULE): BOOLEAN
		do
			Result := modules.has (m)
		end

	module_with_same_type_registered (m: CMS_MODULE): BOOLEAN
		do
			Result := modules.has_module_with_same_type (m)
		end

	register_module (m: CMS_MODULE)
			-- Add module `m' to `modules'
		require
			module_not_registered: not module_registered (m)
			no_module_with_same_type_registered: not module_with_same_type_registered (m)
		deferred
		ensure
			module_registered: module_registered (m)
		end

end
