indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QUESTION_DIALOG_COMMAND

inherit
	EV_COMMAND

feature

	execute (argument: EV_ARGUMENT1[EV_WINDOW]; data: EV_EVENT_DATA) is
		local
			dialog: EV_QUESTION_DIALOG
		do
			!!dialog.make_default(argument.first, "Am I a dialog box?", "Question box")
		end

end -- class QUESTION_DIALOG_COMMAND
