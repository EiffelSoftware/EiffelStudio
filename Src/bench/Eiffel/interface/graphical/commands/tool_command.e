indexing

	description:	
		"Command associated with a tool. All of these commands %
		%should be in menu.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOOL_COMMAND

inherit

	ISE_COMMAND;
	EB_CONSTANTS;
	WINDOWS

feature {NONE} -- Initialization

	init (a_tool: like tool) is
			-- Initialize a command with the `symbol' icon,
			-- `a_tool' is passed as argument to the activation action.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool = a_tool
		end;

feature -- Access

	tool: TOOL_W;
			-- Tool associated with command

	text_window: TEXT_WINDOW is
			-- Text window which status tells if we want to execute 
			-- or not, and usually the target of the command
		do
			Result := tool.text_window
		end;

	popup_parent: COMPOSITE is
			-- Parent used for popup creation
		do
			Result := tool.popup_parent
		end;

invariant

	tool_not_void: tool /= Void

end -- class TOOL_COMMAND
