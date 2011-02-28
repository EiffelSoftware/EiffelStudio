note
	description: "Summary description for {ER_TREE_NODE_MENU_GROUP_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_MENU_GROUP_DATA

inherit
	ER_TREE_NODE_BUTTON_DATA
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "menu_group_"
			xml_constants := {ER_XML_CONSTANTS}.check_box
			new_unique_command_name
		end

end
