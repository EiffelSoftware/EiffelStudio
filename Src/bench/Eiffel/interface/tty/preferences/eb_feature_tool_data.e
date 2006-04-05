indexing
	description: "All shared attributes specific to the feature tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TOOL_DATA

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

	show_all_callers: BOOLEAN is
			-- Show all callers (as opposed to local callers) in `callers' form
		do
			Result := show_all_callers_preference.value
		end

	expand_feature_tree: BOOLEAN is
			-- Automatically expand the feature tree
		do
			Result := expand_feature_tree_preference.value
		end

	is_signature_enabled: BOOLEAN is
			-- Do we display signature of feature ?
		do
			Result := is_signature_enabled_preference.value
		end

	is_alias_enabled: BOOLEAN is
			-- Is alias name shown?
		do
			Result := is_alias_enabled_preference.value
		end

	is_assigner_enabled: BOOLEAN is
			-- Is assigner command shown?
		do
			Result := is_assigner_enabled_preference.value
		end

feature {NONE} -- Preference

	show_all_callers_preference: BOOLEAN_PREFERENCE
		-- Show all callers (as opposed to local callers) in `callers' form

	expand_feature_tree_preference: BOOLEAN_PREFERENCE
		-- Automatically expand the feature tree

feature {EB_FEATURES_TOOL} -- Preference

	is_signature_enabled_preference: BOOLEAN_PREFERENCE
			-- Do we display signature of feature ?

	is_alias_enabled_preference: BOOLEAN_PREFERENCE
			-- Is alias name shown?	

	is_assigner_enabled_preference: BOOLEAN_PREFERENCE
			-- Is assigner command shown?

feature {NONE} -- Preference Strings

	expand_feature_tree_string: STRING is "interface.development_window.expand_feature_tree"
	show_all_callers_string: STRING is "tools.context_tool.show_all_callers"

	is_signature_enabled_string: STRING is "interface.development_window.features_tool.is_signature_enabled"
	is_alias_enabled_string: STRING is "interface.development_window.features_tool.is_alias_enabled"
	is_assigner_enabled_string: STRING is "interface.development_window.features_tool.is_assigner_enabled"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EC_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "feature_tool")

			show_all_callers_preference := l_manager.new_boolean_preference_value (l_manager, show_all_callers_string, False)
			expand_feature_tree_preference := l_manager.new_boolean_preference_value (l_manager, expand_feature_tree_string, True)

			is_signature_enabled_preference := l_manager.new_boolean_preference_value (l_manager, is_signature_enabled_string, False)
			is_alias_enabled_preference := l_manager.new_boolean_preference_value (l_manager, is_alias_enabled_string, False)
			is_assigner_enabled_preference := l_manager.new_boolean_preference_value (l_manager, is_assigner_enabled_string, False)
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	show_all_callers_preference_not_void: show_all_callers_preference /= Void
	expand_feature_tree_preference_not_void: expand_feature_tree_preference /= Void

	is_signature_enabled_preference_not_void: expand_feature_tree_preference /= Void
	is_alias_enabled_preference_not_void: is_alias_enabled_preference /= Void
	is_assigner_enabled_preference_not_void: is_assigner_enabled_preference /= Void

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

end -- class EB_FEATURE_TOOL_DATA
