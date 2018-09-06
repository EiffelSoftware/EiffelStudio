note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_GITHUB

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	APPLICATION_LAUNCHER [LOGIN_WITH_GITHUB_EXECUTION]

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			set_service_option ("port", 9090)
			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("server.ini"))
		end

end
