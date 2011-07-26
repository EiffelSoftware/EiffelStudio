note
	description: "Summary description for {ER_TREE_NODE_TAB_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_TAB_GROUP_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "tab_group_"
			xml_constants := {ER_XML_CONSTANTS}.tab_group
			new_unique_command_name
		end

end
