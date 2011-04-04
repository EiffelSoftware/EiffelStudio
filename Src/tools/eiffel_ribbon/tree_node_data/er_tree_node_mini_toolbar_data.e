note
	description: "Summary description for {ER_MINI_TOOLBAR_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_MINI_TOOLBAR_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			command_name_prefix := "mini_toolbar_"
			xml_constants := {ER_XML_CONSTANTS}.mini_toolbar
			new_unique_command_name
		end

end
