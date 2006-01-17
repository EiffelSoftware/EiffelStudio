indexing
	description: "All shared attributes specific to the debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL_DATA

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

feature {EB_SHARED_PREFERENCES} -- Value

	last_saved_stack_path: STRING is
		do
			Result := last_saved_stack_path_preference.value
		end

	interrupt_every_n_instructions: INTEGER is
		do
			Result := interrupt_every_n_instructions_preference.value
		end

	debug_output_evaluation_enabled: BOOLEAN is
		do
			Result := debug_output_evaluation_enabled_preference.value
		end

	generating_type_evaluation_enabled: BOOLEAN is
		do
			Result := generating_type_evaluation_enabled_preference.value
		end

	min_slice: INTEGER is
			-- From which attribute number should special objects be displayed?
		do
			Result := min_slice_preference.value
		end

	max_slice: INTEGER is
			-- Up to which attribute number should special objects be displayed?
		do
			Result := max_slice_preference.value
		end

	max_evaluation_duration: INTEGER is
		do
			Result := max_evaluation_duration_preference.value
		end

	main_splitter_position: INTEGER is
			--
		do
			Result := main_splitter_position_preference.value
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

	row_unsensitive_foreground_color: EV_COLOR is
		do
			Result := row_unsensitive_foreground_color_preference.value
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

feature {EB_SHARED_PREFERENCES} -- Preference

	last_saved_stack_path_preference: STRING_PREFERENCE
	interrupt_every_n_instructions_preference: INTEGER_PREFERENCE
	debug_output_evaluation_enabled_preference: BOOLEAN_PREFERENCE
	generating_type_evaluation_enabled_preference: BOOLEAN_PREFERENCE
	min_slice_preference: INTEGER_PREFERENCE
	max_slice_preference: INTEGER_PREFERENCE
	max_evaluation_duration_preference: INTEGER_PREFERENCE
	main_splitter_position_preference: INTEGER_PREFERENCE
	local_vs_object_proportion_preference: STRING_PREFERENCE
	left_debug_layout_preference: ARRAY_PREFERENCE
	right_debug_layout_preference: ARRAY_PREFERENCE
	expanded_display_bgcolor_preference: COLOR_PREFERENCE
	number_of_watch_tools_preference: INTEGER_PREFERENCE
	delay_before_cleaning_objects_grid_preference: INTEGER_PREFERENCE
	row_highlight_background_color_preference: COLOR_PREFERENCE
	row_unsensitive_foreground_color_preference: COLOR_PREFERENCE
	select_call_stack_level_on_double_click_preference: BOOLEAN_PREFERENCE
	is_stack_grid_layout_managed_preference: BOOLEAN_PREFERENCE
	is_debugged_grid_layout_managed_preference: BOOLEAN_PREFERENCE
	is_watches_grids_layout_managed_preference: BOOLEAN_PREFERENCE

feature -- Preference Strings

	last_saved_stack_path_string: STRING is "debugger.last_saved_stack_path"
	interrupt_every_n_instructions_string: STRING is "debugger.interrupt_every_N_instructions"
	debug_output_evaluation_enabled_string: STRING is "debugger.debug_output_evaluation"
	generating_type_evaluation_enabled_string: STRING is "debugger.generating_type_evaluation"
	min_slice_string: STRING is "debugger.min_slice"
	max_slice_string: STRING is "debugger.max_slice"
	max_evaluation_duration_preference_string: STRING is "debugger.max_evaluation_duration"
	main_splitter_position_string: STRING is "debugger.main_splitter_position"
	local_vs_object_proportion_string: STRING is "debugger.proportion"
	left_debug_layout_string: STRING is "debugger.left_debug_layout"
	right_debug_layout_string: STRING is "debugger.right_debug_layout"
	expanded_display_bgcolor_string: STRING is "debugger.expanded_display_background_color"
	number_of_watch_tools_string: STRING is "debugger.number_of_watch_tools"
	delay_before_cleaning_objects_string: STRING is "debugger.delay_before_cleaning_objects_grid"
	row_highlight_background_color_string: STRING is "debugger.row_highlight_background_color"
	row_unsensitive_foreground_color_string: STRING is "debugger.row_unsensitive_foreground_color"
	select_call_stack_level_on_double_click_string: STRING is "debugger.select_call_stack_level_on_double_click"
	is_stack_grid_layout_managed_string: STRING is "debugger.stack_grid_layout_managed"
	is_debugged_grid_layout_managed_string: STRING is "debugger.debugged_grid_layout_managed"
	is_watches_grids_layout_managed_string: STRING is "debugger.watches_grids_layout_managed"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "debug_tool")

			last_saved_stack_path_preference := l_manager.new_string_preference_value (l_manager, last_saved_stack_path_string, "")
			last_saved_stack_path_preference.set_hidden (True)
			interrupt_every_n_instructions_preference := l_manager.new_integer_preference_value (l_manager, interrupt_every_n_instructions_string, 1)
			debug_output_evaluation_enabled_preference := l_manager.new_boolean_preference_value (l_manager, debug_output_evaluation_enabled_string, True)
			generating_type_evaluation_enabled_preference := l_manager.new_boolean_preference_value (l_manager, generating_type_evaluation_enabled_string, True)
			min_slice_preference := l_manager.new_integer_preference_value (l_manager, min_slice_string, 0)
			max_slice_preference := l_manager.new_integer_preference_value (l_manager, max_slice_string, 50)
			max_evaluation_duration_preference := l_manager.new_integer_preference_value (l_manager, max_evaluation_duration_preference_string, 5)
			main_splitter_position_preference := l_manager.new_integer_preference_value (l_manager, main_splitter_position_string, 250)
			local_vs_object_proportion_preference := l_manager.new_string_preference_value (l_manager, local_vs_object_proportion_string, "0.5")
			local_vs_object_proportion_preference.set_hidden (True)

			left_debug_layout_preference := l_manager.new_array_preference_value (l_manager, left_debug_layout_string, <<>>)
			right_debug_layout_preference := l_manager.new_array_preference_value (l_manager, right_debug_layout_string, <<>>)
			expanded_display_bgcolor_preference := l_manager.new_color_preference_value (l_manager, expanded_display_bgcolor_string, create {EV_COLOR}.make_with_8_bit_rgb (210, 210, 210))
			number_of_watch_tools_preference := l_manager.new_integer_preference_value (l_manager, number_of_watch_tools_string, 1)
			delay_before_cleaning_objects_grid_preference := l_manager.new_integer_preference_value (l_manager, delay_before_cleaning_objects_string, 500)
			row_highlight_background_color_preference := l_manager.new_color_preference_value (l_manager, row_highlight_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 170))
			row_unsensitive_foreground_color_preference := l_manager.new_color_preference_value (l_manager, row_unsensitive_foreground_color_string, create {EV_COLOR}.make_with_8_bit_rgb (150, 150, 150))
			select_call_stack_level_on_double_click_preference := l_manager.new_boolean_preference_value (l_manager, select_call_stack_level_on_double_click_string, False)
			is_stack_grid_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_stack_grid_layout_managed_string, True)
			is_debugged_grid_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_debugged_grid_layout_managed_string, True)
			is_watches_grids_layout_managed_preference := l_manager.new_boolean_preference_value (l_manager, is_watches_grids_layout_managed_string, True)
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	last_saved_stack_path_preference_not_void: last_saved_stack_path_preference /= Void
	interrupt_every_n_instructions_preference_not_void: interrupt_every_n_instructions_preference /= Void
	debug_output_evaluation_enabled_preference_not_void: debug_output_evaluation_enabled_preference /= Void
	generating_type_evaluation_enabled_preference_not_void: generating_type_evaluation_enabled_preference /= Void
	min_slice_preference_not_void: min_slice_preference /= Void
	max_slice_preference_not_void: max_slice_preference /= Void
	main_splitter_position_preference_not_void: main_splitter_position_preference /= Void
	local_vs_object_proportion_preference_not_void: local_vs_object_proportion_preference /= Void
	left_debug_layout_preference_not_void: left_debug_layout_preference /= Void
	right_debug_layout_preference_not_void: right_debug_layout_preference /= Void
	expanded_display_bgcolor_preference_not_void: expanded_display_bgcolor_preference /= Void
	number_of_watch_tools_preference_not_void: number_of_watch_tools_preference /= Void
	delay_before_cleaning_objects_grid_preference_not_void: delay_before_cleaning_objects_grid_preference /= Void
	row_highlight_background_color_preference_not_void: row_highlight_background_color_preference /= Void
	row_unsensitive_foreground_color_preference_not_void: row_unsensitive_foreground_color_preference /= Void
	select_call_stack_level_on_double_click_preference_not_void: select_call_stack_level_on_double_click_preference /= Void
	is_stack_grid_layout_managed_preference_not_void: is_stack_grid_layout_managed_preference /= Void
	is_debugged_grid_layout_managed_preference_not_void: is_debugged_grid_layout_managed_preference /= Void
	is_watches_grids_layout_managed_preference_not_void: is_watches_grids_layout_managed_preference /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
