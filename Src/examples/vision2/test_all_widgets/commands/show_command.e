indexing

	description: 
	"SHOW_COMMAND, shows a widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SHOW_COMMAND

inherit

	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT1[EV_WIDGET]) is
		do
			argument.first.show
		end

end
