note
	description: "All shared preferences for the Error List tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ERROR_LIST_DATA

create
	make

feature {NONE} -- Initialization

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

feature -- Value

	expand_errors: BOOLEAN
			-- Indicates if errors in the error list should be expanded
		do
			Result := expand_errors_preferences.value
		end

	show_tooltip: BOOLEAN
			-- Indicate if rich tooltip {EVS_GENERAL_TOOLTIP_WINDOW} should be shown
		do
			Result := show_tooltip_preferences.value
		end

	report_c_compiler_errors: BOOLEAN
			-- Level to report C compilation errors.
		do
			Result := report_c_compiler_errors_preference.selected_index > 1
		end

	report_c_compiler_errors_and_warnings: BOOLEAN
			-- Level to report C compilation errors and warnings
		do
			Result := report_c_compiler_errors_preference.selected_index > 2
		end

feature {ES_ERROR_LIST_TOOL_PANEL, EB_SHARED_PREFERENCES} -- Preference

	expand_errors_preferences: BOOLEAN_PREFERENCE
	show_tooltip_preferences: BOOLEAN_PREFERENCE
	report_c_compiler_errors_preference: ARRAY_PREFERENCE

feature {NONE} -- Preference Strings

	expand_errors_string: STRING = "tools.error_list.expand_errors"
	report_c_compiler_errors_string: STRING = "tools.error_list.report_c_compiler_errors"
	show_tooltip_string: STRING = "tools.error_list.show_tooltip"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "tools.tools.error_list")
			expand_errors_preferences := l_manager.new_boolean_preference_value (l_manager, expand_errors_string, False)
			show_tooltip_preferences := l_manager.new_boolean_preference_value (l_manager, show_tooltip_string, True)

			report_c_compiler_errors_preference := l_manager.new_array_preference_value (l_manager, report_c_compiler_errors_string, <<"none", "errors", "errors_and_warnings">>)
			report_c_compiler_errors_preference.set_is_choice (True)
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: attached preferences
	expand_errors_preference_attached: attached expand_errors_preferences
	show_tooltip_preference_attached: attached show_tooltip_preferences
	report_c_compiler_errors_preference_attached: attached report_c_compiler_errors_preference

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end
