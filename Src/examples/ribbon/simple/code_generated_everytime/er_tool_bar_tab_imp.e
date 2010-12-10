note
	description: "Summary description for {ER_TOOL_BAR_TAB_IMP}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_TOOL_BAR_TAB_IMP

inherit
	ER_COMMAND_HANDLER_OBSERVER

feature -- Query

	text: STRING = "Tab 1"
			-- Text of tab
end
