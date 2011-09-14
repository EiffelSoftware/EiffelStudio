note
	description: "[
					Checkbox tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_CHECKBOX_DATA

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
			command_name_prefix := "checkbox_"
			xml_constants := {ER_XML_CONSTANTS}.check_box
			new_unique_command_name
		end

end
