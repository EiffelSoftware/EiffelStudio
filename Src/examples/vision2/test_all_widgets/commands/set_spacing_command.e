indexing

	description: 
	"SET_SPACING_COMMAND, sets the minimum size of widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SET_SPACING_COMMAND

inherit

	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT2[EV_BOX, EV_TEXT_FIELD]; data: EV_EVENT_DATA) is
		do
			argument.first.set_spacing (argument.second.text.to_integer)
		end

end
