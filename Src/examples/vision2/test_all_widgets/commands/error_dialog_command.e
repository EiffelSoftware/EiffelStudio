indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_DIALOG_COMMAND

inherit
	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT1[EV_WINDOW]; data: EV_EVENT_DATA) is
		local
			dialog: EV_ERROR_DIALOG
		do
			!!dialog.make_default(argument.first, "This is an error message!", "Error box")
		end

end -- class ERROR_DIALOG_COMMAND
