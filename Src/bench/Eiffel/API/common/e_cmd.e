indexing

	description: 
		"General notion of an eiffel query command (semantic unity).%
		%To write an actual command inherit from this class and%
		%implement the `execute' feature";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CMD

feature -- Properties

	output_window: CLICK_WINDOW;
			-- Output window for command

feature -- Access

	executable: BOOLEAN is
			-- Is Current command executable?
			-- (Default is True)
		do
			Result := output_window /= Void 
		end

feature -- Setting

	make, set_output_window (display: CLICK_WINDOW) is
			-- Set output_window to `display'.
		do
			output_window := display
		end;

feature -- Execution

	execute is
			-- Execute Current command.
		require
			executable: executable
		deferred
		end;

end -- class E_CMD
