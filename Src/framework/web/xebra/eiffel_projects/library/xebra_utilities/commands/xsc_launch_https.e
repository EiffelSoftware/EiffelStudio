note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_LAUNCH_HTTPS

inherit
	XS_COMMAND

create
	make

feature -- Basic operations

	execute (a_server: XSC_SERVER_INTERFACE)
			-- <Precursor>	
		do
			a_server.launch_http_server
		end
end
