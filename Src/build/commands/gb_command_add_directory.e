indexing
	description: "Objects that represent commands to add directories to a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_DIRECTORY

inherit
	GB_COMMAND

	GB_FILE_UTILITIES
		export
			{NONE} all
		end

	GB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM; a_directory: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with directory named `a_directory'.
		require
			a_directory_not_void: a_directory /= Void
		do
			components := a_components
			components.history.cut_off_at_current_position
			directory_name := a_directory
			if directory_item /= Void then
					-- `directory_item' may be `Void' if we are parenting at the root level
					-- in the widget selector.
				parent_directory_path := directory_item.path
			else
				create parent_directory_path.make (0)
			end
		end

feature -- Basic Operation

	create_new_directory is
			-- Actually create directory
		local
			temp_file_name: FILE_NAME
			root_directory, directory: DIRECTORY
			directory_exists_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			created_directories: ARRAYED_LIST [DIRECTORY]
			test_file_name, test_directory_name: DIRECTORY_NAME
			l_path: STRING
		do
			create created_directories.make (4)
			l_path := components.system_status.current_project_settings.actual_generation_location
			create temp_file_name.make_from_string (l_path)
			create root_directory.make_open_read (l_path)
			create test_directory_name.make_from_string (l_path)
			test_directory_name.extend (unique_name_from_array (root_directory.linear_representation, "TEMP"))

			from
				parent_directory_path.start
			until
				parent_directory_path.off
			loop
				temp_file_name.extend (parent_directory_path.item)
				parent_directory_path.forth
			end
			temp_file_name.extend (directory_name)
			create directory.make (temp_file_name)
			if not directory.exists then
					-- Now temporarily create a temp dir and a file with name matching `directory_name' to see if the
					-- file name entered is valid. If not, this raises an exception which we catch to prompt a user that
					-- the name is invalid. After creating the tmeporary dir and file, we delete them both. Directories
					-- are only actually created when generating the project if actually needed, but we must create a file
					-- with the correct name to catch if it is valid or not on the current platform.
				create test_directory.make_open_read (test_directory_name)
				check
					test_directory_does_not_exist: not test_directory.exists
				end
				test_directory.create_dir
				test_file_name := test_directory_name.twin
				test_file_name.extend (directory_name)
				create directory.make (test_file_name)
				directory.create_dir
				directory.delete
				test_directory.delete
				test_directory := Void
					-- If it was not a valid name, then an exception is raised and this
				directory_added_succesfully := True
			elseif not executed_once then
					-- `executed_once' checks  that we only show the add to project warning the first time we add it and not when
					-- undoing or redoing.
				if not warnings_supressed then
					create directory_exists_dialog.make_initialized (2, preferences.dialog_data.show_adding_existing_directory_warning,
									"The directory already exists on the disk. Do you wish to include it in the project?", "Always include, and do not show this warning again.", preferences.preferences)
					directory_exists_dialog.set_icon_pixmap (Icon_build_window @ 1)
					directory_exists_dialog.set_ok_action (agent set_directory_added_succesfully)
					directory_exists_dialog.show_modal_to_window (components.tools.main_window)
				else
					directory_added_succesfully := True
				end
			end
		end

	set_directory_added_succesfully is
			-- Assign `True' to `directory_added_succesfully'
		do
			directory_added_succesfully := True
		end

	directory_added_succesfully: BOOLEAN
		-- Was last call to `create_directory' successful?

	test_directory: DIRECTORY
		-- Temporary directory created and used to check the current file name.

	execute is
			-- Execute `Current'.
		require else
			directory_added_succesfully: directory_added_succesfully
		local
			directory_item, parent_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			if executed_once then
					-- As we are re-doing an undo, we must create directory again.
					-- See comment of `executed_once'.
				create_new_directory
			end
			create directory_item.make_with_name (directory_name, components)
			if parent_directory_path.is_empty then
				components.tools.widget_selector.add_alphabetically (directory_item)
			else
				parent_directory := components.tools.widget_selector.directory_object_from_name (parent_directory_path)
				check
					parent_directory_not_void: parent_directory /= Void
				end
				parent_directory.add_alphabetically (directory_item)
					-- Ensure `directory_item' is now visible.
				parent_directory.expand
			end

			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end
			components.commands.update
			executed_once := True
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			directory_item,	parent_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			directory_path: ARRAYED_LIST [STRING]
		do
			directory_path := parent_directory_path.twin
			directory_path.extend (directory_name)
			directory_item := components.tools.widget_selector.directory_object_from_name (directory_path)
			check
				directory_item_not_void: directory_item /= Void
			end
			if not parent_directory_path.is_empty then
				parent_directory_item := components.tools.widget_selector.directory_object_from_name (parent_directory_path)
				check
					parent_directory_not_void: parent_directory_item /= Void
					parent_has_directory: directory_item.parent = parent_directory_item
				end
				parent_directory_item.prune_all (directory_item)
			else
				check
					contained_in_widget_selector: directory_item.parent = components.tools.widget_selector
				end
				components.tools.widget_selector.prune_all (directory_item)
			end
			components.commands.update
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := "directory %"" + directory_name + "%" added to project."
		end

	supress_warnings is
			-- Ensure no warning is displayed when adding a directory
			-- that already exists.
		do
			warnings_supressed := True
		end

feature {NONE} -- Implementation

	executed_once: BOOLEAN
		-- Has `execute' already been called once? If so, we must call `create_new_directory'
		-- within `execute'. The first time that we call `execute' we do not perform it directly
		-- as the caller can do this to enable chacking for invalid directory names.

	directory_name: STRING
		-- Name of directory that was added. Only the actual name,
		-- and not the full name, as all directories are relative to the project.

	parent_directory_path: ARRAYED_LIST [STRING]
		-- Full path to parent_directory.

	warnings_supressed: BOOLEAN
		-- Are warnings being supressed?

invariant
	parent_directory_path_not_void: parent_directory_path /= Void
	directory_name_not_void: directory_name /= Void and not directory_name.is_empty

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


end -- class GB_COMMAND_ADD_DIRECTORY
