note
	description: "[
				APPLICATION implements the "Hello World" service.

				It inherits from WSF_DEFAULT_SERVICE to get default EWF connector ready
				only `execute' needs to be implemented.

			]"

class
	HELLO_APPLICATION

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
		do
			Precursor
				--| Uncomment the following line, to read options from "ewf.ini" configuration file
--			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} opts.make_from_file ("ewf.ini"))
		end

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_DEFAULT_SERVICE_LAUNCHER [HELLO_EXECUTION]
		do
			create launcher.make_and_launch (opts)
		end

end
