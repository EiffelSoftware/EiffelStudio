note
	description: "[
					Common ancestor for all tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_TREE_NODE_DATA

feature -- Settings

	set_command_name (a_command_name: detachable STRING)
			-- Set `command_name' with `a_command_name'
		do
			command_name := a_command_name
		end

	set_label_title (a_label_title: detachable STRING_32)
			-- Set `label_title' with `a_label_title'
		do
			label_title := a_label_title
		end

	set_small_image (a_small_image: detachable STRING_32)
			-- Set `small_image' with `a_small_image'
		do
			small_image := a_small_image
		end

	set_large_image (a_large_image: detachable STRING_32)
			-- Set `large_image' with `a_large_image'
		do
			large_image := a_large_image
		end

	set_application_mode (a_mode: INTEGER)
			-- Set `application_mode' with `a_mode'
		do
			application_mode := a_mode
		end

feature -- Query

	command_name: detachable STRING
			-- Command name or identifier name

	label_title: detachable STRING_32
			-- Label title on button, checkbox or spinner etc

	small_image: detachable STRING_32
			-- Small image

	large_image: detachable STRING_32
			-- Large image

	application_mode: INTEGER
			-- Application mode

feature {NONE} -- Implementation

	remove_useless_symbol (a_string: detachable STRING)
			-- Remove useless symbol in `a_string'
		do
			if attached a_string as l_string then
				l_string.replace_substring_all ("%N", "")
				l_string.replace_substring_all ("%T", "")
				l_string.replace_substring_all (" ", "")
			end
		end

	new_unique_command_name
			-- Initialize a command name automatically
		local
			l_shared: ER_SHARED_SINGLETON
			l_list: ARRAYED_LIST [EV_TREE_NODE]
			l_command_name: STRING
			l_count: INTEGER
		do
				-- Count how many buttons node in layout constructor
			create l_shared
			if attached l_shared.layout_constructor_list.first as l_layout_constructor then

				l_list := l_layout_constructor.all_items_in_all_constructors (xml_constants)
				l_count := l_list.count

					-- check if the command name conflict with other buttons
				from
					l_count := l_count + 1
					l_command_name := command_name_prefix + l_count.out
				until
					not is_name_conflict (l_list, l_command_name)
				loop
					l_count := l_count + 1
					l_command_name := command_name_prefix + l_count.out
				end
				set_command_name (l_command_name)
			end
		end

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

	command_name_prefix: STRING
			-- Command name prefix

	xml_constants: STRING
			-- XML tree constants		
end
