note
	description: "Summary description for {ER_TREE_NODE_SPLIT_BUTTON_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_SPLIT_BUTTON_DATA

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
			command_name_prefix := "split_button_"
			xml_constants := {ER_XML_CONSTANTS}.split_button
			new_unique_command_name
		end

end
