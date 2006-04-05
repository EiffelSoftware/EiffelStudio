indexing
	description: "Objects that represent a renaming of an object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_NAME_CHANGE

inherit

	GB_COMMAND
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

	make (child: GB_OBJECT; a_new_name, an_old_name: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		do
			components := a_components
			components.history.cut_off_at_current_position
			object_id := child.id
			new_name := a_new_name
			old_name := an_old_name
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			object: GB_OBJECT
		do
			object := components.object_handler.deep_object_from_id (object_id)

			object.set_name (new_name)
			if not components.history.command_list.has (Current) then
				components.history.add_command (Current)
			end
			if object.is_top_level_object then
				if not new_name.as_lower.is_equal (old_name.as_lower) then
						-- If only the type (Upper or Lower) of the named has changed, then there is no
						-- need to rename files.
					components.tools.widget_selector.update_class_files_of_window (object, old_name, new_name)
				end
					-- Now must recursively update all instances of `object' so that
					-- the representations are up to date.
				update_representations_of_all_referers (object)
			end
			components.object_editors.update_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_name_field)
			components.object_editors.update_all_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_merged_containers)
			components.commands.update
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			object: GB_OBJECT
		do
			object := components.object_handler.deep_object_from_id (object_id)
			object.set_name (old_name)
			object ?= object
			if object.is_top_level_object then
				if not new_name.as_lower.is_equal (old_name.as_lower) then
						-- If only the type (Upper or Lower) of the named has changed, then there is no
						-- need to rename files.
					components.tools.widget_selector.update_class_files_of_window (object, new_name, old_name)
				end
					-- Now must recursively update all instances of `object' so that
					-- the representations are up to date.
				update_representations_of_all_referers (object)
			end
			components.object_editors.update_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_name_field)
			components.commands.update
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object: GB_OBJECT
		do
			object := components.object_handler.deep_object_from_id (object_id)
			if old_name.is_empty then
				Result := "Unnamed " + object.short_type + " named as '" + new_name + "'"
			else
				if new_name.is_empty then
					Result := "'" + old_name + "' name removed."
				else
					Result := "'"+ old_name + "' renamed to '" + new_name + "'"
				end
			end
		end

feature {NONE} -- Implementation

	object_id: INTEGER
		-- Id of object whose name is changed.

	new_name: STRING
		-- Name given to object.

	old_name: STRING
		-- Previous name of `object'.

	update_representations_of_all_referers (an_object: GB_OBJECT) is
			-- For all `instance_referers' of `an_object recursively, call
			-- `update_layout_item_text' to reflect the name change in layout representations.
		require
			an_object_not_void: an_object /= Void
		local
			current_object: GB_OBJECT
		do
			from
				an_object.instance_referers.start
			until
				an_object.instance_referers.off
			loop
				current_object := components.object_handler.deep_object_from_id (an_object.instance_referers.item_for_iteration)
				current_object.update_representations_for_name_or_type_change
				update_representations_of_all_referers (current_object)
				an_object.instance_referers.forth
			end
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


end -- class GB_COMMAND_NAME_CHANGE
