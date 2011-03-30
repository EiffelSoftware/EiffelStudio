note
	description: "Summary description for {ER_TREE_NODE_BUTTON_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_BUTTON_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			command_name_prefix := "button_"
			xml_constants := {ER_XML_CONSTANTS}.button
			new_unique_command_name
		end

end
