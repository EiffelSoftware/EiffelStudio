note
	description: "Summary description for {ER_TREE_NODE_HELP_BUTTON_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_HELP_BUTTON_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			command_name_prefix := "help_button_"
			xml_constants := {ER_XML_CONSTANTS}.helpbutton
			new_unique_command_name
		end

end
