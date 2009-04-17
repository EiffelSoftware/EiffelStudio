note
	description	: "All shared attributes specific to the development window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_PREFERENCES

inherit
	EB_DEVELOPMENT_WINDOW_DATA
	ES_TOOLBAR_PREFERENCE
	EB_SHARED_GRAPHICAL_COMMANDS

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences

			-- Update default value for docking library.
			on_auto_hide_animation_speed_changed
			on_show_all_applicable_docking_indicators_changed

			-- default value
			width := 950;
			height := 650;
		ensure
			preferences_not_void: preferences /= Void
		end

feature {EB_SHARED_PREFERENCES, EB_DEVELOPMENT_WINDOW_SESSION_DATA,
		 EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEVELOPMENT_WINDOW_BUILDER} -- Value

	width: INTEGER
			-- Width for the development window

	height: INTEGER
			-- Height for the development window

	x_position: INTEGER
			-- X position for development windows

	y_position: INTEGER
			-- Y position for development windows

	maximized_width: INTEGER
			-- Width for the development window when maximized

	maximized_height: INTEGER
			-- Height for the development window when maximized

	maximized_x_position: INTEGER
			-- X position for development windows when maximized

	maximized_y_position: INTEGER
			-- Y position for development windows when maximized

	is_maximized: BOOLEAN
			-- Is the development window maximized?

	is_minimized: BOOLEAN
			-- Is the development window minimized?

	is_force_debug_mode: BOOLEAN
			-- Is the development window force debug mode?
		do
			Result := is_force_debug_mode_preference.value
		end

	general_toolbar_layout: ARRAY [STRING]
			-- Toolbar organization
		do
			Result := <<"New_tab__visible", "New_window__hidden", "New_editor__hidden", "New_context_window__hidden", "Open_file__hidden",
				"New_class__hidden", "New_feature__hidden", "Open_shell__visible", "Save_file__visible", "Save_all_file__visible", "Separator",
				"Undo__visible", "Redo__visible", "Separator", "Editor_cut__visible", "Editor_copy__visible", "Editor_paste__visible", "Separator",
				"ES_GROUP_TOOL__hidden", "ES_FEATURES_TOOL__hidden", "ES_SEARCH_TOOL__visible", "Separator", "Send_to_context__visible",
				"New_cluster__hidden", "Remove_class_cluster__hidden", "Toggle_stone__hidden", "Raise_all__hidden", "Minimize_all__hidden",
				"Print__hidden", "ES_OUTPUT_TOOL__hidden", "ES_DIAGRAM_TOOL__hidden", "ES_CLASS_TOOL__hidden", "ES_FEATURE_RELATION_TOOL__hidden",
				"ES_DEPENDENCY_TOOL__hidden", "ES_METRICS_TOOL__hidden", "ES_CONSOLE_TOOL__hidden", "ES_C_OUTPUT_TOOL__hidden", "ES_ERROR_LIST_TOOL__hidden",
				"ES_FAVORITES_TOOL__hidden", "ES_WINDOWS_TOOL__hidden", "ES_PROPERTIES_TOOL__hidden", "ES_DEBUGGER_BREAKPOINTS_TOOL__hidden",
				"ES_SEARCH_REPORT__hidden", "ES_INFORMATION_TOOL__hidden">>
		end

	refactoring_toolbar_layout: ARRAY [STRING]
			-- Toolbar organization
		do
			Result := <<"RF_pull__visible", "RF_rename__visible", "Separator", "RF_undo__visible", "RF_redo__visible">>
		end

	max_history_size: INTEGER
			-- Maximum number of items displayed in the history (in the address combo boxes).
		do
			Result := max_history_size_preference.value
		end

	use_animated_icons: BOOLEAN
			-- Should window status bar use animated icons?
		do
			Result := use_animated_icons_preference.value
		end

	remember_completion_list_size: BOOLEAN
			--
		do
			Result := remember_completion_list_size_preference.value
		end

	completion_list_width: INTEGER
			--
		do
			Result := completion_list_width_preference.value
		end

	completion_list_height: INTEGER
			--
		do
			Result := completion_list_height_preference.value
		end

	progress_bar_color: EV_COLOR
			--
		do
			Result := progress_bar_color_preference.value
		end

	ctrl_right_click_receiver: STRING
			--
		do
			Result := ctrl_right_click_receiver_preference.selected_value
		end

	class_completion: BOOLEAN
			--
		do
			Result := class_completion_preference.value
		end

	last_browsed_cluster_directory: STRING
			--
		do
			Result := last_browsed_cluster_directory_preference.value
		end

	context_unified_stone: BOOLEAN
		do
			Result := context_unified_stone_preference.value
		end

	link_tools: BOOLEAN
		do
			Result := link_tools_preference.value
		end

	graphical_output_disabled: BOOLEAN
		do
			Result := graphical_output_disabled_preference.value
		end

	c_output_panel_prompted: BOOLEAN
		do
			Result := c_output_panel_prompted_preference.value
		end

	auto_hide_animation_speed: INTEGER
			-- The speed of auto hide zone animation in milliseconds. 0 to disable animation effect.
		do
			Result := auto_hide_animation_speed_preference.value
		end

	show_all_applicable_docking_indicators: BOOLEAN
			-- If we need to show all feedback indicators when dragging a zone?
		do
			Result := show_all_applicable_docking_indicators_preference.value
		end

	output_tool_prompted: BOOLEAN
			-- If show up output tool if start compiling?
		do
			Result := output_tool_prompted_preference.value
		end

feature {EB_SHARED_PREFERENCES} -- Preference

	estudio_dbg_menu_allowed_preference: BOOLEAN_PREFERENCE
			-- Is EiffelStudio's debug menu allowed ?

	estudio_dbg_menu_enabled_preference: BOOLEAN_PREFERENCE
 			-- Should Eiffel Studio Debug menu be shown?

	estudio_dbg_menu_accelerator_allowed_preference: BOOLEAN_PREFERENCE
			-- When `estudio_dbg_menu_enabled_preference' is True, whether show eiffel studio debug menu by accelerator ?

	is_force_debug_mode_preference: BOOLEAN_PREFERENCE
			-- Is the development window force debug mode?

	max_history_size_preference: INTEGER_PREFERENCE

	remember_completion_list_size_preference: BOOLEAN_PREFERENCE

	completion_list_width_preference: INTEGER_PREFERENCE

	completion_list_height_preference: INTEGER_PREFERENCE

	progress_bar_color_preference: COLOR_PREFERENCE

	ctrl_right_click_receiver_preference: ARRAY_PREFERENCE

	class_completion_preference: BOOLEAN_PREFERENCE

	last_browsed_cluster_directory_preference: STRING_PREFERENCE

	context_unified_stone_preference: BOOLEAN_PREFERENCE

	link_tools_preference: BOOLEAN_PREFERENCE

	graphical_output_disabled_preference: BOOLEAN_PREFERENCE

	use_animated_icons_preference: BOOLEAN_PREFERENCE

	c_output_panel_prompted_preference: BOOLEAN_PREFERENCE
			-- Should C output panel prompt out when c compilation starts?

	auto_hide_animation_speed_preference: INTEGER_PREFERENCE
			-- The speed of auto hide zone animation in milliseconds if `auto_hide_zone_use_animation_preference' True.
			-- 0 to disable animation effect.

	show_all_applicable_docking_indicators_preference: BOOLEAN_PREFERENCE
			-- If we need to show all feedback indicators when dragging a zone?

	output_tool_prompted_preference: BOOLEAN_PREFERENCE
			-- If show up output tool if start compiling?

feature -- Element change

	save_size (a_width, a_height: INTEGER)
			-- <Precursor>
		do
			width := a_width
			height := a_height
		end

	save_maximized_size (a_width, a_height: INTEGER)
			-- <Precursor>
		do
			maximized_width := a_width
			maximized_height := a_height
		end

	save_window_state (a_minimized, a_maximized: BOOLEAN)
			-- Save the window state of the window.
		do
			is_minimized := a_minimized
			is_maximized := a_maximized
		end

	save_position (a_x, a_y: INTEGER)
			-- <Precursor>
		do
			x_position := a_x
			y_position := a_y
		end

	save_maximized_position (a_x, a_y: INTEGER)
			-- <Precursor>
		do
			maximized_x_position := a_x
			maximized_y_position := a_y
		end

	save_force_debug_mode (a_bool: BOOLEAN)
			-- Save if `is_force_debug_mode'
		do
			is_force_debug_mode_preference.set_value (a_bool)
		end

	save_completion_list_size (a_width, a_height: INTEGER)
			-- Save the size of the completion list
		do
			completion_list_width_preference.set_value (a_width)
			completion_list_height_preference.set_value (a_height)
			preferences.save_preference (completion_list_width_preference)
			preferences.save_preference (completion_list_height_preference)
		end

feature -- Basic operations

	retrieve_general_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- Retreive the general toolbar using the available commands in `command_pool'
		do
			Result := retrieve_toolbar_items (command_pool, general_toolbar_layout)
		end

	retrieve_refactoring_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- Retreive the refactoring toolbar using the available commands in `command_pool'
		do
			Result := retrieve_toolbar_items (command_pool, refactoring_toolbar_layout)
		end

feature {NONE} -- Preference Strings

	is_force_debug_mode_string: STRING = "interface.development_window.is_force_debug_mode"
	max_history_size_string: STRING = "interface.development_window.maximum_history_size"
	remember_completion_list_size_string: STRING = "interface.development_window.remember_completion_list_size"
	completion_list_width_string: STRING = "interface.development_window.completion_list_width"
	completion_list_height_string: STRING = "interface.development_window.completion_list_height"
	progress_bar_color_preference_string: STRING = "interface.development_window.progress_bar_color"
	ctrl_right_click_receiver_string: STRING = "interface.development_window.ctrl_right_click_receiver"
	class_completion_string: STRING = "interface.development_window.class_completion"
	last_browsed_cluster_directory_string: STRING = "interface.development_window.last_browsed_cluster_directory"
	context_unified_stone_string: STRING = "interface.development_window.unified_stone"
	link_tools_string: STRING = "interface.development_window.link_tools"
	graphical_output_disabled_string: STRING = "interface.development_window.graphical_output_disabled"
	use_animated_icons_string: STRING = "interface.development_window.use_animated_icons"
	c_output_panel_prompted_string: STRING = "interface.development_window.c_output_panel_prompted"
	auto_hide_animation_speed_string: STRING = "interface.development_window.auto_hide_animation_speed"
	show_all_applicable_docking_indicators_string: STRING = "interface.development_window.show_all_applicable_docking_indicators"
	output_tool_prompted_string: STRING = "interface.development_window.output_tool_prompted"

	estudio_dbg_menu_allowed_string: STRING = "interface.development_window.estudio_dbg_menu_allowed"
	estudio_dbg_menu_accelerator_allowed_string: STRING = "interface.development_window.estudio_dbg_menu_accelerator_allowed"
	estudio_dbg_menu_enabled_string: STRING = "interface.development_window.estudio_dbg_menu_enabled"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "development_window")
			is_force_debug_mode_preference := l_manager.new_boolean_preference_value (l_manager, is_force_debug_mode_string, False)
			max_history_size_preference := l_manager.new_integer_preference_value (l_manager, max_history_size_string, 10)
			remember_completion_list_size_preference := l_manager.new_boolean_preference_value (l_manager, remember_completion_list_size_string, True)
			completion_list_height_preference := l_manager.new_integer_preference_value (l_manager, completion_list_height_string, 100)
			completion_list_width_preference := l_manager.new_integer_preference_value (l_manager, completion_list_width_string, 80)
			progress_bar_color_preference := l_manager.new_color_preference_value (l_manager, progress_bar_color_preference_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 128))
			ctrl_right_click_receiver_preference := l_manager.new_array_preference_value (l_manager, ctrl_right_click_receiver_string, <<"[new_tab_editor];new_window;current_editor;context;external">>)
			ctrl_right_click_receiver_preference.set_is_choice (True)
			class_completion_preference := l_manager.new_boolean_preference_value (l_manager, class_completion_string, True)
			last_browsed_cluster_directory_preference := l_manager.new_string_preference_value (l_manager, last_browsed_cluster_directory_string, "")
			context_unified_stone_preference := l_manager.new_boolean_preference_value (l_manager, context_unified_stone_string, False)
			link_tools_preference := l_manager.new_boolean_preference_value (l_manager, link_tools_string, False)
			graphical_output_disabled_preference := l_manager.new_boolean_preference_value (l_manager, graphical_output_disabled_string, False)
			use_animated_icons_preference := l_manager.new_boolean_preference_value (l_manager, use_animated_icons_string, True)
			c_output_panel_prompted_preference := l_manager.new_boolean_preference_value (l_manager, c_output_panel_prompted_string, False)
			auto_hide_animation_speed_preference := l_manager.new_integer_preference_value (l_manager, auto_hide_animation_speed_string, 50)
			show_all_applicable_docking_indicators_preference := l_manager.new_boolean_preference_value (l_manager, show_all_applicable_docking_indicators_string, True)
			output_tool_prompted_preference := l_manager.new_boolean_preference_value (l_manager, output_tool_prompted_string, False)

			estudio_dbg_menu_allowed_preference := l_manager.new_boolean_preference_value (l_manager, estudio_dbg_menu_allowed_string, True)
			estudio_dbg_menu_accelerator_allowed_preference := l_manager.new_boolean_preference_value (l_manager, estudio_dbg_menu_accelerator_allowed_string, True)
			estudio_dbg_menu_enabled_preference := l_manager.new_boolean_preference_value (l_manager, estudio_dbg_menu_enabled_string, False)
			estudio_dbg_menu_enabled_preference.set_hidden (not estudio_dbg_menu_allowed_preference.value)
			estudio_dbg_menu_enabled_preference.change_actions.extend (agent update_estudio_dbg_menu)
			auto_hide_animation_speed_preference.change_actions.extend (agent on_auto_hide_animation_speed_changed)
			show_all_applicable_docking_indicators_preference.change_actions.extend (agent on_show_all_applicable_docking_indicators_changed)
		end

	preferences: PREFERENCES
			-- Preferences

	update_estudio_dbg_menu
			-- Show or hidden the Eiffel Studio Debug menu which is at the right side of the Help menu.
		do
			if estudio_dbg_menu_enabled_preference.value then
				estudio_debug_cmd.attach_window (Void)
			else
				estudio_debug_cmd.unattach_window (Void)
			end
		end

	on_auto_hide_animation_speed_changed
			-- Handle change actions of `auto_hide_animation_speed_preference'.
		local
			l_shared: SD_SHARED
		do
			create l_shared
			l_shared.set_auto_hide_tab_slide_timer_interval (auto_hide_animation_speed)
		end

	on_show_all_applicable_docking_indicators_changed
			-- Handle change actions of `show_all_applicable_docking_indicators_preference'.
		local
			l_shared: SD_SHARED
		do
			create l_shared
			l_shared.set_show_all_feedback_indicator (show_all_applicable_docking_indicators)
		end

invariant
	preferences_not_void_not_void: preferences /= Void
	is_force_debug_mode_preference_not_void: is_force_debug_mode_preference /= Void
	max_history_size_preference_not_void: max_history_size_preference /= Void
	estudio_dbg_menu_allowed_preference_not_void: estudio_dbg_menu_allowed_preference /= Void
	estudio_dbg_menu_accelerator_allowed_preference_not_void: estudio_dbg_menu_accelerator_allowed_preference /= Void
	estudio_dbg_menu_enabled_preference_not_void: estudio_dbg_menu_enabled_preference /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

end -- class EB_DEVELOPMENT_WINDOW_PREFERENCES

