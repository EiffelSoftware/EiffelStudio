indexing

	description: 
	"SET_HOMOGENEOUS_COMMAND, sets the minimum size of widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SET_HOMOGENEOUS_COMMAND

inherit

	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT2[EV_BOX, EV_TOGGLE_BUTTON]) is
		do
			argument.first.set_homogeneous (argument.second.pressed)
		end

end
