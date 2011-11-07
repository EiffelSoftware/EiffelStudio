note
	description: "[
					EiffelRibbon Layout Constructor Tool with responsibility for creating target
					ribbon window's widget layout
					Users can pick and drop on it
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LAYOUT_CONSTRUCTOR

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create helper
			create shared_singleton
			create tree_node_factory.make

			create widget
			create content.make_with_widget (widget, "ER_LAYOUT_CONSTRUCTOR")
			content.close_request_actions.extend (agent on_close_content)
			shared_singleton.layout_constructor_list.extend (Current)

			build_ui
			build_docking_content

			widget.drop_actions.extend (agent on_root_tree_drop)
			widget.drop_actions.set_veto_pebble_function (agent on_veto_root_tree_drop)

			update_project_info_window_count
		end

	build_docking_content
			-- Build docking content
		local
			l_count: INTEGER
		do
			l_count := shared_singleton.layout_constructor_list.count

			content.set_long_title ("Layout Constructor " + l_count.out)
			content.set_short_title ("Layout Constructor " + l_count.out)
			content.set_type ({SD_ENUMERATION}.editor)
		end

	build_ui
			-- Build GUI
		local
			l_tree_item_app: EV_TREE_ITEM
		do
			widget.key_press_actions.extend (agent on_tree_key_press)

			-- Ribbon tabs
			l_tree_item_app := tree_item_factory_method ({ER_XML_CONSTANTS}.ribbon_tabs)

			widget.extend (l_tree_item_app)

			helper.expand_all (widget)
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			-- Attach to docking manager
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
			-- Expand Vision2 Tree
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
			from
				widget.start
			until
				widget.after
			loop
				recursive_all_items_with_command_name (a_command_name, widget.item, Result)
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

	is_root_pebble_valid (a_pebble: ANY) : BOOLEAN
			-- If `a_pebble' valid for root?
		require
			not_void: a_pebble /= Void
		do
			if attached {STRING} a_pebble as l_item then
				if
					l_item.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu) or else
					l_item.same_string ({ER_XML_CONSTANTS}.context_popup) or else
					l_item.same_string ({ER_XML_CONSTANTS}.ribbon_quick_access_toolbar) or else
					l_item.same_string ({ER_XML_CONSTANTS}.ribbon_helpbutton) or else
					l_item.same_string ({ER_XML_CONSTANTS}.ribbon_contextual_tabs) then
					Result := True
				end
			end
		end

feature -- Factory

	tree_item_factory_method (a_item_text: STRING): EV_TREE_ITEM
			-- Tree item factory method
		require
			not_void: a_item_text /= Void
		do
			create Result.make_with_text (a_item_text)
			Result.pointer_button_press_actions.extend (agent on_pointer_press (?, ?, ?, ?, ?, ?, ?, ?, Result))
			Result.drop_actions.set_veto_pebble_function (agent on_veto_pebble_function (?, a_item_text))
			Result.drop_actions.extend (agent on_drop (?, Result))
			Result.set_data (tree_node_factory.tree_node_data_for (a_item_text))

			-- Enable PnD within Layout Construstor
			Result.set_pebble (Result)
		end

feature {NONE} -- Action handing

	on_drop (a_stone: ANY; a_parent: EV_TREE_ITEM)
			-- Handle drop action
		require
			not_void: a_stone /= Void
			not_void: a_parent /= Void
		local
			l_child: detachable EV_TREE_ITEM
		do
			if attached {STRING} a_stone as l_string then
				l_child := tree_item_factory_method (l_string)
			elseif attached {EV_TREE_ITEM} a_stone as l_tree_item then
				if attached l_tree_item.parent as l_parent then
					l_parent.prune_all (l_tree_item)
				end
				l_child := l_tree_item
			end
			if l_child /= Void then
				a_parent.extend (l_child)
				expand_tree
			end
		end

	on_veto_pebble_function (a_stone: ANY; a_parent_type: STRING): BOOLEAN
			-- Veto pebble function
		local
			l_item_text: detachable STRING
		do
			if attached {STRING} a_stone as l_stone_child then
				l_item_text := l_stone_child
			elseif attached {EV_TREE_ITEM} a_stone as l_tree_item then
				l_item_text := l_tree_item.text
			end
			if l_item_text /= Void then
				if a_parent_type.same_string ({ER_XML_CONSTANTS}.application_commands) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.command)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.application_views) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.ribbon)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.ribbon) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.ribbon_contextual_tabs) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.ribbon_helpbutton) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.ribbon_quick_access_toolbar) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.ribbon_size_definitions) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.ribbon_tabs)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.ribbon_tabs) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.tab)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.tab) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.group) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.tab_scaling_policy)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.group) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.button) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.check_box) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.combo_box) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.control_group) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.toggle_button) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.spinner) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.split_button) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.drop_down_gallery) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.in_ribbon_gallery) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.split_button_gallery) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.drop_down_color_picker) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.font_control)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.split_button) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.button)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.menu_group)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.menu_group) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.button) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.split_button) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.check_box) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.combo_box) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.drop_down_color_picker) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.drop_down_gallery) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.font_control) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.split_button_gallery) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.toggle_button) or else
						-- FIXME: Parent's parent must be ApplicationMenu here
						l_item_text.same_string ({ER_XML_CONSTANTS}.drop_down_button)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.context_popup) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus) or else
						l_item_text.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.context_menu)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.mini_toolbar)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.mini_toolbar) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.menu_group)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.context_menu) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.menu_group)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.drop_down_button) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.button)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.ribbon_quick_access_toolbar) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.button)	-- FIXME: It can be toggle button and check box also	
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.ribbon_contextual_tabs) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.tab_group)
				elseif a_parent_type.same_string ({ER_XML_CONSTANTS}.tab_group) then
					Result := l_item_text.same_string ({ER_XML_CONSTANTS}.tab)
				end
			end
		end

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER; l_child: EV_TREE_NODE)
			-- Handle pointer press
		do
			if attached l_child as l_type then
				if attached {ER_OBJECT_EDITOR} shared_singleton.object_editor_cell.item as l_object_editor then
					l_object_editor.update_ui_with_node (l_child)
				end
			end
		end

	on_tree_key_press (a_key: EV_KEY)
			-- Handle key press on tree
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
			-- Handle pebble drop on tree
		local
			l_tree_item: EV_TREE_ITEM
		do
			if attached {STRING} a_pebble as l_item then
				check is_root_pebble_valid (a_pebble) end
				l_tree_item := tree_item_factory_method (l_item)
				widget.extend (l_tree_item)
			end
		end

	on_veto_root_tree_drop (a_pebble: ANY): BOOLEAN
			-- Veto pebble drop function
		do
			Result := is_root_pebble_valid (a_pebble)
		end

	on_close_content
			-- Handle close SD_CONTENT request action
		local
			l_warning: EV_WARNING_DIALOG
			l_question: EV_QUESTION_DIALOG
		do
			if attached shared_singleton.main_window_cell.item as l_win then
				if shared_singleton.layout_constructor_list.count <= 1 then
					create l_warning.make_with_text ("Only one ribbon window left, cannot close")
					l_warning.show_modal_to_window (l_win)
				else
					create l_question.make_with_text ("Closing tab will delete the ribbon window data. Are you sure?")
					l_question.set_buttons_and_actions (<<"Yes", "No">>, <<agent on_close_content_imp, agent on_cancel>>)
					l_question.show_modal_to_window (l_win)
				end
			end
		end

	on_close_content_imp
			-- Close current tool
		do
			shared_singleton.layout_constructor_list.prune_all (Current)
			content.close

			update_project_info_window_count
		end

	on_cancel
			-- Handle cancel action
		do
			-- Do nothing
		end

feature -- Persistance

	save_tree
			-- Save to Microsoft Ribbon makrup XML directly
			-- Save different Window's Ribbon to different xml markup files
		local
			l_factory: ER_CODE_GENERATOR_FACTORY
		do
			create l_factory
			l_factory.tree_manager.save_tree
		end

	load_tree (a_ribbon_window_count: INTEGER)
			-- Load a ribbon tree into GUI
		local
			l_factory: ER_CODE_GENERATOR_FACTORY
		do
			create l_factory
			l_factory.tree_manager.load_tree (a_ribbon_window_count)
		end

feature {ER_PROJECT_INFO} -- Internal command

	update_project_info_window_count
			-- Update project info data with window's count
		do
			if attached shared_singleton.project_info_cell.item as l_project_info then
				l_project_info.set_ribbon_window_count (shared_singleton.layout_constructor_list.count)
			end
		end

feature {NONE} -- Implementation

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

	recursive_all_items_with_command_name (a_text: STRING; a_tree_node: EV_TREE_NODE; a_list: ARRAYED_LIST [EV_TREE_NODE])
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
				recursive_all_items_with_command_name (a_text, a_tree_node.item, a_list)

				a_tree_node.forth
			end
		end

	content: SD_CONTENT
			-- Docking content

	helper: ER_HELPER
			-- Helper

	shared_singleton: ER_SHARED_TOOLS
			-- Shared singleton

	tree_node_factory: ER_TREE_NODE_DATA_FACTORY
			-- Tree node factory

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
