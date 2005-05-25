indexing
	description: "Objects that represent a new delete object command."
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

	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end

	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end

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
				Result.drop_actions.extend (agent delete_transported_object)
				Result.drop_actions.extend (agent delete_radio_merge)
				Result.drop_actions.extend (agent delete_directory)
				Result.drop_actions.set_veto_pebble_function (agent veto_the_delete)
			end
	
		execute is
				-- Execute `Current'.
				-- Currently does nothing as you must drop
				-- on the toolbars representation to perform a delete.
			do
			end
	
feature {GB_WIDGET_SELECTOR, GB_CUT_OBJECT_COMMAND} -- Basic operation

	delete_transported_object (object_stone: GB_OBJECT_STONE) is
			-- Delete object represented by `object_stone'.
		require
			object_stone_not_void: object_stone /= Void
		local
			standard_object_stone: GB_STANDARD_OBJECT_STONE
			component_object_stone: GB_COMPONENT_OBJECT_STONE
		do
			standard_object_stone ?= object_stone
			if standard_object_stone /= Void then
				delete_object (standard_object_stone.object)
			else
				component_object_stone ?= object_stone
				if component_object_stone /= Void then
					component_selector.delete_component (component_object_stone.component.name)
				end
			end
		end
			
	delete_object (an_object: GB_OBJECT) is
			-- Remove `an_object' from the system.
		require
			object_not_void: an_object /= Void
		local
			command_delete: GB_COMMAND_DELETE_OBJECT
			command_delete_window: GB_COMMAND_DELETE_WINDOW_OBJECT
			referenced_dialog: GB_OBJECT_STILL_REFERENCED_DIALOG
		do
			if not an_object.is_top_level_object then
				create command_delete.make (an_object)
				history.cut_off_at_current_position
				command_delete.execute
			else
				if not can_delete_object (an_object) then
						-- Do not allow a top level object to be deleted if instances of it are already
						-- in use. May provide an option to convert to flat representations.
					create referenced_dialog.make_with_object (an_object)
					referenced_dialog.show_modal_to_window (main_window)
				end
					-- `referenced_dialog' permits you to flatten all instances so
					-- we simply check once again if we can now delete the object.
				if can_delete_object (an_object) then
					create command_delete_window.make (an_object)
					history.cut_off_at_current_position
					command_delete_window.execute
				end
			end
			--| FIXME we have not really performed the delete, as the object still exists.
			--| Need to clean up. May not be possible, unless we switch to XML representations and
			--| rebuild on the undo. Could be tricky.
		end
		
	can_delete_object (an_object: GB_OBJECT): BOOLEAN is
			-- May `an_object' be deleted? Only if it has no refers.
		require
			object_not_void: an_object /= Void
		do
			Result := True
			from
				an_object.instance_referers.start
			until
				an_object.instance_referers.off
			loop
				if not object_handler.deleted_objects.has (an_object.instance_referers.item_for_iteration) then
					Result := False
				end
				an_object.instance_referers.forth
			end
		end
	
feature {NONE} -- Implementation

	delete_radio_merge (group_link: GB_RADIO_GROUP_LINK) is
			-- Unmerge the containers referenced in `group_link'.
		do
			group_link.gb_ev_container.unlink_group (group_link)
		end
		
	delete_directory (a_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM) is
			-- Delete directory represented by `a_directory'.
		require
			directory_not_void: a_directory /= Void
		do
			widget_selector.remove_directory (a_directory)
		end

	veto_the_delete (object_stone: GB_OBJECT_STONE): BOOLEAN is
			-- Do not allow the delete if the object was picked
			-- from a type of component. The way that we are checking this,
			-- is by looking at the parent of the object. If it is Void then
			-- we should not be deleting the object.
		local
			clipboard_object_stone: GB_CLIPBOARD_OBJECT_STONE
			standard_object_stone: GB_STANDARD_OBJECT_STONE
		do
			clipboard_object_stone ?= object_stone
			Result := clipboard_object_stone = Void
			if Result then
				standard_object_stone ?= object_stone
				if standard_object_stone /= Void then
						-- This ensures you cannot delete an object straight from
						-- the type selector.
					Result := standard_object_stone.object.layout_item /= Void
				end
			end
		end

end -- class GB_DELETE_OBJECT
