indexing
	description: "Abstract notion of a command for an edit tool"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EDITOR_COMMAND

inherit
	EB_TEXT_TOOL_CMD
		redefine
			tool
		end

feature -- Properties

	tool: EB_EDIT_TOOL
			-- The tool

end -- class EB_EDITOR_COMMAND
