indexing
	description: "All shared preferences for the Search tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SEARCH_TOOL_DATA

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

	init_incremental: BOOLEAN is
			-- Incremental search is disabled or not when opening a window.
		do
			Result := init_incremental_preference.value
		end

	init_match_case: BOOLEAN is
			-- Match case is disabled or not when opening a window.
		do
			Result := init_match_case_preference.value
		end

	init_use_regular_expression: BOOLEAN is
			-- Regular_expression is disabled or not when opening a window.
		do
			Result := init_use_regular_expression_preference.value
		end

	init_whole_word: BOOLEAN is
			-- Whole_word is disabled or not when opening a window.
		do
			Result := init_whole_word_preference.value
		end

	init_search_backwards: BOOLEAN is
			-- Search_backwards is disabled or not when opening a window.
		do
			Result := init_search_backwards_preference.value
		end

	init_scope: STRING is
			-- Which scope is going to use when opening a window.
		do
			Result := init_scope_preference.selected_value
		end

	init_only_compiled_classes: BOOLEAN is
			-- Only compiled classes is disabled or not when opening a window.
		do
			Result := init_only_compiled_classes_preference.value
		end

	init_subclusters: BOOLEAN is
			-- Search subclusters is disabled or not when opening a window.
		do
			Result := init_subclusters_preference.value
		end

	none_result_keyword_field_background_color: EV_COLOR is
			-- Background color of keyword field, when no result.
		do
			Result := none_result_keyword_field_background_color_preference.value
		end

feature {EB_SHARED_PREFERENCES} -- Preference

	init_incremental_preference: BOOLEAN_PREFERENCE
	init_match_case_preference: BOOLEAN_PREFERENCE
	init_use_regular_expression_preference: BOOLEAN_PREFERENCE
	init_whole_word_preference: BOOLEAN_PREFERENCE
	init_search_backwards_preference: BOOLEAN_PREFERENCE

	init_scope_preference: ARRAY_PREFERENCE
	init_only_compiled_classes_preference: BOOLEAN_PREFERENCE
	init_subclusters_preference: BOOLEAN_PREFERENCE

	none_result_keyword_field_background_color_preference: COLOR_PREFERENCE

feature {NONE} -- Preference Strings

	init_incremental_string: STRING is "tools.search_tool.init_incremental"
	init_match_case_string: STRING is "tools.search_tool.init_match_case"
	init_use_regular_expression_string: STRING is "tools.search_tool.init_use_regular_expression"
	init_whole_word_string: STRING is "tools.search_tool.init_whole_word"
	init_search_backwards_string: STRING is "tools.search_tool.init_search_backwards"

	init_scope_string: STRING is "tools.search_tool.init_scope"
	init_only_compiled_classes_string: STRING is "tools.search_tool.init_only_compiled_classes"
	init_subclusters_string: STRING is "tools.search_tool.init_subclusters"

	none_result_keyword_field_background_color_string: STRING is "tools.search_tool.none_result_keyword_field_background_color"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "tools.search_tool")
			init_incremental_preference := l_manager.new_boolean_preference_value (l_manager, init_incremental_string, True)
			init_match_case_preference := l_manager.new_boolean_preference_value (l_manager, init_match_case_string, False)
			init_use_regular_expression_preference := l_manager.new_boolean_preference_value (l_manager, init_use_regular_expression_string, True)
			init_whole_word_preference := l_manager.new_boolean_preference_value (l_manager, init_whole_word_string, False)
			init_search_backwards_preference := l_manager.new_boolean_preference_value (l_manager, init_search_backwards_string, False)

			init_scope_preference := l_manager.new_array_preference_value (l_manager, init_scope_string, <<"Current Editor","Whole Project","Custom">>)
			init_scope_preference.set_is_choice (True)
			init_only_compiled_classes_preference := l_manager.new_boolean_preference_value (l_manager, init_only_compiled_classes_string, False)
			init_subclusters_preference := l_manager.new_boolean_preference_value (l_manager, init_subclusters_string, True)
			none_result_keyword_field_background_color_preference := l_manager.new_color_preference_value (l_manager, none_result_keyword_field_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 175, 138))
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

end -- class EB_SEARCH_TOOL_DATA

