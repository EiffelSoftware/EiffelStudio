note
	description: "Summary description for {ER_TYPE_SELECTOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TYPE_SELECTOR

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create helper
			create constants
			build_ui
			build_docking_content
		end

	build_docking_content
			--
		do
			create content.make_with_widget (widget, "ER_TYPE_SELECTOR")
			content.set_long_title ("Type Selector")
			content.set_short_title ("Type Selector")
		end

	build_ui
			--
		local
--			l_tree_item_app: EV_TREE_ITEM
--			l_tree_item_commands: EV_TREE_ITEM
			l_tree_item_view: EV_TREE_ITEM
--			l_command: EV_TREE_ITEM

			l_ribbon: EV_TREE_ITEM
			l_context_popup: EV_TREE_ITEM
			l_context_popup_mini_toolbars: EV_TREE_ITEM
			l_context_popup_context_menus: EV_TREE_ITEM
			l_mini_toolbar: EV_TREE_ITEM
			l_context_menu: EV_TREE_ITEM

			l_ribbon_application_menu, l_ribbon_group: EV_TREE_ITEM
			l_ribbon_contextual_tabs: EV_TREE_ITEM
			l_tab_group: EV_TREE_ITEM
			l_ribbon_help_button: EV_TREE_ITEM
			l_ribbon_quick_access_toolbar: EV_TREE_ITEM
			l_ribbon_size_definitions: EV_TREE_ITEM
			l_ribbon_tabs: EV_TREE_ITEM

			l_tab: EV_TREE_ITEM
			l_group: EV_TREE_ITEM
			l_tab_scaling_policy: EV_TREE_ITEM

			l_items: EV_TREE_ITEM
		do
			create widget

			create l_tree_item_view.make_with_text ("Application.Views")
			widget.extend (l_tree_item_view)

			create l_ribbon.make_with_text (constants.ribbon)
			l_ribbon.set_pebble (constants.ribbon)
			l_tree_item_view.extend (l_ribbon)
--Uncomment following lines when the ribbon features supported
			create l_ribbon_application_menu.make_with_text (constants.ribbon_application_menu)
			l_ribbon_application_menu.set_pebble (constants.ribbon_application_menu)

			create l_ribbon_group.make_with_text (constants.menu_group)
			l_ribbon_group.set_pebble (constants.menu_group)
			l_ribbon_application_menu.extend (l_ribbon_group)

			create l_ribbon_contextual_tabs.make_with_text (constants.ribbon_contextual_tabs)
			l_ribbon_contextual_tabs.set_pebble (constants.ribbon_contextual_tabs)

			create l_tab_group.make_with_text (constants.tab_group)
			l_tab_group.set_pebble (constants.tab_group)
			l_ribbon_contextual_tabs.extend (l_tab_group)

			create l_ribbon_help_button.make_with_text (constants.ribbon_helpbutton)
			l_ribbon_help_button.set_pebble (constants.ribbon_helpbutton)

			create l_ribbon_quick_access_toolbar.make_with_text (constants.ribbon_quick_access_toolbar)
			l_ribbon_quick_access_toolbar.set_pebble (constants.ribbon_quick_access_toolbar)

			create l_ribbon_size_definitions.make_with_text (constants.ribbon_size_definitions)
--			l_ribbon_size_definitions.set_pebble (constants.ribbon_size_definitions)
			create l_ribbon_tabs.make_with_text (constants.ribbon_tabs)
--			l_ribbon_tabs.set_pebble (constants.ribbon_tabs)
			l_ribbon.extend (l_ribbon_application_menu)
			l_ribbon.extend (l_ribbon_contextual_tabs)
			l_ribbon.extend (l_ribbon_help_button)
			l_ribbon.extend (l_ribbon_quick_access_toolbar)
			l_ribbon.extend (l_ribbon_size_definitions)
			l_ribbon.extend (l_ribbon_tabs)

			create l_tab.make_with_text (constants.tab)
			l_ribbon_tabs.extend (l_tab)
			l_tab.set_pebble (constants.tab)

			create l_group.make_with_text (constants.group)
			l_tab.extend (l_group)
			l_group.set_pebble (constants.group)

			create l_tab_scaling_policy.make_with_text (constants.tab_scaling_policy)
			l_tab.extend (l_tab_scaling_policy)
--			l_tab_scaling_policy.set_pebble (constants.tab_scaling_policy)

			-- Context popup
			create l_context_popup.make_with_text (constants.context_popup)
			l_tree_item_view.extend (l_context_popup)
			l_context_popup.set_pebble (constants.context_popup)

			create l_context_popup_mini_toolbars.make_with_text (constants.context_popup_mini_toolbars)
			l_context_popup.extend (l_context_popup_mini_toolbars)
			l_context_popup_mini_toolbars.set_pebble (constants.context_popup_mini_toolbars)

			create l_context_popup_context_menus.make_with_text (constants.context_popup_context_menus)
			l_context_popup.extend (l_context_popup_context_menus)
			l_context_popup_context_menus.set_pebble (constants.context_popup_context_menus)

			create l_mini_toolbar.make_with_text (constants.mini_toolbar)
			l_context_popup_mini_toolbars.extend (l_mini_toolbar)
			l_mini_toolbar.set_pebble (constants.mini_toolbar)

			create l_context_menu.make_with_text (constants.context_menu)
			l_context_popup_context_menus.extend (l_context_menu)
			l_context_menu.set_pebble (constants.context_menu)

			create l_items.make_with_text ("Items")
			widget.extend (l_items)
			extend_all_buttons (l_items)

			helper.expand_all (widget)
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			--
		require
			not_void: a_docking_manager /= Void
		do
			a_docking_manager.contents.extend (content)
			content.set_top ({SD_ENUMERATION}.left)
		end

feature {NONE} -- Action handler

--	on_pick (a_x, a_y: INTEGER; a_item: EV_TREE_ITEM)
--			--
--		do

--		end

feature {NONE} -- Implementation

	extend_all_buttons (a_parent: EV_TREE_ITEM)
			--
		require
			not_void: a_parent /= Void
--			valid: a_parent.text.is_equal ((create {ER_XML_CONSTANTS}).group)
		local
			l_button: EV_TREE_ITEM
			l_toggle_button: EV_TREE_ITEM
			l_check_box: EV_TREE_ITEM
			l_combo_box: EV_TREE_ITEM
			l_control_group: EV_TREE_ITEM
--			l_dropdown_button: EV_TREE_ITEM
--			l_dropdown_color_picker: EV_TREE_ITEM
			l_dropdown_gallery: EV_TREE_ITEM
--			l_font_control: EV_TREE_ITEM
			l_in_ribbon_gallery: EV_TREE_ITEM
--			l_size_definition: EV_TREE_ITEM
			l_spinner: EV_TREE_ITEM
			l_split_button: EV_TREE_ITEM
			l_split_button_gallery: EV_TREE_ITEM
--			l_toggle_button: EV_TREE_ITEM
			l_drop_down_button: EV_TREE_ITEM
			l_drop_down_color_picker: EV_TREE_ITEM
			l_font_control: EV_TREE_ITEM
		do
			create l_button.make_with_text (constants.button)
			l_button.set_pebble (constants.button)
			a_parent.extend (l_button)

			create l_toggle_button.make_with_text (constants.toggle_button)
			l_toggle_button.set_pebble (constants.toggle_button)
			a_parent.extend (l_toggle_button)

--Uncomment following lines when the ribbon features supported
			create l_check_box.make_with_text (constants.check_box)
			l_check_box.set_pebble (constants.check_box)
			a_parent.extend (l_check_box)

			create l_spinner.make_with_text (constants.spinner)
			l_spinner.set_pebble (constants.spinner)
			a_parent.extend (l_spinner)

			create l_combo_box.make_with_text (constants.combo_box)
			l_combo_box.set_pebble (constants.combo_box)
			a_parent.extend (l_combo_box)

			create l_split_button.make_with_text (constants.split_button)
			l_split_button.set_pebble (constants.split_button)
			a_parent.extend (l_split_button)

			create l_control_group.make_with_text (constants.control_group)
--			l_control_group.set_pebble (constants.control_group)
			a_parent.extend (l_control_group)

			create l_dropdown_gallery.make_with_text (constants.drop_down_gallery)
			l_dropdown_gallery.set_pebble (constants.drop_down_gallery)
			a_parent.extend (l_dropdown_gallery)

			create l_in_ribbon_gallery.make_with_text (constants.in_ribbon_gallery)
			l_in_ribbon_gallery.set_pebble (constants.in_ribbon_gallery)
			a_parent.extend (l_in_ribbon_gallery)

			create l_split_button_gallery.make_with_text (constants.split_button_gallery)
			l_split_button_gallery.set_pebble (constants.split_button_gallery)
			a_parent.extend (l_split_button_gallery)

			create l_drop_down_button.make_with_text (constants.drop_down_button)
			l_drop_down_button.set_pebble (constants.drop_down_button)
			a_parent.extend (l_drop_down_button)

			create l_drop_down_color_picker.make_with_text (constants.drop_down_color_picker)
			l_drop_down_color_picker.set_pebble (constants.drop_down_color_picker)
			a_parent.extend (l_drop_down_color_picker)

			create l_font_control.make_with_text (constants.font_control)
			l_font_control.set_pebble (constants.font_control)
			a_parent.extend (l_font_control)
		end

	content: SD_CONTENT
			--

	widget: EV_TREE
			-- Main dockig content widget

	helper: ER_HELPER
			-- Helper

	constants: ER_XML_CONSTANTS
			-- Constants
end
