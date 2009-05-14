note
	description: "[
		Xebra Server run class
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_server: XS_MAIN_SERVER
			l_arg_parser: XS_ARGUMENT_PARSER
		do
			create l_arg_parser.make
			create l_server.make
			l_arg_parser.execute (agent l_server.run (l_arg_parser))
		end
end
