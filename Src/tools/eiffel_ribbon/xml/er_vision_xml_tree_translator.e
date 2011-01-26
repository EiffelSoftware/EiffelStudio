note
	description: "[
					Summary description for {ER_VISION_XML_TREE_TRANSLATOR}.

																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_VISION_XML_TREE_TRANSLATOR

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create xml_constants
			reset_xml_tree
		end

feature -- Command

	reset_xml_tree
			-- Initilaize the basic structure of a ribbon markup xml tree
		local
			l_xml_element: XML_ELEMENT
			l_parent: XML_ELEMENT
		do
			application_mode := 0

			create xml_document.make
			create name_space.make_default
			create root_xml_element.make_root (xml_document, "Application", name_space)
			root_xml_element.add_attribute ("xmlns", name_space, "http://schemas.microsoft.com/windows/2009/Ribbon")

			create l_xml_element.make (root_xml_element, xml_constants.application_commands, name_space)
			root_xml_element.put_last (l_xml_element)

			create l_xml_element.make (root_xml_element, xml_constants.application_views, name_space)
			root_xml_element.put_last (l_xml_element)

			l_parent := l_xml_element
			create l_xml_element.make (l_parent, xml_constants.ribbon, name_space)
			l_parent.put_last (l_xml_element)

			l_parent := l_xml_element
			create l_xml_element.make (l_parent, xml_constants.ribbon_tabs, name_space)
			l_parent.put_last (l_xml_element)
		end

	save_xml_nodes_for_all_layout_constructors
			--
		local
			l_shared: ER_SHARED_SINGLETON
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
		do
			reset_xml_tree
			from
				create l_shared
				l_list := l_shared.layout_constructor_list
				l_list.start
			until
				l_list.after
			loop
				application_mode := l_list.index - 1
				add_xml_nodes_by_vision_tree (l_list.item.widget)

				l_list.forth
			end
		end

feature -- Tree loading

	update_vision_tree_after_load (a_tree: EV_TREE)
			--
		local
			l_ribbon_tabs, l_app_commands: detachable EV_TREE_ITEM
			l_list: ARRAYED_LIST [EV_TREE_ITEM]
			l_singleton: ER_SHARED_SINGLETON
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			-- Separate command and ribbon.tabs
			l_app_commands := tree_node_by_name (xml_constants.application_commands, a_tree)
			l_ribbon_tabs := tree_node_by_name (xml_constants.ribbon_tabs, a_tree)

			if l_ribbon_tabs /= Void  then
				if l_app_commands /= Void then
					from
						l_app_commands.start
					until
						l_app_commands.after
					loop
						update_tree_node_data_with_commands (l_app_commands.item, l_ribbon_tabs)

						l_app_commands.forth
					end
				end

				l_list := separate_tabs_to_different_ribbons (l_ribbon_tabs)
				check l_list.count >= 1 end

				a_tree.wipe_out
				a_tree.extend (l_list.first)

				if l_list.count > 1 then
					-- Need to create new layout constructors
					from
						create l_singleton
						l_list.go_i_th (2)
					until
						l_list.after
					loop
						if attached l_singleton.main_window_cell.item as l_win then
							l_win.new_ribbon_command.execute

							l_layout_constructor := l_singleton.layout_constructor_list.i_th (l_list.index)
							l_layout_constructor.widget.wipe_out
							l_layout_constructor.widget.extend (l_list.item)
							l_layout_constructor.expand_tree
						end

						l_list.forth
					end
				end
			end
		end

	separate_tabs_to_different_ribbons (a_ribbon_tabs: EV_TREE_ITEM): ARRAYED_LIST [EV_TREE_ITEM]
			--
		local
			l_xml: ER_XML_CONSTANTS
			l_application_modes: SORTED_TWO_WAY_LIST [INTEGER]
			l_ribbon_tabs: detachable EV_TREE_ITEM
			l_ribbon_item: EV_TREE_NODE
			l_search_result: INTEGER
			l_shared: ER_SHARED_SINGLETON
		do
			create l_xml
			check valid: a_ribbon_tabs.text.same_string_general (l_xml.ribbon_tabs) end

			-- First find out how many application modes
			from
				create l_application_modes.make
				l_application_modes.extend (0) -- default application mode
				a_ribbon_tabs.start
			until
				a_ribbon_tabs.after
			loop
				if attached {ER_TREE_NODE_TAB_DATA} a_ribbon_tabs.item.data as l_group_data then
					if not l_application_modes.has (l_group_data.application_mode) then
						l_application_modes.extend (l_group_data.application_mode)
					end
				end

				a_ribbon_tabs.forth
			end

			-- Prepare root node Ribbon.Tabs for each ribbon
			create Result.make (l_application_modes.count)
			from
				create l_shared
				l_application_modes.start
			until
				l_application_modes.after
			loop
				l_ribbon_tabs := l_shared.layout_constructor_list.first.tree_item_factory_method (l_xml.ribbon_tabs)
				Result.extend (l_ribbon_tabs)

				l_application_modes.forth
			end

			-- Separate application mode to different ribbon_tabs
			from
				a_ribbon_tabs.start
			until
				a_ribbon_tabs.after
			loop
				l_ribbon_item := a_ribbon_tabs.item
				if attached l_ribbon_item.parent as l_parent then
					l_parent.prune_all (l_ribbon_item)
				else
					check False end
				end
				a_ribbon_tabs.start

				if attached {ER_TREE_NODE_TAB_DATA} l_ribbon_item.data as l_group_data then
					l_search_result := l_application_modes.index_of  (l_group_data.application_mode, 1)
					check l_search_result /= 0 end
					l_ribbon_tabs := Result.i_th (l_search_result)
					l_ribbon_tabs.extend (l_ribbon_item)
				else
					-- No data, put to default
					Result.first.extend (l_ribbon_item)
				end

--				a_ribbon_tabs.forth
			end
		end

	update_tree_node_data_with_commands (a_app_commands: EV_TREE_NODE; a_ribbon_tabs: EV_TREE_NODE)
			--
		do
			if attached {ER_TREE_NODE_DATA} a_app_commands.data as l_data then
				if attached l_data.command_name as l_name and then not l_name.is_empty then
					if attached {EV_TREE_ITEM} command_tree_node_with_command_name (l_name, a_ribbon_tabs) as l_widget_item then
						if attached {ER_TREE_NODE_DATA} l_widget_item.data as l_command_data then
							l_command_data.set_label_title (l_data.label_title)
							l_command_data.set_large_image (l_data.large_image)
							l_command_data.set_small_image (l_data.small_image)
						end
					else
						check must_found: False end
					end
				end
			end
		end

	command_tree_node_with_command_name (a_command_name: STRING; a_app_commands: EV_TREE_NODE): detachable EV_TREE_NODE
			--
		require
			not_void: a_command_name /= Void
		do
			if attached {ER_TREE_NODE_DATA} a_app_commands.data as l_data then
				if attached l_data.command_name as l_name and then not l_name.is_empty then
					if l_name.same_string (a_command_name) then
						Result := a_app_commands
					end
				end
			end
			if Result = Void then
				from
					a_app_commands.start
				until
					a_app_commands.after or Result /= Void
				loop
					Result := command_tree_node_with_command_name (a_command_name, a_app_commands.item)

					a_app_commands.forth
				end
			end
		end

feature {NONE} -- Tree saving

	add_xml_nodes_by_vision_tree (a_vision_tree: EV_TREE)
			-- Add xml nodes by querying info from `a_vision_tree'
		require
			not_void: a_vision_tree /= Void
			valid: a_vision_tree.i_th (1).text.same_string (xml_constants.ribbon_tabs)
		do
			if attached {EV_TREE_ITEM} a_vision_tree.i_th (1) as l_tree_item then
				check l_tree_item.text.same_string (xml_constants.ribbon_tabs) end

				from
					l_tree_item.start
				until
					l_tree_item.after
				loop
					if attached {EV_TREE_ITEM} l_tree_item.item as l_tree_tab_item then
						check l_tree_tab_item.text.same_string (xml_constants.tab) end
						add_xml_tab_node (l_tree_tab_item)

					end

					l_tree_item.forth
				end
			end
		end

	add_xml_tab_node (a_tree_item: EV_TREE_ITEM)
			--
		require
			not_void: a_tree_item /= Void
			valid: a_tree_item.text.same_string (xml_constants.tab)
		local
			l_tab_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached xml_node_by_name (xml_constants.ribbon_tabs) as l_ribbon_tab_node then
				create l_tab_node.make (l_ribbon_tab_node, xml_constants.tab, name_space)
				l_ribbon_tab_node.put_last (l_tab_node)

				if attached {ER_TREE_NODE_TAB_DATA} a_tree_item.data as l_data then
					create l_constants
					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_tab_node.add_attribute (l_constants.command_name, name_space, l_command_name)
						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
					if application_mode /= 0 then
						l_tab_node.add_attribute (l_constants.application_mode, name_space, application_mode.out)
					end
				end

				from
					a_tree_item.start
				until
					a_tree_item.after
				loop
					add_xml_group_node (l_tab_node, a_tree_item.item)

					a_tree_item.forth
				end
			else
				check False end
			end
		end

	add_xml_group_node (a_parent_tab: XML_ELEMENT; a_group_tree_node: EV_TREE_NODE)
			--
		require
			not_void: a_parent_tab /= Void
			valid: a_parent_tab.name.same_string (xml_constants.tab)
		local
			l_group_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
			l_xml_constants: ER_XML_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_group_tree_node as l_item then
				check l_item.text.same_string (xml_constants.group) end

				create l_group_node.make (a_parent_tab, xml_constants.group, name_space)
				a_parent_tab.put_last (l_group_node)

				if attached {ER_TREE_NODE_GROUP_DATA} a_group_tree_node.data as l_data then
					create l_constants
					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_group_node.add_attribute (l_constants.command_name, name_space, l_command_name)
						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
					if application_mode /= 0 then
						l_group_node.add_attribute (l_constants.application_mode, name_space, application_mode.out)
					end

					if attached l_data.size_definition as l_size_definition and then not l_size_definition.is_empty then
						l_group_node.add_attribute (l_constants.size_definition, name_space, l_size_definition)
					end
				end

				from
					create l_xml_constants
					a_group_tree_node.start
				until
					a_group_tree_node.after
				loop
					if a_group_tree_node.item.text.same_string (l_xml_constants.button) then
						add_xml_button_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.check_box) then
						add_xml_checkbox_node (l_group_node, a_group_tree_node.item)
					else
						check not_implemented: False end
					end

					a_group_tree_node.forth
				end
			end
		end

	add_xml_button_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			--
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.button) end

				create l_button_node.make (a_group_node, xml_constants.button, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_BUTTON_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
				end
			end
		end

	add_xml_checkbox_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			--
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.check_box) end

				create l_button_node.make (a_group_node, xml_constants.check_box, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_BUTTON_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
				end
			end
		end

	add_xml_command_node (a_tree_node_data: ER_TREE_NODE_DATA)
			--
		require
			not_void: a_tree_node_data /= Void
		local
			l_command_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached xml_node_by_name (xml_constants.application_commands) as l_ribbon_command_node then
				if attached a_tree_node_data.command_name as l_command_name and then not l_command_name.is_empty then
					create l_constants
					create l_command_node.make (l_ribbon_command_node, xml_constants.command, name_space)
					l_ribbon_command_node.put_last (l_command_node)
					l_command_node.add_attribute (l_constants.name, name_space, l_command_name)
					add_sub_tree_nodes (l_command_node, a_tree_node_data)
				end
			else
				check False end
			end
		end

feature -- Query

	xml_constants: ER_XML_CONSTANTS
			--

	xml_document: XML_DOCUMENT
			--

	name_space: XML_NAMESPACE
			--

 	application_mode: INTEGER
 			-- 0 means first layout constructor
 			-- 1 means second layout constructor
 			-- 2 means third...

feature {NONE} -- implementation

	add_sub_tree_nodes (a_parent_node: XML_ELEMENT; a_tree_node_data: ER_TREE_NODE_DATA)
			-- When saving XML, adding sub tree nodes to `a_parent_node' if possible
		require
			not_void: a_tree_node_data /= Void
		local
			l_item, l_sub_item: XML_ELEMENT
			l_item_text: XML_CHARACTER_DATA
			l_constants: ER_XML_CONSTANTS
		do
			create l_constants
			if attached a_tree_node_data.label_title as l_title and then not l_title.is_empty then
				create l_item.make (a_parent_node, l_constants.command_label_title, name_space)
				a_parent_node.put_last (l_item)

				create l_sub_item.make (l_item, l_constants.string, name_space)
				l_item.put_last (l_sub_item)

				create l_item_text.make (l_sub_item, l_title)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
			end

			if attached a_tree_node_data.large_image as l_image and then not l_image.is_empty then
				create l_item.make (a_parent_node, l_constants.command_large_images, name_space)
				a_parent_node.put_last (l_item)

				create l_sub_item.make (l_item, l_constants.image, name_space)
				l_item.put_last (l_sub_item)

				if not l_image.has_substring ("\\") then
					l_image.replace_substring_all ("\", "\\")
				end

				create l_item_text.make (l_sub_item, l_image)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
			end

			if attached a_tree_node_data.small_image as l_image and then not l_image.is_empty then
				create l_item.make (a_parent_node, l_constants.command_small_images, name_space)
				a_parent_node.put_last (l_item)

				create l_sub_item.make (l_item, l_constants.image, name_space)
				l_item.put_last (l_sub_item)

				if not l_image.has_substring ("\\") then
					l_image.replace_substring_all ("\", "\\")
				end

				create l_item_text.make (l_sub_item, l_image)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
			end
		end

	tree_node_by_name (a_tree_node_name: STRING; a_tree: EV_TREE): detachable EV_TREE_ITEM
			-- Find a tree node by its text
		do
			check a_tree.count = 1 end
			if attached {EV_TREE_ITEM} recursive_tree_node_by_name (a_tree_node_name, a_tree.i_th (1)) as l_result then
				Result := l_result
			end
		end

	recursive_tree_node_by_name (a_tree_node_name: STRING; a_tree_node: EV_TREE_NODE): detachable EV_TREE_NODE
			--
		do
			if attached {EV_TREE_ITEM} a_tree_node as l_node then
				if l_node.text.same_string (a_tree_node_name) then
					Result := a_tree_node
				end

				if Result = Void then
					from
						a_tree_node.start
					until
						a_tree_node.after or Result /= Void
					loop
						Result := recursive_tree_node_by_name (a_tree_node_name, a_tree_node.item)

						a_tree_node.forth
					end
				end
			end
		end

	xml_node_by_name (a_xml_node_name: STRING): detachable XML_ELEMENT
			-- Find a xml node by its node name
		require
			not_void: a_xml_node_name /= Void
			valid: xml_constants.valid (a_xml_node_name)
		do
			if attached {XML_ELEMENT} recursive_xml_node_by_name (a_xml_node_name, root_xml_element) as l_result then
				Result := l_result
			end
		end

	recursive_xml_node_by_name (a_xml_node_name: STRING; a_xml_element: XML_NODE): detachable XML_NODE
			-- Find a xml node by its node name
		require
			not_void: a_xml_node_name /= Void
			valid: xml_constants.valid (a_xml_node_name)
			not_void: a_xml_element /= Void
		do
			if attached {XML_ELEMENT} a_xml_element as l_element then
				if attached l_element.name as l_text then
					if l_text.same_string (a_xml_node_name) then
						Result := a_xml_element
					end
				end

				if Result = Void then
					from
						l_element.start
					until
						l_element.after or Result /= Void
					loop
						Result := recursive_xml_node_by_name (a_xml_node_name, l_element.item_for_iteration)

						l_element.forth
					end
				end
			end
		end

	root_xml_element: XML_ELEMENT
			--

end
