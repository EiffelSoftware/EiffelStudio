indexing
	description: "Objects that represent subdirectoy layouts for windows."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_SELECTOR_DIRECTORY_ITEM
	
inherit

	GB_WIDGET_SELECTOR_COMMON_ITEM

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
		
	GB_SHARED_STATUS_BAR	
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
			tree_item.drop_actions.extend (agent handle_object_drop)
			tree_item.drop_actions.extend (agent add_new_directory_via_pick_and_drop)
			tree_item.drop_actions.set_veto_pebble_function (agent veto_object_drop)
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
		
feature {GB_WIDGET_SELECTOR, GB_WIDGET_SELECTOR_TOOL_BAR} -- Implementation

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

	handle_object_drop (object_pebble: GB_OBJECT_STONE) is
			-- Respond to the dropping of `object_pebble' onto `selector_item'.
		require
			object_pebble_not_void: object_pebble /= Void
		do
			widget_selector.handle_object_drop (object_pebble, Current)
		end

	veto_object_drop (object_stone: GB_OBJECT_STONE): BOOLEAN is
			-- Is `object_stone' permitted to be dropped?
		require
			object_stone_not_void: object_stone /= Void
		do
			Result := True
			if Result then
					-- Only clear the status bar if a drop is permitted.
					-- Without this line, holding an object above a widget selector item that did
					-- not accept the object and then moving over `Current', did not
					-- clear the status bar and the old message was displayed even though a drop was now permitted.
				clear_status_bar
			end
		end
		
	path: ARRAYED_LIST [STRING] is
			-- `Result' is list of directories `Current' is contained in, from the
			-- top level down.
		local
			current_node: GB_WIDGET_SELECTOR_COMMON_ITEM
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
			is_empty_implies_parent_is_widget_selector: Result.is_empty and parent /= Void implies parent = widget_selector
		end
		
	add_new_directory_via_pick_and_drop (directory_pebble: GB_NEW_DIRECTORY_PEBBLE) is
			-- Add a new directory within `Current' to `widget_selector'.
			-- `directory_pebble' is used to type the agent for pick and drop purposes.
		require
			directory_pebble_not_void: directory_pebble /= Void
		do
			widget_selector.add_new_directory (Current)
		end
		
invariant
	contents_alphabetical: tree_node_contents_alphabetical (tree_item)

end -- class GB_WIDGET_SELECTOR_DIRECTORY_ITEM
