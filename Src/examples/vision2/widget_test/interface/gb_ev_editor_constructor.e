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
	
feature {NONE} -- Implementation

	initialize_attribute_editor (editor: GB_OBJECT_EDITOR_ITEM) is
			--
		deferred
		end
		
	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		deferred
		end
	
	validate_agents: HASH_TABLE [FUNCTION [ANY, TUPLE, BOOLEAN], STRING]
			-- Agents to query if a property modification is permitted, accessible
			-- via their associated name.
	
	execution_agents: HASH_TABLE [PROCEDURE [ANY, TUPLE], STRING]
			-- Agents to execute a property modification, accessible
			-- via their associated name.
		
	disable_all_items (box: EV_BOX) is
			-- Call `disable_item_expand' on all items in `b'.
		require
			box_not_void: box /= Void
		deferred
		end
		
	align_labels_left (box: EV_BOX) is
			-- For every item in `box' of type EV_LABEL, align the test left.
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
		
	for_all_objects (p: Procedure [EV_ANY, TUPLE]) is
			-- Call `p' on every item in `objects'.
		deferred
		end
		
	for_first_object (p: Procedure [EV_ANY, TUPLE]) is
			-- Call `p' on the first_item in `objects'.
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
		
	parent_window (widget: EV_WIDGET): EV_WINDOW is
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
		deferred
		end
		
	parent_dialog (widget: EV_WIDGET): EV_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		deferred
		end
		
	parent_editor: EV_VERTICAL_BOX is
			-- Object editor containing `Current'.
		deferred
		end
		
		
	enable_project_modified is
			-- Call enable_project_modified on `system_status' and
			-- update commands to reflect this.
		deferred
		end
		
	new_object_editor (object: GB_OBJECT) is
			-- Generate a new object editor containing `object'.
		deferred
		end
		
	named_list_item_from_object (a_first: EV_CONTAINER): EV_LIST_ITEM is
			--
		deferred
		end
		
	set_default_icon_pixmap (dialog: EV_DIALOG) is
			--
		deferred
		end
		
	retrieve_pebble (a_widget: EV_WIDGET): ANY is
			-- This will always return `Void' in a non
			-- Build2 system, as no pebble must be generated.
		do
		end
		
	named_list_item_from_widget (a_widget: EV_WIDGET): EV_LIST_ITEM is
			-- `Result' 
		require
			widget_not_void: a_widget /= Void
		do
			create Result.make_with_text (type_name (a_widget))
		ensure
			Result_not_void: Result /= Void
		end
		
	rebuild_associated_editors (object: EV_ANY) is
			-- For all editors referencing `vision2_object', rebuild any associated object editors.
		do
		end
		
	validate_true (a_string: STRING): BOOLEAN is
			-- A procedure that matches type for validation,
			-- and always returns True. Used when no validation
			-- is to be performed on STRING data
		do
			Result := True
		end

end -- class GB_EV_EDITOR_CONSTRUCTOR
