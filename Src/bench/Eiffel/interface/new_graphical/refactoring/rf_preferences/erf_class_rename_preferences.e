indexing
	description: "All preferences for the class rename refactoring."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CLASS_RENAME_PREFERENCES

inherit
	ERF_PREFERENCES
		redefine
			initialize_preferences
		end

feature -- Value

	file_rename: BOOLEAN is
			-- Should the file be renamed?
		do
			Result := file_rename_preference.value
		end

	old_class_name: STRING is
			-- The old name of the class.
		do
			Result := old_class_name_preference.value
		end


	new_class_name: STRING is
			-- The new name of the class.
		do
			Result := new_class_name_preference.value
		end

	all_classes: BOOLEAN is
			-- Should all classes be processed?
		do
			Result := all_classes_preference.value
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

	set_old_class_name (a_name: STRING) is
			-- Set the old class name.
		require
			a_name_not_void: a_name /= void
			name_in_upper: a_name.as_upper.is_equal (a_name)
		do
			old_class_name_preference.set_value (a_name)
		end

	set_new_class_name (a_name: STRING) is
			-- Set the new class name.
		require
			a_name_not_void: a_name /= void
			name_in_upper: a_name.as_upper.is_equal (a_name)
		do
			new_class_name_preference.set_value (a_name)
		end

	set_all_classes (a_value: BOOLEAN) is
			-- Set the all classes flag.
		do
			all_classes_preference.set_value (a_value)
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

	file_rename_preference: BOOLEAN_PREFERENCE
	old_class_name_preference: STRING_PREFERENCE
	new_class_name_preference: STRING_PREFERENCE
	all_classes_preference: BOOLEAN_PREFERENCE
	update_comments_preference: BOOLEAN_PREFERENCE
	update_strings_preference: BOOLEAN_PREFERENCE

feature {NONE} -- Preference Strings

	file_rename_string: STRING is "tools.refactoring.class_rename.file_rename"
	old_class_name_string: STRING is "tools.refactoring.class_rename.old_class_name"
	new_class_name_string: STRING is "tools.refactoring.class_rename.new_class_name"
	all_classes_string: STRING is "tools.refactoring.class_rename.all_classes"
	update_comments_string: STRING is "tools.refactoring.class_rename.update_comments"
	update_strings_string: STRING is "tools.refactoring.class_rename.update_strings"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
			l_update_agent: PROCEDURE [ANY, TUPLE]
		do
			create l_manager.make (preferences, "refactoring.class_rename")
			l_update_agent := agent update

			file_rename_preference := l_manager.new_boolean_preference_value (l_manager, file_rename_string, False)
			file_rename_preference.set_description ("Should the file be renamed to the new name?")
			file_rename_preference.change_actions.extend (l_update_agent)

			old_class_name_preference := l_manager.new_string_preference_value (l_manager, old_class_name_string, "OLD_NAME")
			old_class_name_preference.set_description ("The old name of the class.")
			old_class_name_preference.change_actions.extend (l_update_agent)
			old_class_name_preference.set_hidden (True)

			new_class_name_preference := l_manager.new_string_preference_value (l_manager, new_class_name_string, "NEW_NAME")
			new_class_name_preference.set_description ("The new name of the class.")
			new_class_name_preference.change_actions.extend (l_update_agent)
			new_class_name_preference.set_hidden (True)

			all_classes_preference := l_manager.new_boolean_preference_value (l_manager, all_classes_string, False)
			all_classes_preference.set_description ("Should all classes be processed?")
			all_classes_preference.change_actions.extend (l_update_agent)
			all_classes_preference.set_hidden (True)

			update_comments_preference := l_manager.new_boolean_preference_value (l_manager, update_comments_string, False)
			update_comments_preference.set_description ("Should the occurance of the class name in comments be changed?")
			update_comments_preference.change_actions.extend (l_update_agent)
			update_comments_preference.set_hidden (True)

			update_strings_preference := l_manager.new_boolean_preference_value (l_manager, update_strings_string, False)
			update_strings_preference.set_description ("Should the occurance of the class name in strings be changed?")
			update_strings_preference.change_actions.extend (l_update_agent)
			update_strings_preference.set_hidden (True)
		end

invariant
	file_rename_preference_not_void: file_rename_preference /= Void
	old_class_name_preference_not_void: old_class_name_preference /= Void
	new_class_name_preference_not_void: new_class_name_preference /= Void
	all_classes_preference_not_void: all_classes_preference /= Void
	update_comments_preference_not_void: update_comments_preference /= Void
	update_strings_preference_not_void: update_strings_preference /= Void

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
