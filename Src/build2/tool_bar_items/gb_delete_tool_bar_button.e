indexing
	description: "Objects that represent a delete button on the toolbar."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DELETE_TOOL_BAR_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE_OBJECT_HANDLER
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_OBJECT_EDITOR
		undefine
			default_create, copy, is_equal
		end
		
feature -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Set pixmap and connect agents.
		local
			a_pixmap: EV_PIXMAP
		do
			Precursor {EV_TOOL_BAR_BUTTON}
			set_pixmap ((create {GB_SHARED_PIXMAPS}).icon_delete_small @ 1)
			set_tooltip ("Delete")
			drop_actions.extend (agent delete_object)
		end

feature {NONE} -- Implementation

	delete_object (an_object: GB_OBJECT) is
			-- Remove `a_constructor_item' from the system.
		local
			old_parent_object: GB_OBJECT
		do
			update_object_editors_for_delete (an_object, all_editors)
			old_parent_object := an_object.parent_object
			an_object.unparent
			check
				old_parent_object_not_void: old_parent_object /= Void
			end
			--old_parent_object.build_drop_action_for_new_object
			--| FIXME we have not really performed the delete, as the object still exists.
			--| Need to clean up.
		end
		
	update_object_editors_for_delete (deleted_object: GB_OBJECT editors: ARRAYED_LIST [GB_OBJECT_EDITOR]) is
			-- For every item in `editors', update to reflect removal of `deleted_object'.
		local
			editor: GB_OBJECT_EDITOR
			local_parent: GB_OBJECT
		do
			local_parent := deleted_object.parent_object
			from
				editors.start
			until
				editors.off
			loop
				editor := editors.item
					-- Update the editor if `Current' or a child of `Current'
					-- is contained.
				if object_handler.object_contained_in_object (deleted_object, editor.object) or
					deleted_object = editor.object then
					editor.remove_editor
				end
			
					-- If the parent of `an_object' is in the object editor then we must
					-- update it accordingly.
				if local_parent /= Void and then local_parent = editor.object then
					editor.update_current_object
				end	
				editors.forth
			end
		end
		

end -- class GB_DELETE_TOOL_BAR_BUTTON
