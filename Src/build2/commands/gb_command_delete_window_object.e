indexing
	description: "Objects that represent a command for the deletion of a window object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_WINDOW_OBJECT

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
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (an_object: GB_OBJECT; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position' and assign `a_components' to `components'.
		require
			object_not_void: an_object /= Void
			object_is_top_level: an_object.is_top_level_object
			a_components_not_void: a_components /= Void
		local
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			components := a_components
			components.history.cut_off_at_current_position
			directory_item ?= an_object.widget_selector_item.parent
			if directory_item /= Void then
					-- If held in a directory, store the directory name.
				parent_directory := directory_item.path
			end
			original_id := an_object.id
		ensure
			components_set: components = a_components
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			object: GB_OBJECT
		do
			object ?= components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
			object.remove_client_representation_recursively
				-- If the root window is being deleted, select the next window.
			if components.object_handler.root_window_object = object then
				components.tools.widget_selector.mark_next_window_as_root (1)
			end
			components.object_handler.update_for_delete (original_id)
			components.object_handler.update_object_editors_for_delete (object, Void)
			object.layout_item.unparent
			object.widget_selector_item.unparent
			components.object_handler.mark_as_deleted (object)

				-- Store and delete all files associated with `object' if any.
				-- Files associated are only there if already generated.
			delete_files

				-- Record `Current' in the history list.
			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end

			components.system_status.mark_as_dirty
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			object: GB_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			object ?= components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
			object.add_client_representation_recursively
			components.object_handler.mark_existing (object)
			if parent_directory /= Void then
					-- Only try to retrieve the directory item if there was one.
				directory_item := components.tools.widget_selector.directory_object_from_name (parent_directory)
			end
			if directory_item = Void then
				-- Now simply add as root.
				components.tools.widget_selector.add_alphabetically (object.widget_selector_item)
			else
				-- Restore window into original directory.
				directory_item.add_alphabetically (object.widget_selector_item)
				directory_item.expand
			end

				-- If this is the only window contained, select it.
			if components.tools.widget_selector.objects.count = 1 then
				object.widget_selector_item.enable_select
				titled_window_object ?= object
				if titled_window_object /= Void then
					components.tools.widget_selector.change_root_window_to (titled_window_object)
				end
			end
				-- Restore all files associated with `window_object' if any.
			restore_files

			components.commands.update
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			window_name: STRING
			object: GB_OBJECT
		do
			object ?= components.object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
			if not object.name.is_empty then
				window_name := object.name
			else
				window_name := object.short_type
			end
			Result := window_name + " removed from the project"
		end

feature {NONE} -- Implementation

	parent_directory: ARRAYED_LIST [STRING]
		-- Orignal directory containing object referenced by `original_id' before deletion.

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


end -- class GB_COMMAND_DELETE_WINDOW_OBJECT
