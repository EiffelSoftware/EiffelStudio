indexing
	description: "Command to display the argument choosing dialog"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROMPT_ARGUMENT_CMD

inherit
	EB_TEXT_TOOL_CMD

create
	make

feature -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			ad: EB_ARGUMENT_DIALOG
		do
			create ad.make_default (tool.parent_window, Void)
		end

end -- class EB_PROMPT_ARGUMENT_CMD
