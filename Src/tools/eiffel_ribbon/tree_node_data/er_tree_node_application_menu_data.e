note
	description: "[
					Application menu tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_APPLICATION_MENU_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "application_menu_"
			xml_constants := {ER_XML_CONSTANTS}.ribbon_application_menu
			new_unique_command_name

			-- Default value
			max_count := 9
		end

feature -- Query

	max_count: INTEGER
			-- Max count of recent item

	enable_pinning: BOOLEAN
			-- Enable pinning in recent items?

feature -- Command

	set_max_count (a_max_count: INTEGER)
			-- Set `max_count' with `a_max_count'
		do
			max_count := a_max_count
		ensure
			set: max_count = a_max_count
		end

	set_enable_pinning (a_bool: BOOLEAN)
			-- Set `enable_pinning' with `a_bool'
		do
			enable_pinning := a_bool
		ensure
			set: enable_pinning = a_bool
		end

end
