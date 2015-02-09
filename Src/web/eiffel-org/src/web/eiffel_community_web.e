note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_WEB

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	EIFFEL_COMMUNITY_SITE_SERVICE

	APPLICATION_LAUNCHER

	REFACTORING_HELPER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
				-- Default listening port for standalone nino connector: 9090
			set_service_option ("port", 9090)

				-- Options can be set in ewf.ini config file
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("ewf.ini")

			initialize_application
		end

end

