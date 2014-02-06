note
	description: "[
					Microsoft Ribbon makrup XML constants

				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_CONSTANTS

feature -- Root element

	application: STRING = "Application"

	application_commands: STRING = "Application.Commands"

	application_views: STRING = "Application.Views"

feature -- Query, the value of string is what should be written to XML

	ribbon: STRING = "Ribbon"

	ribbon_application_menu: STRING = "Ribbon.ApplicationMenu"

	application_menu: STRING = "ApplicationMenu"

	application_menu_recent_items: STRING = "ApplicationMenu.RecentItems"

	recent_items: STRING = "RecentItems"

	menu_group: STRING = "MenuGroup"

	ribbon_contextual_tabs: STRING = "Ribbon.ContextualTabs"

	ribbon_helpbutton: STRING = "Ribbon.HelpButton"

	helpbutton: STRING = "HelpButton"

	ribbon_quick_access_toolbar: STRING = "Ribbon.QuickAccessToolbar"

	quick_access_toolbar: STRING = "QuickAccessToolbar"

	quick_access_toolbar_application_defaults: STRING = "QuickAccessToolbar.ApplicationDefaults"

	ribbon_size_definitions: STRING = "Ribbon.SizeDefinitions"

	size_definition: STRING = "SizeDefinition"

	control_name_map: STRING = "ControlNameMap"

	control_named_efinition: STRING = "ControlNameDefinition"

	group_size_definition: STRING = "GroupSizeDefinition"

	control_size_definition: STRING = "ControlSizeDefinition"

	row: STRING = "Row"

	ribbon_tabs: STRING = "Ribbon.Tabs"

	tab: STRING = "Tab"

	tab_group: STRING = "TabGroup"

	group: STRING = "Group"

	tab_scaling_policy: STRING = "Tab.ScalingPolicy"

	scaling_policy: STRING = "ScalingPolicy"

	scaling_policy_ideal_sizes: STRING = "ScalingPolicy.IdealSizes"

	scale: STRING = "Scale"

	command: STRING = "Command"

	context_popup: STRING = "ContextPopup"

	context_popup_mini_toolbars: STRING = "ContextPopup.MiniToolbars"

	mini_toolbar: STRING = "MiniToolbar"

	context_popup_context_menus: STRING = "ContextPopup.ContextMenus"

	context_popup_context_maps: STRING = "ContextPopup.ContextMaps"

	context_menu: STRING = "ContextMenu"

	context_map: STRING = "ContextMap"

feature -- ALl types under group

	button: STRING = "Button"

	toggle_button: STRING = "ToggleButton"

	check_box: STRING = "CheckBox"

	spinner: STRING = "Spinner"

	combo_box: STRING = "ComboBox"

	split_button: STRING = "SplitButton"

	drop_down_gallery: STRING = "DropDownGallery"

	drop_down_button: STRING = "DropDownButton"

	drop_down_color_picker: STRING = "DropDownColorPicker"

	font_control: STRING = "FontControl"

	in_ribbon_gallery: STRING = "InRibbonGallery"

	split_button_gallery: STRING = "SplitButtonGallery"

	drop_down_gallery_menu_layout: STRING = "DropDownGallery.MenuLayout"

	split_button_gallery_menu_layout: STRING = "SplitButtonGallery.MenuLayout"

	flow_menu_layout: STRING = "FlowMenuLayout"

	control_group: STRING = "ControlGroup"

feature -- Types under command node

	command_small_images: STRING = "Command.SmallImages"

	command_large_images: STRING = "Command.LargeImages"

	command_label_title: STRING = "Command.LabelTitle"

	command_key_tip: STRING = "Command.Keytip"

	string: STRING = "String"

	Image: STRING = "Image"

feature -- Contract support

	is_valid (a_string: STRING): BOOLEAN
			-- Is `a_string' valid?
		do
			if attached a_string as l_string then
				Result := l_string.same_string (application) or else
					l_string.same_string (application_commands) or else
					l_string.same_string (application_views) or else
					l_string.same_string (menu_group) or else
					l_string.same_string (ribbon) or else
					l_string.same_string (ribbon_application_menu) or else
					l_string.same_string (application_menu) or else
					l_string.same_string (ribbon_contextual_tabs) or else
					l_string.same_string (ribbon_helpbutton) or else
					l_string.same_string (ribbon_quick_access_toolbar) or else
					l_string.same_string (ribbon_size_definitions) or else
					l_string.same_string (ribbon_tabs) or else
					l_string.same_string (command) or else
					l_string.same_string (group) or else
					l_string.same_string (tab) or else
					l_string.same_string (button) or else
					l_string.same_string (check_box) or else
					l_string.same_string (combo_box) or else
					l_string.same_string (control_group) or else
					l_string.same_string (command_label_title) or else
					l_string.same_string (command_small_images) or else
					l_string.same_string (command_large_images) or else
					l_string.same_string (toggle_button) or else
					l_string.same_string (spinner) or else
					l_string.same_string (split_button) or else
					l_string.same_string (drop_down_gallery) or else
					l_string.same_string (drop_down_gallery_menu_layout) or else
					l_string.same_string (flow_menu_layout) or else
					l_string.same_string (application_menu_recent_items) or else
					l_string.same_string (recent_items) or else
					l_string.same_string (in_ribbon_gallery) or else
					l_string.same_string (split_button_gallery) or else
					l_string.same_string (split_button_gallery_menu_layout) or else
					l_string.same_string (context_popup) or else
					l_string.same_string (context_popup_context_menus) or else
					l_string.same_string (context_popup_mini_toolbars) or else
					l_string.same_string (mini_toolbar) or else
					l_string.same_string (context_menu) or else
					l_string.same_string (drop_down_button) or else
					l_string.same_string (drop_down_color_picker) or else
					l_string.same_string (font_control) or else
					l_string.same_string (tab_group) or else
					l_string.same_string (tab_scaling_policy) or else
					l_string.same_string (scaling_policy) or else
					l_string.same_string (scaling_policy_ideal_sizes) or else
					l_string.same_string (scale)
			end
		end

	is_valid_ribbon_item (a_string: STRING): BOOLEAN
			-- Is `a_string' valid ribbon item, such as button, checkbox or spinner etc
		do
			if attached a_string as l_string then
				Result := l_string.same_string (button) or else
					l_string.same_string (check_box) or else
					l_string.same_string (combo_box) or else
					l_string.same_string (toggle_button) or else
					l_string.same_string (spinner) or else
					l_string.same_string (split_button) or else
					l_string.same_string (drop_down_gallery) or else
					l_string.same_string (in_ribbon_gallery) or else
					l_string.same_string (split_button_gallery) or else
					l_string.same_string (drop_down_button) or else
					l_string.same_string (drop_down_color_picker) or else
					l_string.same_string (font_control)
			end
		end
note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
