indexing

	description: 
	"DESTROY_COMMAND, destroys a widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class DESTROY_COMMAND

inherit

	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT1[EV_WIDGET]; data: EV_EVENT_DATA) is
		do
			argument.first.destroy
		end

end
