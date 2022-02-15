note
	description: "All shared preferences for the source control tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	EB_SOURCE_CONTROL_TOOL_DATA

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

feature -- Value

feature {EB_SHARED_PREFERENCES} -- Preference

	svn_command_preference: STRING_PREFERENCE
	git_command_preference: STRING_PREFERENCE
	use_external_svn_diff_command_preference: BOOLEAN_PREFERENCE
	use_external_git_diff_command_preference: BOOLEAN_PREFERENCE
	external_svn_diff_command_preference: STRING_PREFERENCE
	external_git_diff_command_preference: STRING_PREFERENCE
	status_auto_check_enabled_preference: BOOLEAN_PREFERENCE

feature {NONE} -- Preference Strings

	svn_command_string: STRING = "tools.source_control.svn_command"

	git_command_string: STRING = "tools.source_control.git_command"

	use_external_svn_diff_command_string: STRING = "tools.source_control.use_external_svn_diff_command"

	use_external_git_diff_command_string: STRING = "tools.source_control.use_external_git_diff_command"

	external_svn_diff_command_string: STRING = "tools.source_control.external_svn_diff_command"

	external_git_diff_command_string: STRING = "tools.source_control.external_git_diff_command"

	status_auto_check_enabled_string: STRING = "tools.source_control.status_auto_check_enabled"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "tools.source_control")

			svn_command_preference := l_manager.new_string_preference_value (l_manager, svn_command_string, "svn")
			git_command_preference := l_manager.new_string_preference_value (l_manager, git_command_string, "git")
			use_external_svn_diff_command_preference := l_manager.new_boolean_preference_value (l_manager, use_external_svn_diff_command_string, False)
			use_external_git_diff_command_preference := l_manager.new_boolean_preference_value (l_manager, use_external_git_diff_command_string, False)
			external_svn_diff_command_preference := l_manager.new_string_preference_value (l_manager, external_svn_diff_command_string, "")
			external_git_diff_command_preference := l_manager.new_string_preference_value (l_manager, external_git_diff_command_string, "")
			status_auto_check_enabled_preference := l_manager.new_boolean_preference_value (l_manager, status_auto_check_enabled_string, False)
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	svn_command_preference_set: svn_command_preference /= Void
	git_command_preference_set: git_command_preference /= Void
	use_external_svn_diff_command_preference_set: use_external_svn_diff_command_preference /= Void
	use_external_git_diff_command_preference_set: use_external_git_diff_command_preference /= Void
	external_svn_diff_command_preference_set: external_svn_diff_command_preference /= Void
	external_git_diff_command_preference_set: external_git_diff_command_preference /= Void
	status_auto_check_enabled_preference_set: status_auto_check_enabled_preference /= Void

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
