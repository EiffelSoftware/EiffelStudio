note
	description: "Summary description for {ER_TREE_NODE_APPLICATION_MENU_DATA}."
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
			--

	enable_pinning: BOOLEAN
			--

feature -- Command

	set_max_count (a_max_count: INTEGER)
			--
		do
			max_count := a_max_count
		ensure
			set: max_count = a_max_count
		end

	set_enable_pinning (a_bool: BOOLEAN)
			--
		do
			enable_pinning := a_bool
		ensure
			set: enable_pinning = a_bool
		end

end
