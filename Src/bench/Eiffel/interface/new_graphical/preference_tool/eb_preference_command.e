indexing

	description:
		"Abstract notion of a command for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EB_PREFERENCE_COMMAND

inherit
	EB_TOOL_COMMAND
		redefine
			tool
		end

feature -- Properties

	tool: EB_PREFERENCE_TOOL
			-- The tool

end -- class EB_PREFERENCE_COMMAND
