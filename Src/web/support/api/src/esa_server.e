note
	description: "[
		application service
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SERVER

inherit

	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	ARGUMENTS

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("esa.ini")
		end


feature {NONE} -- Launch operation

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_retry: BOOLEAN
			l_message: STRING
			launcher: APPLICATION_LAUNCHER [ESA_SERVICE_EXECUTION]
		do
			create launcher
			launcher.launch (opts)
		end

end
