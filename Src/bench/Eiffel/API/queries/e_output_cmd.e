indexing

	description: 
		"General notion of an eiffel command with output%
		%redirected to an OUTPUT_WINDOW.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_OUTPUT_CMD

inherit

	E_CMD
		redefine
			executable
		end

feature -- Properties

	output_window: OUTPUT_WINDOW;
			-- Output window for command

feature -- Access

	executable: BOOLEAN is
			-- Is Current command executable?
		do
			Result := output_window /= Void 
		end

feature -- Setting

	make, set_output_window (display: like output_window) is
			-- Set output_window to `display'.
		do
			output_window := display
		end;

end -- class E_OUTPUT_CMD
