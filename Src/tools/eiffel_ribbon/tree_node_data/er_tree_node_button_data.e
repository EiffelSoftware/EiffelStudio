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

feature -- Command

	update_for_xml_attribute (a_name, a_value: STRING)
			-- <Precursor>
		local
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_constants
--			check a_name.same_string (l_constants.command_name) end
			if a_name.same_string (l_constants.command_name) then
				command_name := a_value
			elseif a_name.same_string (l_constants.text_position) then
				-- nothing to do
			elseif a_name.same_string (l_constants.type) then
				-- nothing to do
			else

			end

		end

end
