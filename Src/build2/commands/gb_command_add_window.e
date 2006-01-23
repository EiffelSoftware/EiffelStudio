indexing
	description: "Objects that represent a command to add a window to a project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_WINDOW
inherit

	GB_COMMAND
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_FILE_UTILITIES
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

	GB_FILE_REMOVE_RESTORE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (window: GB_OBJECT; a_new_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			window_not_void: window /= Void
		do
			components := a_components
			components.history.cut_off_at_current_position
			if a_new_directory /= Void then
				parent_directory := a_new_directory.path
			end
			original_id := window.id
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			an_object: GB_OBJECT
			window_object: GB_TITLED_WINDOW_OBJECT
			selector_item: GB_WIDGET_SELECTOR_ITEM
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			an_object := components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: an_object /= Void
			end
			create selector_item.make_with_object (an_object, components)
			if parent_directory = Void then
				components.tools.widget_selector.add_alphabetically (an_object.widget_selector_item)
			else
				directory_item := components.tools.widget_selector.directory_object_from_name (parent_directory)
				directory_item.add_alphabetically (an_object.widget_selector_item)
				directory_item.expand
			end

				-- If this is the only window contained, select it.
			if components.tools.widget_selector.objects.count = 1 then
				an_object.widget_selector_item.enable_select
				window_object ?= an_object
				if window_object /= Void then
						-- Only set window object's as root windows.
					components.tools.widget_selector.change_root_window_to (window_object)
				end
			end
				-- Now mark object as non deleted, only if it is deleted.
				-- Handles case, where you repeatedly undo/redo.
			if components.object_handler.deleted_objects.has (an_object.id) then
				components.object_handler.mark_existing (an_object)
			end

				-- Restore all files associated with `an_object' if any.
			restore_files

				-- Record `Current' in the history list.
			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end
			an_object.add_client_representation_recursively

			components.system_status.mark_as_dirty
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			an_object: GB_OBJECT
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			an_object := components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: an_object /= Void
			end
			window_object ?= an_object
			if window_object /= Void then
					-- If the root window is being deleted, select the next window.
				if components.object_handler.root_window_object = window_object then
					components.tools.widget_selector.mark_next_window_as_root (1)
				end
			end
			components.object_handler.update_for_delete (original_id)
			components.object_handler.update_object_editors_for_delete (an_object, Void)
			an_object.layout_item.unparent
			an_object.widget_selector_item.unparent
			components.object_handler.mark_as_deleted (an_object)

				-- Store and delete all files associated with `window_object' if any.
				-- Files associated are only there if already generated.
			delete_files

			an_object.remove_client_representation_recursively
			components.system_status.mark_as_dirty
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object_name: STRING
			an_object: GB_OBJECT
		do
			an_object ?= components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: an_object /= Void
			end
			if not an_object.name.is_empty then
				object_name := an_object.name
			else
				object_name := an_object.short_type
			end
			if parent_directory = Void then
				Result := object_name + " added to the project"
			else
				Result := object_name + " added to project in directory " + parent_directory.last
			end
		end

feature {NONE} -- Implementation

	parent_directory: ARRAYED_LIST [STRING]
		-- Orignal directory that object referenced by `original_id' was added to.

	original_id: INTEGER;
		-- id of object that was deleted.

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


end -- class GB_COMMAND_ADD_WINDOW
