note
	description: "Summary description for {ER_TOOL_BAR_TAB_IMP}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RIBBON_TAB_IMP_$INDEX

inherit
	ER_COMMAND_HANDLER_OBSERVER
	
	ER_TOOL_BAR_TAB

feature -- Query

	text: STRING = "Tab 1"
			-- Text of tab
end
