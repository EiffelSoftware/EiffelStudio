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
	ES_SHARED_FONTS_AND_COLORS

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

			-- Update default value for docking library
			on_auto_hide_animation_speed_changed
			on_undocked_window_lower_than_main_window
			on_show_all_applicable_docking_indicators_changed

			-- default value
			width := 950;
			height := 650;
		ensure
			preferences_not_void: preferences /= Void
		end

feature {EB_SHARED_PREFERENCES, EB_DEVELOPMENT_WINDOW_SESSION_DATA,
		 EB_DEVELOPMENT_WINDOW_DIRECTOR, EB_DEVELOPMENT_WINDOW_BUILDER} -- Value

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
				"ES_GROUP_TOOL__hidden", "ES_FEATURES_TOOL__hidden", "ES_SEARCH_TOOL__visible", "Cloud_account__hidden", "Separator", "Send_to_context__visible",
				"New_cluster__hidden", "Remove_class_cluster__hidden", "Toggle_stone__hidden", "Raise_all__hidden", "Minimize_all__hidden",
				"Print__hidden", "ES_OUTPUTS_TOOL__hidden", "ES_DIAGRAM_TOOL__hidden", "ES_CLASS_TOOL__hidden", "ES_FEATURE_RELATION_TOOL__hidden",
				"ES_DEPENDENCY_TOOL__hidden", "ES_METRICS_TOOL__hidden", "ES_CONSOLE_TOOL__hidden", "ES_ERROR_LIST_TOOL__hidden",
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

	override_tab_behavior: STRING
			-- Defines how editor should behave when a stone is dropped onto an existing tab.
		do
			Result := override_tab_behavior_preference.selected_value
		ensure
			valid_choices: Result.same_string ({INTERFACE_NAMES}.co_editor) or Result.same_string ({INTERFACE_NAMES}.co_new_tab_editor) or Result.same_string ({INTERFACE_NAMES}.co_new_tab_editor_if_edited)
		end

	class_completion: BOOLEAN
			--
		do
			Result := class_completion_preference.value
		end

	last_browsed_cluster_directory: PATH
			--
		do
			Result := last_browsed_cluster_directory_preference.value
		end

	context_unified_stone: BOOLEAN
			-- Is the context tool linked?
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

	external_compilation_output_prompted: BOOLEAN
		do
			Result := external_compilation_output_prompted_preference.value
		end

	auto_hide_animation_speed: INTEGER
			-- The speed of auto hide zone animation in milliseconds. 0 to disable animation effect.
		do
			Result := auto_hide_animation_speed_preference.value
		end

	undocked_window_lower_than_main_window: BOOLEAN
			-- All undocked window lower than main development window?
		do
			Result := undocked_window_lower_than_main_window_preference.value
		end

	show_all_applicable_docking_indicators: BOOLEAN
			-- If we need to show all feedback indicators when dragging a zone?
		do
			Result := show_all_applicable_docking_indicators_preference.value
		end

	outputs_tool_prompted: BOOLEAN
			-- If show up output tool if start compiling?
		do
			Result := outputs_tool_prompted_preference.value
		end

	consecutive_successful_compilations_threshold: NATURAL
			-- Number of consecutive successfult compilations threshold, by default 4.
		do
			Result := consecutive_successful_compilations_threshold_preference.value.to_natural_32
		end

	pretty_printer_messindex: NATURAL
			-- Threshold of estudio pretty printer messindex.
		do
			Result := pretty_printer_messindex_preference.value.to_natural_32
		end

	is_pretty_printer_notification_enabled: BOOLEAN
			-- Is pretty printer notification enabled?
		do
			Result := is_pretty_printer_notification_enabled_preference.value
		end

feature -- General font and color preference

	grid_preferences: EB_GRID_PREFERENCES
		do
			Result := internal_grid_preferences
			if Result = Void then
				create Result.make (Current)
				internal_grid_preferences := Result
			end
		end

	internal_grid_preferences: detachable like grid_preferences

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

	override_tab_behavior_preference: ARRAY_PREFERENCE
			-- Preference defining how an editor tab behaves when receiving a stone.

	class_completion_preference: BOOLEAN_PREFERENCE

	last_browsed_cluster_directory_preference: PATH_PREFERENCE

	context_unified_stone_preference: BOOLEAN_PREFERENCE

	link_tools_preference: BOOLEAN_PREFERENCE

	graphical_output_disabled_preference: BOOLEAN_PREFERENCE

	use_animated_icons_preference: BOOLEAN_PREFERENCE

	external_compilation_output_prompted_preference: BOOLEAN_PREFERENCE
			-- Should C output panel prompt out when c compilation starts?

	auto_hide_animation_speed_preference: INTEGER_PREFERENCE
			-- The speed of auto hide zone animation in milliseconds if `auto_hide_zone_use_animation_preference' True.
			-- 0 to disable animation effect.

	undocked_window_lower_than_main_window_preference: BOOLEAN_PREFERENCE
			-- Allow undocked windows lower than main develop window?

	show_all_applicable_docking_indicators_preference: BOOLEAN_PREFERENCE
			-- If we need to show all feedback indicators when dragging a zone?

	outputs_tool_prompted_preference: BOOLEAN_PREFERENCE
			-- If show up output tool if start compiling?

	consecutive_successful_compilations_threshold_preference: INTEGER_PREFERENCE
		-- Number of successful compilations in a row, to be used when a criteria is met, we suggest something to the user.
		-- for example Pretty printer option.

	pretty_printer_messindex_preference: INTEGER_PREFERENCE
		-- Compute messindex as the diff between the current code and the pretty printed code.

	is_pretty_printer_notification_enabled_preference: BOOLEAN_PREFERENCE
			-- Is pretty printer notification enabled?

feature {EB_SHARED_PREFERENCES, EB_GRID_PREFERENCES} -- Grid related preferences			

	grid_font_preference: FONT_PREFERENCE
	grid_foreground_color_preference: COLOR_PREFERENCE
	grid_background_color_preference: COLOR_PREFERENCE
	grid_focused_selection_text_color_preference: COLOR_PREFERENCE
	grid_focused_selection_color_preference: COLOR_PREFERENCE
	grid_non_focused_selection_text_color_preference: COLOR_PREFERENCE
	grid_non_focused_selection_color_preference: COLOR_PREFERENCE
	grid_separator_color_preference: COLOR_PREFERENCE
	grid_tree_node_connector_color_preference: COLOR_PREFERENCE

feature -- Element change

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

	update_pretty_printer_notification (a_bool: BOOLEAN)
			-- Update pretty printer notification with `a_bool`.
		do
			is_pretty_printer_notification_enabled_preference.set_value (a_bool)
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

feature -- Data Ids for SESSION_MANAGER

	development_window_data_id: STRING_8 = "com.eiffel.develop_window_data"
			-- Session data id for {EB_DEVELOPMENT_WINDOW_SESSION_DATA}.

	development_window_project_data_id: STRING_8 = "com.eiffel.develop_window_project_data"
			-- Session data id for {EB_DEVELOPMENT_WINDOW_SESSION_DATA} for one project.		

	development_window_count_id: STRING_8 = "com_eiffel.develop_window_count"
			-- Session data id for how many {EB_DEVELOPMENT_WINDOW} exists in the session.

feature {NONE} -- Preference Strings

	is_force_debug_mode_string: STRING = "interface.development_window.is_force_debug_mode"
	max_history_size_string: STRING = "interface.development_window.maximum_history_size"
	remember_completion_list_size_string: STRING = "interface.development_window.remember_completion_list_size"
	completion_list_width_string: STRING = "interface.development_window.completion_list_width"
	completion_list_height_string: STRING = "interface.development_window.completion_list_height"
	progress_bar_color_preference_string: STRING = "interface.development_window.progress_bar_color"
	ctrl_right_click_receiver_string: STRING = "interface.development_window.ctrl_right_click_receiver"
	override_tab_behavior_string: STRING = "interface.development_window.override_tab_behavior"
	class_completion_string: STRING = "interface.development_window.class_completion"
	last_browsed_cluster_directory_string: STRING = "interface.development_window.last_browsed_cluster_directory"
	context_unified_stone_string: STRING = "interface.development_window.unified_stone"
	link_tools_string: STRING = "interface.development_window.link_tools"
	graphical_output_disabled_string: STRING = "interface.development_window.graphical_output_disabled"
	use_animated_icons_string: STRING = "interface.development_window.use_animated_icons"
	external_compilation_output_prompted_string: STRING = "interface.development_window.external_compilation_output_prompted"
	auto_hide_animation_speed_string: STRING = "interface.development_window.auto_hide_animation_speed"
	undocked_window_lower_than_main_window_string: STRING = "interface.development_window.undocked_window_lower_than_main_window"
	show_all_applicable_docking_indicators_string: STRING = "interface.development_window.show_all_applicable_docking_indicators"
	outputs_tool_prompted_string: STRING = "interface.development_window.outputs_tool_prompted"

	estudio_dbg_menu_allowed_string: STRING = "interface.development_window.estudio_dbg_menu_allowed"
	estudio_dbg_menu_accelerator_allowed_string: STRING = "interface.development_window.estudio_dbg_menu_accelerator_allowed"
	estudio_dbg_menu_enabled_string: STRING = "interface.development_window.estudio_dbg_menu_enabled"

	consecutive_successful_compilations_threshold_string: STRING = "interface.development_window.consecutive_successful_compilations_threshold"
		-- Number of successful compilations in a row, to be used when a criteria is met, we suggest  something to the user.
		-- for example Pretty printer option.

	pretty_printer_messindex_string: STRING = "interface.development_window.pretty_printer_messindex"
		-- Compute messindex as the diff between the current code and the pretty printed code.

	is_pretty_printer_notification_enabled_string: STRING = "interface.development_window.is_pretty_printer_notification_enabled"

	grid_font_string: STRING = "interface.development_window.grid.font"
	grid_foreground_color_string: STRING = "interface.development_window.grid.foreground_color"
	grid_background_color_string: STRING = "interface.development_window.grid.background_color"
	grid_focused_selection_text_color_string: STRING = "interface.development_window.grid.focused_selection_text_color"
	grid_focused_selection_color_string: STRING = "interface.development_window.grid.focused_selection_color"
	grid_non_focused_selection_text_color_string: STRING = "interface.development_window.grid.non_focused_selection_text_color"
	grid_non_focused_selection_color_string: STRING = "interface.development_window.grid.non_focused_selection_color"
	grid_separator_color_string: STRING = "interface.development_window.grid.separator_color"
	grid_tree_node_connector_color_string: STRING = "interface.development_window.grid.tree_node_connector_color"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
			g: ES_GRID
		do
			create l_manager.make (preferences, "development_window")
			is_force_debug_mode_preference := l_manager.new_boolean_preference_value (l_manager, is_force_debug_mode_string, False)
			max_history_size_preference := l_manager.new_integer_preference_value (l_manager, max_history_size_string, 10)
			remember_completion_list_size_preference := l_manager.new_boolean_preference_value (l_manager, remember_completion_list_size_string, True)
			completion_list_height_preference := l_manager.new_integer_preference_value (l_manager, completion_list_height_string, 100)
			completion_list_width_preference := l_manager.new_integer_preference_value (l_manager, completion_list_width_string, 80)
			progress_bar_color_preference := l_manager.new_color_preference_value (l_manager, progress_bar_color_preference_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 128))
			ctrl_right_click_receiver_preference := l_manager.new_array_preference_value (l_manager, ctrl_right_click_receiver_string, <<"new_tab_editor", "new_window", "current_editor", "context", "external">>)
			ctrl_right_click_receiver_preference.set_is_choice (True)
			override_tab_behavior_preference := l_manager.new_array_preference_value (l_manager, override_tab_behavior_string, <<"current_editor", "new_tab_editor", "new_tab_if_edited">>)
			override_tab_behavior_preference.set_is_choice (True)
			class_completion_preference := l_manager.new_boolean_preference_value (l_manager, class_completion_string, True)
			last_browsed_cluster_directory_preference := l_manager.new_path_preference_value (l_manager, last_browsed_cluster_directory_string, create {PATH}.make_empty)
			context_unified_stone_preference := l_manager.new_boolean_preference_value (l_manager, context_unified_stone_string, False)
			link_tools_preference := l_manager.new_boolean_preference_value (l_manager, link_tools_string, False)
			graphical_output_disabled_preference := l_manager.new_boolean_preference_value (l_manager, graphical_output_disabled_string, False)
			use_animated_icons_preference := l_manager.new_boolean_preference_value (l_manager, use_animated_icons_string, True)
			external_compilation_output_prompted_preference := l_manager.new_boolean_preference_value (l_manager, external_compilation_output_prompted_string, False)
			auto_hide_animation_speed_preference := l_manager.new_integer_preference_value (l_manager, auto_hide_animation_speed_string, 50)
			undocked_window_lower_than_main_window_preference := l_manager.new_boolean_preference_value (l_manager, undocked_window_lower_than_main_window_string, False)
			show_all_applicable_docking_indicators_preference := l_manager.new_boolean_preference_value (l_manager, show_all_applicable_docking_indicators_string, True)
			outputs_tool_prompted_preference := l_manager.new_boolean_preference_value (l_manager, outputs_tool_prompted_string, True)

			estudio_dbg_menu_allowed_preference := l_manager.new_boolean_preference_value (l_manager, estudio_dbg_menu_allowed_string, True)
			estudio_dbg_menu_accelerator_allowed_preference := l_manager.new_boolean_preference_value (l_manager, estudio_dbg_menu_accelerator_allowed_string, True)
			estudio_dbg_menu_enabled_preference := l_manager.new_boolean_preference_value (l_manager, estudio_dbg_menu_enabled_string, False)
			estudio_dbg_menu_enabled_preference.set_hidden (not estudio_dbg_menu_allowed_preference.value)
			estudio_dbg_menu_enabled_preference.change_actions.extend (agent update_estudio_dbg_menu)


			consecutive_successful_compilations_threshold_preference := l_manager.new_integer_preference_value (l_manager, consecutive_successful_compilations_threshold_string, 4)
			pretty_printer_messindex_preference := l_manager.new_integer_preference_value (l_manager, pretty_printer_messindex_string, 2)
			is_pretty_printer_notification_enabled_preference := l_manager.new_boolean_preference_value (l_manager, is_pretty_printer_notification_enabled_string, True)

			create g
			grid_font_preference := l_manager.new_font_preference_value (l_manager, grid_font_string, if attached (create {EV_GRID_LABEL_ITEM}).font as ft then ft else fonts.standard_label_font end)
			if not grid_font_preference.has_default_value then
				grid_font_preference.set_as_default_value (fonts.standard_label_font)
			end
			grid_foreground_color_preference := l_manager.new_color_preference_value (l_manager, grid_foreground_color_string, g.foreground_color)
			if not grid_foreground_color_preference.has_default_value then
				grid_foreground_color_preference.set_as_default_value (g.foreground_color)
			end
			grid_background_color_preference := l_manager.new_color_preference_value (l_manager, grid_background_color_string, g.background_color)
			if not grid_background_color_preference.has_default_value then
				grid_background_color_preference.set_as_default_value (g.background_color)
			end
			grid_focused_selection_text_color_preference := l_manager.new_color_preference_value (l_manager, grid_focused_selection_text_color_string, g.focused_selection_text_color)
			grid_focused_selection_color_preference := l_manager.new_color_preference_value (l_manager, grid_focused_selection_color_string, g.focused_selection_color)
			grid_non_focused_selection_text_color_preference := l_manager.new_color_preference_value (l_manager, grid_non_focused_selection_text_color_string, g.non_focused_selection_text_color)
			grid_non_focused_selection_color_preference := l_manager.new_color_preference_value (l_manager, grid_non_focused_selection_color_string, g.non_focused_selection_color)
			grid_separator_color_preference := l_manager.new_color_preference_value (l_manager, grid_separator_color_string, g.separator_color)
			grid_tree_node_connector_color_preference := l_manager.new_color_preference_value (l_manager, grid_tree_node_connector_color_string, g.tree_node_connector_color)

			auto_hide_animation_speed_preference.change_actions.extend (agent on_auto_hide_animation_speed_changed)
			undocked_window_lower_than_main_window_preference.change_actions.extend (agent on_undocked_window_lower_than_main_window)
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

	on_undocked_window_lower_than_main_window
			-- Handle change actions of `undocked_window_lower_than_main_window_preference'
		local
			l_shared: SD_SHARED
		do
			create l_shared
			l_shared.set_allow_window_to_back (undocked_window_lower_than_main_window)
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
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

