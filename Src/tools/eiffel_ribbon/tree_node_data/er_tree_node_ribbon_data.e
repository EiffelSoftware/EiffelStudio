note
	description: "Summary description for {ER_TREE_NODE_RIBBON_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_RIBBON_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "ribbon_"
			xml_constants := {ER_XML_CONSTANTS}.ribbon
			new_unique_command_name
		end

end
