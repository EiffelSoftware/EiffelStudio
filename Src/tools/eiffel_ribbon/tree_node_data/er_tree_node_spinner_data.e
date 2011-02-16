note
	description: "Summary description for {ER_TREE_NODE_SPINNER_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_SPINNER_DATA

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
			command_name_prefix := "spinner_"
			xml_constants := {ER_XML_CONSTANTS}.spinner
			new_unique_command_name
		end

end
