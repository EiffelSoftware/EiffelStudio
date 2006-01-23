indexing
	description: "[
		Objects that represent a command for the conversion of an existing object to a top level object
		that now represents the original object which becomes a locked representation of the new top level object.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_CONVERT_TO_TOP_LEVEL

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

	make (child: GB_OBJECT; parent_directory: GB_WIDGET_SELECTOR_COMMON_ITEM; new_name: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be converted to a top level object named `new_name'
			-- within `parent_directory'.
		require
			child_not_void: child /= Void
			new_name_not_void: new_name /= Void
			child_is_not_representation: not child.is_instance_of_top_level_object
			a_components_not_void: a_components /= Void
		local
			l_parent_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			components := a_components
			name := new_name
			child_id := child.id
			l_parent_directory ?= parent_directory
			if l_parent_directory = Void then
				create parent_directory_path.make (0)
			else
				parent_directory_path := l_parent_directory.path
			end
			components.history.cut_off_at_current_position
		ensure
			components_set: components = a_components
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			all_children_old, all_children_new: ARRAYED_LIST [GB_OBJECT]
			widget_selector_item: GB_WIDGET_SELECTOR_ITEM
			display_win: GB_DISPLAY_WINDOW
			builder_win: GB_BUILDER_WINDOW
			all_children: ARRAYED_LIST [GB_OBJECT]
			parent_directory_item: GB_WIDGET_SELECTOR_COMMON_ITEM
		do
			child_object := components.object_handler.deep_object_from_id (child_id)
			child_object.remove_client_representation_recursively

			new_object := components.object_handler.deep_object_from_id (child_id).new_top_level_representation

				-- Now perform processing to ensure that each time `execute' is called we end up with
				-- a structure containing objects with identical ids. See comment for `original_ids'.
			if not executed_once then
					-- As this is the first time, record all ids in the structure.
				new_object_id := new_object.id
				create all_children.make (50)
				new_object.all_children_recursive (all_children)
				create original_ids.make (50)
				original_ids.extend (new_object.id)
				from
					all_children.start
				until
					all_children.off
				loop
					original_ids.extend (all_children.item.id)
					all_children.forth
				end
			else
					-- As this is not the first execution, restore the original ids into the new structure.
				create all_children.make (50)
				new_object.all_children_recursive (all_children)
				check
					counts_consistent: all_children.count + 1 = original_ids.count
				end
				components.object_handler.objects.remove (new_object.id)
				new_object.set_id (original_ids.i_th (1))
				components.object_handler.objects.put (new_object, new_object.id)
				from
					all_children.start
				until
					all_children.off
				loop
					components.object_handler.objects.remove (all_children.item.id)
					all_children.item.set_id (original_ids.i_th (all_children.index + 1))
					components.object_handler.objects.put (all_children.item, all_children.item.id)
					all_children.forth
				end
			end

			create widget_selector_item.make_with_object (new_object, components)
			create display_win.make_with_components (components)
			insert_into_window (new_object.object, display_win)
			create builder_win.make_with_components (components)
			insert_into_window (new_object.display_object, builder_win)

			create all_children_old.make (50)
			child_object.all_children_recursive (all_children_old)
			create all_children_new.make (50)
			new_object.all_children_recursive (all_children_new)
			check
				children_count_identical: all_children_new.count = all_children_old.count
			end

			child_object.set_associated_top_level_object (new_object)
			child_object.represent_as_locked_instance
			new_object.represent_as_non_locked_instance
			new_object.instance_referers.put (child_object.id, child_object.id)
			from
				all_children_old.start
				all_children_new.start
			until
				all_children_old.off
			loop
				if all_children_old.item.is_instance_of_top_level_object then
					all_children_new.item.set_associated_top_level_object (components.object_handler.deep_object_from_id (all_children_old.item.associated_top_level_object))
					all_children_new.item.represent_as_locked_instance
					all_children_new.item.update_representations_for_name_or_type_change
				end
				all_children_old.forth
				all_children_new.forth
			end
			from
				all_children_new.start
				all_children_old.start
			until
				all_children_new.off
			loop
				check
					no_instance_referers: all_children_new.item.instance_referers.is_empty
				end
				all_children_new.item.instance_referers.put (all_children_old.item.id, all_children_old.item.id)
				all_children_new.forth
				all_children_old.forth
			end

			new_object.set_name (name)
			if parent_directory_path.is_empty then
				parent_directory_item := components.tools.widget_selector
			else
				parent_directory_item := components.tools.widget_selector.directory_object_from_name (parent_directory_path)
			end
			check
				parent_directory_item_not_void: parent_directory_item /= Void
			end
			parent_directory_item.add_alphabetically (new_object.widget_selector_item)
			parent_directory_item.expand

			components.object_editors.rebuild_associated_editors (child_object.id)

			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end
			child_object.add_client_representation_recursively
			new_object.add_client_representation_recursively
			child_object.update_representations_for_name_or_type_change
			components.commands.update
			executed_once := True
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			all_children_old, all_children_new: ARRAYED_LIST [GB_OBJECT]
		do
			child_object := components.object_handler.deep_object_from_id (child_id)
			new_object := components.object_handler.deep_object_from_id (new_object_id)
			new_object.remove_client_representation_recursively

			create all_children_old.make (50)
			child_object.all_children_recursive (all_children_old)
			create all_children_new.make (50)
			new_object.all_children_recursive (all_children_new)
			check
				children_count_identical: all_children_new.count = all_children_old.count
			end

				-- It is possible that the child object has been flattened before `undo' was called.
				-- If so, there is no instance referring to undo. A subsequent `redo' will once
				-- again ensure that the two objects are linked. Should we overried `redo' if the object
				-- was flattened and not connect the referers, just add the new object?
			if child_object.is_instance_of_top_level_object then

				child_object.remove_associated_top_level_object
				child_object.represent_as_non_locked_instance
				new_object.instance_referers.remove (child_object.id)
				from
					all_children_old.start
					all_children_new.start
				until
					all_children_old.off
				loop
					if all_children_old.item.is_instance_of_top_level_object then
						all_children_new.item.remove_associated_top_level_object
						all_children_new.item.represent_as_non_locked_instance
					end
					all_children_old.forth
					all_children_new.forth
				end
				from
					all_children_new.start
					all_children_old.start
				until
					all_children_new.off
				loop
					check
						has_instance_referers: not all_children_new.item.instance_referers.is_empty
					end
					all_children_new.item.instance_referers.remove (all_children_old.item.id)
					all_children_new.forth
					all_children_old.forth
				end
			end

					-- Remove the widget selector item from the widget selector.
				new_object.widget_selector_item.unparent

					-- Note that we do not mark `new_object' as deleted as it is no longer used after this.
					-- If we undo and re-do we must create the new object representation each time. This is
					-- due to the fact that if we undo the execution of `Current', modify a property of one
					-- of the widgets in the original widget structure and then re-do the command, the two
					-- object instances are out of synch with the new property. This is because while modifying
					-- the property while undone, there is no correct `instance_referes' reference. We cannot simply
					-- keep the refering links as it is performed in the wrong direction from the new to the original,
					-- and the links from every object within the structure are not bi-directional. So for the moment,
					-- we simply rebuild the new top level object each time which keeps the properties in synch. This
					-- has the disadvantage of being slow and creating new objects each time.

					-- Ensure that we no longer reference `new_object' in the object list.
					-- But note the comment above which explains why it is not added to `deleted_objects'.
				components.object_handler.objects.remove (new_object.id)
				from
					all_children_new.start
				until
					all_children_new.off
				loop
					components.object_handler.objects.remove (all_children_new.item.id)
					all_children_new.forth
				end

					-- Now must actually delete the object and its representations.
					--| FIXME

			child_object.update_representations_for_name_or_type_change
			child_object.add_client_representation_recursively

			components.object_editors.rebuild_associated_editors (child_object.id)

			components.commands.update
		ensure then
			not_contained_in_objects: old child_object.is_instance_of_top_level_object implies not components.object_handler.objects.has (new_object.id)
				-- Also must perform recursively for all children, but not easy to write
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			child_name: STRING
		do
			child_object := components.object_handler.deep_object_from_id (child_id)
			if not child_object.name.is_empty then
				child_name := child_object.name
			else
				child_name := child_object.short_type
			end
			Result := child_name  + " converted to widget representation named " + name
		end

feature {NONE} -- Implementation

	executed_once: BOOLEAN

	new_object, child_object: GB_OBJECT
		-- Current representations of `new_object_id' and `child_id'. These may change
		-- each time we execute or undo.

	child_id: INTEGER
		-- Id of child object for addition.

	new_object_id: INTEGER
		-- Id of representation of object with id `child_id' that is created.

	original_ids: ARRAYED_LIST [INTEGER]
		-- All original ids of objects contained in new object created first time that `Current' is
		-- executed. As each time we re-execute `Current' we create a new object structure so that any
		-- modified properties are not lost, we need to keep all of the original ids to set them back
		-- into the structure each time that it is subsequently created. Otherwise, if you convert a structure
		-- to a top level structure and then build into it, undoing the history and redoing causes EiffelBuild
		-- to crash as the add command cannot find the object with the same id as was originally built into.
		-- As soon as there is a way to implement `Current' without re-building the structure each time,
		-- this step should be no longer required.

	parent_directory_path: ARRAYED_LIST [STRING]
		-- Parent directory path containing new conversion. If empty, the parent is the `widget_selector'.

	name: STRING;
		-- Name used for the new object that is created.

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


end -- class GB_COMMAND_CONVERT_TO_TOP_LEVEL
