note
	description: "Summary description for {ER_MINI_TOOLBAR_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_CONTEXT_MENU_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			command_name_prefix := "context_popup_"
			xml_constants := {ER_XML_CONSTANTS}.context_popup
			new_unique_command_name
		end

end
