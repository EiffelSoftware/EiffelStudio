indexing

	description: 
	"GET_SIZE_COMMAND, sets the size of widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class GET_SIZE_COMMAND

inherit

	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT3[EV_WIDGET, EV_TEXT_FIELD, EV_TEXT_FIELD]) is
		do
			argument.second.set_text (argument.first.width.out)
			argument.third.set_text (argument.first.height.out)
		end

end
