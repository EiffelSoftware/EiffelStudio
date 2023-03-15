note
	description: "All shared attributes specific to the debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL_DATA

inherit
	ES_TOOLBAR_PREFERENCE

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS

	SHARED_DEBUGGER_MANAGER

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
		ensure
			preferences_not_void: preferences /= Void
		end

feature {EB_SHARED_PREFERENCES, ES_DOCKABLE_TOOL_PANEL} -- Value

	last_saved_stack_path: PATH
			-- Last saved stack path.
		do
			Result := last_saved_stack_path_preference.value
		end

	default_expanded_view_size: INTEGER
			-- Default size for expanded view dialog
		do
			Result := default_expanded_view_size_preference.value
			if Result < 1 then
				Result := 500
			end
		end

	project_toolbar_layout: ARRAY [STRING_GENERAL]
			-- Toolbar organization.
		do
			Result := <<
				visible_toolbar_item_name ({EB_SYSTEM_CMD}.name),
				visible_toolbar_item_name ({EB_MELT_PROJECT_COMMAND}.command_name),
				visible_toolbar_item_name ({EB_ERROR_INFORMATION_CMD}.name),
				visible_toolbar_item_name ({EB_SYSTEM_INFORMATION_CMD}.name),
				visible_toolbar_item_name ({ES_CODE_ANALYSIS_COMMAND}.command_name),
				hidden_toolbar_item_name ({ES_CODE_ANALYSIS_ANALYZE_EDITOR_COMMAND}.name),
				hidden_toolbar_item_name ({ES_CODE_ANALYSIS_ANALYZE_PARENT_COMMAND}.name),
				hidden_toolbar_item_name ({ES_CODE_ANALYSIS_ANALYZE_TARGET_COMMAND}.name),
				hidden_toolbar_item_name ({ES_CA_SHOW_PREFERENCES_COMMAND}.name),
				visible_toolbar_item_name ({EB_FORCE_EXECUTION_MODE_CMD}.name),
				"Separator",
				visible_toolbar_item_name ({EB_DEBUG_STOPIN_HOLE_COMMAND}.name),
				visible_toolbar_item_name ({EB_DISABLE_STOP_POINTS_COMMAND}.name),
				visible_toolbar_item_name ({EB_CLEAR_STOP_POINTS_COMMAND}.name),
				visible_toolbar_item_name ("Bkpt_info"),
				"Separator",
				hidden_toolbar_item_name ({EB_DBG_IGNORE_BREAKPOINTS_CMD}.name),
				visible_toolbar_item_name ({EB_EXEC_DEBUG_CMD}.name),
				hidden_toolbar_item_name ({EB_EXEC_RESTART_DEBUG_CMD}.name),
				hidden_toolbar_item_name ({EB_EXEC_STOP_CMD}.name),
				hidden_toolbar_item_name ({EB_EXEC_QUIT_CMD}.name),
				hidden_toolbar_item_name ({EB_EXEC_DETACH_CMD}.name),
				hidden_toolbar_item_name ({EB_EXEC_ATTACH_CMD}.name),
				"Separator",
				visible_toolbar_item_name ({EB_EXEC_STEP_CMD}.name),
				visible_toolbar_item_name ({EB_EXEC_INTO_CMD}.name),
				visible_toolbar_item_name ({EB_EXEC_OUT_CMD}.name),
				hidden_toolbar_item_name ({EB_EXEC_NO_STOP_CMD}.name),
				hidden_toolbar_item_name ({EB_ASSERTION_CHECKING_HANDLER_CMD}.name),
				hidden_toolbar_item_name ({EB_EXEC_FINALIZED_CMD}.name),
				hidden_toolbar_item_name ({EB_FREEZE_PROJECT_COMMAND}.name),
				hidden_toolbar_item_name ({EB_FINALIZE_PROJECT_COMMAND}.name),
				hidden_toolbar_item_name ({EB_DISCOVER_AND_MELT_COMMAND}.name)>>
		end

	local_vs_object_proportion: REAL
			-- What ratio should we have between the locals tree
			-- and the objects tree in the object tool?
		local
			str: STRING
		do
			str := local_vs_object_proportion_preference.value
			if not str.is_real then
				local_vs_object_proportion_preference.set_value ("0.5")
				Result := {REAL_32} 0.5
			else
				Result := str.to_real
			end
		end

	set_local_vs_object_proportion (r: REAL)
		do
			local_vs_object_proportion_preference.set_value (r.out)
		end

	expanded_display_bgcolor: EV_COLOR
		do
			Result := expanded_display_bgcolor_preference.value
		end

	number_of_watch_tools: INTEGER
		do
			Result := number_of_watch_tools_preference.value
		end

	delay_before_cleaning_objects_grid: INTEGER
		do
			Result := delay_before_cleaning_objects_grid_preference.value
		end

	row_highlight_background_color: EV_COLOR
		do
			Result := row_highlight_background_color_preference.value
		end

	row_highlight_different_value_background_color: EV_COLOR
		do
			Result := row_highlight_different_value_background_color_preference.value
		end

	unsensitive_foreground_color: EV_COLOR
		do
			Result := unsensitive_foreground_color_preference.value
		end

	internal_background_color: EV_COLOR
		do
			Result := internal_background_color_preference.value
		end

	row_replayable_background_color: EV_COLOR
		do
			Result := row_replayable_background_color_preference.value
		end

	select_call_stack_level_on_double_click: BOOLEAN
		do
			Result := select_call_stack_level_on_double_click_preference.value
		end

	is_stack_grid_layout_managed: BOOLEAN
		do
			Result := is_stack_grid_layout_managed_preference.value
		end

	is_debugged_grid_layout_managed: BOOLEAN
		do
			Result := is_debugged_grid_layout_managed_preference.value
		end

	is_watches_grids_layout_managed: BOOLEAN
		do
			Result := is_watches_grids_layout_managed_preference.value
		end

	display_agent_details: BOOLEAN
		do
			Result := display_agent_details_preference.value
		end

	always_show_callstack_tool_when_stopping: BOOLEAN
		do
			Result := always_show_callstack_tool_when_stopping_preference.value
		end

	show_debug_tooltip: BOOLEAN
		do
			Result := show_debug_tooltip_preference.value
		end

	show_debug_tooltip_delay: INTEGER
			-- Show debug tooltip delay in milliseconds
		do
			Result := show_debug_tooltip_delay_preference.value
		end

	always_evaluate_potential_side_effect_expression: BOOLEAN
			-- Always evaluate expression with potential side effect?
		do
			Result := always_evaluate_potential_side_effect_expression_preference.value
		end

	new_edit_selected_shortcut: ES_KEY_SHORTCUT
		do
			Result := new_shortcut ({EV_KEY_CONSTANTS}.key_f2, False, False, False)
		end

	new_open_viewer_shortcut: ES_KEY_SHORTCUT
		do
			Result := new_shortcut ({EV_KEY_CONSTANTS}.key_e, True, False, False)
		end

	new_goto_home_shortcut: ES_KEY_SHORTCUT
		do
			Result := new_shortcut ({EV_KEY_CONSTANTS}.key_home, True, False, True)
		end

	new_goto_end_shortcut: ES_KEY_SHORTCUT
		do
			Result := new_shortcut ({EV_KEY_CONSTANTS}.key_end, True, False, False)
		end

	auto_import_debugger_profiles_enabled: BOOLEAN
		do
			Result := auto_import_debugger_profiles_enabled_preference.value
		end

	auto_export_debugger_profiles_enabled: BOOLEAN
		do
			Result := auto_export_debugger_profiles_enabled_preference.value
		end

feature -- Color preference on demand

	custom_color_preference (a_color_name: STRING; dft: EV_COLOR): COLOR_PREFERENCE
		local
			l_manager: EB_PREFERENCE_MANAGER
			l_prefs: like custom_colors_preferences
		do
			l_prefs := custom_colors_preferences
			if attached l_prefs.item (a_color_name) as v then
				Result := v
			else
				create l_manager.make (preferences, "debug_tool")
				Result := l_manager.new_color_preference_value (l_manager, "debugger.colors.customs." + a_color_name, dft)
				Result.set_description ("Debug color for %""+ a_color_name +"%"")
--				Result.set_tag ("theme")
				l_prefs.put (Result, a_color_name)
			end
		end

	custom_colors_preferences: STRING_TABLE [COLOR_PREFERENCE]

feature -- Preference

	edit_bp_here_shortcut_preference: SHORTCUT_PREFERENCE
	enable_remove_bp_here_shortcut_preference: SHORTCUT_PREFERENCE
	enable_disable_bp_here_shortcut_preference: SHORTCUT_PREFERENCE
	run_to_this_point_shortcut_preference: SHORTCUT_PREFERENCE

	auto_import_debugger_profiles_enabled_preference: BOOLEAN_PREFERENCE
	auto_export_debugger_profiles_enabled_preference: BOOLEAN_PREFERENCE

feature {EB_SHARED_PREFERENCES, ES_DOCKABLE_TOOL_PANEL} -- Preference

	last_saved_stack_path_preference: PATH_PREFERENCE
	default_expanded_view_size_preference: INTEGER_PREFERENCE
	local_vs_object_proportion_preference: STRING_PREFERENCE
	left_debug_layout_preference: ARRAY_PREFERENCE
	right_debug_layout_preference: ARRAY_PREFERENCE
	expanded_display_bgcolor_preference: COLOR_PREFERENCE
	number_of_watch_tools_preference: INTEGER_PREFERENCE
	delay_before_cleaning_objects_grid_preference: INTEGER_PREFERENCE
	row_highlight_background_color_preference: COLOR_PREFERENCE
	row_highlight_different_value_background_color_preference: COLOR_PREFERENCE
	unsensitive_foreground_color_preference: COLOR_PREFERENCE
	internal_background_color_preference: COLOR_PREFERENCE
	row_replayable_background_color_preference: COLOR_PREFERENCE
	select_call_stack_level_on_double_click_preference: BOOLEAN_PREFERENCE
	is_stack_grid_layout_managed_preference: BOOLEAN_PREFERENCE
	is_debugged_grid_layout_managed_preference: BOOLEAN_PREFERENCE
	is_watches_grids_layout_managed_preference: BOOLEAN_PREFERENCE
	display_agent_details_preference: BOOLEAN_PREFERENCE
	show_text_in_project_toolbar_preference: BOOLEAN_PREFERENCE
	show_all_text_in_project_toolbar_preference: BOOLEAN_PREFERENCE
	always_show_callstack_tool_when_stopping_preference: BOOLEAN_PREFERENCE
	watch_tools_layout_preference: ARRAY_PREFERENCE
	move_up_watch_expression_shortcut_preference: SHORTCUT_PREFERENCE
	move_down_watch_expression_shortcut_preference: SHORTCUT_PREFERENCE
	show_debug_tooltip_preference: BOOLEAN_PREFERENCE
	show_debug_tooltip_delay_preference: INTEGER_PREFERENCE
	always_evaluate_potential_side_effect_expression_preference: BOOLEAN_PREFERENCE

	objects_tool_layout_preference: ARRAY_PREFERENCE

	grid_column_layout_preference_for (grid_name: STRING): STRING_PREFERENCE
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			if grid_column_layout_preferences.has (grid_name) then
				Result := grid_column_layout_preferences.item (grid_name)
			else
				create l_manager.make (preferences, "debug_tool")
				Result := l_manager.new_string_preference_value (l_manager, grid_column_layout_prefix + grid_name, "")
				Result.set_hidden (True)
				grid_column_layout_preferences.put (Result, grid_name)
			end
		end

	grid_column_layout_preferences: HASH_TABLE [STRING_PREFERENCE, STRING]
		once
			create Result.make (3)
			Result.compare_objects
		end

feature -- Toolbar Convenience

	retrieve_project_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- Retreive the project toolbar using the available commands in `command_pool'
		do
			Result := retrieve_toolbar_items (command_pool, project_toolbar_layout)
			-- if show_text_in_project_toolbar then
				-- 	FIXME: enable_important_text feature is not available now, we do it in the future.	
				--	codes are something like this: Result.enable_important_text
			-- elseif show_all_text_in_project_toolbar then
				-- FIXME: enable_text_displayed feature is not available now, we do it in the future.
				-- codes are somehing like this: Result.enable_text_displayed
			-- end
		end

	save_project_toolbar (project_toolbar: ARRAYED_SET [SD_TOOL_BAR_ITEM])
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_preferences' to have the changes actually saved.
		do
			-- FIXIT: 	This feature is not used. However, docking library should support features
			--			like `is_text_important' and `is_text_displayed'
			-- 			Original codes:
			--
			--			project_toolbar_layout_preference.set_value (save_toolbar (project_toolbar))
			--			show_text_in_project_toolbar_preference.set_value (project_toolbar.is_text_important)
			--			show_all_text_in_project_toolbar_preference.set_value (project_toolbar.is_text_displayed)
			--			preferences.save_preference (project_toolbar_layout_preference)
			--			preferences.save_preference (show_text_in_project_toolbar_preference)
			--			preferences.save_preference (show_all_text_in_project_toolbar_preference)
		end

feature -- Preference Strings

	last_saved_stack_path_string: STRING = "debugger.last_saved_stack_path"
	main_splitter_position_string: STRING = "debugger.main_splitter_position"
	local_vs_object_proportion_string: STRING = "debugger.proportion"
	left_debug_layout_string: STRING = "debugger.left_debug_layout"
	right_debug_layout_string: STRING = "debugger.right_debug_layout"
	expanded_display_bgcolor_string: STRING = "debugger.colors.expanded_display_background_color"
	grid_background_color_string: STRING = "debugger.colors.grid_background_color"
	grid_foreground_color_string: STRING = "debugger.colors.grid_foreground_color"
	row_highlight_background_color_string: STRING = "debugger.colors.row_highlight_background_color"
	row_highlight_different_value_background_color_string: STRING = "debugger.colors.row_highlight_different_value_background_color"
	unsensitive_foreground_color_string: STRING = "debugger.colors.unsensitive_foreground_color"
	internal_background_color_string: STRING = "debugger.colors.internal_background_color"
	row_replayable_background_color_string: STRING = "debugger.colors.row_replayable_background_color"
	number_of_watch_tools_string: STRING = "debugger.number_of_watch_tools"
	delay_before_cleaning_objects_string: STRING = "debugger.delay_before_cleaning_objects_grid"
	select_call_stack_level_on_double_click_string: STRING = "debugger.select_call_stack_level_on_double_click"
	is_stack_grid_layout_managed_string: STRING = "debugger.stack_grid_layout_managed"
	is_debugged_grid_layout_managed_string: STRING = "debugger.debugged_grid_layout_managed"
	is_watches_grids_layout_managed_string: STRING = "debugger.watches_grids_layout_managed"
	objects_tool_layout_string: STRING = "debugger.objects_tool_layout"
	watch_tools_layout_string: STRING = "debugger.watch_tools_layout"
	display_agent_details_string: STRING = "debugger.display_agent_details"
	grid_column_layout_prefix: STRING = "debugger.grid_column_layout_"
	show_text_in_project_toolbar_string: STRING = "debugger.show_text_in_project_toolbar"
	show_all_text_in_project_toolbar_string: STRING = "debugger.show_all_text_in_project_toolbar"
	always_show_callstack_tool_when_stopping_string: STRING = "debugger.always_show_callstack_tool_when_stopping"
	show_debug_tooltip_string: STRING = "debugger.show_debug_tooltip"
	show_debug_tooltip_delay_string: STRING = "debugger.show_debug_tooltip_delay"
	always_evaluate_potential_side_effect_expression_string: STRING = "debugger.always_evaluate_potential_side_effect_expression"
	default_expanded_view_size_string: STRING = "debugger.default_expanded_view_size"
	move_up_watch_expression_shortcut_string: STRING = "debugger.shortcuts.move_up_watch_expression"
	move_down_watch_expression_shortcut_string: STRING = "debugger.shortcuts.move_down_watch_expression"
	edit_bp_here_shortcut_string: STRING = "debugger.shortcuts.edit_bp_here"
	enable_remove_here_shortcut_string: STRING = "debugger.shortcuts.enable_remove_here"
	enable_disable_bp_here_shortcut_string: STRING = "debugger.shortcuts.enable_disable_bp_here"
	run_to_this_point_shortcut_string: STRING = "debugger.shortcuts.run_to_this_point"
	auto_import_debugger_profiles_enabled_string: STRING = "debugger.parameters.auto_import"
	auto_export_debugger_profiles_enabled_string: STRING = "debugger.parameters.auto_export"

feature {NONE} -- Visibility control

	visible_toolbar_item_name (command_name: STRING): STRING_GENERAL
			-- Preference name of a toolbar item of name `command_name` corresponding to its visible status.
		do
			Result := command_name.twin
			Result.append ("__visible")
		end

	hidden_toolbar_item_name (command_name: STRING_32): STRING_GENERAL
			-- Preference name of a toolbar item of name `command_name` corresponding to its hidden status.
		do
			Result := command_name.twin
			Result.append ("__hidden")
		end

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "debug_tool")

			create custom_colors_preferences.make (0)

			last_saved_stack_path_preference := l_manager.new_path_preference_value (l_manager, last_saved_stack_path_string, create {PATH}.make_empty)
			last_saved_stack_path_preference.set_hidden (True)
			default_expanded_view_size_preference := l_manager.new_integer_preference_value (l_manager, default_expanded_view_size_string, 500)
			local_vs_object_proportion_preference := l_manager.new_string_preference_value (l_manager, local_vs_object_proportion_string, "0.5")
			local_vs_object_proportion_preference.set_hidden (True)

			left_debug_layout_preference := l_manager.new_array_preference_value (l_manager, left_debug_layout_string, <<>>)
			right_debug_layout_preference := l_manager.new_array_preference_value (l_manager, right_debug_layout_string, <<>>)
			expanded_display_bgcolor_preference := l_manager.new_color_preference_value (l_manager, expanded_display_bgcolor_string, create {EV_COLOR}.make_with_8_bit_rgb (210, 210, 210))

			number_of_watch_tools_preference := l_manager.new_integer_preference_value (l_manager, number_of_watch_tools_string, 1)
			delay_before_cleaning_objects_grid_preference := l_manager.new_integer_preference_value (l_manager, delay_before_cleaning_objects_string, 500)
			row_highlight_background_color_preference := l_manager.new_color_preference_value (l_manager, row_highlight_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 170))
			row_highlight_different_value_background_color_preference := l_manager.new_color_preference_value (l_manager, row_highlight_different_value_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 210, 210))
			unsensitive_foreground_color_preference := l_manager.new_color_preference_value (l_manager, unsensitive_foreground_color_string, create {EV_COLOR}.make_with_8_bit_rgb (150, 150, 150))
			internal_background_color_preference := l_manager.new_color_preference_value (l_manager, internal_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (180, 150, 150))
			row_replayable_background_color_preference := l_manager.new_color_preference_value (l_manager, row_replayable_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (205, 230, 255))
			select_call_stack_level_on_double_click_preference := l_manager.new_boolean_preference_value (l_manager, select_call_stack_level_on_double_click_string, False)
			is_stack_grid_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_stack_grid_layout_managed_string, True)
			is_debugged_grid_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_debugged_grid_layout_managed_string, True)
			is_watches_grids_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_watches_grids_layout_managed_string, True)
			display_agent_details_preference := l_manager.new_boolean_preference_value (l_manager, display_agent_details_string, False)
			objects_tool_layout_preference := l_manager.new_array_preference_value (l_manager, objects_tool_layout_string, <<>>)
			watch_tools_layout_preference := l_manager.new_array_preference_value (l_manager, watch_tools_layout_string, <<>>)
			always_show_callstack_tool_when_stopping_preference := l_manager.new_boolean_preference_value (l_manager, always_show_callstack_tool_when_stopping_string, True)
			show_debug_tooltip_preference := l_manager.new_boolean_preference_value (l_manager, show_debug_tooltip_string, True)
			show_debug_tooltip_delay_preference := l_manager.new_integer_preference_value (l_manager, show_debug_tooltip_delay_string, 500)
			show_debug_tooltip_delay_preference.set_validation_agent (
					agent (a_str: READABLE_STRING_GENERAL): BOOLEAN
						do
							if a_str /= Void then
								Result := a_str.is_integer and then a_str.to_integer >= 0
							end
						end
				)
			always_evaluate_potential_side_effect_expression_preference := l_manager.new_boolean_preference_value (l_manager, always_evaluate_potential_side_effect_expression_string, False)

			move_up_watch_expression_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, move_up_watch_expression_shortcut_string, [True, False, True, "up"])
			move_down_watch_expression_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, move_down_watch_expression_shortcut_string,  [True, False, True, "down"])

			edit_bp_here_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, edit_bp_here_shortcut_string,  [False, True, False, "F9"])
			enable_remove_bp_here_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, enable_remove_here_shortcut_string,  [False, False, False, "F9"])
			enable_disable_bp_here_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, enable_disable_bp_here_shortcut_string,  [False, False, True, "F9"])
			run_to_this_point_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, run_to_this_point_shortcut_string,  [False, True, False, "F10"])

			auto_import_debugger_profiles_enabled_preference := l_manager.new_boolean_preference_value (l_manager, auto_import_debugger_profiles_enabled_string, True)
			auto_export_debugger_profiles_enabled_preference := l_manager.new_boolean_preference_value (l_manager, auto_export_debugger_profiles_enabled_string, False)
		end

	new_shortcut (a_key: INTEGER; a_ctrl, a_alt, a_shift: BOOLEAN): ES_KEY_SHORTCUT
			-- Create new shortcut from arguments
		do
			create Result.make_with_key_combination (create {EV_KEY}.make_with_code (a_key), a_ctrl, a_alt, a_shift)
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	last_saved_stack_path_preference_not_void: last_saved_stack_path_preference /= Void
	default_expanded_view_size_preference_not_void: default_expanded_view_size_preference /= Void
	local_vs_object_proportion_preference_not_void: local_vs_object_proportion_preference /= Void
	left_debug_layout_preference_not_void: left_debug_layout_preference /= Void
	right_debug_layout_preference_not_void: right_debug_layout_preference /= Void
	expanded_display_bgcolor_preference_not_void: expanded_display_bgcolor_preference /= Void
	number_of_watch_tools_preference_not_void: number_of_watch_tools_preference /= Void
	delay_before_cleaning_objects_grid_preference_not_void: delay_before_cleaning_objects_grid_preference /= Void
	row_highlight_background_color_preference_not_void: row_highlight_background_color_preference /= Void
	row_highlight_different_value_background_color_preference_not_void: row_highlight_different_value_background_color_preference /= Void
	unsensitive_foreground_color_preference_not_void: unsensitive_foreground_color_preference /= Void
	internal_background_color_preference_not_void: internal_background_color_preference /= Void
	row_replayable_background_color_preference_not_void: row_replayable_background_color_preference /= Void
	select_call_stack_level_on_double_click_preference_not_void: select_call_stack_level_on_double_click_preference /= Void
	is_stack_grid_layout_managed_preference_not_void: is_stack_grid_layout_managed_preference /= Void
	is_debugged_grid_layout_managed_preference_not_void: is_debugged_grid_layout_managed_preference /= Void
	is_watches_grids_layout_managed_preference_not_void: is_watches_grids_layout_managed_preference /= Void
	objects_tool_layout_preference_not_void: objects_tool_layout_preference /= Void
	watch_tools_layout_preference_not_void: watch_tools_layout_preference /= Void
	edit_bp_here_shortcut_preference_not_void: edit_bp_here_shortcut_preference /= Void
	enable_remove_here_shortcut_preference_not_void: enable_remove_bp_here_shortcut_preference /= Void
	enable_disable_bp_here_shortcut_preference_not_void: enable_disable_bp_here_shortcut_preference /= Void
	run_to_this_point_shortcut_preference_not_void: run_to_this_point_shortcut_preference /= Void
	display_agent_details_preference_not_void: display_agent_details_preference /= Void
	always_show_callstack_tool_when_stopping_preference_not_void: always_show_callstack_tool_when_stopping_preference /= Void
	auto_import_debugger_profiles_enabled_preference_not_void: auto_import_debugger_profiles_enabled_preference /= Void
	auto_export_debugger_profiles_enabled_preference_not_void: auto_export_debugger_profiles_enabled_preference /= Void

note
	ca_ignore:
		"CA093", "CA093: manifest array type mismatch"
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

