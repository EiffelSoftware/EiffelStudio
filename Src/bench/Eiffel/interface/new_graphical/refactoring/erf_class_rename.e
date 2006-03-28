indexing
	description: "Refactoring that allows to rename a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_CLASS_RENAME

inherit
	ERF_CLASS_LIST_REFACTORING
		redefine
			preferences,
			ask_run_settings,
			refactor,
			execute
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	CONF_ACCESS

create
	make

feature -- Status

	class_set: BOOLEAN is
			-- Has the class to change been set?
		do
			Result := class_i /= void
		end

feature -- Element change

	set_class (a_class: like class_i) is
			-- That class that get's renamed
		require
			a_class_not_void: a_class /= void
		do
			class_i := a_class
		end

feature -- Main operation

	execute is
			-- Execute the refactoring.
		require else
			class_set: class_set
		local
			class_stone: CLASSI_STONE
		do
			Precursor
				-- was the class opened? so we have to change the class to show the new class
				-- must be done after compilation, because we can't get the class before
       		if open_classes.has (preferences.old_class_name) then
				class_i ?= universe.class_named (preferences.new_class_name, class_i.cluster)
				if class_i /= Void then
	       			create class_stone.make (class_i)
	       			open_classes.item (preferences.old_class_name).do_all (agent {EB_DEVELOPMENT_WINDOW}.set_stone (class_stone))
	       			window_manager.for_all_development_windows (agent {EB_DEVELOPMENT_WINDOW}.synchronize)
				end
       		end
		end

feature {NONE} -- Implementation

	preferences: ERF_CLASS_RENAME_PREFERENCES
			-- Preferences for this refactoring.

	refactor is
			-- Do the refactoring changes.
		require else
			class_set: class_set
		do
        	if preferences.all_classes then
        		affected_classes := all_classes
        	else
        		affected_classes := usage_classes (class_i)
        	end
			handle_classes
				-- update class name information
			class_i.set_name
			if success then
				apply_to_project
			end
		end

    ask_run_settings is
            -- Ask for the settings, that are run specific.
		require else
			class_set: class_set
		local
			dialog: ERF_CLASS_RENAME_DIALOG
        do
        	preferences.set_old_class_name (class_i.name_in_upper)

			create dialog
			dialog.set_name (class_i.name_in_upper)
			dialog.disable_user_resize
			if class_i.compiled then
				dialog.enable_compiled
			else
				dialog.disable_compiled
			end
			if preferences.file_rename then
				dialog.enable_rename_file
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
			preferences.set_new_class_name (dialog.name.as_upper)
			preferences.set_file_rename (dialog.rename_file)
			preferences.set_update_comments (dialog.comments)
			preferences.set_update_strings (dialog.strings)
			preferences.set_all_classes (dialog.all_classes)

				-- add the checks
        	checks.wipe_out
			checks.extend (create {ERF_VALID_CLASS_NAME}.make (preferences.new_class_name))
			checks.extend (create {ERF_CHK_SAME_CLASS_NAME}.make (preferences.new_class_name))
        end


    apply_to_project is
            -- Make project global changes (eg. *.ace, create/remove/rename cluster/files, ...).
		require else
			class_set: class_set
		local
			project_modifier: ERF_PROJECT_TEXT_MODIFICATION
			file_rename: ERF_CLASS_FILE_RENAME
			l_eif_class: EIFFEL_CLASS_I
        do
        		-- if the renamed class was the root class
        	if system.root_class.name.is_case_insensitive_equal (class_i.name) then
	        	create project_modifier
				project_modifier.prepare
				project_modifier.change_root_class (preferences.new_class_name.as_upper)
				project_modifier.commit
	        	current_actions.extend (project_modifier)
	        end

	        	-- TODO handle other cases where the class was in the project file
	        to_implement ("TODO handle other cases where the class was in the project file")

				-- if the file should be renamed
        	if preferences.file_rename then
        		-- rename file action
        		create file_rename.make (preferences.new_class_name.as_lower, class_i)
        		file_rename.redo
        		current_actions.extend (file_rename)
        	end
		end


    apply_to_class (a_class: CLASS_I) is
            -- Make the changes in `a_class'.
		require else
			class_set: class_set
		local
			class_modifier: ERF_CLASS_TEXT_MODIFICATION
			rename_visitor: AST_RENAME_CLASS_VISITOR
        do
        	create class_modifier.make (a_class)
        		-- if we want to process all classes, enable parsing on demand
        	if preferences.all_classes then
        		class_modifier.enable_parsing
        	end
			class_modifier.prepare

			create rename_visitor.make (preferences.old_class_name, preferences.new_class_name, preferences.update_comments, preferences.update_strings)
			class_modifier.execute_visitor (rename_visitor, false)

        	class_modifier.commit
        	current_actions.extend (class_modifier)
        end


	class_i: EIFFEL_CLASS_I;
			-- The class to rename.

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
