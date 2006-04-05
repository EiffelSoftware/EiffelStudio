indexing
	description: "All preferences for the feature rename refactoring."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_FEATURE_RENAME_PREFERENCES

inherit
	ERF_PREFERENCES
		redefine
			initialize_preferences
		end

feature -- Value

	new_feature_name: STRING is
			-- The new name of the feature.
		do
			Result := new_feature_name_preference.value
		end

	update_comments: BOOLEAN is
			-- Should the occurance of the class name in comments be changed?
		do
			Result := update_comments_preference.value
		end

	update_strings: BOOLEAN is
			-- Should the occurance of the class name in strings be changed?
		do
			Result := update_strings_preference.value
		end

feature -- Change value

	set_new_feature_name (a_name: STRING) is
			-- Set the new feature name.
		require
			a_name_not_void: a_name /= void
			name_in_upper: a_name.as_upper.is_equal (a_name)
		do
			new_feature_name_preference.set_value (a_name)
		end

	set_update_comments (a_value: BOOLEAN) is
			-- Set the update comments flag.
		do
			update_comments_preference.set_value (a_value)
		end

	set_update_strings (a_value: BOOLEAN) is
			-- Set the update strings flag.
		do
			update_strings_preference.set_value (a_value)
		end


feature {NONE} -- Preference

	new_feature_name_preference: STRING_PREFERENCE
	update_comments_preference: BOOLEAN_PREFERENCE
	update_strings_preference: BOOLEAN_PREFERENCE

feature {NONE} -- Preference Strings

	new_feature_name_string: STRING is "tools.refactoring.feature_rename.new_feature_name"
	update_comments_string: STRING is "tools.refactoring.feature_rename.update_comments"
	update_strings_string: STRING is "tools.refactoring.feature_rename.update_strings"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
			l_update_agent: PROCEDURE [ANY, TUPLE]
		do
			create l_manager.make (preferences, "refactoring.feature_rename")
			l_update_agent := agent update

			new_feature_name_preference := l_manager.new_string_preference_value (l_manager, new_feature_name_string, "NEW_NAME")
			new_feature_name_preference.set_description ("The new name of the feature.")
			new_feature_name_preference.change_actions.extend (l_update_agent)
			new_feature_name_preference.set_hidden (True)

			update_comments_preference := l_manager.new_boolean_preference_value (l_manager, update_comments_string, False)
			update_comments_preference.set_description ("Should the occurance of the feature name in comments be changed?")
			update_comments_preference.change_actions.extend (l_update_agent)
			update_comments_preference.set_hidden (True)

			update_strings_preference := l_manager.new_boolean_preference_value (l_manager, update_strings_string, False)
			update_strings_preference.set_description ("Should the occurance of the feature name in strings be changed?")
			update_strings_preference.change_actions.extend (l_update_agent)
			update_strings_preference.set_hidden (True)
		end

invariant
	new_feature_name_preference_not_void: new_feature_name_preference /= Void
	update_comments_preference_not_void: update_comments_preference /= Void
	update_strings_preference_not_void: update_strings_preference /= Void

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

end
