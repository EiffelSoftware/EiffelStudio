indexing
	description: "Objects that provide common attributes for the editor constructors."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_EDITOR_CONSTRUCTOR
	
inherit
	EV_ANY_HANDLER
	
	GB_CONSTANTS
	
	INTERNAL
	
feature {GB_OBJECT, GB_EV_EDITOR_CONSTRUCTOR} -- Implementation

	validate_agents: HASH_TABLE [FUNCTION [ANY, TUPLE, BOOLEAN], STRING] is
			-- Agents to query if a property modification is permitted, accessible
			-- via their associated name.
		deferred
		end
		
	
	execution_agents: HASH_TABLE [PROCEDURE [ANY, TUPLE], STRING] is
			-- Agents to execute a property modification, accessible
			-- via their associated name.
		deferred
		end

	initialize_attribute_editor (editor: GB_OBJECT_EDITOR_ITEM) is
			-- Perform common initialization on `editor'.
		deferred
		end
		
	disable_all_items (box: EV_BOX) is
			-- Call `disable_item_expand' on all items in `b'.
		require
			box_not_void: box /= Void
		deferred
		end
		
	align_labels_left (box: EV_BOX) is
			-- For every item in `box' of type EV_LABEL, align the text left.
		require
			box_not_void: box /= Void
		deferred
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		deferred
		end
		
	first: like ev_type is
			-- First entry in `objects'. This corresponds to
			-- the display component.
		require
			objects_not_empty: not objects.is_empty
		deferred
		end
		
	ev_type: EV_ANY is
			-- Vision2 type represented by `Current'.
			-- Only used with `like' in descendents.
			-- Always `Void'.
		deferred
		end
		
	type: STRING is
			-- String representation of `ev_type'.
		deferred
		end
		
		
	for_all_objects (p: Procedure [EV_ANY, TUPLE]) is
			-- Call `p' on every item in `objects'.
		deferred
		end
		
	for_first_object (p: Procedure [EV_ANY, TUPLE]) is
			-- Call `p' on the first_item in `objects'.
		deferred
		end
		
	for_all_instance_referers (an_object: GB_OBJECT; p: PROCEDURE [ANY, TUPLE [GB_OBJECT]]) is
			-- For all instance referers recursively of `an_object', call `p' with the current
			-- instance referer filled as the open argument. Used in places where `for_all_objects'
			-- can not be used directly as some level of indirection and/or calculation is required
			-- for each individual setting.
		require
			an_object_not_void: an_object /= Void
			procedure_not_void: p /= Void
		deferred
		end

		
	objects: ARRAYED_LIST [like ev_type] is
			-- All objects to which `Current' represents.
			-- Modifications must be made to all items
			-- identically.
		deferred
		end
		
	update_editors is
			-- Short version for calling everywhere.
		deferred
		end
		
	parent_window (widget: EV_ANY): EV_WINDOW is
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
		deferred
		end
		
	parent_dialog (widget: EV_WIDGET): EV_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		deferred
		end
		
	parent_editor: GB_OBJECT_EDITOR is
			-- Object editor containing `Current'.
		deferred
		end
		
	rebuild_associated_editors (object_id: INTEGER) is
			-- For all editors referencing object with id `object_id', rebuild any associated object editors.
		deferred
		end
		
	enable_project_modified is
			-- Call enable_project_modified on `system_status' and
			-- update commands to reflect this.
		deferred
		end
		
	new_object_editor (an_object: GB_OBJECT) is
			-- Generate a new object editor containing `object'.
		deferred
		end
		
	named_list_item_from_widget (a_widget: EV_WIDGET): EV_LIST_ITEM is
			-- `Result' is list item with text corresponding to
			-- object associated with `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
		local
			shared_handler: GB_SHARED_OBJECT_HANDLER
			an_object: GB_OBJECT
		do
			create shared_handler
			an_object := shared_handler.object_handler.object_from_display_widget (a_widget)
			check
				object_not_void: an_object /= Void
			end
			if object.name.is_empty then
				create Result.make_with_text (class_name (a_widget))
			else
				create Result.make_with_text (an_object.name + " : " + class_name (a_widget))
			end
		ensure
			Result_not_void: Result /= Void
			Result_has_text: not Result.text.is_empty
		end
		
	retrieve_pebble (a_widget: EV_WIDGET): ANY is
			-- Retrieve pebble for transport.
			-- `Result' is GB_OBJECT associated with `a_widget'.
			-- A convenient was of setting up the drop
			-- actions for GB_OBJECT.
		local
			an_object: GB_OBJECT
			shared_handler: GB_SHARED_OBJECT_HANDLER
		do
			create shared_handler
			an_object := shared_handler.object_handler.object_from_display_widget (a_widget)
			check
				object_not_void: an_object /= Void
			end
			
				--| FIXME This is currently identical to version in 
				--| GB_OBJECT
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if application.ctrl_pressed then
				new_object_editor (an_object)
			else
				Result := create {GB_STANDARD_OBJECT_STONE}.make_with_object (an_object)
			end
		end
	
	validate_true (a_string: STRING): BOOLEAN is
			-- A procedure that matches type for validation,
			-- and always returns True. Used when no validation
			-- is to be performed on STRING data
		do
			Result := True
		end
		
feature {GB_INTEGER_INPUT_FIELD, GB_STRING_INPUT_FIELD} -- Implementation

	object: GB_OBJECT is
			-- Object referenced by `Current'.
		deferred
		end
		
	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'.
		require
			an_object_not_void: an_object /= Void
		deferred
		ensure
			object_set: object = an_object
		end

end -- class GB_EV_EDITOR_CONSTRUCTOR
