indexing

	description:	
		"Command associated with a tool.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOOL_COMMAND

inherit

	COMMAND_W

feature {NONE} -- Initialization

	init (a_text_window: like text_window) is
			-- Initialize a command with the `symbol' icon,
			-- `a_text_window' is passed as argument to the activation action.
		require
			a_text_window_not_void: a_text_window /= Void
		do
			tool := a_text_window.tool
		ensure
			tool_set: tool = a_text_window.tool
		end;

	init_from_tool (a_tool: like tool) is
			-- Initialize a command with the `symbol' icon,
			-- `a_tool' is passed as argument to the activation action.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool = a_tool
		end;

feature -- Properties

	tool: TOOL_W;
			-- Tool associated with command

feature -- Access

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

	name: STRING is
			-- Name of the command.
		deferred
		end;

feature {EB_BUTTON} -- Implementation

	button_three_action: ANY is
			-- Action to specify that the third button was pressed
		once
			!! Result
		end;

invariant

	tool_not_void: tool /= Void

end -- class TOOL_COMMAND
