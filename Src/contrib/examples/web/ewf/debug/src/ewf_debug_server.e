note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DEBUG_SERVER

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	APPLICATION_LAUNCHER [EWF_DEBUG_EXECUTION]

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
--			set_service_option ("verbose", True)
			set_service_option ("port", 9090)
--			set_service_option ("base", "/www-debug/debug_service.fcgi/")
			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("debug.ini"))
		end

end

