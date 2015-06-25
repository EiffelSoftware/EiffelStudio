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

	make (a_env: CMS_ENVIRONMENT)
			-- Create a default setup with `a_env'.
		do
			environment := a_env
			create {INI_CONFIG} configuration.make_from_file (a_env.cms_config_ini_path)
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
		local
			l_url: like site_url
		do
				--| Site id, used to identified a site, this could be set to a uuid, or else
			site_id := text_item_or_default ("site.id", "_EWF_CMS_NO_ID_")

				-- Site url: optional, but ending with a slash
			l_url := string_8_item ("site_url")
			if l_url /= Void and then not l_url.is_empty then
				if l_url [l_url.count] /= '/' then
					l_url := l_url + "/"
				end
			end
			site_url := l_url

				-- Site name
			site_name := text_item_or_default ("site.name", "EWF::CMS")

				-- Site email for any internal notification
				-- Can be also used to precise the "From:" value for email.
			site_email := text_item_or_default ("site.email", "webmaster")

				-- Location for modules folders.
			if attached text_item ("modules-dir") as s then
				create modules_location.make_from_string (s)
			else
				modules_location := environment.modules_path
			end

				-- Location for themes folders.
			if attached text_item ("themes-dir") as s then
				create themes_location.make_from_string (s)
			else
				themes_location := environment.themes_path
			end

				-- Selected theme's name
			theme_name := text_item_or_default ("theme", "default")

			debug ("refactor_fixme")
				fixme ("Review export clause for configuration and environment")
			end

			compute_theme_location
		end

	initialize_storages
			-- Initialize storages
		do
			storage_drivers.force (create {CMS_STORAGE_NULL_BUILDER}, "null")
		end

	initialize_modules
				-- Intialize core modules.
		local
--			m: CMS_MODULE
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

--			create {NODE_MODULE} m.make (Current)
--			m.enable
--			register_module (m)
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

feature -- Theme: Compute location

	compute_theme_location
		do
			theme_location := themes_location.extended (theme_name)
		end

end
