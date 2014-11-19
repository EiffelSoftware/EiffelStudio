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

	ARGUMENTS

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
			Precursor
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("demo.ini")
			initialize_cms (cms_setup)
		end

feature -- Service

	cms_service: CMS_SERVICE
		-- cms service.

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			cms_service.execute (req, res)
		end

feature -- Layout

	layout: CMS_LAYOUT
		-- cms layout.		

feature {NONE} -- Launch operation

	launcher: APPLICATION_LAUNCHER

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_retry: BOOLEAN
			l_message: STRING
		do
			if not l_retry then
				log.write_debug (generator + ".launch")
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
				-- send email shutdown
				log.write_debug (generator + ".launch shutdown")
			end
		rescue
			l_retry :=  True
			retry
		end

feature -- CMS Initialization

	cms_setup: CMS_CUSTOM_SETUP
		do
			if attached separate_character_option_value ('d') as  l_dir then
				log.write_debug (generator + ".cms_setup using a command line argument -d " + l_dir )
				create layout.make_with_path (create {PATH}.make_from_string (l_dir))
			else
				log.write_debug (generator + ".cms_setup using current directory" )
				create layout.make_default
			end
			create Result.make (layout)
			setup_storage (Result)
		end

	initialize_cms (a_setup: CMS_SETUP)
		local
			cms: CMS_SERVICE
			api: CMS_API
		do
			log.write_debug (generator + ".initialize_cms")
			setup_modules (a_setup)
			create api.make (a_setup)
			create cms.make (api)
			cms_service := cms
		end

feature -- CMS setup

	setup_modules (a_setup: CMS_SETUP)
			-- Setup additional modules.
		local
			m: CMS_MODULE
		do
			create {BASIC_AUTH_MODULE} m.make
			m.enable
			a_setup.available_modules.extend (m)

			create {CMS_DEMO_MODULE} m.make
			m.enable
			a_setup.available_modules.extend (m)
		end

	setup_storage (a_setup: CMS_SETUP)
		do
			debug ("refactor_fixme")
				to_implement ("To implement custom storage")
			end
		end
end

