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
			create widget
			create content.make_with_widget (widget, "ER_LAYOUT_CONSTRUCTOR")

			shared_singleton.layout_constructor_list.extend (Current)

			build_ui
			build_docking_content

			widget.drop_actions.extend (agent on_root_tree_drop)
			widget.drop_actions.set_veto_pebble_function (agent on_veto_root_tree_drop)

			if attached shared_singleton.project_info_cell.item as l_project_info then
				l_project_info.set_ribbon_window_count (shared_singleton.layout_constructor_list.count)
			end
		end

	build_docking_content
			--
		local
			l_count: INTEGER
		do
			l_count := shared_singleton.layout_constructor_list.count

			content.set_long_title ("Layout Constructor " + l_count.out)
			content.set_short_title ("Layout Constructor " + l_count.out)
			content.set_type ({SD_ENUMERATION}.editor)
		end

	build_ui
			--
		local
			l_tree_item_app: EV_TREE_ITEM
		do
			widget.key_press_actions.extend (agent on_tree_key_press)

			-- Ribbon tabs
			l_tree_item_app := tree_item_factory_method (constants.ribbon_tabs)

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

			if widget.count >= 1 then
				from
					widget.start
				until
					widget.after
				loop
					recursive_all_items_with (a_text, widget.item, Result)
					widget.forth
				end
			end
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

	all_items_with_command_name (a_command_name: STRING): ARRAYED_LIST [EV_TREE_NODE]
			-- All tree items which data's command name equal `a_command_name'
		do
			create Result.make (5)
--			check widget.count >= 1 end
			from
				widget.start
			until
				widget.after
			loop
				recrusive_all_items_with_command_name (a_command_name, widget.item, Result)
				widget.forth
			end
		end

	all_items_with_command_name_in_all_constructors (a_text: STRING): ARRAYED_LIST [EV_TREE_NODE]
			-- Find in all layout constructors with command name `a_text'
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
				Result.merge_right (l_list.item.all_items_with_command_name (a_text))
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
						l_stone_child.same_string (constants.drop_down_gallery) or else
						l_stone_child.same_string (constants.in_ribbon_gallery) or else
						l_stone_child.same_string (constants.split_button_gallery) or else
						l_stone_child.same_string (constants.drop_down_color_picker) or else
						l_stone_child.same_string (constants.font_control)
				elseif a_parent_type.same_string (constants.split_button) then
					Result := l_stone_child.same_string (constants.button)
				elseif a_parent_type.same_string (constants.ribbon_application_menu) then
					Result := l_stone_child.same_string (constants.menu_group)
				elseif a_parent_type.same_string (constants.menu_group) then
					Result := l_stone_child.same_string (constants.button) or else
						l_stone_child.same_string (constants.split_button) or else
						-- FIXME: Parent's parent must be ApplicationMenu here
						l_stone_child.same_string (constants.drop_down_button)
				elseif a_parent_type.same_string (constants.context_popup) then
					Result := l_stone_child.same_string (constants.context_popup_context_menus) or else
						l_stone_child.same_string (constants.context_popup_mini_toolbars)
				elseif a_parent_type.same_string (constants.context_popup_context_menus) then
					Result := l_stone_child.same_string (constants.context_menu)
				elseif a_parent_type.same_string (constants.context_popup_mini_toolbars) then
					Result := l_stone_child.same_string (constants.mini_toolbar)
				elseif a_parent_type.same_string (constants.mini_toolbar) then
					Result := l_stone_child.same_string (constants.menu_group)
				elseif a_parent_type.same_string (constants.context_menu) then
					Result := l_stone_child.same_string (constants.menu_group)
				elseif a_parent_type.same_string (constants.drop_down_button) then
					Result := l_stone_child.same_string (constants.button)
				elseif a_parent_type.same_string (constants.ribbon_quick_access_toolbar) then
					Result := l_stone_child.same_string (constants.button)	-- FIXME: It can be toggle button and check box also				
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

	on_root_tree_drop (a_pebble: ANY)
			--
		local
			l_tree_item: EV_TREE_ITEM
		do
			if attached {STRING} a_pebble as l_item then
				check l_item.same_string (constants.ribbon_application_menu) or else
					l_item.same_string (constants.context_popup) or else
					l_item.same_string (constants.ribbon_quick_access_toolbar) or else
					l_item.same_string (constants.ribbon_helpbutton) end
				l_tree_item := tree_item_factory_method (l_item)
				widget.extend (l_tree_item)
			end
		end

	on_veto_root_tree_drop (a_pebble: ANY): BOOLEAN
			--
		do
			if attached {STRING} a_pebble as l_item then
				if l_item.same_string (constants.ribbon_application_menu) or else
					l_item.same_string (constants.context_popup) or else
					l_item.same_string (constants.ribbon_quick_access_toolbar) or else
					l_item.same_string (constants.ribbon_helpbutton) then
					Result := True
				end
			end
		end

feature -- Persistance

	save_tree
			-- Save to Microsoft Ribbon makrup XML directly
			-- Save different Window's Ribbon to different xml markup files
		local
			l_printer: XML_NODE_PRINTER
			l_output_stream: ER_XML_OUTPUT_STREAM
			l_document: XML_DOCUMENT
			l_index: INTEGER
			l_found_and_saved: BOOLEAN
			l_max_count: INTEGER
		do
			if attached shared_singleton.project_info_cell.item as l_project_info then
				from
					l_index := 1
					l_max_count := l_project_info.ribbon_window_count
				until
					l_index > l_max_count
				loop
					l_found_and_saved := vision_xml_translator.save_xml_nodes_for_one_layout_constructors (l_index)
					check l_found_and_saved end
					l_document := vision_xml_translator.xml_document

					create l_printer.make

					create l_output_stream.make (l_index)
					l_printer.set_output (l_output_stream)

					l_document.process (l_printer)

					l_output_stream.close

					l_index := l_index + 1
				end
			end
		end

	load_tree (a_ribbon_window_count: INTEGER)
			--
		local
			l_file: RAW_FILE
			l_index: INTEGER
			l_constants: ER_MISC_CONSTANTS
			l_stop: BOOLEAN
		do
			from
				prepare_layout_constructors (a_ribbon_window_count)
				create l_constants
				l_index := 1
			until
				l_index > a_ribbon_window_count or l_stop
			loop
				if attached l_constants.xml_full_file_name (l_index) as l_file_name then
					create l_file.make (l_file_name)
					if l_file.exists then
						load_tree_imp (l_index)
					else
						l_stop := True
					end
				else
					l_stop := True
				end

				l_index := l_index + 1
			end

		end

feature {NONE} -- Implementation

	prepare_layout_constructors (a_ribbon_window_count: INTEGER)
			--
		local
			l_index: INTEGER
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			from
				l_index := 1
			until
				l_index > a_ribbon_window_count
			loop
				if shared_singleton.layout_constructor_list.valid_index (l_index) then
					l_layout_constructor := shared_singleton.layout_constructor_list.i_th (l_index)
				else
					create l_layout_constructor.make
					if attached shared_singleton.main_window_cell.item as l_main_window then
						if attached l_main_window.docking_manager as l_docking_manager then
							l_layout_constructor.attach_to_docking_manager (l_docking_manager)
						end
					end
				end

				l_layout_constructor.widget.wipe_out

				l_index := l_index + 1
			end
		end

	load_tree_imp (a_index: INTEGER)
			--
		require
			valid: a_index >= 1
		local
			l_manager: ER_XML_TREE_MANAGER
			l_vision2_visitor: ER_LOAD_VISION_TREE_VISITOR
			l_command_updater: ER_UPDATE_COMMAND_VISITOR
			l_separate_tab_visitor: ER_SEPARATE_WINDOW_TAB_VISITOR
			l_drop_down_gallery_visitor: ER_DROP_DOWN_GALLERY_INFO_VISITOR
			l_update_application_menu: ER_UPDATE_APPLICATION_MENU_INFO_VISITOR
			l_split_button_gallery_visitor: ER_SPLIT_BUTTON_GALLERY_INFO_VISITOR
			l_update_context_popups_visitor: ER_UPDATE_CONTEXT_POPUP_VISITOR
			l_load_help_button_visitor: ER_LOAD_HELP_BUTTON_VISITOR
			l_load_quick_access_toolbar_visitor: ER_LOAD_QUICK_ACCESS_TOOLBAR_VISITOR
			l_size_definition_visitor: ER_SIZE_DEFINITION_VISITOR
		do
			l_manager := shared_singleton.xml_tree_manager.item
			l_manager.load_tree (a_index)

			if attached l_manager.xml_root as l_root then
				create l_vision2_visitor
				l_root.accept (l_vision2_visitor, a_index)

				create l_separate_tab_visitor.make
				l_root.accept (l_separate_tab_visitor, a_index)
				create l_drop_down_gallery_visitor
				l_root.accept (l_drop_down_gallery_visitor, a_index)
				create l_split_button_gallery_visitor
				l_root.accept (l_split_button_gallery_visitor, a_index)
				create l_update_application_menu
				l_root.accept (l_update_application_menu, a_index)

				create l_update_context_popups_visitor
				l_root.accept (l_update_context_popups_visitor, a_index)

				create l_load_help_button_visitor
				l_root.accept (l_load_help_button_visitor, a_index)

				create l_load_quick_access_toolbar_visitor
				l_root.accept (l_load_quick_access_toolbar_visitor, a_index)

				create l_command_updater
				l_root.accept (l_command_updater, a_index)

				create l_size_definition_visitor
				l_root.accept (l_size_definition_visitor, a_index)
			else
				check False end
			end
		end

	recursive_all_items_with (a_text: STRING; a_tree_node: EV_TREE_NODE; a_list: ARRAYED_LIST [EV_TREE_NODE])
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
				recursive_all_items_with (a_text, a_tree_node.item, a_list)

				a_tree_node.forth
			end
		end

	recrusive_all_items_with_command_name (a_text: STRING; a_tree_node: EV_TREE_NODE; a_list: ARRAYED_LIST [EV_TREE_NODE])
			-- Recursive find tree node which command anme is same as `a_text'
		require
			not_void: a_text /= Void
			not_void: a_tree_node /= Void
			not_void: a_list /= Void
		do
			if attached {ER_TREE_NODE_DATA} a_tree_node.data as l_data then
				if attached l_data.command_name as l_command_name and then l_command_name.same_string (a_text) then
					a_list.extend (a_tree_node)
				end
			end
			from
				a_tree_node.start
			until
				a_tree_node.after
			loop
				recrusive_all_items_with_command_name (a_text, a_tree_node.item, a_list)

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
