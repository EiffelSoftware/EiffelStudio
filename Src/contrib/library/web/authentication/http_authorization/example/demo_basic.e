note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DEMO_BASIC

inherit
	WSF_DEFAULT_SERVICE [DEMO_BASIC_EXECUTION]
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			set_service_option ("port", 9090)
			set_service_option ("verbose", True)
		end

end
