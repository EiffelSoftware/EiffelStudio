indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_DIALOG_COMMAND

inherit
	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT1[EV_WINDOW]; data: EV_EVENT_DATA) is
		local
			dialog: EV_INFORMATION_DIALOG
		do
			!!dialog.make_default(argument.first, "This is some information!", "Info box")
		end

end -- class MESSAGE_DIALOG_COMMAND
