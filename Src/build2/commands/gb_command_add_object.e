indexing
	description: "Objects that represent a command for addition of an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_OBJECT

inherit

	GB_COMMAND
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (parent, child: GB_OBJECT; an_insert_position: INTEGER; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be inserted in `parent' at
			-- position `position'.
		require
			parent_not_void: parent /= Void
			child_not_void: child /= Void
			an_insert_position_valid: an_insert_position >= 1 and an_insert_position <= parent.layout_item.count + 1
		local
			previous_parent_object: GB_OBJECT
		do
			components := a_components
			parent_id := parent.id
			child_id := child.id
			previous_parent_object ?= child.parent_object
			if previous_parent_object /= Void then
				previous_parent_id := previous_parent_object.id
				previous_position_in_parent := previous_parent_object.children.index_of (child, 1)
			end
			insert_position := an_insert_position

			components.history.cut_off_at_current_position
			insert_position := an_insert_position

			create new_parent_child_objects.make (100)
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		do
			internal_execute (child_id, parent_id, previous_parent_id, insert_position, previous_position_in_parent)
			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end
			components.commands.update
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		do
			internal_execute (child_id, previous_parent_id, parent_id, previous_position_in_parent, insert_position)
			components.commands.update
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			child_name, parent_name: STRING
			child_object, parent_object: GB_OBJECT
		do
			child_object := components.object_handler.deep_object_from_id (child_id)
			parent_object := components.object_handler.deep_object_from_id (parent_id)

			if not child_object.name.is_empty then
				child_name := child_object.name
			else
				child_name := name_and_type_from_object (child_object)
			end

			if not parent_object.name.is_empty then
				parent_name := parent_object.name
			else
				parent_name := parent_object.short_type
			end
			Result := child_name  + " added to " + parent_name
		end

feature {NONE} -- Implementation

	child_id: INTEGER
		-- Id of child object for addition.

	parent_id: INTEGER
		-- Id of parent object into which child is inserted.

	previous_parent_id: INTEGER
		-- Id of parent object which contained the child object
		-- previously. 0 if none.

	actual_child_id: INTEGER
		-- Actual id of child. For example, if a top level is being created,
		-- this is the id of the new representation.

	previous_position_in_parent: INTEGER
		-- If `previous_parent_id' /= 0 then this is
		-- the index of `child_object' within `previous_parent_object'.

	insert_position: INTEGER
		-- The position `execute' will insert `child_object'
		-- in `parent_object'.

	update_parent_object_editors (an_object, a_parent_object: GB_OBJECT) is
			-- For every item in `editors', update to reflect changed in `an_object'.
		local
			editor: GB_OBJECT_EDITOR
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
			editors := components.object_editors.all_editors
			from
				editors.start
			until
				editors.off
			loop
				editor := editors.item
					-- If the parent of `an_object' is in the object editor then we must
					-- update it accordingly.
				if a_parent_object /= Void and then a_parent_object = editor.object then
					editor.update_current_object
				end
				editors.forth
			end
		end

feature {NONE} -- Implementation

	internal_execute (a_child_id, a_parent_id, an_original_parent_id, an_insert_position, an_original_insert_pos: INTEGER) is
			-- Add object referenced by `a_child_id' to `a_parent_id'. If `an_original_parent_id' is not 0 then remove
			-- original representations of `a_child_id' from object represented at `an_original_parent_id'. `an_insert_position'
			-- is the position to insert `a_child_id' within `a_parent_id' and `an_original_insert_pos' is the original insertion
			-- position of `a_child_id' if `an_original_parent_id' is not 0.
		local
			a_previous_parent: GB_OBJECT
			child_object: GB_OBJECT
			parent_object: GB_PARENT_OBJECT
			real_child: GB_OBJECT
		do
				-- Retrieve the parent and child objects
			child_object := components.object_handler.deep_object_from_id (a_child_id)
			parent_object ?= components.object_handler.deep_object_from_id (a_parent_id)
				-- Note that `parent_object' may be Void in the case that we are performing an undo.
			check
				child_object_exists: child_object /= Void
			end

				-- Flag that the object structure is in the process of changing.
			components.system_status.set_object_structure_changing


			if an_original_parent_id /= 0 then
					-- As `an_original_parent_id' /= O we must remove the old representations of the child
					-- before moving it.
				if actual_child_id = 0 then
					real_child := child_object
				else
					real_child := components.object_handler.deep_object_from_id (actual_child_id)
					check
						child_object_has_real_child_as_referer: child_object.instance_referers.has (actual_child_id)
					end
				end
				real_child.remove_client_representation_recursively
				unparent_children (real_child)
			end

			if parent_object /= Void then
					-- Now parent the object associated with `child_id' into the object associated with `parent_id'
				if child_object.object = Void then
						-- If picked straight from the type selector, we may have to build the objects.
					child_object.build_objects
				end
				if child_object.is_top_level_object and child_object.parent_object = Void then
						-- If we are dropping a top level object, we must copy the object rather
						-- than use it directly. Only in the case where the object is not already
						-- parented as if so, all representations are already created.

					if new_parent_child_objects.has (parent_object.id) then
							-- If we have already created a new version of `real_child', then we must now
							-- create a new strict version which is an exact copy of the original, including ids.
						real_child := components.object_handler.deep_object_from_id (new_parent_child_objects.item (parent_object.id)).new_top_level_representation_strict
					else
							-- Create a new representation of `child_object'.
						real_child := child_object.new_top_level_representation
							-- Record the fact that we have now created a new representation.
						new_parent_child_objects.put (real_child.id, parent_object.id)
							-- Update the instance referers.
						child_object.instance_referers.put (real_child.id, real_child.id)
						real_child.connect_instance_referers (child_object, real_child)
					end
					actual_child_id := real_child.id

					real_child.set_associated_top_level_object (child_object)
				else
						-- If not a top level object, simply use the child as is.
					real_child := child_object
				end

					-- Add `real_child' to it's new parent, `parent_object' at position `an_insert_position'.
				components.object_handler.add_object (parent_object, real_child, an_insert_position)

					-- Create and add new representations of `real_child' to representations of `parent_object'
					-- as position `an_insert_position'.

				create_new_representations (parent_object, real_child, an_insert_position)
				components.system_status.set_object_structure_changing
				real_child.add_client_representation_recursively
				if components.object_handler.deleted_objects.has (real_child.id) then
					components.object_handler.mark_existing (real_child)
				end

				components.system_status.set_object_structure_changed
			end

				-- Update all object editors to reflect the change.
			update_parent_object_editors (real_child, a_previous_parent)

			components.system_status.set_object_structure_changed
		end

	unparent_children (a_child: GB_OBJECT) is
			-- For all instance referers of `parent' recursively, remove child
			-- at position `child_index'.
		require
			a_child_not_void: a_child /= Void
		local
			list: ARRAYED_LIST [INTEGER]
			old_parent: GB_OBJECT
		do
				-- It is possible that the object has already been deleted by an undo
				-- as we keep all instance referers even though they have been undone. This
				-- ensures that we are able to keep the properties up to date.

				-- FIXME if we go back in the history and change something, all referers that
				-- are no longer reachable are still kept. We must find a way to remove these
				-- at some point. Maybe each object could have a history index of when it was created
				-- and when cutting off the history, we could determine which objects are no
				-- longer usable.
			if components.object_handler.objects.has (a_child.id) then
				old_parent := a_child.parent_object
					-- Actually perform the unparenting.
				if not new_parent_child_objects.has (a_child.parent_object.id) then
					new_parent_child_objects.put (a_child.id, a_child.parent_object.id)
				end
				a_child.parent_object.remove_child (a_child)
				check
					a_child_exists: components.object_handler.deep_object_from_id (a_child.id) /= Void
					a_child_not_delted: not components.object_handler.deleted_objects.has (a_child.id)
				end
				components.object_handler.mark_as_deleted (a_child)
				update_parent_object_editors (a_child, old_parent)
			end
				-- Now iterate through the `instance_referers'.
			list := a_child.instance_referers.linear_representation
			from
				list.start
			until
				list.off
			loop
				unparent_children (components.object_handler.deep_object_from_id (list.item))
				list.forth
			end
		ensure
			instance_referers_not_changed: old a_child.instance_referers = a_child.instance_referers
		end

	create_new_representations (parent_object: GB_PARENT_OBJECT; child_object: GB_OBJECT; insert_pos: INTEGER) is
			-- Recursivley create new representations of `child_object' for each `parent_object'
			-- and link new representations to `child_object'.
		require
			parent_object_not_void: parent_object /= Void
			child_object_not_void: child_object /= Void
			insert_pos_valid:
		local
			new_object: GB_OBJECT
			iterated_parent_object: GB_PARENT_OBJECT
			actual_child: GB_OBJECT
			current_instance_referer: GB_OBJECT
		do
				-- Always retrieve the original child that must be copied.
			actual_child := components.object_handler.deep_object_from_id (child_id)
			from
				parent_object.instance_referers.start
			until
				parent_object.instance_referers.off
			loop
				if new_parent_child_objects.has (parent_object.instance_referers.item_for_iteration) then
					current_instance_referer := components.object_handler.deep_object_from_id (new_parent_child_objects.item (parent_object.instance_referers.item_for_iteration))
					new_object := current_instance_referer.new_top_level_representation_strict
				else
					if not components.object_handler.deleted_objects.has (parent_object.instance_referers.item_for_iteration) then
						new_object := actual_child.new_top_level_representation
						new_parent_child_objects.put (new_object.id, parent_object.instance_referers.item_for_iteration)
						child_object.instance_referers.put (new_object.id, new_object.id)
						new_object.connect_instance_referers (actual_child, new_object)
					end
				end
				if not components.object_handler.deleted_objects.has (parent_object.instance_referers.item_for_iteration) then
					if components.object_handler.deleted_objects.has (new_object.id) then
						components.object_handler.mark_existing (new_object)
					end
					iterated_parent_object ?= components.object_handler.deep_object_from_id (parent_object.instance_referers.item_for_iteration)

					iterated_parent_object.add_child_object (new_object, insert_pos)

					-- Perform this recursively.
					create_new_representations (iterated_parent_object, new_object, insert_pos)
				end
				parent_object.instance_referers.forth
			end
		end

	new_parent_child_objects: HASH_TABLE [INTEGER, INTEGER];
		-- All newly created child object ids hashed by their associated parent.
		-- As `Current' executes, we must create new instances of each object if not contained in `here',
		-- otherwise we must rebuild the object without changing any of the ids.

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


end -- class GB_COMMAND_ADD_OBJECT
