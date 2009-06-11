note
	description: "Summary description for {XSC_LAUNCH_INPUTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_LAUNCH_INPUTS

inherit
	XS_COMMAND

create
	make

feature -- Basic operations

	execute (a_server: XS_MAIN_SERVER)
			-- <Precursor>	
		do
			o.iprint ("Launching input server...")
			a_server.input_server := create {XS_INPUT_SERVER}.make (a_server)
			a_server.input_server.launch
			o.iprint ("Done.")
		end
end
