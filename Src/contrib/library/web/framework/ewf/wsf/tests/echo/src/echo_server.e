note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ECHO_SERVER

inherit
	WSF_DEFAULT_SERVICE [ECHO_SERVER_EXECUTION]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			set_service_option ("port", 9091)
			set_service_option ("verbose", True)
			make_and_launch
		end

end
