indexing
	description: "Abstract notion of a command for a text tool"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TEXT_TOOL_CMD

inherit
	EB_TOOL_COMMAND
		redefine
			tool
		end

feature -- Properties

	tool: EB_TEXT_TOOL
			-- The tool

end -- class EB_TEXT_TOOL_CMD
