indexing
	description: "All shared preferences for the Search tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	EB_METRIC_TOOL_DATA

inherit
	QL_SHARED_UNIT

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

	criterion_completion_list_width: INTEGER is
			-- Width (in pixels) of criterion completion list
		do
			Result := criterion_completion_list_width_preference.value
		end

	criterion_completion_list_height: INTEGER is
			-- Height (in pixels) of criterion completion list
		do
			Result := criterion_completion_list_height_preference.value
		end

	is_invisible_result_filtered: BOOLEAN is
			-- Is invisible result item filtered?
		do
			Result := filter_invisible_result_preference.value
		end

	is_percentage_for_ratio_displayed: BOOLEAN is
			-- Is percentage for ratio metric displayed?
		do
			Result := display_percentage_for_ratio_preference.value
		end

	should_go_to_result_panel_automatically: BOOLEAN is
			-- Should go to result panel automatically after metric evaluation?
		do
			Result := automatic_go_to_result_panel_preference.value
		end

	unit_order: LINKED_LIST [QL_METRIC_UNIT] is
			-- List of metric units in order
		local
			l_order_string: STRING
			l_hash_code_list: LIST [STRING]
			l_unit_table: like metric_tool_unit_table
		do
			l_order_string := unit_order_preference.value
			l_hash_code_list := l_order_string.split (';')
			l_unit_table := metric_tool_unit_table
			create Result.make
			from
				l_hash_code_list.start
			until
				l_hash_code_list.after
			loop
				Result.extend (l_unit_table.item (l_hash_code_list.item.to_integer))
				l_hash_code_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

	is_tree_view_for_history: BOOLEAN is
			-- Is tree view used to display metric history?
		do
			Result := tree_view_for_history_preference.value
		end

	history_flat_view_sorting_order: STRING is
			-- History flat view sorting order
		do
			Result := flat_view_sorting_order_preference.value
		end

	history_tree_view_sorting_order: STRING is
			-- History tree view sorting order
		do
			Result := tree_view_sorting_order_preference.value
		end

	is_old_archive_item_hidden: BOOLEAN is
			-- Should old archive items be hidden?
		do
			Result := hide_old_item_preference.value
		end

	old_archive_item_age: INTEGER is
			-- Age in days for an archive item to be considered old
		do
			Result := old_item_day_preference.value
		end

	is_detailed_result_kept: BOOLEAN is
			-- Is detailed result kept when recalculation metric archive history?
		do
			Result := keep_detailed_result_preference.value
		end

feature -- Setting

	set_unit_order (a_unit_list: LIST [QL_METRIC_UNIT]) is
			-- Set `unit_order_preference' with `a_unit_list'.
		require
			a_unit_list_attached: a_unit_list /= Void
		local
			l_unit_str: STRING
			l_index: INTEGER
			l_count: INTEGER
		do
			create l_unit_str.make (64)
			from
				l_index := 1
				l_count := a_unit_list.count
				a_unit_list.start
			until
				a_unit_list.after
			loop
				l_unit_str.append (a_unit_list.item.hash_code.out)
				if l_index < l_count then
					l_unit_str.append_character (';')
				end
				l_index := l_index + 1
				a_unit_list.forth
			end
			unit_order_preference.set_value (l_unit_str)
		end

feature {EB_SHARED_PREFERENCES} -- Preference

	criterion_completion_list_width_preference: INTEGER_PREFERENCE
	criterion_completion_list_height_preference: INTEGER_PREFERENCE
	filter_invisible_result_preference: BOOLEAN_PREFERENCE
	display_percentage_for_ratio_preference: BOOLEAN_PREFERENCE
	automatic_go_to_result_panel_preference: BOOLEAN_PREFERENCE
	unit_order_preference: STRING_PREFERENCE
	tree_view_for_history_preference: BOOLEAN_PREFERENCE
	flat_view_sorting_order_preference: STRING_PREFERENCE
	tree_view_sorting_order_preference: STRING_PREFERENCE
	hide_old_item_preference: BOOLEAN_PREFERENCE
	old_item_day_preference: INTEGER_PREFERENCE
	keep_detailed_result_preference: BOOLEAN_PREFERENCE

feature {NONE} -- Preference Strings

	criterion_completion_list_width_string: STRING is "tools.metric_tool.criterion_completion_list_width"
	criterion_completion_list_height_string: STRING is "tools.metric_tool.criterion_completion_list_height"
	filter_invisible_result_string: STRING is "tools.metric_tool.filter_invisible_result"
	display_percentage_for_ratio_string: STRING is "tools.metric_tool.display_percentage_for_ratio"
	automatic_go_to_result_panel_string: STRING is "tools.metric_tool.automatic_go_to_result_panel"
	unit_order_string: STRING is "tools.metric_tool.unit_order"
	tree_view_for_history_string: STRING is "tools.metric_tool.tree_view_for_metrc_history"
	flat_view_sorting_order_string: STRING is "tools.metric_tool.history_flat_view_sorting_order"
	tree_view_sorting_order_string: STRING is "tools.metric_tool.history_tree_view_sorting_order"
	hide_old_item_string: STRING is "tools.metric_tool.hide_old_archive"
	old_item_day_string: STRING is "tools.metric_tool.old_archive_age_in_days"
	keep_detailed_result_string: STRING is "tools.metric_tool.keep_detailed_result"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "tools.metric_tool")
			criterion_completion_list_height_preference := l_manager.new_integer_preference_value (l_manager, criterion_completion_list_height_string, 350)
			criterion_completion_list_width_preference := l_manager.new_integer_preference_value (l_manager, criterion_completion_list_width_string, 240)
			filter_invisible_result_preference := l_manager.new_boolean_preference_value (l_manager, filter_invisible_result_string, False)
			display_percentage_for_ratio_preference := l_manager.new_boolean_preference_value (l_manager, display_percentage_for_ratio_string, True)
			automatic_go_to_result_panel_preference := l_manager.new_boolean_preference_value (l_manager, automatic_go_to_result_panel_string, True)
			unit_order_preference := l_manager.new_string_preference_value (l_manager, unit_order_string, initial_unit_order)
			criterion_completion_list_width_preference.set_hidden (True)
			criterion_completion_list_height_preference.set_hidden (True)
			tree_view_for_history_preference := l_manager.new_boolean_preference_value (l_manager, tree_view_for_history_string, False)
			flat_view_sorting_order_preference := l_manager.new_string_preference_value (l_manager, flat_view_sorting_order_string, "1:1")
			flat_view_sorting_order_preference.set_hidden (True)
			tree_view_sorting_order_preference := l_manager.new_string_preference_value (l_manager, tree_view_sorting_order_string, "1:1")
			tree_view_sorting_order_preference.set_hidden (True)
			hide_old_item_preference := l_manager.new_boolean_preference_value (l_manager, hide_old_item_string, False)
			old_item_day_preference := l_manager.new_integer_preference_value (l_manager, old_item_day_string, 30)
			keep_detailed_result_preference := l_manager.new_boolean_preference_value (l_manager, keep_detailed_result_string, False)
		end

	preferences: PREFERENCES
			-- Preferences

	metric_tool_unit_table: HASH_TABLE [QL_METRIC_UNIT, INTEGER] is
			-- Table of metric units used in metric tool
			-- Key is hash-code of a unit, value is that unit.
		once
			create Result.make (11)
			Result.put (target_unit, target_unit.hash_code)
			Result.put (group_unit, group_unit.hash_code)
			Result.put (class_unit, class_unit.hash_code)
			Result.put (generic_unit, generic_unit.hash_code)
			Result.put (feature_unit, feature_unit.hash_code)
			Result.put (assertion_unit, assertion_unit.hash_code)
			Result.put (argument_unit, argument_unit.hash_code)
			Result.put (local_unit, local_unit.hash_code)
			Result.put (line_unit, line_unit.hash_code)
			Result.put (compilation_unit, compilation_unit.hash_code)
			Result.put (ratio_unit, ratio_unit.hash_code)
		ensure
			result_attached: Result /= Void
		end

	initial_unit_order: STRING is
			-- String representation initial metric unit order
		do
			create Result.make (64)

			Result.append (class_unit.hash_code.out)
			Result.append_character (';')

			Result.append (feature_unit.hash_code.out)
			Result.append_character (';')

			Result.append (target_unit.hash_code.out)
			Result.append_character (';')

			Result.append (group_unit.hash_code.out)
			Result.append_character (';')


			Result.append (generic_unit.hash_code.out)
			Result.append_character (';')

			Result.append (assertion_unit.hash_code.out)
			Result.append_character (';')

			Result.append (argument_unit.hash_code.out)
			Result.append_character (';')

			Result.append (local_unit.hash_code.out)
			Result.append_character (';')

			Result.append (line_unit.hash_code.out)
			Result.append_character (';')

			Result.append (compilation_unit.hash_code.out)
			Result.append_character (';')

			Result.append (ratio_unit.hash_code.out)
		ensure
			result_attached: Result /= Void
		end

invariant
	preferences_not_void: preferences /= Void

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

end -- class EB_SEARCH_TOOL_DATA

