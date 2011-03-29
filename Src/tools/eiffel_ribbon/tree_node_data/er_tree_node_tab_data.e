note
	description: "Summary description for {ER_TREE_NODE_TAB_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_TAB_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "tab_"
			xml_constants := {ER_XML_CONSTANTS}.tab
			new_unique_command_name
		end

feature -- Command

	update_for_xml_attribute (a_name, a_value: STRING)
			-- <Precursor>
		local
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_constants

			if a_name.same_string (l_constants.command_name) then
				command_name := a_value
			elseif a_name.same_string (l_constants.application_mode) then
				application_mode := a_value.to_integer
			else
				-- Maybe ApplicationModes, or....
				check not_implemented: False end
			end
		end
end
