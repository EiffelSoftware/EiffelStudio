
deferred class LICENCE_COMMAND

inherit

	COMMAND;
	LICENSED_COMMAND
		rename
			execute_licensed as execute
		end;
	WINDOWS

feature {NONE} -- License manager

	parent_window: COMPOSITE is
		once
			Result := Main_panel.base
		end

end
