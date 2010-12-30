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
		local
			l_shared: ER_SHARED_SINGLETON
			l_constants: ER_XML_CONSTANTS
			l_list: ARRAYED_LIST [EV_TREE_NODE]
			l_command_name: STRING
			l_count: INTEGER
			l_conflict: BOOLEAN
		do
			-- Initialize a command name automatically

			-- Count how many buttons node in layout constructor
			create l_shared
			if attached l_shared.layout_constructor_cell.item as l_layout_constructor then
				create l_constants
				l_list := l_layout_constructor.all_items_with (l_constants.button)
				l_count := l_list.count

				-- check if the command name conflict with other buttons
				from
					l_count := l_count + 1
					l_command_name := "button_cmd_" + l_count.out
				until
					not is_name_conflict (l_list, l_command_name)
				loop
					l_count := l_count + 1
					l_command_name := "button_cmd_" + l_count.out
				end
				set_command_name (l_command_name)
			end
		end

feature -- Command

	update_for_xml_attribute (a_name, a_value: STRING)
			-- <Precursor>
		local
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_constants
			check a_name.is_equal (l_constants.command_name) end
			command_name := a_value
		end

feature {NONE} -- Implementation

	is_name_conflict (a_all_buttons: ARRAYED_LIST [EV_TREE_NODE]; a_command_name: STRING): BOOLEAN
			-- Check if `a_command_name' conflict with other buttons in `a_all_buttons'
		require
			not_void: a_all_buttons /= Void
			not_void: a_command_name /= Void
		do
			from
				a_all_buttons.start
			until
				a_all_buttons.after or Result
			loop
				if attached {ER_TREE_NODE_BUTTON_DATA} a_all_buttons.item.data as l_data then
					if attached l_data.command_name as l_command_name then
						Result := l_command_name.same_string (a_command_name)
					end

				end
				a_all_buttons.forth
			end
		end
end
