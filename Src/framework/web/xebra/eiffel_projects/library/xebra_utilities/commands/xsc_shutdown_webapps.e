note
	description: "Summary description for {XSC_SHUTDOWN_WEBAPPS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_SHUTDOWN_WEBAPPS

inherit
	XS_COMMAND

create
	make

feature -- Basic operations

	execute (a_server: XSC_SERVER_INTERFACE)
			-- <Precursor>	
		do
			a_server.shutdown_webapps
		end
end
