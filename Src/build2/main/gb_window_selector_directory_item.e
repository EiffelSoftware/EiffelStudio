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
		
	GB_WIDGET_UTILITIES
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
		
	GB_SHARED_TOOLS
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
			set_pebble (Current)
		ensure
			name_set: a_name.is_equal (text)
		end	

feature {GB_XML_STORE} -- Implementation

	generate_xml (element: XM_ELEMENT) is
			-- Generate properties of `Current' into `element'.
		require
			element_not_void: element /= Void
		do
			add_element_containing_string (element, "name", text)		
		end

feature {GB_XML_LOAD, GB_XML_IMPORT} -- Implementation

	modify_from_xml (element: XM_ELEMENT) is
			-- Update `Current' based on information in `element'
		require
			element_not_void: element /= Void
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (name_string)
			if element_info /= Void then
				set_text (element_info.data)
			end
		end

feature -- Implementation

	add_selector_item (an_item: GB_WINDOW_SELECTOR_ITEM) is
			-- Add `an_item' to `Current' by first removing it from
			-- its current `parent'.
		require
			an_item_not_void: an_item /= Void
		local
			command_move_window: GB_COMMAND_MOVE_WINDOW
		do
			create command_move_window.make (an_item.object, Current)
			command_move_window.execute
				-- Ensure that `Current' is expanded
			expand
				-- Update the system
			system_status.enable_project_modified
			command_handler.update	
		ensure
			item_contained: has (an_item)
		end
		
feature -- Implementation
	
	add_window_object (an_object: GB_TITLED_WINDOW_OBJECT) is
			-- Add representation of `an_object' to `Current'.
		require
			an_object_not_void: an_object /= Void
		do
			if an_object.window_selector_item = Void then
				window_selector.add_new_object (an_object)
			end
			add_selector_item (an_object.window_selector_item)
			system_status.enable_project_modified
			command_handler.update
		end
		
end -- class GB_WINDOW_SELECTOR_DIRECTORY_ITEM
