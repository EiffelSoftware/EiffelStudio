indexing

	description: 
	"SET_MIN_SIZE_COMMAND, sets the minimum size of widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SET_MIN_SIZE_COMMAND

inherit

	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT3[EV_WIDGET, EV_ENTRY, EV_ENTRY]) is
		do
			argument.first.set_minimum_size (argument.second.text.to_integer, 
						 argument.third.text.to_integer)
		end

end
