indexing
	description: "All shared preferences for the Search tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	EB_METRIC_TOOL_DATA

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

feature {EB_SHARED_PREFERENCES} -- Preference

	criterion_completion_list_width_preference: INTEGER_PREFERENCE
	criterion_completion_list_height_preference: INTEGER_PREFERENCE

feature {NONE} -- Preference Strings

	criterion_completion_list_width_string: STRING is "tools.metric_tool.criterion_completion_list_width"
	criterion_completion_list_height_string: STRING is "tools.metric_tool.criterion_completion_list_height"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "tools.metric_tool")
			criterion_completion_list_height_preference := l_manager.new_integer_preference_value (l_manager, criterion_completion_list_height_string, 250)
			criterion_completion_list_width_preference := l_manager.new_integer_preference_value (l_manager, criterion_completion_list_width_string, 200)
		end

	preferences: PREFERENCES
			-- Preferences

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

