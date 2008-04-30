indexing
	description: "Objects that represent a command for the deletion of a directory."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_DIRECTORY

inherit
	GB_COMMAND

	GB_FILE_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (a_directory, parent_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with directory named `a_directory'.
		require
			a_directory_not_void: a_directory /= Void
			void_parent_implies_widget_selector: parent_directory = Void implies a_directory.parent = a_components.tools.widget_selector
			non_void_parent_correct: parent_directory /= Void implies a_directory.parent /= a_components.tools.widget_selector
		do
			components := a_components
			components.history.cut_off_at_current_position
			directory_name := a_directory.path
			if parent_directory /= Void then
				parent_directory_name := parent_directory.path
			end
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
				-- Now actually remove the directory from the disk.
			create temp_file_name.make_from_string (components.system_status.current_project_settings.actual_generation_location)
			from
				directory_name.start
			until
				directory_name.off
			loop
				temp_file_name.extend (directory_name.item)
				directory_name.forth
			end
			create directory.make (temp_file_name)
			if directory.exists and directory.is_empty then
					-- Only remove the directory if it is present on the disk.
					-- If a project has not been generated, then there may be no directory yet.
				delete_directory (directory)
			end
				-- Now remove the representation from the directory selector.
			directory_item := components.tools.widget_selector.directory_object_from_name (directory_name)
			check
				directory_item_found: directory_item /= Void
			end
			directory_item.unparent

			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end
			components.commands.update
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			temp_file_name: FILE_NAME
			directory: DIRECTORY
		do
				-- Only restore the directory to the disk if it was actually
				-- removed previously.
			create temp_file_name.make_from_string (components.system_status.current_project_settings.actual_generation_location)
			from
				directory_name.start
			until
				directory_name.off
			loop
				temp_file_name.extend (directory_name.item)
				directory_name.forth
			end
			create directory.make (temp_file_name)
			if not directory.exists then
				create_directory (directory)
			end
			components.tools.widget_selector.silent_add_named_directory (directory_name)
			components.commands.update
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := "directory %"" + directory_name.last + "%" removed from project."
		end

feature {NONE} -- Implementation

	parent_directory_name: ARRAYED_LIST [STRING]
		-- Name of parent directory in which `directory_name' is contained.

	directory_name: ARRAYED_LIST [STRING];
		-- Name of directory that was deleted.

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


end -- class GB_COMMAND_DELETE_DIRECTORY
