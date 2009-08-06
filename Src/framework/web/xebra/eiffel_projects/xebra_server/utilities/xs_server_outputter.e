note
	description: "[
			A version of XU_OUTPUTTER that sets all attributes already in the constructor.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_SERVER_OUTPUTTER

inherit
	XU_OUTPUTTER
		redefine
			make
		end

	XS_SHARED_SERVER_CONFIG


create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			set_debug_level (config.args.debug_level)
			set_name ({XS_MAIN_SERVER}.Name)
			set_add_input_line (True)
		end

end
