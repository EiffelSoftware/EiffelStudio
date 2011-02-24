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
			create vision_xml_translator.make

			build_ui
			build_docking_content
		end

	build_docking_content
			--
		local
			l_count: INTEGER
		do
			l_count := shared_singleton.layout_constructor_list.count
			create content.make_with_widget (widget, "ER_LAYOUT_CONSTRUCTOR")
			content.set_long_title ("Layout Constructor " + l_count.out)
			content.set_short_title ("Layout Constructor " + l_count.out)
			content.set_type ({SD_ENUMERATION}.editor)
		end

	build_ui
			--
		local
			l_tree_item_app: EV_TREE_ITEM
		do
			create widget
			widget.key_press_actions.extend (agent on_tree_key_press)

			create l_tree_item_app.make_with_text (constants.ribbon_tabs)
			l_tree_item_app.pointer_button_press_actions.extend (agent on_pointer_press (?, ?, ?, ?, ?, ?, ?, ?, l_tree_item_app))
			l_tree_item_app.drop_actions.set_veto_pebble_function (agent on_veto_pebble_function (?, constants.ribbon_tabs))
			l_tree_item_app.drop_actions.extend (agent on_drop (?, l_tree_item_app))
			widget.extend (l_tree_item_app)

			helper.expand_all (widget)
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			--
		require
			not_void: a_docking_manager /= Void
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_last_editor: detachable SD_CONTENT
			l_count: INTEGER
		do
			from
				l_contents := a_docking_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				if l_contents.item.type = {SD_ENUMERATION}.editor then
					l_count := l_count + 1
					l_last_editor := l_contents.item
				end
				l_contents.forth
			end

			a_docking_manager.contents.extend (content)

			if l_count = 0 then
				content.set_default_editor_position
			else
				check l_last_editor /= Void end
				content.set_tab_with (l_last_editor, False)
			end

		end

	expand_tree
			--
		do
			helper.expand_all (widget)
		end

feature -- Query

	widget: EV_TREE
			-- Main dockig content widget

	all_items_with (a_text: STRING): ARRAYED_LIST [EV_TREE_NODE]
			-- All tree items which text equal `a_text'
		require
			not_void: a_text /= Void
		do
			create Result.make (50)
			check widget.count = 1 end
			recrusive_all_items_with (a_text, widget.i_th (1), Result)
		end

	all_items_in_all_constructors (a_text: STRING): ARRAYED_LIST [EV_TREE_NODE]
			-- Find in all layout constructors
		require
			not_void: a_text /= Void
		local
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
		do
			from
				create Result.make (100)
				l_list := shared_singleton.layout_constructor_list
				l_list.start
			until
				l_list.after
			loop
				Result.merge_right (l_list.item.all_items_with (a_text))
				l_list.forth
			end
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
				if a_parent_type.same_string (constants.application_commands) then
					Result := l_stone_child.same_string (constants.command)
				elseif a_parent_type.same_string (constants.application_views) then
					Result := l_stone_child.same_string (constants.ribbon)
				elseif a_parent_type.same_string (constants.ribbon) then
					Result := l_stone_child.same_string (constants.ribbon_application_menu) or else
						l_stone_child.same_string (constants.ribbon_contextual_tabs) or else
						l_stone_child.same_string (constants.ribbon_helpbutton) or else
						l_stone_child.same_string (constants.ribbon_quick_access_toolbar) or else
						l_stone_child.same_string (constants.ribbon_size_definitions) or else
						l_stone_child.same_string (constants.ribbon_tabs)
				elseif a_parent_type.same_string (constants.ribbon_tabs) then
					Result := l_stone_child.same_string (constants.tab)
				elseif a_parent_type.same_string (constants.tab) then
					Result := l_stone_child.same_string (constants.group) or else
						l_stone_child.same_string (constants.tab_scaling_policy)
--				elseif a_parent_type.same_string (constants.ribbon_tabs) then
--					Result := l_stone_child.same_string (constants.tab)
--				elseif a_parent_type.same_string (constants.tab) then
--					Result := l_stone_child.same_string (constants.group) or else
--						l_stone_child.same_string (constants.tab_scaling_policy)
				elseif a_parent_type.same_string (constants.group) then
					Result := l_stone_child.same_string (constants.button) or else
						l_stone_child.same_string (constants.check_box) or else
						l_stone_child.same_string (constants.combo_box) or else
						l_stone_child.same_string (constants.control_group) or else
						l_stone_child.same_string (constants.toggle_button) or else
						l_stone_child.same_string (constants.spinner) or else
						l_stone_child.same_string (constants.split_button) or else
						l_stone_child.same_string (constants.drop_down_gallery)
				elseif a_parent_type.same_string (constants.split_button) then
					Result := l_stone_child.same_string (constants.button)
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

	on_tree_key_press (a_key: EV_KEY)
			--
		do
			if a_key.code = {EV_KEY_CONSTANTS}.Key_delete then
				if attached widget.selected_item as l_selected_node then
					if attached l_selected_node.parent as l_parent then
						l_parent.prune_all (l_selected_node)
					end
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
			vision_xml_translator.save_xml_nodes_for_all_layout_constructors
			l_document := vision_xml_translator.xml_document

			create l_printer.make

			create l_output_stream.make
			l_printer.set_output (l_output_stream)

			l_document.process (l_printer)

			l_output_stream.close
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
			if attached l_constants.xml_full_file_name as l_file_name then
				create l_factory
				l_parser := l_factory.new_parser

				create l_callback.make (widget)
				l_parser.set_callbacks (l_callback)

				l_parser.parse_from_filename (l_file_name)

				vision_xml_translator.update_vision_tree_after_load (widget)

				helper.expand_all (widget)
			else
				check should_not_happend: False end
			end
		end

feature {NONE} -- Implementation

	recrusive_all_items_with (a_text: STRING; a_tree_node: EV_TREE_NODE; a_list: ARRAYED_LIST [EV_TREE_NODE])
			-- Recursive find tree node which text is same as `a_text'
		require
			not_void: a_text /= Void
			not_void: a_tree_node /= Void
			not_void: a_list /= Void
		do
			if a_tree_node.text.same_string (a_text) then
				a_list.extend (a_tree_node)
			end
			from
				a_tree_node.start
			until
				a_tree_node.after
			loop
				recrusive_all_items_with (a_text, a_tree_node.item, a_list)

				a_tree_node.forth
			end
		end

	content: SD_CONTENT
			--

	helper: ER_HELPER
			-- Helper

	constants: ER_XML_CONSTANTS
			-- Constants	

	shared_singleton: ER_SHARED_SINGLETON
			--			

	tree_node_factory: ER_TREE_NODE_DATA_FACTORY
			--

	vision_xml_translator: ER_VISION_XML_TREE_TRANSLATOR
			--
end
