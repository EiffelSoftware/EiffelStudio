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
		local
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
		
	rebuild_associated_editors (object: EV_ANY) is
			-- For all editors referencing `vision2_object', rebuild any associated object editors.
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
		
	named_list_item_from_widget (a_widget: EV_WIDGET): EV_LIST_ITEM is
			-- `Result' is list item with text corresponding to
			-- object associated with `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
		local
			shared_handler: GB_SHARED_OBJECT_HANDLER
			object: GB_OBJECT
		do
			create shared_handler
			object := shared_handler.object_handler.object_from_display_widget (a_widget)
			check
				object_not_void: object /= Void
			end
			if object.name.is_empty then
				create Result.make_with_text (class_name (a_widget))
			else
				create Result.make_with_text (object.name + " : " + class_name (a_widget))
			end
		ensure
			Result_not_void: Result /= Void
			Result_has_text: not Result.text.is_empty
		end
		
	set_default_icon_pixmap (dialog: EV_DIALOG) is
			-- Assign the default Build icon to `dialog'.
		do
			dialog.set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
		end
		

end -- class GB_EV_EDITOR
