indexing
	description: "Objects that represent a command for type changing objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_CHANGE_TYPE

inherit

	GB_COMMAND
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (an_object: GB_OBJECT; an_original_type, a_new_type: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and store necessary information
			-- required to `execute' and `undo'. Assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			components.history.cut_off_at_current_position
			original_type := an_original_type
			new_type := a_new_type
			original_id := an_object.id
			create new_ids.make (4)
			create original_ids.make (4)
		ensure
			components_set: components = a_components
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			original_object: GB_OBJECT
			layout_constructor_state_handler: GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
		do
			create layout_constructor_state_handler.make_with_components (components)
			layout_constructor_state_handler.store_layout_constructor
			original_object := components.object_handler.deep_object_from_id (original_id)
				-- Reset `new_ids' for iteration within `internal_execute' in the case where we are executing 2 or more times.
			new_ids.start

			internal_execute (original_object, Void)
			executed_once := True
			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end

			layout_constructor_state_handler.restore_layout_constructor
			components.commands.update
		end

	internal_execute (original_object: GB_OBJECT; instance_object: GB_OBJECT) is
			-- Change type of `original_object' to `new_type', recursively changing all instances.
			-- If `instance_object' is not Void, then insert the newly created object into `instance_referers'
			-- of `instance_object'. This ensures that the instance structure of the new objects is identical to
			-- that of the original.
		require
			original_object_not_void: original_object /= Void
		local
			new_object: GB_OBJECT
		do
				-- Call delete on object.
			original_object.delete

				-- We do not call `mark_as_deleted' here, as this would
				-- mark all the children as deleted also. Only the
				-- actual object should be marked as deleted.
			components.object_handler.objects.remove (original_object.id)
			components.object_handler.deleted_objects.put (original_object, original_object.id)

			if not executed_once then
					-- The first time `Current' is executed, we build a new object.
				new_object := components.object_handler.build_object_from_string_and_assign_id (new_type)
				new_ids.extend (new_object.id)
				original_ids.extend (original_object.id)
				if instance_object /= Void then
					instance_object.instance_referers.put (new_object.id, new_object.id)
				end
			else
					-- Additional executions use the objects created the first time.
				new_object := components.object_handler.deleted_objects.item (new_ids.item)
				components.object_handler.deleted_objects.remove (new_object.id)
				components.object_handler.objects.put (new_object, new_object.id)
				new_ids.forth
			end


			if not original_object.expanded_in_box then
					-- Update expanded status for objects parented in boxes.
				new_object.disable_expanded_in_box
			end
			components.object_handler.replace_object (original_object, new_object)
			new_object.set_name (original_object.name)

				-- Now recurse through all instance referers.
			from
				original_object.instance_referers.start
			until
				original_object.instance_referers.off
			loop
				internal_execute (components.object_handler.deep_object_from_id (original_object.instance_referers.item_for_iteration), new_object)
				original_object.instance_referers.forth
			end
		end


	undo is
			-- Undo `Current'.
			-- Must restore state to that before `execute'.
		local
			original_object, new_object: GB_OBJECT
			layout_constructor_state_handler: GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
		do
			create layout_constructor_state_handler.make_with_components (components)
			layout_constructor_state_handler.store_layout_constructor

			from
				original_ids.start
			until
				original_ids.off
			loop
				original_object := components.object_handler.deep_object_from_id (original_ids.item)
				new_object := components.object_handler.deep_object_from_id (new_ids.i_th (original_ids.index))
				components.object_handler.deleted_objects.remove (original_object.id)
				components.object_handler.objects.put (original_object, original_object.id)

				components.object_handler.objects.remove (new_object.id)
				components.object_handler.deleted_objects.put (new_object, new_object.id)

				components.object_handler.replace_object (new_object, original_object)
				new_object.set_name (original_object.name)
				new_object.layout_item.update_pixmap

				original_ids.forth
			end
			layout_constructor_state_handler.restore_layout_constructor
			components.commands.update
		end

feature -- Access

	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
			Result := original_type + " changed type to " + new_type
		end

feature {NONE} -- Implementation

	original_id: INTEGER
		-- Id of object whose type was changed.

	new_ids: ARRAYED_LIST [INTEGER]
		-- Ids of all objects that were created as part of the type change operation.

	original_ids: ARRAYED_LIST [INTEGER]
		-- Ids of all objects that were replaced as part of the type change operation.

	original_type: STRING
		-- String representation of original object type.

	new_type: STRING
		-- String representation of type changed to.

	executed_once: BOOLEAN

invariant
	new_ids_not_void: new_ids /= Void
	original_ids_not_void: original_ids /= Void
	original_type_not_void: original_type /= Void

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


end -- class GB_COMMAND_CHANGE_TYPE
