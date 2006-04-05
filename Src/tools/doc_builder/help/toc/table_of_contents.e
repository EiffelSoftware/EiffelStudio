indexing
	description: "TOC structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS

inherit
	TABLE_OF_CONTENTS_NODE
		rename
			sort as sort_as_node,		
			flatten_ids as flatten_node_ids
		end
		
	UTILITY_FUNCTIONS
		undefine
			copy,
			is_equal
		end
		
	TEMPLATE_CONSTANTS
		undefine
			copy,
			is_equal
		end
		
create
	make,
	make_empty,
	make_from_directory,
	make_from_directory_sub_dirs,
	make_from_tree,
	make_from_toc

feature -- Creation
			
	make_empty is
			-- Make empty TOC
		do
			make_root
			initialize
		end		
			
	make_from_directory (a_directory: DIRECTORY) is
			-- Make with `a_directory' as top node.
		require
			has_root: a_directory /= Void
		do
			make_empty
			build_from_directory (a_directory, Current)
			build_code_toc
		end	
		
	make_from_directory_sub_dirs (a_directory: DIRECTORY; include_dirs: ARRAYED_LIST [STRING]) is
			-- Make with `a_directory' as top node.  During generation use only files in include dirs
		require
			has_root: a_directory /= Void
			has_include_dirs: include_dirs /= Void
			include_dirs_valid: not include_dirs.is_empty
		do
			make_empty
			build_from_directory_sub_dirs (a_directory, include_dirs, Current)
		end
		
	make_from_tree (a_tree: EV_TREE) is
			-- Initialize based on structure of `a_toc'
		do
			make_empty
			build_from_tree (a_tree, Current)
			build_code_toc
		end

	make_from_toc (a_toc: like Current) is
			-- Make from existing toc
		do
			make_empty
			build_from_node (a_toc, Current)
		end		

feature -- Initialization

	initialize is
			-- Initialize
		do			
			set_filter (manager.shared_project.filter_manager.filter_by_description ("Unfiltered"))
			set_title (root_string)
			code_nodes.clear_all
		end

feature -- Access	
	
	name: STRING
			-- File from which Current was constructed	
		
	old_name: STRING
			-- Old name of toc
	
	node_by_id (a_id: INTEGER): TABLE_OF_CONTENTS_NODE is
			-- Retrieve node with id `a_id', Void if no match found
		require
			valid_id: a_id > 0
		do
			Result ?= internal_nodes.item (a_id)
		end

	filter: DOCUMENT_FILTER
			-- Associatied filter for sorting

feature -- Status Setting	
	
	set_name (a_name: STRING) is
			-- Set filename to `a_name'
		do
			name := a_name
		end	
	
	set_persisted (a_flag: BOOLEAN) is
			-- Set if persisted to disk
		do
			is_persisted := a_flag	
		end

	set_filter_empty_nodes (a_flag: BOOLEAN) is
			-- Set `filter_empty_nodes'
		do
			filter_empty_nodes := a_flag
		end
	
	set_filter_skipped_sub_nodes (a_flag: BOOLEAN) is
			-- Set `filter_skipped_sub_nodes'
		do
			filter_skipped_sub_nodes := a_flag
		end
		
	set_filter_nodes_no_index (a_flag: BOOLEAN) is
			-- Set `filter_nodes_no_index'
		do
			filter_nodes_no_index := a_flag
		end
	
	set_filter_alphabetically (a_flag: BOOLEAN) is
			-- Set `order_alphabetically'
		do
			order_alphabetically := a_flag
		end
	
	set_make_index_root (a_flag: BOOLEAN) is
			-- Set `make_index_root'
		do
			make_root_from_index := a_flag
		end

	set_filter (a_filter: DOCUMENT_FILTER) is
			-- Associated filter for sorting
		require
			filter_not_void: a_filter /= Void
		do
			filter := a_filter
		ensure
			filter_set: filter = a_filter
		end

feature -- Query

	is_persisted: BOOLEAN
			-- Is Current saved to disk?

feature -- Commands	

	sort is
			-- Sort.  Sort according to the following sequence and rules:
			--	1) Filters out nodes not applicable to output type.  If a node needs to be moved
			--     it is filtered here and added back later in the correct location
			--  2) Sorts nodes which passed filter process in 1) according to sorting options specified
			--  3) Moves sorted nodes which need moving to appropriate locations
			--  4) With fully sorted structure sorts nodes alphabetically if required
		do				
			reset
			Manager.Shared_constants.Application_constants.set_index_file_name ("index.xml")
			filter_nodes	
			sort_node (Current)
			move_nodes				
			if order_alphabetically then
				sort_node_alphabetically (Current)
			end
			remove_duplicate_nodes (Current)			
		end		

	reset is
			-- Reset
		do
			is_persisted := False
			create Move_nodes_list.make (2)
			Move_nodes_list.compare_objects
			New_indexes.wipe_out
			Code_nodes.clear_all
		end			

	flatten_ids is
			-- Flatten ids
		do			
			set_unique_id (flatten_node_ids (1))
		end

feature -- Storage

	save is
			-- Save Current to disk (XML format)
		do
			if not is_persisted then
				save_dialog
			else
				save_as_xml			
			end
		end		

feature {NONE} -- Initialization

	build_from_directory (root_dir: DIRECTORY; a_parent: TABLE_OF_CONTENTS_NODE) is
			-- Starting from `root_dir' build a TOC that contains nodes for
			-- files recursively in `root_dir'. Resulting TOC is identical in structure to
			-- `root_dir' and does not apply any filtering or sorting.
		require
			dir_not_void: root_dir /= Void
			parent_not_void: a_parent /= Void
		local
			l_node: TABLE_OF_CONTENTS_NODE
			l_dir: DIRECTORY
			cnt, l_id, l_dir_cnt: INTEGER
			l_item, l_extension: STRING
			l_url: FILE_NAME
			l_make_node: BOOLEAN
		do			
			from
				cnt := 0
				root_dir.open_read
				root_dir.start
				l_dir_cnt := root_dir.count
			until
				cnt = l_dir_cnt
			loop
				root_dir.readentry
				l_item := root_dir.lastentry						
				if l_item /= Void and then not l_item.is_equal (".") and then not l_item.is_equal ("..") then 
							-- Make url from name of directory entry
					create l_url.make_from_string (root_dir.name)					
					l_url.extend (l_item)
					create l_dir.make (l_url.string)
					l_make_node := l_dir.exists
					
					if not l_make_node then
						l_extension := l_item.substring (l_item.last_index_of ('.', l_item.count) + 1, l_item.count)
						if l_extension /= Void then
							l_extension.to_lower
							l_make_node := file_types.has (l_extension)
						end
					end
					
					if l_make_node then									
					
								-- Create new node and append to `a_parent'
						l_id := next_id
						create l_node.make (l_id, a_parent, l_url.string, l_item)
						a_parent.add_node (l_node)
						
								-- Check if new current item is a folder and if so process children
						if l_dir.exists then
							if Manager.Shared_constants.Application_constants.Code_directories.has (l_dir.name.string) then
									-- This is a marked code directory.  Therefore do not include it.
								code_nodes.extend (l_node, l_dir.name.string)
								sort_excluded.extend (l_node.id)
							else
								build_from_directory (l_dir, l_node)
							end
						end			
					end				
				end
				cnt := cnt + 1
			end
			root_dir.close
		end

	build_from_directory_sub_dirs (root_dir: DIRECTORY; include_dirs: ARRAYED_LIST [STRING]; a_parent: TABLE_OF_CONTENTS_NODE) is
			-- Starting from `root_dir' build a TOC that contains nodes for
			-- files recursively from `root_dir' and which are in `include_dirs'.
		require
			dir_not_void: root_dir /= Void
			parent_not_void: a_parent /= Void
		local
			l_node: TABLE_OF_CONTENTS_NODE
			l_dir: DIRECTORY
			cnt, l_id, l_dir_cnt: INTEGER
			l_item, l_extension: STRING
			l_url: FILE_NAME
			l_make_node: BOOLEAN
		do			
			from
				cnt := 0
				root_dir.open_read
				root_dir.start
				l_dir_cnt := root_dir.count
			until
				cnt = l_dir_cnt
			loop
				root_dir.readentry
				l_item := root_dir.lastentry						
				if l_item /= Void and then not l_item.is_equal (".") and then not l_item.is_equal ("..") then 
							-- Make url from name of directory entry
					create l_url.make_from_string (root_dir.name)					
					l_url.extend (l_item)
					create l_dir.make (l_url.string)
					l_make_node := l_dir.exists and then is_parent_dir_include_dir (l_dir, include_dirs)
					
					if not l_make_node then
						l_extension := l_item.substring (l_item.last_index_of ('.', l_item.count) + 1, l_item.count)
						if l_extension /= Void then
							l_extension.to_lower
							l_make_node := file_types.has (l_extension) and then file_in_dir (root_dir.name, include_dirs)
						end
					end
					
					if l_make_node then									
					
								-- Create new node and append to `a_parent'
						l_id := next_id
						create l_node.make (l_id, a_parent, l_url.string, l_item)
						a_parent.add_node (l_node)
						
								-- Check if new current item is a folder and if so process children
						if l_dir.exists then
							if Manager.Shared_constants.Application_constants.Code_directories.has (l_dir.name.string) then
									-- This is a marked code directory.  Therefore do not include it.
								code_nodes.extend (l_node, l_dir.name.string)
								sort_excluded.extend (l_node.id)
							else
								build_from_directory_sub_dirs (l_dir, include_dirs, l_node)
							end
						end			
					end				
				end
				cnt := cnt + 1
			end
			root_dir.close
		end

	build_from_tree (a_tree: EV_TREE_NODE_LIST; a_parent: TABLE_OF_CONTENTS_NODE) is
				-- Initialize based on structure of `a_tree'
			local
				l_item: TABLE_OF_CONTENTS_WIDGET_NODE
				l_node: TABLE_OF_CONTENTS_NODE				
				l_widget_node: TABLE_OF_CONTENTS_WIDGET_NODE
				l_url, l_title: STRING
				l_id: INTEGER
			do			
				from
					a_tree.start
				until
					a_tree.after
				loop
					l_item ?= a_tree.item
					if l_item /= Void then
						l_id := next_id
								-- Make url and title from tree item data
						l_widget_node ?= l_item
						if l_widget_node /= Void then
							l_url := l_widget_node.file_url
							l_title := l_widget_node.title
						else
							l_title := l_item.text
						end			
								
						check
							title_not_void: l_title /= Void
							valid_id: l_id > 0
						end
								
								-- Create new node and append to `a_parent'						
						create l_node.make (l_id, a_parent, l_url, l_title)
						a_parent.add_node (l_node)
						
								-- Check if new node was a folder and if so process children
						if not l_item.is_empty then
							build_from_tree (l_item, l_node)
						end
					end
					a_tree.forth
				end								
			end		
			
	build_from_node (a_node, a_parent: TABLE_OF_CONTENTS_NODE) is
				-- Initialize based on structure of `a_node'
			local
				l_node,
				l_new_node: TABLE_OF_CONTENTS_NODE								
				l_url, l_title: STRING
				l_id: INTEGER
			do			
				if a_node.has_child then
					from
						a_node.children.start
					until
						a_node.children.after
					loop
						l_node := a_node.children.item.twin
						l_id := l_node.id
						l_url := l_node.url.twin
						l_title := l_node.title.twin
						create l_new_node.make (l_id, a_parent, l_url, l_title)
						a_parent.add_node (l_new_node)
						if l_node.has_child then
							build_from_node (l_node, l_new_node)
						end
						a_node.children.forth
					end					
				end								
			end		

	build_code_toc is
			-- Build in code sub-tocs
		local
			l_dir: DIRECTORY
			l_name: STRING
			l_node: TABLE_OF_CONTENTS_NODE
		do
			from
				Code_nodes.start
			until
				Code_nodes.after
			loop
				l_name := Code_nodes.key_for_iteration.string
				l_node := Code_nodes.item (l_name)
				create l_dir.make (l_name)
				insert_code_toc (l_node, l_dir)
				Code_nodes.forth
			end
		end	

	insert_code_toc (a_parent: TABLE_OF_CONTENTS_NODE; a_root: DIRECTORY) is
			-- Insert code toc representation of `a_root' into parent
		local
			l_file: PLAIN_TEXT_FILE
			l_sub_dir: DIRECTORY
			l_path,
			l_curr_name,
			l_node_title: STRING
			l_dir_name: FILE_NAME
			l_cnt,
			l_dir_count: INTEGER
			l_node: TABLE_OF_CONTENTS_NODE
			l_index_done,
			l_is_index: BOOLEAN
			l_class_processor: CLASS_TOC_PROCESSOR			
		do
			from
				a_root.open_read
				a_root.start
				l_cnt := 1
				l_dir_count := a_root.count
			until
				l_cnt > l_dir_count
			loop
				l_path := a_root.name
				a_root.readentry
				l_curr_name := a_root.lastentry				
				if not (l_curr_name.is_equal (".") or l_curr_name.is_equal (".."))  then
					if not l_index_done then
							-- Process index node first
						l_index_done := True
						create l_dir_name.make_from_string (l_path)
						if a_root.has_entry (Default_url) then						
							l_dir_name.extend (Default_url)
							create l_file.make (l_dir_name.string)
							if l_file.exists then
									-- Set parent node with index details
								l_node_title := short_name (l_path)
								l_node_title.to_lower
								if l_node_title.is_equal ("reference") then
									l_node_title.replace_substring (l_node_title.item (1).as_upper.out, 1, 1)									
								end
								a_parent.set_title (l_node_title)
								a_parent.set_url (l_dir_name.string)
								create l_class_processor.make (a_parent.parent, l_file)
							end
							l_is_index := l_curr_name.is_equal (Default_url)
						end
					end				
					
					if not l_is_index then
						create l_dir_name.make_from_string (l_path)
						l_dir_name.extend (l_curr_name)
								-- Process chart node (*_chart.xml)
						if l_curr_name.substring (l_curr_name.count - 9, l_curr_name.count - 4).is_equal (Chart_suffix) then
							create l_file.make (l_dir_name.string)
							if l_file.exists then
								create l_class_processor.make (a_parent, l_file)
							end
						else
							create l_sub_dir.make (l_dir_name.string)
							if l_sub_dir.exists and then not l_sub_dir.is_empty then
								create l_node.make (next_id, a_parent, Void, l_curr_name)								
								a_parent.add_node (l_node)
								insert_code_toc (l_node, l_sub_dir)
							end
						end
					else						
						l_is_index := False
					end
				end
				l_cnt := l_cnt + 1				
			end
			a_root.close
		end		

feature {NONE} -- Implementation
		
	internal_nodes: HASH_TABLE [TABLE_OF_CONTENTS_NODE, INTEGER]
			-- Hash of nodes with their ids

	save_dialog is
			-- Save Dialog
		local
			l_save_dialog: EV_FILE_SAVE_DIALOG
		do
			create l_save_dialog
			l_save_dialog.show_modal_to_window (Manager.Application_window)
			if l_save_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_save) then
				old_name := name
				set_name (l_save_dialog.file_name)
				is_persisted := True
				save
			end	
		end		

	file_types: ARRAYED_LIST [STRING] is
			-- List of file types allowed in HTML project
		once
			create Result.make (6)
			Result.compare_objects
			Result.extend ("html")
			Result.extend ("htm")
			Result.extend ("xml")
		end

	code_nodes: HASH_TABLE [TABLE_OF_CONTENTS_NODE, STRING] is
			-- Nodes which have code nodes in them
		once
			create Result.make (10)
			Result.compare_objects
		end		

	sort_excluded: ARRAYED_LIST [INTEGER] is
			-- Nodes which should be excluded from any sorting or filtering (i.e code nodes)
		once
			create Result.make (10)
			Result.compare_objects
		end	

	save_as_xml is
			-- Save Current as XML file		
		local
			l_xml: XML_TABLE_OF_CONTENTS
		do
			create l_xml.make_from_toc (Current, name)			 
		end
		
	is_parent_dir_include_dir (a_dir: DIRECTORY; include_dirs: ARRAYED_LIST [STRING]): BOOLEAN is
			-- Is a_dir a parent of, or equal to, any of include_dirs?
		local
			l_dir,
			l_dir2: STRING
		do
			from
				include_dirs.start
				l_dir2 := a_dir.name
				l_dir2.replace_substring_all ("\", "/")
			until
				include_dirs.after or Result
			loop		
				l_dir := include_dirs.item
				l_dir.replace_substring_all ("\", "/")
				Result := l_dir.substring (1, l_dir2.count).is_equal (l_dir2)
				include_dirs.forth
			end
		end
		
	file_in_dir (a_path: STRING; include_dirs: ARRAYED_LIST [STRING]): BOOLEAN is
			-- Is a_path equal to ora sub path of any of include_dirs?
		local
			path_count: INTEGER
		do
			from
				path_count := a_path.count
				include_dirs.start
			until
				include_dirs.after or Result
			loop		
				Result := (path_count >= include_dirs.item.count) and then include_dirs.item.substring (1, path_count).is_equal (a_path)
				include_dirs.forth
			end
		end

feature {NONE} -- Sorting

	filter_empty_nodes: BOOLEAN
			-- Filter empty nodes?
	
	filter_skipped_sub_nodes: BOOLEAN
			-- Filter sub-nodes of unwanted nodes?  This means if a node is filtered
			-- out of the structure then SUB DIRECTORIES may be included by moving them
			-- into the parent, if any.  It does not mean files will be included.
	
	filter_nodes_no_index: BOOLEAN
			-- Should nodes without a index file be filtered?
	
	order_alphabetically: BOOLEAN
			-- Order contents alphabetically?
	
	make_root_from_index: BOOLEAN
			-- Create root nodes automatically from index nodes?		

	move_node (a_node, a_target: TABLE_OF_CONTENTS_NODE) is
			-- Move `a_node' to `a_target'
		require
			node_not_void: a_node /= Void
			target_not_void: a_target /= Void
		do	
			a_node.parent.delete_node (a_node.id)
			a_target.add_node (a_node)
			a_node.set_parent (a_target)
		end		

	move_nodes_list: HASH_TABLE [STRING, TABLE_OF_CONTENTS_NODE]
			-- Nodes which need moving to new toc location

	new_indexes: ARRAYED_LIST [INTEGER] is
			-- Id of nodes which have been made into index nodes in current sorting
			-- process.  Used to prevent bubble effect of index creation
		once
			create Result.make (2)
		end		
	
	filter_nodes is
			-- Filter all nodes
		local
			l_node: TABLE_OF_CONTENTS_NODE
			l_nodes,
			l_remove_nodes: like nodes
		do
			l_nodes := nodes (True)
			create l_remove_nodes.make (1)
			from
				l_nodes.start
			until
				l_nodes.after
			loop
				l_node := l_nodes.item
				if filter_node (l_node) then
					l_node.parent.delete_node (l_node.id)
				end
				l_nodes.forth
			end
		end		
	
	filter_node (a_node: TABLE_OF_CONTENTS_NODE): BOOLEAN is
			-- Filter node based on output type.  Once filtered we can confidently call `sort_node'
			-- to produce the expected sorting result.
		local
			l_doc: DOCUMENT
			l_filtered_doc: FILTERED_DOCUMENT
			l_new_location, 
			l_url,
			l_title: STRING	
		do
			if a_node /= Void then						
				if a_node.url_is_file then
					
						-- First determine if node needs filterng out
					l_url := a_node.url					
					create l_doc.make_from_file (create {PLAIN_TEXT_FILE}.make (l_url))
					
					if is_code_document (l_doc) then
						Result := not is_required_library_document (l_url)
					else
						Result := not l_doc.can_display
					end
					
					if not Result then
							-- The node should not be filtered out so retrieve filter specific information from it
						if is_code_document (l_doc) then
							a_node.set_title (a_node.title)
						else
							if l_doc.is_valid_xml (l_doc.text) then
								l_filtered_doc := Manager.Shared_project.filter_manager.filtered_document (l_doc)								
								l_title := l_filtered_doc.title
								a_node.set_title (l_title)
							else
								a_node.set_title (l_doc.title)
							end
							
									-- Add node to move list if it needs moving.
							if l_doc.is_valid_to_schema then						
								l_new_location := l_filtered_doc.toc_location
								if l_new_location /= Void and then not l_new_location.is_empty then
									move_nodes_list.extend (l_new_location, a_node)
									a_node.parent.delete_node (a_node.id)
								end
							end	
						end			
					end
				end				
			end					
		end		
	
	sort_node (a_node: TABLE_OF_CONTENTS_NODE) is
			-- Sort `a_node'
		local
			l_remove: BOOLEAN
			l_children_clone,
			l_children_children_clone: ARRAYED_LIST [TABLE_OF_CONTENTS_NODE]
			l_child: TABLE_OF_CONTENTS_NODE
		do
			if a_node /= Void and then not Sort_excluded.has (a_node.id) then 											
				if a_node.has_child then
					create l_children_clone.make (1)
					from
						a_node.children.start
					until
						a_node.children.after
					loop
						l_child := a_node.children.item
						l_remove := False
						if not Sort_excluded.has (l_child.id) then
						
							if filter_nodes_no_index and l_child.url_is_directory and not l_child.has_index then
									-- Node is a folder and has no index
								l_remove := True
							end
	
							if filter_empty_nodes and l_child.url_is_directory and not l_child.has_child then
									-- Node is a folder and has no files
								l_remove := True
							elseif not filter_empty_nodes and l_child.url_is_directory and not l_child.has_child then
								l_remove := False
							end
							
							if l_remove then
								if not filter_skipped_sub_nodes and l_child.has_child then
									l_children_children_clone := l_child.parent_children
									a_node.children.append (l_children_children_clone)
								end
							end
						
								-- Check if is index and make as root node if sort options require.  Child node also removed.
							if make_root_from_index and then l_child.is_index and not (a_node = Current) then
								make_index (a_node, l_child)
								l_remove := True
							end

								-- Sort sub nodes
							if not l_remove and l_child.has_child then
								sort_node (l_child)
							end
						end
						
						if not l_remove then
								-- This child node has passed the filter	
							l_children_clone.extend (l_child)
						end
						
						a_node.children.forth						
					end
						-- Replace the old children with the new sorted ones
					a_node.set_children (l_children_clone)
				else
					if filter_empty_nodes and a_node.url_is_directory then
						a_node.parent.delete_node (a_node.id)
					end
				end	
			end
		end
		
	move_nodes is
			-- Move nodes in `move_nodes_list' to appropriate location.
			-- Note: This index sorting assumes that any index node which requires moving
			-- will be moved to unique location in respect to other index nodes which need
			-- moving.  If 2 nodes attempt to move to the same location, only one will be
			-- in the resulting TOC, and which one is not guaranteed.
		local
			l_location,
			l_url: STRING
			l_data_location: DATA_STRING
			l_src_el: TABLE_OF_CONTENTS_NODE
			l_index_locations: SORTED_TWO_WAY_LIST [DATA_STRING]
			a_node_nodes_hash_table: HASH_TABLE [TABLE_OF_CONTENTS_NODE, STRING]
		do		
					-- Sort indexes.  We sort indexes so an index is not moved before a
					-- a parent index is.  			
			from
				create l_index_locations.make
				create a_node_nodes_hash_table.make (move_nodes_list.count)
				a_node_nodes_hash_table.compare_objects
				move_nodes_list.start
			until
				move_nodes_list.after
			loop
				l_location := move_nodes_list.item_for_iteration
				l_src_el := move_nodes_list.key_for_iteration				
				if l_src_el.is_index then
					l_url := l_src_el.url					
					create l_data_location.make_from_string (l_location)					
					l_data_location.set_data (l_url)
					l_index_locations.extend (l_data_location)
					a_node_nodes_hash_table.extend (l_src_el, l_url)
				end
				move_nodes_list.forth
			end
			l_index_locations.sort
			
					-- Move indexes.  We move them before other nodes so another node is not
					-- moved before parent node (index) exists.
			from
				l_index_locations.start
				
			until
				l_index_locations.after
			loop
				l_data_location := l_index_locations.item
				l_url ?= l_data_location.data
				l_src_el := a_node_nodes_hash_table.item (l_url)	
				move_node_to_location (l_data_location, l_src_el)
				l_index_locations.forth
			end
			
					-- Move other files
			from
				move_nodes_list.start
			until
				move_nodes_list.after
			loop
				l_src_el := move_nodes_list.key_for_iteration
				if not l_src_el.is_index then
					l_location := move_nodes_list.item_for_iteration
					move_node_to_location (l_location, l_src_el)
				end			
				move_nodes_list.forth
			end
		end		
		
	move_node_to_location (new_location: STRING; src_node: TABLE_OF_CONTENTS_NODE) is
			-- Move node `src_node' to toc defined `new_location'
		local
			l_location: STRING
			l_name_array: ARRAY [STRING]
			l_target_node: TABLE_OF_CONTENTS_NODE
		do	
			l_location := new_location
			if not (l_location.item (l_location.count).is_equal ('\') or l_location.item (l_location.count).is_equal ('/')) then
				l_location.append_character ('/')
			end
			l_name_array := directory_array (l_location)
			if l_name_array /= Void then
						-- Find the target node
				l_target_node ?= Current
				if l_target_node /= Void then
					l_target_node ?= l_target_node.node_by_title_location (l_name_array)
				end
			end
						
					-- Move the node.  If there is no target, do not move it.
			if l_target_node /= Void then
				move_node (src_node, l_target_node)
			end			
		end		
		
	pseudo_overrides: BOOLEAN is True
			-- If pseudo name is present in document does it override filename/directory name
			-- for alphabetical ordering?
		
	sort_node_alphabetically (a_node: TABLE_OF_CONTENTS_NODE) is
			-- Sort `a_node' sub nodes alphabetically
		require
			has_children: not a_node.children.is_empty
		local			
			l_name: STRING			
			l_node: TABLE_OF_CONTENTS_NODE
			l_children,
			l_sorted_node_list: ARRAYED_LIST [TABLE_OF_CONTENTS_NODE]			
			l_sorted_list: SORTED_TWO_WAY_LIST [STRING]
			l_temp_hash: HASH_TABLE [TABLE_OF_CONTENTS_NODE, STRING]
			l_doc: DOCUMENT
			l_filtered_doc: FILTERED_DOCUMENT
			l_cnt: INTEGER
			l_file: PLAIN_TEXT_FILE
		do
			if a_node /= Void and then a_node.has_child and then not Sort_excluded.has (a_node.id) then								
						-- Extract name information from sub-nodes
				from					 	
					l_children := a_node.children
					create l_sorted_list.make
					create l_sorted_node_list.make (l_children.count)
					create l_temp_hash.make (l_children.count)
					l_temp_hash.compare_objects
					l_children.start
					l_cnt := 1
				until 
					l_children.after
				loop
					l_node ?= l_children.item
					
					if l_node.url /= Void then
						if Pseudo_overrides then
									-- Try for pseudo name
							create l_file.make (l_node.url)
							if l_file.exists and then not l_file.is_directory then
								create l_doc.make_from_file (l_file)
								if l_doc /= Void then
									if l_doc.is_valid_xml (l_doc.text) then
										l_filtered_doc := Manager.Shared_project.filter_manager.filtered_document (l_doc)
										l_name := l_filtered_doc.pseudo_name
									end																															
								end	
							end							
						end					
					end	
					
					if l_name = Void then						
						if l_node.is_index then	
								-- Is index file, so use directory name instead since index may have
								-- been made a parent node
							l_name := short_name (directory_no_file_name (l_node.url))
						else
								-- No pseudo name specified, use filename
							l_name := l_node.title
						end				
					end
					
					check
						name_not_void: l_name /= Void
					end
					
					if not l_temp_hash.has (l_name) then		
						check
							node_not_void: l_node /= Void
						end
						l_sorted_list.extend (l_name + l_cnt.out)
						l_temp_hash.extend (l_node, l_name + l_cnt.out)	
					end
					l_children.forth
					
							-- Process sub node if there are any
					if l_node.has_child then
						sort_node_alphabetically (l_node)
					end	
					l_cnt := l_cnt + 1
				end
										-- Sort the extracted names in the list alphabetically
				l_sorted_list.sort
				
						-- With the sorted name list sort the nodes via the temp hash
				from
					l_sorted_list.start
				until
					l_sorted_list.after
				loop
					l_node ?= l_temp_hash.item (l_sorted_list.item)
					check
						not_not_void: l_node /= Void
					end
					l_sorted_node_list.extend (l_node)
					l_sorted_list.forth
				end
				
						-- Now remove the nodes from the parent and add them back in sorted form
				from
					l_sorted_node_list.start
				until
					l_sorted_node_list.after
				loop
					a_node.children.wipe_out
					a_node.children.append (l_sorted_node_list)
					l_sorted_node_list.forth
				end
			end
		end		

	make_index (a_node, a_index: TABLE_OF_CONTENTS_NODE) is
			-- Make `a_node' index node from `a_index'
		require
			node_has_index: a_node.has_index
			index_is_index: a_index.is_index
		do
			if not new_indexes.has (a_node.id) then
				a_node.set_title (a_index.title)
				a_node.set_url (a_index.url)		
				new_indexes.extend (a_index.id)
			end
		end

	manager: TABLE_OF_CONTENTS_MANAGER is
			-- Manager
		once
			Result := (create {SHARED_OBJECTS}).Shared_toc_manager	
		end		

	is_required_library_document (a_url: STRING): BOOLEAN is
			-- Is url a required library file according to current filter?
		local
			l_filter: DOCUMENT_FILTER
			l_string: FILE_NAME
			l_library_names: ARRAYED_LIST [STRING]
			l_lib_name: STRING
		do
			if l_filter /= Void then
				l_filter := filter
			else
				l_filter := manager.shared_project.filter_manager.filter
			end			
			
			if l_filter.description.has_substring ("EiffelEnvision") then
				l_library_names := manager.shared_constants.application_constants.envision_libraries
			elseif l_filter.description.has_substring ("EiffelStudio") then
				l_library_names := manager.shared_constants.application_constants.studio_libraries
			end
			
			if l_library_names /= Void then
				from
					l_library_names.start
				until
					l_library_names.after or Result
				loop
					create l_string.make_from_string (manager.shared_project.root_directory)
					l_string.extend ("libraries")
					l_string.extend (l_library_names.item)
					l_lib_name := l_string.string
					l_lib_name.replace_substring_all ("\", "/")
					Result := a_url.has_substring (l_lib_name)
					l_library_names.forth
				end
			end
		end
			
	remove_duplicate_nodes (a_node: TABLE_OF_CONTENTS_NODE) is
			-- Remove nodes occuring with the same id
		local
			l_ids,
			l_removable: ARRAYED_LIST [INTEGER]
			l_item: TABLE_OF_CONTENTS_NODE
		do
			if a_node.has_child then
				create l_ids.make (a_node.children.count)
				from
					a_node.children.start
				until
					a_node.children.after
				loop					
					l_item := a_node.children.item
					if l_item /=  Void then
						if l_item.has_child then
							remove_duplicate_nodes (l_item)
						end
					
						if l_ids.has (l_item.id) then
							if l_removable = Void then
								create l_removable.make (1)							
							end
							l_removable.extend (l_item.id)
						else
							l_ids.extend (l_item.id)
						end		
					end
					a_node.children.forth
				end
				
				if l_removable /= Void then
					from
						l_removable.start
					until
						l_removable.after
					loop
						a_node.delete_node (l_removable.item)
						l_removable.forth
					end
				end
				
			end
		end	

invariant
	has_name: name /= Void and then not	name.is_empty
	has_filter: filter /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TABLE_OF_CONTENTS
