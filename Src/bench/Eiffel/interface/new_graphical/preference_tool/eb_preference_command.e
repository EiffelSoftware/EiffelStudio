indexing

	description:
		"Abstract notion of a command for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

deferred class EB_PREFERENCE_COMMAND

inherit
	EV_COMMAND
		export
			{EB_PREFERENCE_COMMAND} execute
		end

feature {NONE} -- Initialization

	make (a_tool: EB_PREFERENCE_TOOL) is
			-- Initialize Current.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		end

feature -- Properties

	tool: EB_PREFERENCE_TOOL
			-- The tool

end -- class EB_PREFERENCE_COMMAND
