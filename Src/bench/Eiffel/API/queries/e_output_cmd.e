indexing

	description: 
		"General notion of an eiffel command with output%
		%appended to `structured_text'.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_OUTPUT_CMD

inherit

	E_CMD
		redefine
			executable
		end

feature -- Properties

	structured_text: STRUCTURED_TEXT;
			-- Structured text for command.

feature -- Access

	executable: BOOLEAN is
			-- Is Current command executable?
		do
			Result := structured_text /= Void 
		end

feature -- Setting

	make, set_structured_text (st: like structured_text) is
			-- Set `structured_text' to `st'.
		do
			structured_text := st
		end;

end -- class E_OUTPUT_CMD
