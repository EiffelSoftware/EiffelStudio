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

	last_saved_stack_path: STRING
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

	project_toolbar_layout: ARRAY [STRING]
			-- Toolbar organization
		do
			Result := <<"System_tool__visible", "Melt_project__visible", "Open_help_tool__visible", "System_info__visible", "Force_debug_mode__visible",
				"Separator", "Enable_bkpt__visible", "Disable_bkpt__visible", "Clear_bkpt__visible", "Bkpt_info__visible", "Separator", "Ignore_breakpoints_cmd__hidden",
				"Exec_debug__visible", "Exec_restart_debug__hidden", "Exec_stop__hidden", "Exec_quit__hidden", "Separator", "Exec_step__visible", "Exec_into__visible",
				"Exec_out__visible", "Exec_no_stop__hidden", "Assertion_checking_handler__hidden", "Run_final__hidden", "Freeze_project__hidden", "Finalize_project__hidden",
				"Override_scan__hidden", "Discover_melt__hidden">>
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

	unsensitive_foreground_color: EV_COLOR
		do
			Result := unsensitive_foreground_color_preference.value
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

feature -- Preference

	edit_bp_here_shortcut_preference: SHORTCUT_PREFERENCE
	enable_remove_bp_here_shortcut_preference: SHORTCUT_PREFERENCE
	enable_disable_bp_here_shortcut_preference: SHORTCUT_PREFERENCE

feature {EB_SHARED_PREFERENCES, ES_DOCKABLE_TOOL_PANEL} -- Preference

	last_saved_stack_path_preference: STRING_PREFERENCE
	default_expanded_view_size_preference: INTEGER_PREFERENCE
	local_vs_object_proportion_preference: STRING_PREFERENCE
	left_debug_layout_preference: ARRAY_PREFERENCE
	right_debug_layout_preference: ARRAY_PREFERENCE
	expanded_display_bgcolor_preference: COLOR_PREFERENCE
	grid_background_color_preference: COLOR_PREFERENCE
	grid_foreground_color_preference: COLOR_PREFERENCE
	number_of_watch_tools_preference: INTEGER_PREFERENCE
	delay_before_cleaning_objects_grid_preference: INTEGER_PREFERENCE
	row_highlight_background_color_preference: COLOR_PREFERENCE
	unsensitive_foreground_color_preference: COLOR_PREFERENCE
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
	unsensitive_foreground_color_string: STRING = "debugger.colors.unsensitive_foreground_color"
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
	default_expanded_view_size_string: STRING = "debugger.default_expanded_view_size"
	move_up_watch_expression_shortcut_string: STRING = "debugger.shortcuts.move_up_watch_expression"
	move_down_watch_expression_shortcut_string: STRING = "debugger.shortcuts.move_down_watch_expression"
	edit_bp_here_shortcut_string: STRING = "debugger.shortcuts.edit_bp_here"
	enable_remove_here_shortcut_string: STRING = "debugger.shortcuts.enable_remove_here"
	enable_disable_bp_here_shortcut_string: STRING = "debugger.shortcuts.enable_disable_bp_here"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "debug_tool")

			last_saved_stack_path_preference := l_manager.new_string_preference_value (l_manager, last_saved_stack_path_string, "")
			last_saved_stack_path_preference.set_hidden (True)
			default_expanded_view_size_preference := l_manager.new_integer_preference_value (l_manager, default_expanded_view_size_string, 500)
			local_vs_object_proportion_preference := l_manager.new_string_preference_value (l_manager, local_vs_object_proportion_string, "0.5")
			local_vs_object_proportion_preference.set_hidden (True)

			left_debug_layout_preference := l_manager.new_array_preference_value (l_manager, left_debug_layout_string, <<>>)
			right_debug_layout_preference := l_manager.new_array_preference_value (l_manager, right_debug_layout_string, <<>>)
			expanded_display_bgcolor_preference := l_manager.new_color_preference_value (l_manager, expanded_display_bgcolor_string, create {EV_COLOR}.make_with_8_bit_rgb (210, 210, 210))
			grid_background_color_preference := l_manager.new_color_preference_value (l_manager, grid_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			grid_foreground_color_preference := l_manager.new_color_preference_value (l_manager, grid_foreground_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))

			number_of_watch_tools_preference := l_manager.new_integer_preference_value (l_manager, number_of_watch_tools_string, 1)
			delay_before_cleaning_objects_grid_preference := l_manager.new_integer_preference_value (l_manager, delay_before_cleaning_objects_string, 500)
			row_highlight_background_color_preference := l_manager.new_color_preference_value (l_manager, row_highlight_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 170))
			unsensitive_foreground_color_preference := l_manager.new_color_preference_value (l_manager, unsensitive_foreground_color_string, create {EV_COLOR}.make_with_8_bit_rgb (150, 150, 150))
			row_replayable_background_color_preference := l_manager.new_color_preference_value (l_manager, row_replayable_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (205, 230, 255))
			select_call_stack_level_on_double_click_preference := l_manager.new_boolean_preference_value (l_manager, select_call_stack_level_on_double_click_string, False)
			is_stack_grid_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_stack_grid_layout_managed_string, True)
			is_debugged_grid_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_debugged_grid_layout_managed_string, True)
			is_watches_grids_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_watches_grids_layout_managed_string, True)
			display_agent_details_preference := l_manager.new_boolean_preference_value (l_manager, display_agent_details_string, False)
			objects_tool_layout_preference := l_manager.new_array_preference_value (l_manager, objects_tool_layout_string, <<>>)
			watch_tools_layout_preference := l_manager.new_array_preference_value (l_manager, watch_tools_layout_string, <<>>)
			always_show_callstack_tool_when_stopping_preference := l_manager.new_boolean_preference_value (l_manager, always_show_callstack_tool_when_stopping_string, True)

			move_up_watch_expression_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, move_up_watch_expression_shortcut_string, [True, False, True, "up"])
			move_down_watch_expression_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, move_down_watch_expression_shortcut_string,  [True, False, True, "down"])

			edit_bp_here_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, edit_bp_here_shortcut_string,  [False, True, False, "F9"])
			enable_remove_bp_here_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, enable_remove_here_shortcut_string,  [False, False, False, "F9"])
			enable_disable_bp_here_shortcut_preference := l_manager.new_shortcut_preference_value (l_manager, enable_disable_bp_here_shortcut_string,  [False, False, True, "F9"])
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
	grid_background_color_preference_attached: grid_background_color_preference /= Void
	grid_foreground_color_preference_attached: grid_foreground_color_preference /= Void
	number_of_watch_tools_preference_not_void: number_of_watch_tools_preference /= Void
	delay_before_cleaning_objects_grid_preference_not_void: delay_before_cleaning_objects_grid_preference /= Void
	row_highlight_background_color_preference_not_void: row_highlight_background_color_preference /= Void
	unsensitive_foreground_color_preference_not_void: unsensitive_foreground_color_preference /= Void
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
	display_agent_details_preference_not_void: display_agent_details_preference /= Void
	always_show_callstack_tool_when_stopping_preference_not_void: always_show_callstack_tool_when_stopping_preference /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EB_DEBUG_TOOL_DATA
