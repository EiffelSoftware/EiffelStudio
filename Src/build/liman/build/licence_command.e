
deferred class LICENCE_COMMAND

inherit

	EV_COMMAND

	LICENSED_COMMAND

	WINDOWS

feature {NONE} -- License manager

	parent_window: EV_WINDOW is
		once
			Result := main_window
		end

end -- class LICENCE_COMMAND

