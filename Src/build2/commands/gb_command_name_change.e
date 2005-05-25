indexing
	description: "Objects that represent a renaming of an object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_NAME_CHANGE
	
inherit
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_COMMAND
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
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

	make (child: GB_OBJECT; a_new_name, an_old_name: STRING) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		do
			history.cut_off_at_current_position
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
			object := Object_handler.deep_object_from_id (object_id)
			
			object.set_name (new_name)
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			if object.is_top_level_object then
				if not new_name.as_lower.is_equal (old_name.as_lower) then
						-- If only the type (Upper or Lower) of the named has changed, then there is no
						-- need to rename files.
					widget_selector.update_class_files_of_window (object, old_name, new_name)
				end
					-- Now must recursively update all instances of `object' so that
					-- the representations are up to date.
				update_representations_of_all_referers (object)
			end
			update_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_name_field)
			update_all_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_merged_containers)
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			object: GB_OBJECT
		do
			object := Object_handler.deep_object_from_id (object_id)
			object.set_name (old_name)
			object ?= object
			if object.is_top_level_object then
				if not new_name.as_lower.is_equal (old_name.as_lower) then
						-- If only the type (Upper or Lower) of the named has changed, then there is no
						-- need to rename files.
					widget_selector.update_class_files_of_window (object, new_name, old_name)
				end
					-- Now must recursively update all instances of `object' so that
					-- the representations are up to date.
				update_representations_of_all_referers (object)
			end
			update_editors_by_calling_feature (object.object, Void, agent {GB_OBJECT_EDITOR}.update_name_field)
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			object: GB_OBJECT
		do
			object := Object_handler.deep_object_from_id (object_id)
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
				current_object := object_handler.deep_object_from_id (an_object.instance_referers.item_for_iteration)
				current_object.update_representations_for_name_or_type_change
				update_representations_of_all_referers (current_object)
				an_object.instance_referers.forth
			end
		end

end -- class GB_COMMAND_NAME_CHANGE
