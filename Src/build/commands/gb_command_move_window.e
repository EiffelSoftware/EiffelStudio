indexing
	description: "Objects that represent commands to move a window between directories."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_MOVE_WINDOW

inherit

	GB_COMMAND
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (object: GB_OBJECT; a_new_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `window' to be moved from its current directory, to `new_directory'.
			-- If `a_new_directory' is Void, then move to root of project.
		require
			object_not_void: object /= Void
			is_top_level_object: object.is_top_level_object
		local
			dir: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			components := a_components
			components.history.cut_off_at_current_position
			original_id := object.id
			dir ?= object.widget_selector_item.parent
			if dir /= Void then
				original_directory := dir.path
			end
			if a_new_directory /= Void then
				new_directory := a_new_directory.path
			end
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			object: GB_OBJECT
			original_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			new_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			object ?= components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_was_top_level: object.is_top_level_object = True
			end

				-- Retrieve the directories via their names.
			if original_directory /= Void then
				original_directory_item := components.tools.widget_selector.directory_object_from_name (original_directory)
			end
			if new_directory /= Void then
				new_directory_item := components.tools.widget_selector.directory_object_from_name (new_directory)
			end

			object.widget_selector_item.unparent
			if new_directory_item /= Void then
				new_directory_item.add_alphabetically (object.widget_selector_item)
			else
				components.tools.widget_selector.add_alphabetically (object.widget_selector_item)
			end

			components.tools.widget_selector.update_class_files_location (object.widget_selector_item, original_directory_item, new_directory_item)
				-- Record `Current' in the history list.
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
			object: GB_OBJECT
			original_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			new_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			object ?= components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_was_top_level: object.is_top_level_object = True
			end

				-- Retrieve the directories via their names.
			if original_directory /= Void then
				original_directory_item := components.tools.widget_selector.directory_object_from_name (original_directory)
			end
			if new_directory /= Void then
				new_directory_item :=components.tools.widget_selector.directory_object_from_name (new_directory)
			end

			object.widget_selector_item.unparent
			if original_directory_item /= Void then
				original_directory_item.add_alphabetically (object.widget_selector_item)
			else
				components.tools.widget_selector.add_alphabetically (object.widget_selector_item)
			end
			components.tools.widget_selector.update_class_files_location (object.widget_selector_item, new_directory_item, original_directory_item)
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object: GB_OBJECT
			current_text: STRING
		do
			object ?= components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_was_top_level: object.is_top_level_object = True
			end
			current_text := object.name
			if object.name.is_empty then
				current_text := "unnamed " + object.short_type
			end
			if original_directory = Void then
				Result := current_text + " moved into directory %"" + new_directory.last + "%""
			elseif new_directory = Void then
				Result := current_text + " moved from directory %"" + original_directory.last + "%" to the root"
			else
				Result := current_text + " moved from %"" + original_directory.last + "%" to directory %"" + new_directory.last + "%""
			end
		end

feature {NONE} -- Implementation

	original_id: INTEGER
		-- id of object that was deleted.

	original_directory: ARRAYED_LIST [STRING]
		-- String representing the original directory holding the window
		-- empty if root of project.

	new_directory: ARRAYED_LIST [STRING];
		-- String representing the directory into which the window was moved.
		-- `empty' if root of project.

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


end -- class GB_COMMAND_MOVE_WINDOW
