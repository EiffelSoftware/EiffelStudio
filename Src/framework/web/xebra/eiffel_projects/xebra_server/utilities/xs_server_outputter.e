note
	description: "Summary description for {XU_SERVER_OUTPUTTER}."
	author: ""
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
		end

end
