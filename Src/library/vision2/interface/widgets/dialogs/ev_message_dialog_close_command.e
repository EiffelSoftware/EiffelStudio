indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MESSAGE_DIALOG_CLOSE_COMMAND

inherit
	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT1[EV_MESSAGE_DIALOG_I]; data: EV_EVENT_DATA) is
		do
			argument.first.interface.destroy
		end

end -- class EV_MESSAGE_DIALOG_CLOSE_COMMAND
