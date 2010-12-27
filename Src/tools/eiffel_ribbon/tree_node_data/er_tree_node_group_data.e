note
	description: "Summary description for {ER_TREE_NODE_GROUP_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_GROUP_DATA

inherit
	ER_TREE_NODE_DATA

feature -- Query

	size_definition: detachable STRING
			--

feature -- Command

	set_size_definition (a_size_definition: like size_definition)
			--
		do
			size_definition := a_size_definition
		end

	update_for_xml_attribute (a_name, a_value: STRING)
			-- <Precursor>
		local
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_constants
			if a_name.is_equal (l_constants.command_name) then
				command_name := a_value
			else
				size_definition := a_value
			end
		end
end
