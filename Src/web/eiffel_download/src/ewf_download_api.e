note
	description: "[
		application service
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DOWNLOAD_API

inherit

	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	APPLICATION_LAUNCHER [EWF_DOWNLOAD_SERVICE_EXECUTION]

	SHARED_EXECUTION_ENVIRONMENT

	ARGUMENTS

	SHARED_LOGGER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("download.ini")
		end


end
