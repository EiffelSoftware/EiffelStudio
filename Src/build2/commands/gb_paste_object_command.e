indexing
	description: "Objects that represent a paste object command."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PASTE_OBJECT_COMMAND
	
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
			set_tooltip ("Paste")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_paste)
			set_name ("Paste")
			set_menu_name ("Paste")
			disable_sensitive
			add_agent (agent execute)

				-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_v)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end
		
feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			parent_object: GB_OBJECT
		do
			Result := not clipboard.is_empty and (layout_constructor.has_focus and layout_constructor.selected_item /= Void) or (window_selector.has_focus)
			if not clipboard.is_empty and (layout_constructor.has_focus and layout_constructor.selected_item /= Void) then
				layout_item ?= layout_constructor.selected_item
				parent_object ?= layout_item.object
				Result := parent_object.accepts_child (clipboard.object_type) and not parent_object.is_full and not parent_object.is_instance_of_top_level_object
			end
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			local
				layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				cut_object: GB_OBJECT
				global_status: GB_GLOBAL_STATUS
				layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
				command_add: GB_COMMAND_ADD_OBJECT
				parent_object: GB_PARENT_OBJECT
			do
					--|FIXME handle window selector.
				layout_item ?= layout_constructor.selected_item
				parent_object ?= layout_item.object
				create command_add.make (parent_object, clipboard.object, parent_object.children.count + 1)
				command_add.execute
			end

end -- class GB_PASTE_OBJECT_COMMAND
