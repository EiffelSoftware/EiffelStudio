note
	description: "Summary description for {ER_TREE_NODE_GROUP_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_GROUP_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "group_"
			xml_constants := {ER_XML_CONSTANTS}.group
			new_unique_command_name
		end

feature -- Query

	size_definition: detachable STRING
			--

feature -- Command

	set_size_definition (a_size_definition: like size_definition)
			--
		do
			size_definition := a_size_definition
		end

end
