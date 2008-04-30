indexing
	description: "Objects that represent a command for the deletion of an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_OBJECT

inherit
	GB_COMMAND_ADD_OBJECT
		rename
			make as old_make
		redefine
			execute, undo, textual_representation
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_object: GB_OBJECT; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `an_object' to be deleted.
		do
			components := a_components
			components.history.cut_off_at_current_position
			child_id := an_object.id
			parent_id := an_object.parent_object.id
			insert_position := an_object.parent_object.children.index_of (an_object, 1)
			create new_parent_child_objects.make (50)
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		do
			internal_execute (child_id, previous_parent_id, parent_id, previous_position_in_parent, insert_position)
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
			internal_execute (child_id, parent_id, 0, insert_position, 0)
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
				child_name := child_object.short_type
			end

			if not parent_object.name.is_empty then
				parent_name := parent_object.name
			else
				parent_name := parent_object.short_type
			end
			Result := child_name + " removed from " + parent_name
		end

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


end -- class GB_COMMAND_DELETE_OBJECT
