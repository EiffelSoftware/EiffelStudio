note
	description: "Summary description for {ER_OBJECT_EDITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_OBJECT_EDITOR

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create constants
			build_ui
			build_docking_content
		end

	build_docking_content
			--
		do
			create content.make_with_widget (widget, "ER_OBJECT_EDITOR")
			content.set_long_title ("Object Editor")
			content.set_short_title ("Object Editor")
		end

	build_ui
			--
		do
			create widget
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			--
		require
			not_void: a_docking_manager /= Void
		do
			a_docking_manager.contents.extend (content)
			content.set_top ({SD_ENUMERATION}.right)
		end

	update_ui_with_node (a_node: EV_TREE_NODE)
			--
		require
			not_void: a_node /= Void
		local
			l_command_widget: ER_COMMAND_NODE_WIDGET
			l_group_widget: ER_GROUP_NODE_WIDGET
			l_tab_widget: ER_TAB_NODE_WIDGET
			l_button_widget: ER_BUTTON_NODE_WIDGET
			l_checkbox_widget: ER_CHECKBOX_NODE_WIDGET
			l_ribbon_widget: ER_RIBBON_NODE_WIDGET
			l_toggle_button_widget: ER_TOGGLE_BUTTON_NODE_WIDGET
			l_spinner_widget: ER_SPINNER_NODE_WIDGET
			l_combo_box_widget: ER_COMBO_BOX_NODE_WIDGET
			l_split_button_widget: ER_SPLIT_BUTTON_NODE_WIDGET
			l_drop_down_gallery_widget: ER_DROP_DOWN_GALLERY_NODE_WIDGET
			l_in_ribbon_gallery_widget: ER_IN_RIBBON_GALLERY_NODE_WIDGET
			l_split_button_gallery_widget: ER_SPLIT_BUTTON_GALLERY_NODE_WIDGET
			l_application_menu_widget: ER_RIBBON_APPLICATION_MENU_NODE_WIDGET
			l_mini_tool_bar_widget: ER_MINI_TOOLBAR_NODE_WIDGET
			l_context_menu_widget: ER_CONTEXT_MENU_NODE_WIDGET
			l_drop_down_button_widget: ER_DROP_DOWN_BUTTON_NODE_WIDGET
			l_help_button_widget: ER_HELP_BUTTON_NODE_WIDGET
			l_drop_down_color_picker_widget: ER_DROP_DOWN_COLOR_PICKER_NODE_WIDGET
			l_font_control_widget: ER_FONT_CONTROL_NODE_WIDGET
			l_quick_access_toolbar_widget: ER_QUICK_ACCESS_TOOLBAR_NODE_WIDGET
		do
			widget.wipe_out
			if attached a_node.text as l_text then
				check (create {ER_XML_CONSTANTS}).valid (l_text) end
				if l_text.same_string (constants.command) then
					create l_command_widget
					if attached {ER_TREE_NODE_COMMAND_DATA} a_node.data as l_data then
						l_command_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_command_widget)
				elseif l_text.same_string (constants.tab) then
					create l_tab_widget
					if attached {ER_TREE_NODE_TAB_DATA} a_node.data as l_data then
						l_tab_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_tab_widget)
				elseif l_text.same_string (constants.group) then
					create l_group_widget
					if attached {ER_TREE_NODE_GROUP_DATA} a_node.data as l_data then
						l_group_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_group_widget)
				elseif l_text.same_string (constants.button) then
					create l_button_widget
					if attached {ER_TREE_NODE_BUTTON_DATA} a_node.data as l_data then
						l_button_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_button_widget)
				elseif l_text.same_string (constants.check_box) then
					create l_checkbox_widget
					if attached {ER_TREE_NODE_CHECKBOX_DATA} a_node.data as l_data then
						l_checkbox_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_checkbox_widget)
				elseif l_text.same_string (constants.ribbon_tabs) then
					create l_ribbon_widget
					if attached {ER_TREE_NODE_RIBBON_DATA} a_node.data as l_data then
						l_ribbon_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_ribbon_widget)
				elseif l_text.same_string (constants.toggle_button) then
					create l_toggle_button_widget
					if attached {ER_TREE_NODE_TOGGLE_BUTTON_DATA} a_node.data as l_data then
						l_toggle_button_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_toggle_button_widget)
				elseif l_text.same_string (constants.spinner) then
					create l_spinner_widget
					if attached {ER_TREE_NODE_SPINNER_DATA} a_node.data as l_data then
						l_spinner_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_spinner_widget)
				elseif l_text.same_string (constants.combo_box) then
					create l_combo_box_widget
					if attached {ER_TREE_NODE_COMBO_BOX_DATA} a_node.data as l_data then
						l_combo_box_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_combo_box_widget)
				elseif l_text.same_string (constants.split_button) then
					create l_split_button_widget
					if attached {ER_TREE_NODE_SPLIT_BUTTON_DATA} a_node.data as l_data then
						l_split_button_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_split_button_widget)
				elseif l_text.same_string (constants.drop_down_gallery) then
					create l_drop_down_gallery_widget
					if attached {ER_TREE_NODE_DROP_DOWN_GALLERY_DATA} a_node.data as l_data then
						l_drop_down_gallery_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_drop_down_gallery_widget)
				elseif l_text.same_string (constants.in_ribbon_gallery) then
					create l_in_ribbon_gallery_widget
					if attached {ER_TREE_NODE_IN_RIBBON_GALLERY_DATA} a_node.data as l_data then
						l_in_ribbon_gallery_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_in_ribbon_gallery_widget)
				elseif l_text.same_string (constants.split_button_gallery) then
					create l_split_button_gallery_widget
					if attached {ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA} a_node.data as l_data then
						l_split_button_gallery_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_split_button_gallery_widget)
				elseif l_text.same_string (constants.ribbon_application_menu) then
					create l_application_menu_widget
					if attached {ER_TREE_NODE_APPLICATION_MENU_DATA} a_node.data as l_data then
						l_application_menu_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_application_menu_widget)
				elseif l_text.same_string (constants.mini_toolbar) then
					create l_mini_tool_bar_widget
					if attached {ER_TREE_NODE_MINI_TOOLBAR_DATA} a_node.data as l_data then
						l_mini_tool_bar_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_mini_tool_bar_widget)
				elseif l_text.same_string (constants.context_menu) then
					create l_context_menu_widget
					if attached {ER_TREE_NODE_CONTEXT_MENU_DATA} a_node.data as l_data then
						l_context_menu_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_context_menu_widget)
				elseif l_text.same_string (constants.drop_down_button) then
					create l_drop_down_button_widget
					if attached {ER_TREE_NODE_DROP_DOWN_BUTTON_DATA} a_node.data as l_data then
						l_drop_down_button_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_drop_down_button_widget)
				elseif l_text.same_string (constants.ribbon_helpbutton) then
					create l_help_button_widget
					if attached {ER_TREE_NODE_HELP_BUTTON_DATA} a_node.data as l_data then
						l_help_button_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_help_button_widget)
				elseif l_text.same_string (constants.drop_down_color_picker) then
					create l_drop_down_color_picker_widget
					if attached {ER_TREE_NODE_DROP_DOWN_COLOR_PICKER_DATA} a_node.data as l_data then
						l_drop_down_color_picker_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_drop_down_color_picker_widget)
				elseif l_text.same_string (constants.font_control) then
					create l_font_control_widget
					if attached {ER_TREE_NODE_FONT_CONTROL_DATA} a_node.data as l_data then
						l_font_control_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_font_control_widget)
				elseif l_text.same_string (constants.ribbon_quick_access_toolbar) then
					create l_quick_access_toolbar_widget
					if attached {ER_TREE_NODE_QUICK_ACCESS_TOOLBAR_DATA} a_node.data as l_data then
						l_quick_access_toolbar_widget.set_tree_node_data (l_data)
					end
					widget.extend (l_quick_access_toolbar_widget)
				end
			end

		end

--feature {NONE} -- Dynamic GUI

--	widgets_for_command_node: EV_WIDGET
--			--
--		do
--			create {ER_COMMAND_NODE_WIDGET} Result
--		end

feature {NONE} -- Implementation

	content: SD_CONTENT
			--

	widget: EV_CELL
			-- Main dockig content widget

	constants: ER_XML_CONSTANTS
			-- Constants	

end
