indexing
	description: "Objects that represent subdirectoy layouts for windows."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WINDOW_SELECTOR_DIRECTORY_ITEM
	
inherit
	EV_TREE_ITEM
	
	GB_XML_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_COMMAND_HANDLER
	
create
	make_with_name
	
feature {NONE} -- Initialization

	make_with_name (a_name: STRING) is
			-- Create current with name `a_name' displayed as `text'.
		do
			default_create
			set_text (a_name)
			set_pixmap (((create {GB_SHARED_PIXMAPS}).icon_directory) @ 1)
			drop_actions.extend (agent add_window_object)
		ensure
			name_set: a_name.is_equal (text)
		end	

feature {GB_XML_STORE} -- Implementation

	generate_xml (element: XML_ELEMENT) is
			-- Generate properties of `Current' into `element'.
		require
			element_not_void: element /= Void
		do
			add_element_containing_string (element, "name", text)		
		end

feature {GB_XML_LOAD} -- Implementation

	modify_from_xml (element: XML_ELEMENT) is
			-- Update `Current' based on information in `element'
		require
			element_not_void: element /= Void
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			stripped_text: STRING
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (name_string)
			if element_info /= Void then
				set_text (element_info.data)
			end
		end

feature {GB_XML_LOAD} -- Implementation

	add_selector_item (an_item: GB_WINDOW_SELECTOR_ITEM) is
			-- Add `an_item' to `Current' by first removing it from
			-- its current `parent'.
		require
			an_item_not_void: an_item /= Void
		local
			tree: EV_TREE
			tree_item: EV_TREE_ITEM
		do
			tree ?= an_item.parent
			if tree /= Void then
				tree.prune_all (an_item)
			else
				tree_item ?= an_item.parent
				if tree_item /= Void then
					tree_item.prune_all (an_item)
				end
			end
			check
				item_not_parented: an_item.parent = Void
			end
			extend (an_item)
				-- Ensure that `Current' is expanded
			expand
		ensure
			item_contained: has (an_item)
		end
	
	add_window_object (an_object: GB_TITLED_WINDOW_OBJECT) is
			-- Add representation of `an_object' to `Current'.
		local
			window_selector: GB_WINDOW_SELECTOR
		do
			window_selector ?= parent
			check
				parent_is_window_selector: window_selector /= Void
			end
			if an_object.window_selector_item = Void then
				window_selector.add_new_object (an_object)
			end
			add_selector_item (an_object.window_selector_item)
			system_status.enable_project_modified
			command_handler.update
		end
		
end -- class GB_WINDOW_SELECTOR_DIRECTORY_ITEM
