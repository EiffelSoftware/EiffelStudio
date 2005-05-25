indexing
	description: "Objects that represent a cut object command."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CUT_OBJECT_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
		
	GB_SHARED_TOOLS
		export
			{ANY} layout_constructor
			{NONE} all
		end
		
	GB_SHARED_CLIPBOAD
		export
			{NONE} all
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Cut")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_cut)
			set_name ("Cut")
			set_menu_name ("Cut")
			disable_sensitive
			add_agent (agent execute)
			drop_agent := agent execute_with_object

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_x)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end
		
feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := (layout_constructor.has_focus and layout_constructor.selected_item /= Void) or
				(widget_selector.has_focus and widget_selector.selected_window /= Void)
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			local
				command_delete: GB_DELETE_OBJECT_COMMAND
				layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				cut_object: GB_OBJECT
				selector_item: GB_WIDGET_SELECTOR_ITEM
			do
				if layout_constructor.has_focus then
					layout_item ?= layout_constructor.selected_item
					cut_object := layout_item.object
				else
					selector_item ?= widget_selector.selected_window
					check
						selected_item_was_object: selector_item /= Void
					end
					cut_object := selector_item.object
				end
				clipboard.set_object (cut_object)
				
				create command_delete.make
				command_delete.delete_object (cut_object)
				
				command_handler.update
			end
			
		execute_with_object (object_stone: GB_STANDARD_OBJECT_STONE) is
				-- Execute `Current' directly with object `object_stone'.
			require
				object_stone_not_void: object_stone /= Void
			local
				command_delete: GB_DELETE_OBJECT_COMMAND
			do
				clipboard.set_object (object_stone.object)
				
				create command_delete.make
				command_delete.delete_object (object_stone.object)
				
				command_handler.update
			end

end -- class GB_CUT_OBJECT_COMMAND
