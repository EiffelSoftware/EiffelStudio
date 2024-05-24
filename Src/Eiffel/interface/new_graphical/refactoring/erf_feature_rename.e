note
	description: "Refactoring that allows to rename a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_FEATURE_RENAME

inherit
	ERF_CLASS_LIST_REFACTORING
		redefine
			preferences,
			ask_run_settings,
			refactor,
			refactoring_committed
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature -- Status

	feature_set: BOOLEAN
			-- Has the the feature to rename been set?
		do
			Result := feature_i /= Void
		end

feature -- Element change

	set_feature (a_feature: FEATURE_I)
			-- The feature that get's renamed
		require
			a_feature_not_void: a_feature /= Void
		do
			feature_i := a_feature
		ensure
			feature_set_correct: feature_set and feature_i = a_feature
		end

feature {ERF_CHK_FEATURE_RENAME} -- Element Change from check

	set_affected_classes (an_affected_classes: SEARCH_TABLE [CLASS_I])
			-- Set `affected_classes' to `an_affected_classes'.
		require
			an_affected_classes_not_void: an_affected_classes /= Void
		do
			affected_classes := an_affected_classes
		ensure
			affected_classes_set: affected_classes = an_affected_classes
		end

	set_recursive_descendants (a_recursive_descendants: SEARCH_TABLE [INTEGER])
			-- Set `recursive_descendants' to `a_recursive_descendants'.
		require
			a_recursive_descendants_not_void: a_recursive_descendants /= Void
		do
			recursive_descendants := a_recursive_descendants
		ensure
			recursive_descendants_set: recursive_descendants = a_recursive_descendants
		end

feature {NONE} -- Implementation

	preferences: ERF_FEATURE_RENAME_PREFERENCES
			-- Preferences for this refactoring.

	direct_parents: SEARCH_TABLE [INTEGER]
			-- The direct parents of the class where we change something.

	recursive_descendants: SEARCH_TABLE [INTEGER]
			-- All the classes that are descendants of the class where the feature was modified
			-- and that didn't undefine or rename the feature completely.

	refactor
			-- Do the refactoring changes.
		require else
			feature_set: feature_set
		do
			handle_classes
			if success then
				apply_to_project
			end
		end

    ask_run_settings
            -- Ask for the settings, that are run specific.
		require else
			feature_set: feature_set
		local
			dialog: ERF_FEATURE_RENAME_DIALOG
        do
			create dialog
			dialog.set_name (feature_i.feature_name)
			if preferences.is_duplicate_allowed then
				dialog.enable_duplicate
			else
				dialog.disable_duplicate
			end
			if preferences.update_comments then
				dialog.enable_update_comments
			end
			if preferences.update_strings then
				dialog.enable_update_strings
			end
			dialog.show_modal_to_window (window_manager.last_focused_development_window.window)
			retry_ask_run_settings := dialog.ok_pressed

				-- get the settings
			preferences.set_new_feature_name (dialog.name)
			preferences.set_update_comments (dialog.comments)
			preferences.set_update_strings (dialog.strings)
			preferences.set_is_duplicate_allowed (dialog.is_duplicate_allowed)

				-- add the checks
        	checks.wipe_out
			checks.extend (create {ERF_VALID_FEATURE_NAME}.make (preferences.new_feature_name))
			if not dialog.is_duplicate_allowed then
				checks.extend (create {ERF_CHK_FEATURE_RENAME}.make (feature_i, preferences.new_feature_name, Current))
			end
        end

    apply_to_class (a_class: CLASS_I)
            -- Make the changes in `a_class'.
        require else
        	feature_set: feature_set
		local
			l_class_modifier: ERF_CLASS_TEXT_MODIFICATION
			l_rename_visitor: AST_RENAME_FEATURE_VISITOR
        do
        	create l_class_modifier.make (a_class)
			l_class_modifier.prepare

			create l_rename_visitor.make (feature_i, preferences.new_feature_name, preferences.update_comments,
											preferences.update_strings, a_class.compiled_class,
											recursive_descendants)
			l_class_modifier.execute_visitor (l_rename_visitor, False)

        	l_class_modifier.commit
        	current_actions.extend (l_class_modifier)
        end

    apply_to_project
            -- Make project global changes (eg. *.ace, create/remove/rename cluster/files, ...).
		require else
			feature_set: feature_set
		local
			project_modifier: ERF_PROJECT_TEXT_MODIFICATION
			l_root: SYSTEM_ROOT
        do
        		-- if the class was the root class and the feature the root feature
        		--
        		-- Arno: this code must be updated to support multiple root features
        		--       (appearently it is also assumed that system has a root feature defined)
        	l_root := system.root_creators.first
        	if
        		l_root.root_class.name.is_case_insensitive_equal (feature_i.written_class.name) and then
        		l_root.procedure_name.is_case_insensitive_equal (feature_i.feature_name)
        	then
	        	create project_modifier
				project_modifier.prepare
				project_modifier.change_root_feature (preferences.new_feature_name.as_lower)
				project_modifier.commit
	        	current_actions.extend (project_modifier)
	        end
        end

	feature_i: FEATURE_I;
			-- The feature to rename.

	refactoring_committed
			-- <precursor>
		do
			if attached feature_i as l_feat then
				favorites.feature_renamed (l_feat.api_feature (l_feat.written_in), preferences.new_feature_name)
				window_manager.synchronize_all_favorites_tool
			end
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
