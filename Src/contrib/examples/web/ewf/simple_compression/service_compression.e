note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SERVICE_COMPRESSION

inherit
	WSF_DEFAULT_SERVICE [SERVICE_COMPRESSION_EXECUTION]
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("service.ini"))
		end

end
