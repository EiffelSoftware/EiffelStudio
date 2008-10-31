indexing
	description: "All shared attributes specific to the debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL_DATA

inherit
	ES_TOOLBAR_PREFERENCE

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
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

	last_saved_stack_path: STRING is
			-- Last saved stack path.
		do
			Result := last_saved_stack_path_preference.value
		end

	default_expanded_view_size: INTEGER is
			-- Default size for expanded view dialog
		do
			Result := default_expanded_view_size_preference.value
			if Result < 1 then
				Result := 500
			end
		end

	show_text_in_project_toolbar: BOOLEAN is
			-- Show selected text in the project toolbar?
		do
			Result := show_text_in_project_toolbar_preference.value
		end

	show_all_text_in_project_toolbar: BOOLEAN is
			-- Show all selected text in the project toolbar?
		do
			Result := show_all_text_in_project_toolbar_preference.value
		end

	project_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := project_toolbar_layout_preference.value
		end

	local_vs_object_proportion: REAL is
			-- What ratio should we have between the locals tree
			-- and the objects tree in the object tool?
		local
			str: STRING
		do
			str := local_vs_object_proportion_preference.value
			if not str.is_real then
				local_vs_object_proportion_preference.set_value ("0.5")
				Result := 0.5
			else
				Result := str.to_real
			end
		end

	set_local_vs_object_proportion (r: REAL) is
		do
			local_vs_object_proportion_preference.set_value (r.out)
		end

	expanded_display_bgcolor: EV_COLOR is
		do
			Result := expanded_display_bgcolor_preference.value
		end

	number_of_watch_tools: INTEGER is
		do
			Result := number_of_watch_tools_preference.value
		end

	delay_before_cleaning_objects_grid: INTEGER is
		do
			Result := delay_before_cleaning_objects_grid_preference.value
		end

	row_highlight_background_color: EV_COLOR is
		do
			Result := row_highlight_background_color_preference.value
		end

	unsensitive_foreground_color: EV_COLOR is
		do
			Result := unsensitive_foreground_color_preference.value
		end

	row_replayable_background_color: EV_COLOR is
		do
			Result := row_replayable_background_color_preference.value
		end

	select_call_stack_level_on_double_click: BOOLEAN is
		do
			Result := select_call_stack_level_on_double_click_preference.value
		end

	is_stack_grid_layout_managed: BOOLEAN is
		do
			Result := is_stack_grid_layout_managed_preference.value
		end

	is_debugged_grid_layout_managed: BOOLEAN is
		do
			Result := is_debugged_grid_layout_managed_preference.value
		end

	is_watches_grids_layout_managed: BOOLEAN is
		do
			Result := is_watches_grids_layout_managed_preference.value
		end

	display_agent_details: BOOLEAN is
		do
			Result := display_agent_details_preference.value
		end

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
	project_toolbar_layout_preference: ARRAY_PREFERENCE
	watch_tools_layout_preference: ARRAY_PREFERENCE

	objects_tool_layout_preference: ARRAY_PREFERENCE

	grid_column_layout_preference_for (grid_name: STRING): STRING_PREFERENCE is
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			if grid_column_layout_preferences.has (grid_name) then
				Result := grid_column_layout_preferences.item (grid_name)
			else
				create l_manager.make (preferences, "debug_tool")
				Result := l_manager.new_string_preference_value (l_manager, grid_column_layout_prefix + grid_name, "")
				grid_column_layout_preferences.put (Result, grid_name)
			end
		end

	grid_column_layout_preferences: HASH_TABLE [STRING_PREFERENCE, STRING] is
		once
			create Result.make (3)
			Result.compare_objects
		end

feature -- Toolbar Convenience

	retrieve_project_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): ARRAYED_SET [SD_TOOL_BAR_ITEM] is
			-- Retreive the project toolbar using the available commands in `command_pool'
		do
			Result := retrieve_toolbar_items (command_pool, project_toolbar_layout_preference.value)
			if show_text_in_project_toolbar then
				-- 	enable_important_text feature is not available now, we do it in the future.	
				--	codes are something like this: Result.enable_important_text
			elseif show_all_text_in_project_toolbar then
				-- enable_text_displayed feature is not available now, we do it in the future.
				-- codes are somehing like this: Result.enable_text_displayed
			end
		end

	save_project_toolbar (project_toolbar: ARRAYED_SET [SD_TOOL_BAR_ITEM]) is
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

	last_saved_stack_path_string: STRING is "debugger.last_saved_stack_path"
	main_splitter_position_string: STRING is "debugger.main_splitter_position"
	local_vs_object_proportion_string: STRING is "debugger.proportion"
	left_debug_layout_string: STRING is "debugger.left_debug_layout"
	right_debug_layout_string: STRING is "debugger.right_debug_layout"
	expanded_display_bgcolor_string: STRING is "debugger.expanded_display_background_color"
	grid_background_color_string: STRING is "debugger.colors.grid_background_color"
	grid_foreground_color_string: STRING is "debugger.colors.grid_foreground_color"
	row_highlight_background_color_string: STRING is "debugger.colors.row_highlight_background_color"
	unsensitive_foreground_color_string: STRING is "debugger.colors.unsensitive_foreground_color"
	row_replayable_background_color_string: STRING is "debugger.colors.row_replayable_background_color"
	number_of_watch_tools_string: STRING is "debugger.number_of_watch_tools"
	delay_before_cleaning_objects_string: STRING is "debugger.delay_before_cleaning_objects_grid"
	select_call_stack_level_on_double_click_string: STRING is "debugger.select_call_stack_level_on_double_click"
	is_stack_grid_layout_managed_string: STRING is "debugger.stack_grid_layout_managed"
	is_debugged_grid_layout_managed_string: STRING is "debugger.debugged_grid_layout_managed"
	is_watches_grids_layout_managed_string: STRING is "debugger.watches_grids_layout_managed"
	objects_tool_layout_string: STRING is "debugger.objects_tool_layout"
	watch_tools_layout_string: STRING is "debugger.watch_tools_layout"
	display_agent_details_string: STRING is "debugger.display_agent_details"
	grid_column_layout_prefix: STRING is "debugger.grid_column_layout_"
	project_toolbar_layout_string: STRING is "debugger.project_toolbar_layout"
	show_text_in_project_toolbar_string: STRING is "debugger.show_text_in_project_toolbar"
	show_all_text_in_project_toolbar_string: STRING is "debugger.show_all_text_in_project_toolbar"
	default_expanded_view_size_string: STRING is "debugger.default_expanded_view_size"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "debug_tool")

			last_saved_stack_path_preference := l_manager.new_string_preference_value (l_manager, last_saved_stack_path_string, "")
			last_saved_stack_path_preference.set_hidden (True)
			default_expanded_view_size_preference := l_manager.new_integer_preference_value (l_manager, default_expanded_view_size_string, 500)
			show_text_in_project_toolbar_preference := l_manager.new_boolean_preference_value (l_manager, show_text_in_project_toolbar_string, True)
			show_all_text_in_project_toolbar_preference := l_manager.new_boolean_preference_value (l_manager, show_all_text_in_project_toolbar_string, True)
			project_toolbar_layout_preference := l_manager.new_array_preference_value (l_manager, project_toolbar_layout_string, <<"Clear_bkpt__visible">>)
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
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	last_saved_stack_path_preference_not_void: last_saved_stack_path_preference /= Void
	default_expanded_view_size_preference_not_void: default_expanded_view_size_preference /= Void
	show_text_in_project_toolbar_preference_not_void: show_text_in_project_toolbar_preference /= Void
	show_all_text_in_project_toolbar_preference_not_void: show_all_text_in_project_toolbar_preference /= Void
	project_toolbar_layout_preference_not_void: project_toolbar_layout_preference /= Void
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

	display_agent_details_preference_not_void: display_agent_details_preference /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_DEBUG_TOOL_DATA
