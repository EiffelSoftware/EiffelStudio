note
	description: "[
					Vision2 tree to Ribbon markup XML tree translator
					when using application modes

				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_VISION_XML_TREE_TRANSLATOR_AM

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

			create l_xml_element.make (l_parent, xml_constants.ribbon_application_menu, name_space)
			l_parent.put_last (l_xml_element)

			l_parent := l_xml_element
			create l_xml_element.make (l_parent, xml_constants.application_menu, name_space)
			l_parent.put_last (l_xml_element)
		end

	save_xml_nodes_for_all_layout_constructors
			-- Save XML nodes for all layout constructors
		local
			l_shared: ER_SHARED_TOOLS
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
			save_size_definitions
		end

feature -- Tree loading

	command_tree_node_with_command_name (a_command_name: STRING; a_app_commands: EV_TREE_NODE): detachable EV_TREE_NODE
			-- Find out command tree node which name is `a_command_name'
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

	save_size_definitions
			-- Save size definitions
		local
			l_ribbon_xml: detachable XML_ELEMENT
			l_shared: ER_SHARED_TOOLS
			l_root_xml_size_definition: XML_ELEMENT
		do
			l_ribbon_xml := xml_node_by_name (xml_constants.ribbon)
			if l_ribbon_xml /= Void then
				create l_shared
				if attached l_shared.size_definition_cell.item as l_size_definition and then not l_size_definition.size_definition_writer.is_empty then
					l_root_xml_size_definition := l_size_definition.size_definition_writer.root_xml_for_saving
--					l_root_xml_size_definition.set_parent (l_ribbon_xml)
					l_ribbon_xml.put_last (l_root_xml_size_definition)
				end
			end
		end

	save_scaling_policy (a_vision2_tab: EV_TREE_ITEM; a_tab: XML_ELEMENT)
			-- Save scaling policy
		require
			not_void: a_vision2_tab /= Void
			not_void: a_tab /= Void
		local
			l_tab_scaling_policy_xml, l_scaling_policy, l_ideal_sizes, l_scale: XML_ELEMENT
			l_ideal_sizes_list: ARRAYED_LIST [TUPLE [a_group: STRING; a_size: STRING]]
			l_scale_list: ARRAYED_LIST [TUPLE [a_group: STRING; a_size: STRING]]
		do
			from
				create l_ideal_sizes_list.make (10)
				create l_scale_list.make (10)
				a_vision2_tab.start
			until
				a_vision2_tab.after
			loop
				-- Vision2 group items
				if attached {ER_TREE_NODE_GROUP_DATA} a_vision2_tab.item.data as l_data then
					if attached l_data.command_name as l_command_name then
						if l_data.is_ideal_sizes_large_checked then
							l_ideal_sizes_list.extend ([l_command_name, {ER_XML_ATTRIBUTE_CONSTANTS}.Large])
						end
						if l_data.is_ideal_sizes_medium_checked then
							l_ideal_sizes_list.extend ([l_command_name, {ER_XML_ATTRIBUTE_CONSTANTS}.Medium])
						end
						if l_data.is_ideal_sizes_small_checked then
							l_ideal_sizes_list.extend ([l_command_name, {ER_XML_ATTRIBUTE_CONSTANTS}.Small])
						end

						if l_data.is_scale_large_checked then
							l_scale_list.extend ([l_command_name, {ER_XML_ATTRIBUTE_CONSTANTS}.Large])
						end
						if l_data.is_scale_medium_checked then
							l_scale_list.extend ([l_command_name, {ER_XML_ATTRIBUTE_CONSTANTS}.Medium])
						end
						if l_data.is_scale_small_checked then
							l_scale_list.extend ([l_command_name, {ER_XML_ATTRIBUTE_CONSTANTS}.Small])
						end
						if l_data.is_scale_popup_checked then
							l_scale_list.extend ([l_command_name, {ER_XML_ATTRIBUTE_CONSTANTS}.Popup])
						end
					end
				else
					check group_node_must_have_group_tree_node_data: False end
				end

				a_vision2_tab.forth
			end

			if not l_ideal_sizes_list.is_empty or not l_scale_list.is_empty then
				create l_tab_scaling_policy_xml.make (a_tab, xml_constants.tab_scaling_policy, name_space)
				a_tab.force_first (l_tab_scaling_policy_xml)

				create l_scaling_policy.make (l_tab_scaling_policy_xml, xml_constants.scaling_policy, name_space)
				l_tab_scaling_policy_xml.put_last (l_scaling_policy)

				create l_ideal_sizes.make (l_scaling_policy, xml_constants.scaling_policy_ideal_sizes, name_space)
				l_scaling_policy.put_last (l_ideal_sizes)

				from
					l_ideal_sizes_list.start
				until
					l_ideal_sizes_list.after
				loop
					create l_scale.make (l_ideal_sizes, xml_constants.scale, name_space)
					l_ideal_sizes.put_last (l_scale)

					l_scale.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.group, name_space, l_ideal_sizes_list.item.a_group)
					l_scale.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.size, name_space, l_ideal_sizes_list.item.a_size)

					l_ideal_sizes_list.forth
				end

				from
					l_scale_list.start
				until
					l_scale_list.after
				loop
					create l_scale.make (l_scaling_policy, xml_constants.scale, name_space)
					l_scaling_policy.put_last (l_scale)

					l_scale.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.group, name_space, l_scale_list.item.a_group)
					l_scale.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.size, name_space, l_scale_list.item.a_size)

					l_scale_list.forth
				end
			end
		end

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

				-- Saving applicaition menu node
				if a_vision_tree.count >= 2 then
					from
						a_vision_tree.go_i_th (2)
					until
						a_vision_tree.after
					loop
						save_application_menu_node (a_vision_tree.item)
						save_context_popup_node (a_vision_tree.item)
						save_help_button_node (a_vision_tree.item)
						save_quick_access_toolbar_node (a_vision_tree.item)

						a_vision_tree.forth
					end

				end
			end
		end

	save_help_button_node (a_tree_node: EV_TREE_NODE)
			-- Save help button node if possible
		require
			not_void: a_tree_node /= Void
		local
			l_xml_item, l_last_parent: XML_ELEMENT
			l_attribute: XML_ATTRIBUTE
		do
			if attached {EV_TREE_ITEM} a_tree_node as l_tree_item_menu and then
					l_tree_item_menu.text.same_string (xml_constants.ribbon_helpbutton) then

				-- Add context popup xml node
				if attached xml_node_by_name (xml_constants.ribbon) as l_ribbon then
					create l_xml_item.make (l_ribbon, xml_constants.ribbon_helpbutton, name_space)
					l_ribbon.put_last (l_xml_item)
					l_last_parent := l_xml_item

					create l_xml_item.make (l_last_parent, xml_constants.helpbutton, name_space)
					l_last_parent.put_last (l_xml_item)

					if attached {ER_TREE_NODE_DATA} a_tree_node.data as l_tree_node_data then
						add_xml_command_node (l_tree_node_data)

						if attached l_tree_node_data.command_name as l_command_name then
							create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name, name_space, l_command_name, l_xml_item)
							l_xml_item.put_last (l_attribute)
						else
							check not_possible: False end
						end
					else
						check not_possible: False end
					end

				else
					check not_possible: False end
				end
			end
		end

	save_quick_access_toolbar_node (a_tree_node: EV_TREE_NODE)
			-- Save quick access toolbar node if possible
		require
			not_void: a_tree_node /= Void
		local
			l_xml_item, l_last_parent: XML_ELEMENT
			l_attribute: XML_ATTRIBUTE
		do
			if attached {EV_TREE_ITEM} a_tree_node as l_tree_item_menu and then
					l_tree_item_menu.text.same_string (xml_constants.ribbon_quick_access_toolbar) then

				-- Add context popup xml node
				if attached xml_node_by_name (xml_constants.ribbon) as l_ribbon then
					create l_xml_item.make (l_ribbon, xml_constants.ribbon_quick_access_toolbar, name_space)
					l_ribbon.put_last (l_xml_item)
					l_last_parent := l_xml_item

					create l_xml_item.make (l_last_parent, xml_constants.quick_access_toolbar, name_space)
					l_last_parent.put_last (l_xml_item)

					if attached {ER_TREE_NODE_DATA} a_tree_node.data as l_tree_node_data then
						add_xml_command_node (l_tree_node_data)

						if attached l_tree_node_data.command_name as l_command_name then
							create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name, name_space, l_command_name, l_xml_item)
							l_xml_item.put_last (l_attribute)
						else
							check not_possible: False end
						end
					else
						check not_possible: False end
					end

					-- Add default buttons
					add_quick_access_toolbar_application_defaults (l_xml_item, a_tree_node)
				else
					check not_possible: False end
				end
			end
		end

	add_quick_access_toolbar_application_defaults (a_quick_access_toolbar: XML_ELEMENT; a_tree_node: EV_TREE_NODE)
			-- Add default buttons for quick access toolbar
		require
			valid: attached a_quick_access_toolbar as l_toolbar and then l_toolbar.name.same_string ({ER_XML_CONSTANTS}.quick_access_toolbar)
			not_void: a_tree_node /= Void
		local
			l_xml_item: XML_ELEMENT
		do
			create l_xml_item.make (a_quick_access_toolbar, xml_constants.quick_access_toolbar_application_defaults, name_space)
			a_quick_access_toolbar.put_last (l_xml_item)

			from
				a_tree_node.start
			until
				a_tree_node.after
			loop
				add_xml_button_node (l_xml_item, a_tree_node.item, true)

				a_tree_node.forth
			end

			-- FIXME: need iteration again to add attributes like "ApplicationDefaults.IsChecked"
		end

	save_context_popup_node (a_tree_node: EV_TREE_NODE)
			-- Save context popup node if possible
		require
			not_void: a_tree_node /= Void
		local
			l_xml_item, l_last_parent, l_last_parent_2: XML_ELEMENT
			l_data_list: ARRAYED_LIST [ER_TREE_NODE_DATA]
		do
			if attached {EV_TREE_ITEM} a_tree_node as l_tree_item_menu and then
					l_tree_item_menu.text.same_string (xml_constants.context_popup) then

				-- Add context popup xml node
				if attached xml_node_by_name (xml_constants.application_views) as l_ribbon_application_views then
					create l_xml_item.make (l_ribbon_application_views, xml_constants.context_popup, name_space)
					l_ribbon_application_views.put_last (l_xml_item)
					l_last_parent := l_xml_item
					from
						create l_data_list.make (10)
						a_tree_node.start
					until
						a_tree_node.after
					loop
						if attached {EV_TREE_ITEM} a_tree_node.item as l_item then
							check l_item.text.same_string (xml_constants.context_popup_context_menus) or else
								l_item.text.same_string (xml_constants.context_popup_mini_toolbars) end

							create l_xml_item.make (l_last_parent, l_item.text, name_space)
							l_last_parent.put_last (l_xml_item)
							l_last_parent_2 := l_xml_item

							from
								l_item.start
							until
								l_item.after
							loop
								save_context_menu_or_mini_toolbar_node (l_item.item, l_last_parent_2, l_data_list)

								l_item.forth
							end
						end
						a_tree_node.forth
					end

					save_context_maps (l_last_parent, l_data_list)
				else
					check not_possible: False end
				end
			end
		end

	save_context_maps (a_parent: XML_ELEMENT; a_data_list: ARRAYED_LIST [ER_TREE_NODE_DATA])
			-- Save context maps
		require
			not_void: a_parent /= Void
			not_void: a_data_list /= Void
		local
			l_xml_item, l_child: XML_ELEMENT
			l_attribute: XML_ATTRIBUTE
		do
			create l_xml_item.make (a_parent, {ER_XML_CONSTANTS}.context_popup_context_maps, name_space)
			a_parent.put_last (l_xml_item)

			from
				a_data_list.start
			until
				a_data_list.after
			loop
				create l_child.make (l_xml_item, {ER_XML_CONSTANTS}.context_map, name_space)
				l_xml_item.put_last (l_child)

				if attached a_data_list.item.command_name as l_command_name then
					create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name, name_space, l_command_name, l_child)
					l_child.put_last (l_attribute)

					add_xml_command_node (a_data_list.item)

					if attached {ER_TREE_NODE_MINI_TOOLBAR_DATA} a_data_list.item as l_mini_toolbar_data then
						create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.mini_toolbar, name_space, l_command_name, l_child)
						l_child.put_last (l_attribute)
					elseif attached {ER_TREE_NODE_CONTEXT_MENU_DATA} a_data_list.item as l_context_menu_data then
						create l_attribute.make ({ER_XML_ATTRIBUTE_CONSTANTS}.context_menu, name_space, l_command_name, l_child)
						l_child.put_last (l_attribute)
					else
						check False end
					end
				else
					check False end
				end
				a_data_list.forth
			end
		end

	save_context_menu_or_mini_toolbar_node (a_context_menu_or_mini_toolbar: EV_TREE_NODE; a_parent: XML_ELEMENT; a_data_list: ARRAYED_LIST [ER_TREE_NODE_DATA])
			-- Save context menu or mini toolbar node
		require
			not_void: a_context_menu_or_mini_toolbar /= Void
			valid: a_context_menu_or_mini_toolbar.text.same_string (xml_constants.context_menu) or else
				a_context_menu_or_mini_toolbar.text.same_string (xml_constants.mini_toolbar)
		local
			l_xml_item: XML_ELEMENT
			l_name: XML_ATTRIBUTE
		do
			create l_xml_item.make (a_parent, a_context_menu_or_mini_toolbar.text, name_space)
			a_parent.put_last (l_xml_item)

			-- Add mini toolbar/context menu name
			if attached {ER_TREE_NODE_DATA} a_context_menu_or_mini_toolbar.data as l_data then
				a_data_list.extend (l_data)
				-- FIXME: use command name for mini tool bar name?
				if attached l_data.command_name as l_command_name then
					create l_name.make ({ER_XML_ATTRIBUTE_CONSTANTS}.name, name_space, l_command_name, l_xml_item)
					l_xml_item.put_last (l_name)

				else
					check not_possible: False end
				end

			else
				check not_possible: False end
			end

			from
				a_context_menu_or_mini_toolbar.start
			until
				a_context_menu_or_mini_toolbar.after
			loop
				check a_context_menu_or_mini_toolbar.item.text.same_string (xml_constants.menu_group) end
				-- Add menu group now
				if attached {EV_TREE_ITEM} a_context_menu_or_mini_toolbar.item as l_menu_group then
					add_xml_menu_group_node (l_menu_group, l_xml_item)
				else
					check not_possible: False end
				end

				a_context_menu_or_mini_toolbar.forth
			end

		end

	save_application_menu_node (a_tree_node: EV_TREE_NODE)
			-- Save application menu node if possible
		require
			not_void: a_tree_node /= Void
		do
			if attached {EV_TREE_ITEM} a_tree_node as l_tree_item_menu and then
					l_tree_item_menu.text.same_string (xml_constants.ribbon_application_menu) then

				-- Add recent items xml node
				-- Only save one recent items node, otherwise uicc compiler error
				-- It means, all generated ribbon windows have to share one recent items CommandName
				if is_first_ribbon_application_menu then
					add_xml_recent_items_node (l_tree_item_menu)
				end

				-- Add menu group xml node
				from
					l_tree_item_menu.start
				until
					l_tree_item_menu.after
				loop
					if attached {EV_TREE_ITEM} l_tree_item_menu.item as l_tree_menu_group_item then
						check l_tree_menu_group_item.text.same_string (xml_constants.menu_group) end
						add_xml_menu_group_node (l_tree_menu_group_item, xml_node_by_name (xml_constants.application_menu))

					end

					l_tree_item_menu.forth
				end
			end
		end

	is_first_ribbon_application_menu: BOOLEAN
			-- Is first ribbon application menu?
		local
			l_application_menu: detachable XML_ELEMENT
		do
			l_application_menu := xml_node_by_name (xml_constants.application_menu_recent_items)
			Result := l_application_menu = Void
		end

	add_xml_recent_items_node (a_tree_item: EV_TREE_ITEM)
			-- Add XML recent items node
		require
			not_void: a_tree_item /= Void
			valid: a_tree_item.text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu)
		local
			l_application_menu_recent_items, l_recent_items: XML_ELEMENT
		do
			if attached xml_node_by_name (xml_constants.application_menu) as l_ribbon_application_menu_node then
				create l_application_menu_recent_items.make (l_ribbon_application_menu_node, xml_constants.application_menu_recent_items, name_space)
				l_ribbon_application_menu_node.put_last (l_application_menu_recent_items)

				create l_recent_items.make (l_application_menu_recent_items, xml_constants.recent_items, name_space)
				l_application_menu_recent_items.put_last (l_recent_items)

				if attached {ER_TREE_NODE_APPLICATION_MENU_DATA} a_tree_item.data as l_data then
					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						-- FIXME: Use application menu name for recent items command name?
						l_recent_items.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name, name_space, l_command_name)
						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
					if l_data.enable_pinning then
						l_recent_items.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.enable_pinning, name_space, "true")
					else
						l_recent_items.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.enable_pinning, name_space, "false")
					end

					l_recent_items.add_attribute ({ER_XML_ATTRIBUTE_CONSTANTS}.max_count, name_space, l_data.max_count.out)
				end
			end
		end

	add_xml_menu_group_node (a_tree_item: EV_TREE_ITEM; a_parent_xml: detachable XML_ELEMENT)
			-- Add XML menu group node
		require
			not_void: a_tree_item /= Void
			valid: a_tree_item.text.same_string (xml_constants.menu_group)
		local
			l_menu_group_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached a_parent_xml as l_ribbon_application_menu_node then
				create l_menu_group_node.make (l_ribbon_application_menu_node, xml_constants.menu_group, name_space)
				l_ribbon_application_menu_node.put_last (l_menu_group_node)

				if attached {ER_TREE_NODE_MENU_GROUP_DATA} a_tree_item.data as l_data then
					create l_constants
					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_menu_group_node.add_attribute (l_constants.command_name, name_space, l_command_name)
						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
				end

				from
					a_tree_item.start
				until
					a_tree_item.after
				loop
					if a_tree_item.item.text.same_string ({ER_XML_CONSTANTS}.button) then
						add_xml_button_node (l_menu_group_node, a_tree_item.item, true)
					elseif a_tree_item.item.text.same_string ({ER_XML_CONSTANTS}.split_button) then
						add_xml_split_button_node (l_menu_group_node, a_tree_item.item, true)
					elseif a_tree_item.item.text.same_string ({ER_XML_CONSTANTS}.drop_down_button) then
						add_xml_drop_down_button_node (l_menu_group_node, a_tree_item.item)
					else
						check not_possible: False end
					end

					a_tree_item.forth
				end
			else
				check False end
			end
		end

	add_xml_drop_down_button_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add dropdown button XML nodes
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.menu_group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.drop_down_button) end

				create l_button_node.make (a_group_node, xml_constants.drop_down_button, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_DROP_DOWN_BUTTON_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)
						if application_mode /= 0 then
							l_button_node.add_attribute (l_constants.application_mode, name_space, application_mode.out)
						end
						-- Add coresspond command xml node
						add_xml_command_node (l_data)

						-- We can adding one more level <MenuGroup Class='MajorItems'> here--

						--***  Add sub item nodes for split button ***
						from
							a_button_tree_node.start
						until
							a_button_tree_node.after
						loop
							add_xml_button_node (l_button_node, a_button_tree_node.item, False)

							a_button_tree_node.forth
						end
					end
				end
			end
		end

	add_xml_tab_node (a_tree_item: EV_TREE_ITEM)
			-- Add tab XML node
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

				save_scaling_policy (a_tree_item, l_tab_node)
			else
				check False end
			end
		end

	add_xml_group_node (a_parent_tab: XML_ELEMENT; a_group_tree_node: EV_TREE_NODE)
			-- Add group XML node
		require
			not_void: a_parent_tab /= Void
			valid: a_parent_tab.name.same_string (xml_constants.tab)
		local
			l_group_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
			l_xml_constants: ER_XML_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_group_tree_node as l_item and then
				 l_item.text.same_string (xml_constants.group) then

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
						add_xml_button_node (l_group_node, a_group_tree_node.item, False)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.toggle_button) then
						add_xml_toggle_button_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.check_box) then
						add_xml_checkbox_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.spinner) then
						add_xml_spinner_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.combo_box) then
						add_xml_combo_box_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.split_button) then
						add_xml_split_button_node (l_group_node, a_group_tree_node.item, False)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.drop_down_gallery) then
						add_xml_drop_down_gallery_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.drop_down_color_picker) then
						add_xml_drop_down_color_picker_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.font_control) then
						add_xml_font_control_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.in_ribbon_gallery) then
						add_xml_in_ribbon_gallery_node (l_group_node, a_group_tree_node.item)
					elseif a_group_tree_node.item.text.same_string (l_xml_constants.split_button_gallery) then
						add_xml_split_button_gallery_node (l_group_node, a_group_tree_node.item)
					else
						check not_implemented: False end
					end

					a_group_tree_node.forth
				end
			end
		end

	add_xml_button_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE; a_is_menu_button: BOOLEAN)
			-- Add button XML node
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group) or else
					a_group_node.name.same_string (xml_constants.split_button) or else
					a_group_node.name.same_string (xml_constants.menu_group) or else
					a_group_node.name.same_string (xml_constants.drop_down_button) or else
					a_group_node.name.same_string (xml_constants.quick_access_toolbar_application_defaults)

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

						if a_is_menu_button and then application_mode /= 0 then
							l_button_node.add_attribute (l_constants.application_mode, name_space, application_mode.out)
						end

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
				end
			end
		end

	add_xml_toggle_button_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add toggle button XML node
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.toggle_button) end

				create l_button_node.make (a_group_node, xml_constants.toggle_button, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_TOGGLE_BUTTON_DATA} a_button_tree_node.data as l_data then
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

	add_xml_spinner_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add spinner XML node
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.spinner) end

				create l_button_node.make (a_group_node, xml_constants.spinner, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_SPINNER_DATA} a_button_tree_node.data as l_data then
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

	add_xml_combo_box_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add combo box XML node
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.combo_box) end

				create l_button_node.make (a_group_node, xml_constants.combo_box, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_COMBO_BOX_DATA} a_button_tree_node.data as l_data then
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

	add_xml_in_ribbon_gallery_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add in-ribbon gallery XML node
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.in_ribbon_gallery) end

				create l_button_node.make (a_group_node, xml_constants.in_ribbon_gallery, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_IN_RIBBON_GALLERY_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end

					l_button_node.add_attribute (l_constants.type, name_space, "Items")

					-- Add menu layout
					add_xml_menu_layout_for_in_ribbon_gallery (l_button_node, l_data)
				end
			end
		end

	add_xml_menu_layout_for_in_ribbon_gallery (a_gallery_node: XML_ELEMENT; a_data: ER_TREE_NODE_IN_RIBBON_GALLERY_DATA)
			-- Add meuu layout XML nodes for in-ribbon gallery
		require
			not_void: a_gallery_node /= Void
			valid: a_gallery_node.name.same_string (xml_constants.in_ribbon_gallery)
			not_void: a_data /= Void
		local
			l_attribute: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_attribute
			a_gallery_node.add_attribute (l_attribute.max_rows, name_space, a_data.max_rows.out)
			a_gallery_node.add_attribute (l_attribute.max_columns, name_space, a_data.max_columns.out)
		end

	add_xml_split_button_gallery_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add split button gallery XML node
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.split_button_gallery) end

				create l_button_node.make (a_group_node, xml_constants.split_button_gallery, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end

					l_button_node.add_attribute (l_constants.type, name_space, "Items")

					-- Add menu layout
					add_xml_menu_layout_for_split_button_gallery (l_button_node, l_data)
				end
			end
		end

	add_xml_menu_layout_for_split_button_gallery (a_gallery_node: XML_ELEMENT; a_data: ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA)
			-- Add menu layout XML nodes for split button gallery
		require
			not_void: a_gallery_node /= Void
			valid: a_gallery_node.name.same_string (xml_constants.split_button_gallery)
			not_void: a_data /= Void
		local
			l_xml_node: XML_ELEMENT
			l_flow_menu_layout: XML_ELEMENT
			l_attribute: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_xml_node.make (a_gallery_node, xml_constants.split_button_gallery_menu_layout, name_space)
			a_gallery_node.put_last (l_xml_node)

			create l_flow_menu_layout.make (l_xml_node, xml_constants.flow_menu_layout, name_space)
			l_xml_node.put_last (l_flow_menu_layout)

			create l_attribute
			l_flow_menu_layout.add_attribute (l_attribute.rows, name_space, a_data.rows.out)
			l_flow_menu_layout.add_attribute (l_attribute.columns, name_space, a_data.columns.out)
			l_flow_menu_layout.add_attribute (l_attribute.gripper, name_space, "None") -- FIXME: NONE for test
		end

	add_xml_font_control_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add Font Control XML nodes
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.font_control) end

				create l_button_node.make (a_group_node, xml_constants.font_control, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_FONT_CONTROL_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
					if attached l_data.font_type as l_font_type and then not l_font_type.is_empty then
						l_button_node.add_attribute (l_constants.font_type, name_space, l_font_type)
					end
				end
			end
		end

	add_xml_drop_down_color_picker_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add dropdown color picker XML nodes
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.drop_down_color_picker) end

				create l_button_node.make (a_group_node, xml_constants.drop_down_color_picker, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_DROP_DOWN_COLOR_PICKER_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end
					if attached l_data.color_template as l_color_template and then not l_color_template.is_empty then
						l_button_node.add_attribute (l_constants.color_template, name_space, l_color_template)
					end
				end
			end
		end

	add_xml_drop_down_gallery_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add dropdown gallery XML nodes
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.drop_down_gallery) end

				create l_button_node.make (a_group_node, xml_constants.drop_down_gallery, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_DROP_DOWN_GALLERY_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
					end

					l_button_node.add_attribute (l_constants.type, name_space, "Items")

					-- Add menu layout
					add_xml_menu_layout_for_drop_down_gallery (l_button_node, l_data)
				end
			end
		end

	add_xml_menu_layout_for_drop_down_gallery (a_gallery_node: XML_ELEMENT; a_data: ER_TREE_NODE_DROP_DOWN_GALLERY_DATA)
			-- Add menu layout XML nodes for dropdown gallery
		require
			not_void: a_gallery_node /= Void
			valid: a_gallery_node.name.same_string (xml_constants.drop_down_gallery)
			not_void: a_data /= Void
		local
			l_xml_node: XML_ELEMENT
			l_flow_menu_layout: XML_ELEMENT
			l_attribute: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_xml_node.make (a_gallery_node, xml_constants.drop_down_gallery_menu_layout, name_space)
			a_gallery_node.put_last (l_xml_node)

			create l_flow_menu_layout.make (l_xml_node, xml_constants.flow_menu_layout, name_space)
			l_xml_node.put_last (l_flow_menu_layout)

			create l_attribute
			l_flow_menu_layout.add_attribute (l_attribute.rows, name_space, a_data.rows.out)
			l_flow_menu_layout.add_attribute (l_attribute.columns, name_space, a_data.columns.out)
			l_flow_menu_layout.add_attribute (l_attribute.gripper, name_space, "None") -- FIXME: NONE for test
		end

	add_xml_split_button_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE; a_is_menu_button: BOOLEAN)
			-- Add split button XML nodes
		require
			not_void: a_group_node /= Void
			valid: a_group_node.name.same_string (xml_constants.group) or else a_group_node.name.same_string (xml_constants.menu_group)
		local
			l_button_node: XML_ELEMENT
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			if attached {EV_TREE_ITEM} a_button_tree_node as l_item then
				check l_item.text.same_string (xml_constants.split_button) end

				create l_button_node.make (a_group_node, xml_constants.split_button, name_space)
				a_group_node.put_last (l_button_node)

				if attached {ER_TREE_NODE_SPLIT_BUTTON_DATA} a_button_tree_node.data as l_data then
					create l_constants

					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_button_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)

						--***  Add sub item nodes for split button ***
						from
							a_button_tree_node.start
						until
							a_button_tree_node.after
						loop
							add_xml_button_node (l_button_node, a_button_tree_node.item, a_is_menu_button)

							a_button_tree_node.forth
						end
					end
				end
			end
		end

	add_xml_checkbox_node (a_group_node: XML_ELEMENT; a_button_tree_node: EV_TREE_NODE)
			-- Add checkbox XML nodes
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
			-- Add command XML nodes
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
			-- XML constants

	xml_document: XML_DOCUMENT
			-- XML document

	name_space: XML_NAMESPACE
			-- Default XML namespace

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
			-- Find a tree node which name is `a_tree_node_name' recursively
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
			valid: xml_constants.is_valid (a_xml_node_name)
		do
			if attached {XML_ELEMENT} recursive_xml_node_by_name (a_xml_node_name, root_xml_element) as l_result then
				Result := l_result
			end
		end

	recursive_xml_node_by_name (a_xml_node_name: STRING; a_xml_element: XML_NODE): detachable XML_NODE
			-- Find a xml node by its node name
		require
			not_void: a_xml_node_name /= Void
			valid: xml_constants.is_valid (a_xml_node_name)
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
			-- Root XML element

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
