indexing
	description: "Objects that represent subdirectoy layouts for windows."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WINDOW_SELECTOR_DIRECTORY_ITEM
	
inherit

	GB_WINDOW_SELECTOR_COMMON_ITEM

	GB_XML_UTILITIES
		export
			{NONE} all
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_HANDLER	
		export
			{NONE} all
		end
		
create
	make_with_name
	
feature {NONE} -- Initialization

	make_with_name (a_name: STRING) is
			-- Create current with name `a_name' displayed as `text'.
		require
			a_name_not_void: a_name /= Void
		do
			default_create
			common_make
			set_name (a_name)
			tree_item.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_cluster_symbol_gray"))
			tree_item.drop_actions.extend (agent add_object)
			tree_item.drop_actions.set_veto_pebble_function (agent restrict_drop_to_valid_types)
			tree_item.set_pebble (Current)
			is_grayed_out := True
		ensure
			name_set: name.is_equal (a_name)
		end

feature {GB_XML_STORE} -- Implementation

	generate_xml (element: XM_ELEMENT) is
			-- Generate properties of `Current' into `element'.
		require
			element_not_void: element /= Void
		do
			add_element_containing_string (element, "name", name)		
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
				set_name (element_info.data)
			end
		end
		
feature {GB_WINDOW_SELECTOR, GB_WINDOW_SELECTOR_TOOL_BAR} -- Implementation

	is_grayed_out: BOOLEAN
		-- Is current represent with a gray icon?
		
	display_in_color is
			-- Ensure `Current' is represented in color.
		do
			if is_grayed_out then
				tree_item.set_pixmap (((create {GB_SHARED_PIXMAPS}).icon_directory) @ 1)
				is_grayed_out := False
			end
		ensure
			not_grayed_out: not is_grayed_out
		end
		
	display_in_gray is
			-- Ensure `Current' is represented in gray.
		do
			if not is_grayed_out then
				tree_item.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_cluster_symbol_gray"))
				is_grayed_out := True
			end
		ensure
			is_grayed_out: is_grayed_out
		end

feature -- Implementation
	
	add_object (an_object: GB_OBJECT) is
			-- Add representation of `an_object' to `Current'.
		require
			an_object_not_void: an_object /= Void
		do
			if an_object.window_selector_item = Void then
				window_selector.add_new_object (an_object)
			end
			if an_object.window_selector_item /= Void then
				add_selector_item (an_object.window_selector_item)
			else
				add_selector_item (object_handler.deep_object_from_id (an_object.associated_top_level_object).window_selector_item)
			end
			system_status.enable_project_modified
			command_handler.update
		end
		
	restrict_drop_to_valid_types (an_object: GB_OBJECT): BOOLEAN is
			-- Return `True' if `an_object' is a top level object.
		require
			an_object_not_void: an_object /= Void
		local
			type: STRING
		do
			type := an_object.generating_type
			Result := type.substring_index ("_ITEM_", 1) = 0
				and type.substring_index ("MENU", 1) = 0
				and not an_object.is_instance_of_top_level_object
		ensure
		-- | FIXME Crashes transport. No idea why.
		--	Result = (an_object.object /= Void) implies an_object.is_top_level_object
		end
		
	path: ARRAYED_LIST [STRING] is
			-- `Result' is list of directories `Current' is contained in, from the
			-- top level down.
		local
			current_node: GB_WINDOW_SELECTOR_COMMON_ITEM
			temp_result: ARRAYED_LIST [STRING]
		do
			create temp_result.make (4)
			from
				current_node := Current
			until
				current_node.parent = Void
			loop
				temp_result.extend (current_node.name)
				current_node ?= current_node.parent
			end
			create Result.make (temp_result.count)
			from
				temp_result.go_i_th (temp_result.count)
			until
				temp_result.off
			loop
				Result.extend (temp_result.item)
				temp_result.back
			end
			check
				results_consistent: temp_result.count = Result.count
			end
		ensure
			Result_not_void: Result /= Void
			is_empty_implies_parent_is_window_selector: Result.is_empty and parent /= Void implies parent = window_selector
		end
		
feature {NONE} -- Implementation

	add_selector_item (an_item: GB_WINDOW_SELECTOR_ITEM) is
			-- Add `an_item' to `Current' by first removing it from
			-- its current `parent'.
		require
			an_item_not_void: an_item /= Void
		local
			command_move_window: GB_COMMAND_MOVE_WINDOW
		do
			if an_item.object.window_selector_item.parent /= Void then
				create command_move_window.make (an_item.object, Current)
				command_move_window.execute
			
					-- Ensure that `Current' is expanded
				expand
					-- Update the system
				system_status.enable_project_modified
				command_handler.update	
			end
		ensure
			item_contained: children.has (an_item)
		end
		
invariant
	contents_alphabetical: tree_node_contents_alphabetical (tree_item)

end -- class GB_WINDOW_SELECTOR_DIRECTORY_ITEM
