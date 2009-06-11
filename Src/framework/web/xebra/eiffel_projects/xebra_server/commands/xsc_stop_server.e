note
	description: "Summary description for {XSC_STOP_SERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_STOP_SERVER

inherit
	XS_COMMAND

create
	make

feature -- Basic operations

	execute (a_server: XS_MAIN_SERVER)
			-- <Precursor>	
		do
			a_server.stop := True
		end
end
