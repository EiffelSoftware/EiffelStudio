note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_STOP_SERVER

inherit
	XS_COMMAND

create
	make

feature -- Basic operations

	execute (a_server: XSC_SERVER_INTERFACE)
			-- <Precursor>	
		do
			a_server.stop_server
		end
end
