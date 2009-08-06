note
	description: "[
		Xebra Server run class
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_APPLICATION

inherit
	ARGUMENTS
	XU_STOPWATCH
	ERROR_SHARED_MULTI_ERROR_MANAGER


create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_server: XS_MAIN_SERVER
			l_arg_parser: XS_ARGUMENT_PARSER
			l_common_classes: XC_CLASSES
		do

			create l_common_classes.make
			create l_arg_parser.make
			create l_server.make
			l_arg_parser.execute (agent l_server.setup (l_arg_parser))
		end

end
