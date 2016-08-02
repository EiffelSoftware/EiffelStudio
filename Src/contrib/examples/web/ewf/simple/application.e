note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	WSF_DEFAULT_SERVICE [APPLICATION_EXECUTION]
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
				-- Specific to `standalone' connector (the EiffelWeb server).
				-- See `{WSF_STANDALONE_SERVICE_LAUNCHER}.initialize'
 			set_service_option ("port", 9090)
			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("simple.ini"))
		end

end
