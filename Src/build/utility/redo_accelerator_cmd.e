indexing
	description: "Command to redo a previous action. Called %
				% after pressing Ctrl-R."
	date: "$Date$"
	revision: "$Revision$"

class
	REDO_ACCELERATOR_CMD

inherit

	WINDOWS

	COMMAND

feature -- Implementation

	execute (arg: ANY) is
			-- Undo previous command
		do
			history_window.forth
		end

end -- class REDO_ACCELERATOR_CMD
