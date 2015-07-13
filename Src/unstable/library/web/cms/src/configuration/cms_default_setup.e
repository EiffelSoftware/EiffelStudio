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
		redefine
			initialize
		end

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
			Precursor
			create modules.make (3)
			create storage_drivers.make (2)

			build_mailer
			initialize_storages
			initialize_modules
		end

	initialize_storages
			-- Initialize storages
		do
			storage_drivers.force (create {CMS_STORAGE_NULL_BUILDER}, "null")
		end

	initialize_modules
				-- Intialize core modules.
		do
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


note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
