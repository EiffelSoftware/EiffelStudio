note
	description: "All shared preferences for the Search tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_DATA

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

feature {EB_SHARED_PREFERENCES} -- Value

	odd_row_background_color: EV_COLOR
			-- Background color of odd rows in class browser
		do
			Result := odd_row_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	even_row_background_color: EV_COLOR
			-- Background color of even rows in class browser
		do
			Result := even_row_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	is_feature_from_any_shown: BOOLEAN
			-- Are unchanged features from class {ANY} shown?
		do
			Result := show_feature_from_any_preference.value
		end

	is_tooltip_shown: BOOLEAN
			-- Is tooltip shown?
		do
			Result := show_tooltip_preference.value
		end

	class_flat_view_sorting_order: STRING
			-- String representation of class flat view sorting order
		do
			Result := class_flat_view_sorting_order_preference.value
		end

	class_tree_view_sorting_order: STRING
			-- String representation of class tree view sorting order
		do
			Result := class_tree_view_sorting_order_preference.value
		end

	class_client_view_sorting_order: STRING
			-- String representation of class client view sorting order
		do
			Result := class_client_view_sorting_order_preference.value
		end

	feature_view_sorting_order: STRING
			-- String representation of feature view sorting order
		do
			Result := feature_view_sorting_order_preference.value
		end

	dependency_view_sorting_order: STRING
			-- String representation of dependency view sorting order
		do
			Result := dependency_view_sorting_order_preference.value
		end

	is_item_path_shown: BOOLEAN
			-- Is item path shown?
		do
			Result := show_item_path_preference.value
		end

	is_self_dependency_shown: BOOLEAN
			-- Is dependency on self shown?
		do
			Result := show_self_dependency_preference.value
		end

	should_referenced_class_be_expanded: BOOLEAN
			-- Should referenced classes in dependency view be expanded by default?
		do
			Result := expand_referenced_class_preference.value
		end

	should_referencer_class_be_expanded: BOOLEAN
			-- Should referencer classes in dependency view be expanded by default?
		do
			Result := expand_referencer_class_preference.value
		end

	is_class_categorized_in_folder: BOOLEAN
			-- Should classes be categorized in physical folders where they locates?
		do
			Result := categorized_folder_preference.value
		end

	is_syntactical_class_shown: BOOLEAN
			-- Should syntactical referenced classes be displayed?
		do
			Result := syntactical_class_preference.value
		end

	is_inheritance_class_shown: BOOLEAN
			-- Should inheritance classes be displayed?
		do
			Result := inheritance_class_preference.value
		end

	is_normal_referenced_class_shown: BOOLEAN
			-- Should normally referenced classes be displayed?
		do
			Result := normal_referenced_class_preference.value
		end

	is_folder_search_recursive: BOOLEAN
			-- Should search for classes in a folder be recursive?
		do
			Result := folder_search_recursive_preference.value
		end

	should_categorized_folder_level_be_expanded: BOOLEAN
			-- Should categorized folder level in dependency view be expanded?
		do
			Result := expand_categorized_folder_level_preference.value
		end

	caller_sorting_order: STRING
			-- Caller sorting order status
		do
			Result := caller_sorting_order_preference.value
		end

	callee_sorting_order: STRING
			-- Caller sorting order status
		do
			Result := callee_sorting_order_preference.value
		end

feature {EB_SHARED_PREFERENCES} -- Preference

	odd_row_background_color_preference: COLOR_PREFERENCE
	even_row_background_color_preference: COLOR_PREFERENCE
	show_feature_from_any_preference: BOOLEAN_PREFERENCE
	show_tooltip_preference: BOOLEAN_PREFERENCE
	class_flat_view_sorting_order_preference: STRING_PREFERENCE
	class_tree_view_sorting_order_preference: STRING_PREFERENCE
	class_client_view_sorting_order_preference: STRING_PREFERENCE
	feature_view_sorting_order_preference: STRING_PREFERENCE
	dependency_view_sorting_order_preference: STRING_PREFERENCE
	show_item_path_preference: BOOLEAN_PREFERENCE
	show_self_dependency_preference: BOOLEAN_PREFERENCE
	expand_referenced_class_preference: BOOLEAN_PREFERENCE
	expand_referencer_class_preference: BOOLEAN_PREFERENCE
	categorized_folder_preference: BOOLEAN_PREFERENCE
	syntactical_class_preference: BOOLEAN_PREFERENCE
	inheritance_class_preference: BOOLEAN_PREFERENCE
	normal_referenced_class_preference: BOOLEAN_PREFERENCE
	folder_search_recursive_preference: BOOLEAN_PREFERENCE
	expand_categorized_folder_level_preference: BOOLEAN_PREFERENCE
	caller_sorting_order_preference: STRING_PREFERENCE
	callee_sorting_order_preference: STRING_PREFERENCE

feature {NONE} -- Preference Strings

	odd_row_background_color_string: STRING = "tools.class_browser.odd_row_background_color"
	even_row_background_color_string: STRING = "tools.class_browser.even_row_background_color"
	show_feature_from_any_string: STRING = "tools.class_browser.show_unchanged_feature_from_any"
	show_tooltip_string: STRING = "tools.class_browser.show_tooltip"
	class_flat_view_sorting_order_string: STRING = "tools.class_browser.class_flat_view_sorting_order"
	class_tree_view_sorting_order_string: STRING = "tools.class_browser.class_flat_tree_sorting_order"
	class_client_view_sorting_order_string: STRING = "tools.class_browser.class_flat_client_sorting_order"
	feature_view_sorting_order_string: STRING = "tools.class_browser.feature_view_sorting_order"
	dependency_view_sorting_order_string: STRING = "tools.class_browser.dependency_view_sorting_order"
	show_item_path_string: STRING = "tools.class_browser.show_item_path"
	show_self_dependency_string: STRING = "tools.class_browser.show_self_dependency"
	expand_referenced_class_string: STRING = "tools.class_browser.expand_referenced_class"
	expand_referencer_class_string: STRING = "tools.class_browser.expand_referencer_class"
	categorized_folder_string: STRING = "tools.class_browser.classes_categorized_folder"
	syntactical_class_string: STRING = "tools.class_browser.syntactical_classes"
	inheritance_class_string: STRING = "tools.class_browser.inheritance_classes"
	normal_referenced_class_string: STRING = "tools.class_browser.normal_referenced_classes"
	folder_search_recursive_string: STRING = "tools.class_browser.folder_search_recursive"
	expand_categorized_folder_level_string: STRING = "tools.class_browser.expand_categorized_folder_level"
	caller_sorting_order_string: STRING = "tools.class_browser.caller_sorting_order"
	callee_sorting_order_string: STRING = "tools.class_browser.callee_sorting_order"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "tools.class_browser")
			odd_row_background_color_preference := l_manager.new_color_preference_value (l_manager, odd_row_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (240, 240, 240))
			even_row_background_color_preference := l_manager.new_color_preference_value (l_manager, even_row_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			show_feature_from_any_preference := l_manager.new_boolean_preference_value (l_manager, show_feature_from_any_string, False)
			show_tooltip_preference := l_manager.new_boolean_preference_value (l_manager, show_tooltip_string, False)
			class_flat_view_sorting_order_preference := l_manager.new_string_preference_value (l_manager, class_flat_view_sorting_order_string, "2:1")
			class_flat_view_sorting_order_preference.set_hidden (True)
			class_tree_view_sorting_order_preference := l_manager.new_string_preference_value (l_manager, class_tree_view_sorting_order_string, "1:1")
			class_client_view_sorting_order_preference := l_manager.new_string_preference_value (l_manager, class_client_view_sorting_order_string, "1:1")
			class_tree_view_sorting_order_preference.set_hidden (True)
			feature_view_sorting_order_preference := l_manager.new_string_preference_value (l_manager, feature_view_sorting_order_string, "2:1")
			feature_view_sorting_order_preference.set_hidden (True)

			dependency_view_sorting_order_preference := l_manager.new_string_preference_value (l_manager, dependency_view_sorting_order_string, "1:1,2:1,3:1,4:1")
			dependency_view_sorting_order_preference.set_hidden (True)
			show_item_path_preference := l_manager.new_boolean_preference_value (l_manager, show_item_path_string, False)
			show_self_dependency_preference := l_manager.new_boolean_preference_value (l_manager, show_self_dependency_string, False)
			expand_referenced_class_preference := l_manager.new_boolean_preference_value (l_manager, expand_referenced_class_string, True)
			expand_referencer_class_preference := l_manager.new_boolean_preference_value (l_manager, expand_referencer_class_string, False)
			categorized_folder_preference := l_manager.new_boolean_preference_value (l_manager, categorized_folder_string, False)
			syntactical_class_preference := l_manager.new_boolean_preference_value (l_manager, syntactical_class_string, False)
			inheritance_class_preference := l_manager.new_boolean_preference_value (l_manager, inheritance_class_string, False)
			normal_referenced_class_preference := l_manager.new_boolean_preference_value (l_manager, normal_referenced_class_string, True)
			folder_search_recursive_preference := l_manager.new_boolean_preference_value (l_manager, folder_search_recursive_string, True)
			expand_categorized_folder_level_preference := l_manager.new_boolean_preference_value (l_manager, expand_categorized_folder_level_string, False)
			caller_sorting_order_preference := l_manager.new_string_preference_value (l_manager, caller_sorting_order_string, "1:1")
			callee_sorting_order_preference := l_manager.new_string_preference_value (l_manager, callee_sorting_order_string, "1:1")
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void

note
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

