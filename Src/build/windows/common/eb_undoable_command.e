indexing
	description: "Abstract undoable command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_UNDOABLE_COMMAND

inherit
	EV_UNDOABLE_COMMAND
		redefine
			update_history
		end

	WINDOWS

feature -- Access

	history: HISTORY_WINDOW is
			-- History in which Current command is to be recorded.
		do
			Result := History_window
		end

	update_history is
			-- Update history if not `failed'.
		do
			if not failed then
				{EV_UNDOABLE_COMMAND} Precursor
			end
		end

	Command_names: COMMAND_NAME_CONSTANTS is
		once
			create Result
		end

	name: STRING is
			-- Name of the command, shown in the first column of the history
		deferred
		end

	comment: STRING is
			-- Text shown in the second column 
		deferred
		end

end -- class EB_UNDOABLE_COMMAND

