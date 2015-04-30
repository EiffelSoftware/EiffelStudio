note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_ROC_SERVER

inherit
	WSF_LAUNCHABLE_SERVICE
		rename
			make_and_launch as make_and_launch_service
		redefine
			initialize
		end

	WSF_SERVICE
		redefine
			execute
		end

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

	SHARED_LOGGER

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		do
			create launcher
			make_and_launch_service
		end

	initialize
			-- Initialize current service.
		do
				-- Launcher
			Precursor
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("demo.ini")

				-- CMS
			initialize_cms
		end

feature -- Service

	cms_service: CMS_SERVICE
			-- cms service.

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			cms_service.execute (req, res)
		end

feature {NONE} -- Launch operation

	launcher: APPLICATION_LAUNCHER

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_retry: BOOLEAN
			l_message: STRING
		do
			if not l_retry then
				write_debug_log (generator + ".launch")
				launcher.launch (a_service, opts)
			else
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
					-- notify shutdown
				write_debug_log (generator + ".launch shutdown")
			end
		rescue
			l_retry :=  True
			retry
		end

feature -- CMS Initialization

	initialize_cms
		local
			l_setup: CMS_DEFAULT_SETUP
			utf: UTF_CONVERTER
			cms_env: CMS_ENVIRONMENT
		do
				-- Application Environment initialization
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create cms_env.make_with_directory_name (l_dir)
			else
				create cms_env.make_default
			end
			initialize_logger (cms_env)

				-- CMS Setup
			write_debug_log (generator + ".initialize_cms / SETUP based directory=%"" + utf.escaped_utf_32_string_to_utf_8_string_8 (cms_env.path.name) + "%"")
			create l_setup.make (cms_env)

				-- CMS
			write_debug_log (generator + ".initialize_cms / CMS")
			setup_storage (l_setup)
			setup_modules (l_setup)
			create cms_service.make (l_setup)
		end

feature -- CMS setup

	setup_modules (a_setup: CMS_SETUP)
			-- Setup additional modules.
		local
			m: CMS_MODULE
		do
			create {NODE_MODULE} m.make (a_setup)
			m.enable
			a_setup.register_module (m)

			create {BASIC_AUTH_MODULE} m.make
			if not a_setup.module_with_same_type_registered (m) then
				m.enable
				a_setup.register_module (m)
			end

			create {CMS_DEBUG_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CMS_DEMO_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CMS_BLOG_MODULE} m.make
			m.enable
			a_setup.register_module (m)
		end

	setup_storage (a_setup: CMS_SETUP)
			-- Setup storage by declaring storage builder.
		do
--			a_setup.storage_drivers.force (create {CMS_STORAGE_MYSQL_BUILDER}.make, "mysql")
			a_setup.storage_drivers.force (create {CMS_STORAGE_SQLITE_BUILDER}.make, "sqlite")
		end

end

