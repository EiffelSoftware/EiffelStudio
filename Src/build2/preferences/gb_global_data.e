indexing
	description: "Global preference data."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GLOBAL_DATA

create
	make

feature {GB_PREFERENCES} -- Initialization

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

feature {GB_SHARED_PREFERENCES} -- Value

	show_tip_of_the_day: BOOLEAN is
			-- 
		do
			Result := show_tip_of_the_day_preference.value
		end
	
	number_of_recent_projects: INTEGER is
			-- 
		do
			Result := number_of_recent_projects_preference.value
		end

	build_window_height: INTEGER is
			-- 
		do
			Result := build_window_height_preference.value
		end
	
	build_window_width: INTEGER is
			-- 
		do
			Result := build_window_width_preference.value
		end
	
	build_window_x_position: INTEGER is
			-- 
		do
			Result := build_window_x_position_preference.value
		end
	
	build_window_y_position: INTEGER is
			-- 
		do
			Result := build_window_y_position_preference.value
		end
		
	main_split_position: INTEGER is
			-- 
		do
			Result := main_split_position_preference.value
		end
	
	tip_of_day_index: INTEGER is
			-- 
		do
			Result := tip_of_day_index_preference.value
		end
	
	tool_order: ARRAY [STRING] is
			-- 
		do
			Result := tool_order_preference.value
		end
	
	external_tool_order: ARRAY [STRING] is
			-- 
		do
			Result := external_tool_order_preference.value
		end

	recent_projects_string: ARRAY [STRING] is
			-- 
		do
			Result := recent_projects_string_preference.value
		end
	
	tools_on_top: BOOLEAN is
			-- 
		do
			Result := tools_on_top_preference.value
		end
	
	type_selector_classic_mode: BOOLEAN is
			-- 
		do
			Result := type_selector_classic_mode_preference.value
		end

feature -- Preference

	show_tip_of_the_day_preference: BOOLEAN_PREFERENCE
	
	number_of_recent_projects_preference: INTEGER_PREFERENCE
	
	build_window_height_preference: INTEGER_PREFERENCE
	
	build_window_width_preference: INTEGER_PREFERENCE
		
	build_window_x_position_preference: INTEGER_PREFERENCE
	
	build_window_y_position_preference: INTEGER_PREFERENCE
	
	main_split_position_preference: INTEGER_PREFERENCE
	
	tip_of_day_index_preference: INTEGER_PREFERENCE
	
	tool_order_preference: ARRAY_PREFERENCE
	
	external_tool_order_preference: ARRAY_PREFERENCE

	recent_projects_string_preference: ARRAY_PREFERENCE
	
	tools_on_top_preference: BOOLEAN_PREFERENCE
	
	type_selector_classic_mode_preference: BOOLEAN_PREFERENCE

feature -- Preference Strings

	show_tip_of_the_day_string: STRING is "global_preferences.show_tip_of_the_day"
	
	number_of_recent_projects_string: STRING is "global_preferences.number_of_recent_projects"

	build_window_height_string: STRING is "global_preferences.build_window_height"
	
	build_window_width_string: STRING is "global_preferences.build_window_width"
	
	build_window_x_position_string: STRING is "global_preferences.build_window_x_position"
	
	build_window_y_position_string: STRING is "global_preferences.build_window_y_position"
	
	main_split_position_string: STRING is "global_preferences.main_split_position"
	
	tip_of_day_index_string: STRING is "global_preferences.tip_of_day_index"
	
	tool_order_string: STRING is "global_preferences.tool_order"
	
	external_tool_order_string: STRING is "global_preferences.external_tool_order"

	recent_projects_string_string: STRING is "global_preferences.recent_projects"
	
	tools_on_top_string:STRING is "global_preferences.tools_on_top"
	
	type_selector_classic_mode_string: string is "global_preferences.type_selector_classic_mode"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: GB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "global_preferences")			
			
			show_tip_of_the_day_preference := l_manager.new_boolean_resource_value (l_manager, show_tip_of_the_day_string, True)		
			number_of_recent_projects_preference := l_manager.new_integer_resource_value (l_manager, number_of_recent_projects_string, 10)		
			build_window_height_preference := l_manager.new_integer_resource_value (l_manager, build_window_height_string, 600)
			build_window_width_preference := l_manager.new_integer_resource_value (l_manager, build_window_width_string, 800)
			build_window_x_position_preference := l_manager.new_integer_resource_value (l_manager, build_window_x_position_string, 50)
			build_window_y_position_preference := l_manager.new_integer_resource_value (l_manager, build_window_y_position_string, 50)
			main_split_position_preference := l_manager.new_integer_resource_value (l_manager, main_split_position_string, 250)
			tip_of_day_index_preference := l_manager.new_integer_resource_value (l_manager, tip_of_day_index_string, 1)
			tool_order_preference := l_manager.new_array_resource_value (l_manager, tool_order_string, <<"typeselector_normal_100_100","componentselector_normal_100_100","windowselector_normal_100_100">>)
			external_tool_order_preference := l_manager.new_array_resource_value (l_manager, external_tool_order_string, <<"">>)
			recent_projects_string_preference := l_manager.new_array_resource_value (l_manager, recent_projects_string_string, <<"">>)
			tools_on_top_preference := l_manager.new_boolean_resource_value (l_manager, tools_on_top_string, True)
			type_selector_classic_mode_preference := l_manager.new_boolean_resource_value (l_manager, type_selector_classic_mode_string, True)
		end
	
	preferences: PREFERENCES
			-- Preferences
	
invariant
	preferences_not_void: preferences /= Void

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


end
