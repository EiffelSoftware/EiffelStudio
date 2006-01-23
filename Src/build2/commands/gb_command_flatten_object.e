indexing
	description: "Objects that represent a command for flattening of an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_FLATTEN_OBJECT

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

	make (an_object: GB_OBJECT; deep_flatten: BOOLEAN; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be inserted in `parent' at
			-- position `position'.
		require
			object_not_void: an_object /= Void
			object_is_top_level_instance: an_object.is_instance_of_top_level_object
		do
			components := a_components
			components.history.cut_off_at_current_position
			object_id := an_object.id
			top_id := an_object.associated_top_level_object
			is_deep_flatten := deep_flatten
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			an_object: GB_OBJECT
			top_object: GB_OBJECT
		do
				-- Recreate structures each time we execute which ensures that
				-- they are reset if we call `execute' and `undo' multiple times.
			create new_links.make (4)
			create original_links.make (4)
			create original_instances.make (4)

			an_object := components.object_handler.deep_object_from_id (object_id)
			top_object := components.object_handler.deep_object_from_id (top_id)
			check
				links_correct: top_object.instance_referers.has (an_object.id) and an_object.associated_top_level_object = top_object.id
			end
			create original_referers.make (10)
				-- Store the original referers of `an_object'.
			original_referers := an_object.instance_referers.twin
			top_object.remove_client_representation (an_object)
			an_object.unconnect_instance_referers (top_object, an_object)
			internal_shallow_flatten (an_object, top_object)
			check
				top_object_link_removed: not top_object.instance_referers.has (object_id)
			end
			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end
			update_editors_for_change
			components.commands.update
		end


	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			new_object: GB_OBJECT
			top_object: GB_OBJECT
			an_object: GB_OBJECT
			parent_object: GB_PARENT_OBJECT
			old_pos: INTEGER
			original_link_object, new_link_object, original_instance_object: GB_OBJECT
			is_selected: BOOLEAN
			new_children, original_children: ARRAYED_LIST [GB_OBJECT]
			current_new_child, current_original_child: GB_OBJECT
		do
				-- Retrieve the objects which are the subject of this flattening.
			an_object := components.object_handler.deep_object_from_id (object_id)
			top_object := components.object_handler.deep_object_from_id (top_id)

				-- Create a new representation of `new_object'.
			new_object := top_object.new_top_level_representation

				-- Recursively retrieve all children of `new_object' and `an_object'.
			create new_children.make (50)
			new_object.all_children_recursive (new_children)
			create original_children.make (50)
			an_object.all_children_recursive (original_children)

				-- Now convert all asssociated top level objects on loading to actual associated top level object references.
				-- Without this, the objects would not act as instances of top level objects.
			from
				new_children.start
			until
				new_children.off
			loop
				current_new_child := new_children.item
				if current_new_child.associated_top_level_object_on_loading > 0 then
					current_new_child.set_associated_top_level_object (components.object_handler.deep_object_from_id (current_new_child.associated_top_level_object_on_loading))
				end
				new_children.forth
			end

				-- Now copy all instance referers and client representations from the original object children
				-- to the new object children.
			from
				new_children.start
				original_children.start
			until
				new_children.off
			loop
				current_new_child := new_children.item
				current_original_child := original_children.item

					-- Clear the client representations and merge those from the original object.
				current_new_child.all_client_representations.wipe_out
				current_new_child.all_client_representations.merge_right (current_original_child.all_client_representations.twin)

					-- Clear the instance_refers and merge those from the original object.
				current_new_child.instance_referers.clear_all
				current_new_child.instance_referers.merge (current_original_child.instance_referers)

				new_children.forth
				original_children.forth
			end

				-- Now ensure that the newly created objects have the same id's as the
				-- originals and are contained within the global list of objects.
				-- Simply iterate and replace, being sure to remove the original representations
				-- from the object list.
			components.object_handler.remove_object (new_object)
			new_object.set_id (an_object.id)
			components.object_handler.remove_object (an_object)
			components.object_handler.add_object_to_objects (new_object)
			from
				new_children.start
				original_children.start
			until
				new_children.off
			loop
				current_new_child := new_children.item
				current_original_child := original_children.item

				components.object_handler.remove_object (current_new_child)
				current_new_child.set_id (current_original_child.id)
				components.object_handler.remove_object (current_original_child)
				components.object_handler.add_object_to_objects (current_new_child)

				new_children.forth
				original_children.forth
			end

				-- Now replace the new representation of the object in the old parent.
				-- Paying attention to the original selected state.
			if an_object.layout_item.is_selected then
				is_selected := True
			end
			parent_object ?= an_object.parent_object
			old_pos := parent_object.children.index_of (an_object, 1)
			parent_object.remove_child (an_object)
			components.object_handler.add_object (parent_object, new_object, old_pos)
			if is_selected then
				new_object.layout_item.select_actions.block
				new_object.layout_item.enable_select
				new_object.layout_item.select_actions.resume
			end

				-- Now iterate through all of the objects that were originally stored as having their
				-- instances referers updated and store the connections to the pre `execute' state'.
			from
				new_links.start
				original_links.start
				original_instances.start
			until
				new_links.off
			loop
				new_link_object := components.object_handler.deep_object_from_id (new_links.item)
				original_link_object := components.object_handler.deep_object_from_id (original_links.item)
				original_instance_object := components.object_handler.deep_object_from_id (original_instances.item)

						-- Perform the reconnection of the clients.
				new_link_object.remove_client_representation (original_instance_object)
				new_link_object.instance_referers.remove (original_instance_object.id)
				new_link_object.unconnect_instance_referers (new_link_object, original_instance_object)
				original_link_object.instance_referers.put (original_instance_object.id, original_instance_object.id)
				original_link_object.connect_instance_referers (original_link_object, original_instance_object)

				new_links.forth
				original_links.forth
				original_instances.forth
			end

				-- Restore the original referers of `new_object'.
			new_object.instance_referers.merge (original_referers)

				-- Now update the instance referers for the top level object that had been flattened.
			an_object := components.object_handler.deep_object_from_id (object_id)
			top_object := components.object_handler.deep_object_from_id (top_id)

			new_object.connect_instance_referers (top_object, new_object)
			top_object.instance_referers.put (new_object.id, new_object.id)
			new_object.set_associated_top_level_object (top_object)

				-- Add a new client representation for the unflatten.
			top_object.add_client_representation (new_object)

			update_editors_for_change
			components.commands.update
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object_name: STRING
			an_object: GB_OBJECT
		do
			an_object := components.object_handler.deep_object_from_id (object_id)

			if not an_object.name.is_empty then
				object_name := an_object.name.twin
			else
				object_name := name_and_type_from_object (an_object)
			end
			if is_deep_flatten then
				object_name.append (" deep")
			end
			Result := object_name  + " flattened"
		end

feature {GB_WIDGET_SELECTOR} -- Implementation

	silent_execute is
			-- Execute a shallow flatten silently, without addition to the history
			-- and therefore not undoable.
		local
			an_object: GB_OBJECT
			top_object: GB_OBJECT
		do
				-- Recreate structures each time we execute which ensures that
				-- they are reset if we call `execute' and `undo' multiple times.
			create new_links.make (4)
			create original_links.make (4)
			create original_instances.make (4)

			an_object := components.object_handler.deep_object_from_id (object_id)
			top_object := components.object_handler.deep_object_from_id (top_id)
			check
				links_correct: top_object.instance_referers.has (an_object.id) and an_object.associated_top_level_object = top_object.id
			end
			an_object.unconnect_instance_referers (top_object, an_object)
			internal_shallow_flatten (an_object, top_object)
		end

feature {NONE} -- Implementation

	object_id: INTEGER
		-- id of object for flatten.

	top_id: INTEGER
		-- id of top object which the object was an instance.

	is_deep_flatten: BOOLEAN
		-- Does `Current' represent a deep flatten command?

	internal_shallow_flatten (current_object, associated_object: GB_OBJECT) is
			-- Recursively flatten all instance representations of `Current' object to `associated_object' if the
			-- current structure is not a representation of another top level object. If it is, reconnect
			-- all instance referers in the `current_object' structure to those in the `associated_object' structure.
		require
			current_object_not_void: current_object /= Void
			associated_object_not_void: associated_object /= Void
			current_object.children.count = associated_object.children.count
		local
			current_object_children, associated_object_children: ARRAYED_LIST [GB_OBJECT]
			current_item, current_associated_item: GB_OBJECT
			associated_cursor, current_cursor: CURSOR
			original_link_object, new_link_object, original_instance_object: GB_OBJECT
		do
			if current_object.associated_top_level_object /= 0 then
				current_object.remove_associated_top_level_object
				current_object.connect_display_object_events
				current_object.represent_as_non_locked_instance
				current_object.update_representations_for_name_or_type_change
			end

			associated_object.instance_referers.remove (current_object.id)

			current_object_children := current_object.children
			current_cursor := current_object_children.cursor
			associated_object_children := associated_object.children
			associated_cursor := associated_object_children.cursor
			from
				current_object_children.start
				associated_object_children.start
			until
				current_object_children.off
			loop
				current_item := current_object_children.item
				current_associated_item := associated_object_children.item
				if current_associated_item.associated_top_level_object > 0 then
					if is_deep_flatten then
						original_instances.extend (current_item.id)
						original_links.extend (current_associated_item.id)
					else
							-- If the current associated object has a reference to a top level object then we must
							-- set the current object as an association to this top level object directly.

						new_links.extend (current_associated_item.associated_top_level_object)
						original_instances.extend (current_item.id)
						original_links.extend (current_associated_item.id)

						original_link_object := current_associated_item
						new_link_object := components.object_handler.deep_object_from_id (current_associated_item.associated_top_level_object)
						original_instance_object := current_item

						original_link_object.instance_referers.remove (original_instance_object.id)

						new_link_object.instance_referers.put (original_instance_object.id, original_instance_object.id)
						current_item.set_associated_top_level_object (new_link_object)
						current_object.connect_instance_referers (new_link_object, original_instance_object)

							-- This next check ensures that the object already exists in the object structure.
							-- If we are executing this as a result of dropping an object from the clipboard (so
							-- not yet parented), it is not possible to add representations and this must be performed by the
							-- subsequent addition.
						if original_instance_object.top_level_parent_object.widget_selector_item /= Void then
							new_link_object.add_client_representation (original_instance_object)
						end

							-- Ensure that the representations are updated to reflect the fact that they are locked.
						current_item.represent_as_locked_instance
						current_item.update_representations_for_name_or_type_change
					end
				end
				if current_associated_item.associated_top_level_object = 0 or is_deep_flatten then
					internal_shallow_flatten (current_item, current_associated_item)
				end

				associated_object_children.forth
				current_object_children.forth
			end
			associated_object_children.go_to (associated_cursor)
			current_object_children.go_to (current_cursor)
		ensure
			current_object_is_not_top_level_instance: not current_object.is_instance_of_top_level_object
			current_object_children_index_not_changed: old current_object.children.index = current_object.children.index
			associated_object_children_index_not_changed: old associated_object.children.index = associated_object.children.index
		end

	update_editors_for_change is
			-- Now update all editors. As we have replaced the original object, we need to
			-- ensure that if they reference the original object, they now reference the new object.
		local
			l_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			current_editor: GB_OBJECT_EDITOR
		do
			l_editors := components.object_editors.all_editors
			from
				l_editors.start
			until
				l_editors.off
			loop
				current_editor := l_editors.item
				if current_editor.object /= Void and then current_editor.object.id = object_id then
					current_editor.set_object (components.object_handler.deep_object_from_id (object_id))
				end
				l_editors.forth
			end
		end

	new_links: ARRAYED_LIST [INTEGER]
	original_links: ARRAYED_LIST [INTEGER]
	original_instances: ARRAYED_LIST [INTEGER]
		-- Strutures used to keep track of the changed client representation
		-- links when they are rerouted during a flatten. They are subsequently
		-- restored from the contents of these arrays.

	original_referers: HASH_TABLE [INTEGER, INTEGER];
		-- All original referers of flattened object

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


end -- class GB_COMMAND_ADD_OBJECT

