indexing
	description: "Objects that represent a new delete object command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DELETE_OBJECT_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable,
			new_toolbar_item
		end
		
	GB_ACCESSIBLE_COMMAND_HANDLER
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
	GB_ACCESSIBLE_SYSTEM_STATUS
	
	GB_ACCESSIBLE_OBJECT_EDITOR

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Delete")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_delete_small)
			set_name ("Delete")
			set_menu_name ("Delete")
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := system_status.project_open
		end

feature -- Basic operations

		new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
				-- Create a new toolbar item linked to `Current'. This has been redefined as each button
				-- needs to have its drop actions set.
			do
				Result := Precursor {EB_STANDARD_CMD} (display_text, use_gray_icons)
				Result.drop_actions.extend (agent delete_object)
				Result.drop_actions.set_veto_pebble_function (agent veto_the_delete)
			end
	
		execute is
				-- Execute `Current'.
				-- Currently does nothing as you must drop
				-- on the toolbars representation to perform a delete.
			do
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
		
	veto_the_delete (an_object: GB_OBJECT): BOOLEAN is
			-- Do not allow the delete if the object was picked
			-- from a type of component. The way that we are checking this,
			-- is by looking at the parent of the object. If it is Void then
			-- we should not be deleting the object.
		do
			Result := an_object.parent_object /= Void
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

end -- class GB_DELETE_OBJECT
