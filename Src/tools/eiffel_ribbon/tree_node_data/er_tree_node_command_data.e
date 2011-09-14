note
	description: "[
					Ribbon command tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_COMMAND_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "command_"
			xml_constants := {ER_XML_CONSTANTS}.command
			new_unique_command_name
		end

feature -- XML callbacks

	tag_of_start: detachable STRING
			-- Set by `on_start_tag'
end
