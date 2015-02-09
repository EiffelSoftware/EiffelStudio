note
	description: "[
			Default CMS_SETUP that can be reused easily, and/or redefined to match specific setup.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_DEFAULT_SETUP

inherit
	CMS_SETUP

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_layout: CMS_LAYOUT)
				-- Create a default setup with `a_layout'.
		do
			layout := a_layout
			create {INI_CONFIG} configuration.make_from_file (layout.cms_config_ini_path)
			initialize
		end

	initialize
			-- Initialize various cms components.
		do
			configure
			create modules.make (3)
			create storage_drivers.make (2)

			build_mailer
			initialize_storages
			initialize_modules
		end

	configure
		do
				--| Site id, used to identified a site, this could be set to a uuid, or else
			site_id := text_item_or_default ("site.id", "_EWF_CMS_NO_ID_")

				-- Site url: optional, but ending with a slash
			site_url := string_8_item ("site_url")
			if attached site_url as l_url and then not l_url.is_empty then
				if l_url[l_url.count] /= '/' then
					site_url := l_url + "/"
				end
			end
				-- Site name
			site_name := text_item_or_default ("site.name", "EWF::CMS")

				-- Site email for any internal notification
				-- Can be also used to precise the "From:" value for email.
			site_email := text_item_or_default ("site.email", "webmaster")

				-- Location for theme folders.
			if attached text_item ("themes-dir") as s then
				create themes_location.make_from_string (s)
			else
				themes_location := layout.www_path.extended ("themes")
			end

				-- Selected theme's name
			theme_name := text_item_or_default ("theme", "default")

			debug ("refactor_fixme")
				fixme ("Review export clause for configuration and layout")
			end

			compute_theme_location
			compute_theme_assets_location
		end

	initialize_storages
			-- Initialize storages
		do
			storage_drivers.force (create {CMS_STORAGE_NULL_BUILDER}, "null")
		end

	initialize_modules
				-- Intialize core modules.
		local
			m: CMS_MODULE
		do
			-- Core
--			create {BASIC_AUTH_MODULE} m.make
--			m.enable
--			register_module (m)

--			create {USER_MODULE} m.make (Current)
--			m.enable
--			register_module (m)

--			create {ADMIN_MODULE} m.make (Current)
--			m.enable
--			register_module (m)

			create {NODE_MODULE} m.make (Current)
			m.enable
			register_module (m)
		end

feature {NONE} -- Configuration

	configuration: CONFIG_READER
			-- Association configuration file.		

feature -- Access

	modules: CMS_MODULE_COLLECTION
			-- <Precursor>

	text_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Configuration value associated with `a_name', if any.
		do
			Result := configuration.resolved_text_item (a_name)
		end

	string_8_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- String 8 configuration value associated with `a_name', if any.
		local
			utf: UTF_CONVERTER
		do
			if attached text_item (a_name) as s then
				if s.is_valid_as_string_8 then
					Result := s.as_string_8
				else
					Result := utf.escaped_utf_32_string_to_utf_8_string_8 (s)
				end
			end
		end

	is_html: BOOLEAN
			-- <Precursor>
		do
				-- Enable change the mode
			Result := (create {CMS_JSON_CONFIGURATION}).is_html_mode (layout.application_config_path)
		end

	is_web: BOOLEAN
			-- <Precursor>
		do
			Result := (create {CMS_JSON_CONFIGURATION}).is_web_mode (layout.application_config_path)
		end

	build_auth_engine
		do
			to_implement ("Not implemented authentication")
		end

	build_mailer
		do
			to_implement ("Not implemented mailer")
		end

feature -- Access: storage

	storage_drivers: STRING_TABLE [CMS_STORAGE_BUILDER]
			-- Precursor	

feature -- Element change

	register_module (m: CMS_MODULE)
			-- <Precursor>
		do
			modules.extend (m)
		end

feature -- Compute location

	compute_theme_location
		do
			theme_location := themes_location.extended (theme_name)
		end

	compute_theme_assets_location
			-- assets (js, css, images, etc)
			-- Not used at the moment.
		do
			debug ("refactor_fixme")
				fixme ("Check if we really need it")
			end
				-- Check how to get this path from the CMS_THEME information.
			theme_assets_location := theme_location.extended ("assets")
		end

end
