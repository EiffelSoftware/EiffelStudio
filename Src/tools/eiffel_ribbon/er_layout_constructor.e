note
	description: "Summary description for {ER_LAYOUT_CONSTRUCTOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LAYOUT_CONSTRUCTOR

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create helper
			create constants
			create shared_singleton
			create tree_node_factory.make

			build_ui
			build_docking_content
		end

	build_docking_content
			--
		do
			create content.make_with_widget (widget, "ER_LAYOUT_CONSTRUCTOR")
			content.set_long_title ("Layout Constructor")
			content.set_short_title ("Layout Constructor")
			content.set_type ({SD_ENUMERATION}.editor)
		end

	build_ui
			--
		local
			l_tree_item_app: EV_TREE_ITEM
			l_tree_item_commands, l_tree_item_view: EV_TREE_ITEM
		do
			create widget

			create l_tree_item_app.make_with_text ("Application")
			widget.extend (l_tree_item_app)

			create l_tree_item_commands.make_with_text (constants.application_commands)
			l_tree_item_commands.drop_actions.set_veto_pebble_function (agent on_veto_pebble_function (?, constants.application_commands))
			l_tree_item_commands.drop_actions.extend (agent on_drop (?, l_tree_item_commands))
			l_tree_item_app.extend (l_tree_item_commands)

			create l_tree_item_view.make_with_text ("Application.Views")
			l_tree_item_view.drop_actions.set_veto_pebble_function (agent on_veto_pebble_function (?, constants.application_views))
			l_tree_item_view.drop_actions.extend (agent on_drop (?, l_tree_item_view))
			l_tree_item_app.extend (l_tree_item_view)

			helper.expand_all (widget)
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			--
		require
			not_void: a_docking_manager /= Void
		do
			a_docking_manager.contents.extend (content)
			content.set_default_editor_position
		end

feature -- Factory

	tree_item_factory_method (a_item_text: STRING): EV_TREE_ITEM
			--
		require
			not_void: a_item_text /= Void
		do
			create Result.make_with_text (a_item_text)
			Result.pointer_button_press_actions.extend (agent on_pointer_press (?, ?, ?, ?, ?, ?, ?, ?, Result))
			Result.drop_actions.set_veto_pebble_function (agent on_veto_pebble_function (?, a_item_text))
			Result.drop_actions.extend (agent on_drop (?, Result))
			Result.set_data (tree_node_factory.tree_node_data_for (a_item_text))
		end

feature {NONE} -- Action handing

	on_drop (a_stone: ANY; a_parent: EV_TREE_ITEM)
			--
		require
			not_void: a_stone /= Void
			not_void: a_parent /= Void
		local
			l_child: EV_TREE_ITEM
		do
			if attached {STRING} a_stone as l_stone_child then
				l_child := tree_item_factory_method (l_stone_child)
				a_parent.extend (l_child)
				if a_parent.is_expandable then
					a_parent.expand
				end
			end
		end

	on_veto_pebble_function (a_stone: ANY; a_parent_type: STRING): BOOLEAN
			--
		do
			if attached {STRING} a_stone as l_stone_child then
				if a_parent_type.is_equal (constants.application_commands) then
					Result := l_stone_child.is_equal (constants.command)
				elseif a_parent_type.is_equal (constants.application_views) then
					Result := l_stone_child.is_equal (constants.ribbon)
				elseif a_parent_type.is_equal (constants.ribbon) then
					Result := l_stone_child.is_equal (constants.ribbon_application_menu) or else
						l_stone_child.is_equal (constants.ribbon_contextual_tabs) or else
						l_stone_child.is_equal (constants.ribbon_helpbutton) or else
						l_stone_child.is_equal (constants.ribbon_quick_access_toolbar) or else
						l_stone_child.is_equal (constants.ribbon_size_definitions) or else
						l_stone_child.is_equal (constants.ribbon_tabs)
				elseif a_parent_type.is_equal (constants.ribbon_tabs) then
					Result := l_stone_child.is_equal (constants.tab)
				elseif a_parent_type.is_equal (constants.tab) then
					Result := l_stone_child.is_equal (constants.group) or else
						l_stone_child.is_equal (constants.tab_scaling_policy)
--				elseif a_parent_type.is_equal (constants.ribbon_tabs) then
--					Result := l_stone_child.is_equal (constants.tab)
--				elseif a_parent_type.is_equal (constants.tab) then
--					Result := l_stone_child.is_equal (constants.group) or else
--						l_stone_child.is_equal (constants.tab_scaling_policy)
				elseif a_parent_type.is_equal (constants.group) then
					Result := l_stone_child.is_equal (constants.button) or else
						l_stone_child.is_equal (constants.check_box) or else
						l_stone_child.is_equal (constants.combo_box) or else
						l_stone_child.is_equal (constants.control_group)
				end
			end
		end

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER; l_child: EV_TREE_NODE)
			--
		do
			if attached l_child as l_type then
				if attached {ER_OBJECT_EDITOR} shared_singleton.object_editor_cell.item as l_object_editor then
					l_object_editor.update_ui_with_node (l_child)
				end
			end
		end

feature -- Persistance

	save_tree
			-- save to Microsoft Ribbon makrup XML directly
		local
			l_printer: XML_NODE_PRINTER
			l_output_stream: ER_XML_OUTPUT_STREAM
			l_document: XML_DOCUMENT
		do
			create l_document.make

			xml_from_widget (l_document)

			create l_printer.make

			create l_output_stream.make
			l_printer.set_output (l_output_stream)

			l_document.process (l_printer)

			l_output_stream.close
		end

	xml_from_widget (a_document: XML_DOCUMENT)
			--
		local
			l_tree: EV_TREE
			l_tree_node: EV_TREE_NODE
			l_name_space: XML_NAMESPACE
			l_element: XML_ELEMENT
		do
			l_tree := widget
			check l_tree.count = 1 end -- Only allow one <Application> as root node
			l_tree.start
			l_tree_node := l_tree.item
			create l_name_space.make_default
			create l_element.make_root (a_document, "Application", l_name_space)
			l_element.add_attribute ("xmlns", l_name_space, "http://schemas.microsoft.com/windows/2009/Ribbon")

			from
				l_tree_node.start
			until
				l_tree_node.after
			loop
				xml_from_widget_imp (l_element, l_name_space, l_tree_node.item)
				l_tree_node.forth
			end
		end

	xml_from_widget_imp (a_parent: XML_ELEMENT; a_name_space: XML_NAMESPACE; a_tree_node: EV_TREE_NODE)
			--
		local
			l_xml_element: XML_ELEMENT
		do
			l_xml_element := tree_node_to_xml_element (a_tree_node, a_parent, a_name_space)
			a_parent.put_last (l_xml_element)
			from
				a_tree_node.start
			until
				a_tree_node.after
			loop
				xml_from_widget_imp (l_xml_element, a_name_space, a_tree_node.item)
				a_tree_node.forth
			end
		end

	tree_node_to_xml_element (a_tree_node: EV_TREE_NODE; a_parent: XML_ELEMENT; a_name_space: XML_NAMESPACE): XML_ELEMENT
			--
		local
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_constants
			create Result.make (a_parent, a_tree_node.text, a_name_space)

			if attached {ER_TREE_NODE_COMMAND_DATA} a_tree_node.data as l_data then
				if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
					Result.add_attribute (l_constants.name, a_name_space, l_command_name)
				end
				l_data.add_sub_tree_nodes (Result, a_name_space)
			elseif attached {ER_TREE_NODE_BUTTON_DATA} a_tree_node.data as l_data then
				if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
					Result.add_attribute (l_constants.command_name, a_name_space, l_command_name)
				end
			elseif attached {ER_TREE_NODE_GROUP_DATA} a_tree_node.data as l_data then
				if attached l_data.command_name as l_command_name and then not l_command_name.is_empty then
					Result.add_attribute (l_constants.command_name, a_name_space, l_command_name)
				end
				if attached l_data.size_definition as l_size_definition and then not l_size_definition.is_empty then
					Result.add_attribute (l_constants.size_definition, a_name_space, l_size_definition)
				end
			end
		end

	load_tree
			--
		local
			l_callback: ER_XML_CALLBACKS
			l_factory: XML_LITE_PARSER_FACTORY
			l_parser: XML_LITE_PARSER
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			if attached l_constants.full_file_name as l_file_name then
				create l_factory
				l_parser := l_factory.new_parser

				create l_callback.make (widget)
				l_parser.set_callbacks (l_callback)

				l_parser.parse_from_filename (l_file_name)

				helper.expand_all (widget)
			else
				check should_not_happend: False end
			end

		end

feature {NONE} -- Implementation

	content: SD_CONTENT
			--

	widget: EV_TREE
			-- Main dockig content widget

	helper: ER_HELPER
			-- Helper

	constants: ER_XML_CONSTANTS
			-- Constants	

	shared_singleton: ER_SHARED_SINGLETON
			--			

	tree_node_factory: ER_TREE_NODE_DATA_FACTORY
			--
end
