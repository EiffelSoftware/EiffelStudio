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
		
	GB_XML_UTILITIES
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
			all_dependents: HASH_TABLE [GB_OBJECT, INTEGER]
			contents: XM_ELEMENT
			element_info: ELEMENT_INFORMATION
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			top_level_id: INTEGER
			actual_object: GB_OBJECT
			new_parent: GB_OBJECT
			selected_window: GB_WINDOW_SELECTOR_ITEM
		do
			Result := not clipboard.is_empty and ((layout_constructor.has_focus and layout_constructor.selected_item /= Void) or (window_selector.has_focus))
			if not clipboard.is_empty and (layout_constructor.has_focus and layout_constructor.selected_item /= Void) then
				layout_item ?= layout_constructor.selected_item
				parent_object ?= layout_item.object
				Result := parent_object.accepts_child (clipboard.object_type) and not parent_object.is_full and not parent_object.is_instance_of_top_level_object
			end
				-- Now ensure that we do not nest an instance of a top level widget in a structure
				-- that does not permit such nesting, thereby preventing nested inheritance cycles.
			if Result then
				if layout_constructor.has_focus then
					layout_item ?= layout_constructor.selected_item
					if layout_item /= Void then
						new_parent ?= layout_item.object
					end
				else
					selected_window ?= window_selector.selected_window
					if selected_window /= Void then
						new_parent ?= selected_window.object
					end
				end	
				if new_parent /= Void then	
					contents ?= clipboard.contents_cell.item.first
					contents ?= child_element_by_name (contents, internal_properties_string)
					full_information := get_unique_full_info (contents)
					element_info := full_information @ (reference_id_string)
					if element_info /= Void then
						top_level_id := element_info.data.to_integer
					
						create all_dependents.make (4)
						actual_object := object_handler.deep_object_from_id (top_level_id)
						if actual_object /= Void then
							actual_object.all_dependents_recursive (actual_object, all_dependents)
							all_dependents.extend (actual_object, actual_object.id)
							Result := Result and not all_dependents.has (new_parent.id)
						end
						
						Result := Result and new_parent.override_drop_on_child (actual_object)
					end
				end
			end
		end

feature -- Basic operations
	
		execute is
				-- Execute `Current'.
			local
				layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
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
