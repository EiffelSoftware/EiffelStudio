
deferred class LICENCE_COMMAND

inherit

	COMMAND;
	LICENCED_COMMAND
		rename
			execute_licenced as execute
		end;
	WINDOWS

feature {NONE} -- License manager

	parent_window: COMPOSITE is
		once
			Result := Main_panel.base
		end

end
