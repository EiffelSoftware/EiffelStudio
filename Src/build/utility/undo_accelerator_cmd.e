indexing
	description: "Command to undo a previous action. Called %
				% after pressing Ctrl-Z."
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_ACCELERATOR_CMD

inherit

	WINDOWS

	COMMAND

feature -- Implementation

	execute (arg: ANY) is
			-- Undo previous command
		do
			history_window.back
		end

end -- class UNDO_ACCELERATOR_CMD
