indexing
	description	: "Command with an associated icon.";
	date		: "$Date$";
	revision	: "$Revision$"

deferred class PIXMAP_COMMAND

inherit
	TOOL_COMMAND
		redefine
			execute
		end

	NAMER

	BENCH_LICENSED_COMMAND
		rename
			parent_window as Project_tool
		end

feature -- Callbacks

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Useless here.
		do
		end

feature -- Properties

	symbol: PIXMAP is
			 -- Icon for current command
		deferred
		end;

feature -- Execute

	execute (argument: ANY) is
			-- Execute current command but don't change the cursor into
			-- watch shape.
		do
			if last_warner /= Void and then
					not last_warner.destroyed then
				last_warner.popdown
			end;
			execute_licensed (argument);
		end;
	
invariant

	text_window_not_void: text_window /= Void

end -- class PIXMAP_COMMAND
