note
	description: "Summary description for {ER_TREE_NODE_DATA}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_TREE_NODE_DATA

feature -- Command

	update_for_xml_attribute (a_name, a_value: STRING)
			-- FIXME this feature can be removed now?
		require
			not_void: a_name /= Void
			not_void: a_value /= Void
		deferred
		end

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			--
		do
		end

	on_content (a_content: STRING)
			--
		do
		end

feature -- Settings

	set_command_name (a_command_name: detachable STRING)
			--
		do
			command_name := a_command_name
		end

	set_label_title (a_label_title: detachable STRING_32)
			--
		do
			label_title := a_label_title
		end

	set_small_image (a_small_image: detachable STRING_32)
			--
		do
			small_image := a_small_image
		end

	set_large_image (a_large_image: detachable STRING_32)
			--
		do
			large_image := a_large_image
		end

	set_application_mode (a_mode: INTEGER)
			--
		do
			application_mode := a_mode
		end

feature -- Query

	command_name: detachable STRING
			--

	label_title: detachable STRING_32
			--

	small_image: detachable STRING_32
			--

	large_image: detachable STRING_32
			--

	application_mode: INTEGER
			--

feature {NONE} -- Implementation

	remove_useless_symbol (a_string: detachable STRING)
			--
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
