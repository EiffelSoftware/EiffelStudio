
deferred class EB_UNDOABLE 

inherit

	UNDOABLE;
	WINDOWS;

feature 

	history: HISTORY_WND is
			-- History in which Current command
			-- is to be recorded
		do
			Result := History_window
		end;

	Command_names: COMMAND_NAME_CONSTANTS is
		once
			!! Result
		end

end
