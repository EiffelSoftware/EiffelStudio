indexing

	description:
		"Abstract notion of a command for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PREFERENCE_COMMAND

inherit
	COMMAND

feature {NONE} -- Initialization

	make (a_tool: PREFERENCE_TOOL) is
			-- Initialize Current.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		end

feature -- Properties

	name: STRING is
			-- Current's name
		deferred
		end;

	symbol: PIXMAP is
			-- Current's symbol
		deferred
		end

	dark_symbol: PIXMAP is
			-- Current's symbol for selected state
		deferred
		end

	tool: PREFERENCE_TOOL
			-- The tool

end -- class PREFERENCE_COMMAND
