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

	add_xml_nodes_by_vision_tree (a_vision_tree: EV_TREE)
			-- Add xml nodes by querying info from `a_vision_tree'
		require
			not_void: a_vision_tree /= Void
			valid: a_vision_tree.i_th (1).text.same_string (xml_constants.ribbon_tabs)
		local

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
					-- Add xml attribute
					if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
						create l_constants
						l_tab_node.add_attribute (l_constants.command_name, name_space, l_command_name)

						-- Add coresspond command xml node
						add_xml_command_node (l_data)
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
		do
			if attached {EV_TREE_ITEM} a_group_tree_node as l_item then
				check l_item.text.same_string_general (xml_constants.group) end

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

					if attached l_data.size_definition as l_size_definition and then not l_size_definition.is_empty then
						l_group_node.add_attribute (l_constants.size_definition, name_space, l_size_definition)
					end
				end

				from
					a_group_tree_node.start
				until
					a_group_tree_node.after
				loop
					add_xml_button_node (l_group_node, a_group_tree_node.item)

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
--				check l_item.text.same_string_general (xml_constants.button) end --FIXME: checkbox, combobox, controlgroup should be all ok here

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

				create l_item_text.make (l_sub_item, l_image)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
			end

			if attached a_tree_node_data.small_image as l_image and then not l_image.is_empty then
				create l_item.make (a_parent_node, l_constants.command_small_images, name_space)
				a_parent_node.put_last (l_item)

				create l_sub_item.make (l_item, l_constants.image, name_space)
				l_item.put_last (l_sub_item)

				create l_item_text.make (l_sub_item, l_image)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
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
