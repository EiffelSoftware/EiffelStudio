indexing

	description: 
		"General notion of an eiffel query command (semantic unity)%
		%for a class. Display output for current command for%
		%associated class to output_window.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CLASS_CMD

inherit

	E_OUTPUT_CMD
		rename
			make as cmd_make
		export
			{NONE} cmd_make
		redefine
			executable
		end

feature -- Initialization

	set, make (a_class: E_CLASS; display: like output_window) is
			-- Make current command with current_class as
			-- `a_class'.
		require
			valid_a_class_c: a_class /= Void;
			valid_display: display /= Void
		do
			current_class := a_class;	
			set_output_window (display)
		ensure
			class_set: current_class = a_class;
			display_set: output_window = display
		end;

feature -- Property

	current_class: E_CLASS
			-- Class for current action

	executable: BOOLEAN is
			-- Is the Current able to be executed?
		do
			Result := current_class /= Void and then
				output_window /= Void
		ensure then
			good_result: Result implies current_class /= Void;
		end

feature -- Execution

	execute is
			-- Execute Current command.
		deferred
		end;

end -- class E_CLASS_CMD
