indexing

	description: 
	"APPLICATION_EXIT_COMMAND, Exits the application. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class APPLICATION_EXIT_COMMAND

inherit

	EV_COMMAND

feature

	execute (arg: EV_ARGUMENT1[EV_APPLICATION]; data: EV_EVENT_DATA) is
		do
--			arg.first.exit
		end

end
