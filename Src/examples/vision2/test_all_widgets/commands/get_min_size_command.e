indexing

	description: 
	"GET_MIN_SIZE_COMMAND, sets the minimum size of widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class GET_MIN_SIZE_COMMAND

inherit

	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT3[EV_WIDGET, EV_TEXT_FIELD, EV_TEXT_FIELD]; data: EV_EVENT_DATA) is
		do
			argument.second.set_text (argument.first.minimum_width.out)
			argument.third.set_text (argument.first.minimum_height.out)
		end

end
