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
			site_location := environment.path

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


				-- Location for public files
			if attached text_item ("files-dir") as s then
				create files_location.make_from_string (s)
			else
				files_location := site_location.extended ("files")
			end

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
		local
			retried: BOOLEAN
			f: FILE
		do
			if not retried then
				if attached text_item ("mailer.smtp") as l_smtp then
					create {NOTIFICATION_SMTP_MAILER} mailer.make (l_smtp)
				elseif attached text_item ("mailer.sendmail") as l_sendmail then
					create {NOTIFICATION_SENDMAIL_MAILER} mailer.make_with_location (l_sendmail)
				elseif attached text_item ("mailer.output") as l_output then
					if l_output.is_case_insensitive_equal ("@stderr") then
						f := io.error
					elseif l_output.is_case_insensitive_equal ("@stdout") then
						f := io.output
					else
						create {RAW_FILE} f.make_with_name (l_output)
						if not f.exists then
							f.create_read_write
							f.close
						end
					end
					create {NOTIFICATION_STORAGE_MAILER} mailer.make (create {NOTIFICATION_EMAIL_FILE_STORAGE}.make (f))
				else
					create {NOTIFICATION_STORAGE_MAILER} mailer.make (create {NOTIFICATION_EMAIL_FILE_STORAGE}.make (io.error))
				end
			else
				check valid_mailer: False end
					-- FIXME: should we report persistent error message? If yes, see how.
				create {NOTIFICATION_NULL_MAILER} mailer
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	mailer: NOTIFICATION_MAILER

feature -- Access: storage

	storage_drivers: STRING_TABLE [CMS_STORAGE_BUILDER]
			-- Precursor	

feature -- Element change

	register_module (m: CMS_MODULE)
			-- <Precursor>
		do
			debug ("roc")
				if module_registered (m) or module_with_same_type_registered (m) then
						-- FIXME: report error
						-- The assertions specify this is bad,
						-- but here we still handle the case
						--| Ignored.
					if attached (create {DEVELOPER_EXCEPTION}) as e then
						if module_registered (m) then
							e.set_description ("Module '" + m.name + "' is already registered.")
						else
							e.set_description ("A module of type '" + m.name + "' is already registered.")
						end
						e.raise
					end
				end
			end
			modules.extend (m)
		end

feature -- Theme: Compute location

	compute_theme_location
		do
			theme_location := themes_location.extended (theme_name)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
