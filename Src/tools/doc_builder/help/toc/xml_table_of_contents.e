indexing
	description: "Table of contents in XML representation.  Can be filtered and sorted."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_TABLE_OF_CONTENTS

inherit
	XM_DOCUMENT
		rename
			sort as xml_sort
		end
	
	XML_ROUTINES
		undefine
			copy,
			is_equal
		end
	
	TABLE_OF_CONTENTS_CONSTANTS
		undefine
			copy,
			is_equal
		end
		
	UTILITY_FUNCTIONS
		undefine
			copy,
			is_equal
		end
		
create
	make,
	make_empty,
	make_from_directory,
	make_from_tree

feature -- Creation
			
	make_empty is
			-- Make empty TOC
		do
			make
			initialize
		end		
			
	make_from_directory (a_directory: DIRECTORY) is
			-- Make with `a_directory' as top node.  Resulting structure is
			-- just XML representation of `a_directory'.
		require
			has_root: a_directory /= Void
		do
			make
			initialize
			build_from_directory (a_directory, root_element)
		end	
		
	make_from_tree (a_tree: EV_TREE) is
			-- Initialize based on structure of `a_toc'
		do
			make
			initialize
			build_from_tree (a_tree, root_element)
		end

feature -- Initialization

	initialize is
			-- Initialize
		do
			unique_id := 1
			set_root_element (create {XML_TABLE_OF_CONTENTS_NODE}.make_root (Root_string, Void))
			set_filter_function (agent internal_filter_function)
			filename := Shared_toc_manager.next_toc_name
			create internal_nodes.make (10)			
		end

feature -- Access
	
	nodes: like internal_nodes is
			-- Nodes
		do
			Result := internal_nodes
		end		
	
	files: ARRAYED_LIST [FILE_NAME] is
			-- Files represented by nodes
		local
			l_nodes: ARRAYED_LIST [XML_TABLE_OF_CONTENTS_NODE]
			l_help_topic: XML_TABLE_OF_CONTENTS_NODE
			l_url: STRING			
		do
			from
				l_nodes := nodes.linear_representation				
				create Result.make (l_nodes.count)
				l_nodes.start
			until
				l_nodes.after
			loop				
				l_help_topic := l_nodes.item
				l_url := l_help_topic.attribute_by_name (Url_string).value
				if l_url /= Void then
					Result.extend (create {FILE_NAME}.make_from_string (l_url))
				end
				l_nodes.forth
			end
		end		
	
	filename: STRING
			-- File from which Current was constructed	
		
	old_name: STRING
			-- Old name of toc
		
	contents_file: PLAIN_TEXT_FILE is
			-- File
		local
			l_filename: FILE_NAME
		do
			create l_filename.make_from_string ("C:\toc.xml")
			save_xml_document (Current, l_filename)
			create Result.make (l_filename.string)
		end
	
	node_by_id (a_id: INTEGER): XML_TABLE_OF_CONTENTS_NODE is
			-- Retrieve node with id `a_id', Void if no match found
		require
			valid_id: a_id > 0
		do
			Result ?= internal_nodes.item (a_id)
		end

feature -- Status Setting	
	
	set_file_name (a_name: STRING) is
			-- Set filename to `a_name'
		do
			filename := a_name
		end	
	
	set_persisted (a_flag: BOOLEAN) is
			-- Set if persisted to disk
		do
			is_persisted := a_flag	
		end		
	
	set_root (e: XM_ELEMENT) is
			-- Set root element as `e'
		do
			delete (root_element)
			set_root_element (e)
		end	

	set_filter_function (a_function: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]) is
			-- Set `filter_function'
		do
			filter_function := a_function
		end

	set_filter_empty_elements (a_flag: BOOLEAN) is
			-- Set `filter_empty_elements'
		do
			filter_empty_elements := a_flag
		end
	
	set_filter_skipped_sub_elements (a_flag: BOOLEAN) is
			-- Set `filter_skipped_sub_elements'
		do
			filter_skipped_sub_elements := a_flag
		end
		
	set_filter_elements_no_index (a_flag: BOOLEAN) is
			-- Set `filter_elements_no_index'
		do
			filter_elements_no_index := a_flag
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

feature -- Query

	is_persisted: BOOLEAN
			-- Is Current saved to disk?

feature -- Element Change

	add_node (a_node: XML_TABLE_OF_CONTENTS_NODE) is
			-- Add `a_node'
		require
			node_not_void: a_node /= Void
		do
			internal_nodes.extend (a_node, a_node.attribute_by_name (Id_string).value.to_integer)	
		end

	remove_node (a_node: XML_TABLE_OF_CONTENTS_NODE) is
			-- Remove `a_node'
		do			
			a_node.parent.set_equality_tester (create {KL_EQUALITY_TESTER [XM_NODE]})
			a_node.parent.delete (a_node)
			if internal_nodes.has (a_node.id) then								
				internal_nodes.remove (a_node.id)
			end
		end

	move_element (src, target: XML_TABLE_OF_CONTENTS_NODE) is 
			-- Move `src' element (and all of it's children) to `target'.  Element
			-- put at the end of `target'.
		require
			source_not_void: src /= Void
			target_not_void: target /= Void
		do
			target.put_last (src)
		ensure
			moved: target.has (src)
		end

feature -- Commands	

	sort is
			-- Sort
		do			
			reset
			if not Shared_project.filter_manager.filter.description.is_equal ("Web") then
				filter_element (root_element)	
			end			
			sort_element (root_element)
			move_nodes
			if order_alphabetically then
				sort_element_alphabetically (root_element)
			end
		end		

	reset is
			-- Reset
		do
			is_persisted := False
			create Move_nodes_list.make (2)
			Move_nodes_list.compare_objects
			New_indexes.wipe_out
		end		

feature -- Storage

	save is
			-- Save Current to disk		
		do
			if not is_persisted then
				save_dialog
			else
				save_xml_document (Current, create {FILE_NAME}.make_from_string (filename))				
			end
		end		

feature {NONE} -- Initialization

	build_from_directory (root_dir: DIRECTORY; a_parent: XM_ELEMENT) is
			-- Starting from `root_dir' build a TOC that contains nodes for
			-- files recursively in `root_dir'. Resulting TOC is identical in structure to
			-- `root_dir' and does not apply any filtering or sorting.
		require
			dir_not_void: root_dir /= Void
			parent_not_void: a_parent /= Void
		local
			l_node: XML_TABLE_OF_CONTENTS_NODE
			l_dir: DIRECTORY
			cnt, l_id: INTEGER
			l_item, l_extension: STRING
			l_url: FILE_NAME
			l_make_node: BOOLEAN
		do			
			from
				cnt := 0
				root_dir.open_read
				root_dir.start
			until
				cnt = root_dir.count
			loop
				root_dir.readentry
				l_item := root_dir.lastentry						
				if l_item /= Void and then not l_item.is_equal (".") and then not l_item.is_equal ("..") then 
							-- Make url from name of directory entry
					create l_url.make_from_string (root_dir.name)					
					l_url.extend (l_item)
					create l_dir.make (l_url)
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
						create l_node.make (l_id, a_parent, l_url.string, l_item, (l_dir.exists))
						a_parent.put_last (l_node)
						add_node (l_node)
						
								-- Check if new current item is a folder and if so process children
						if l_dir.exists then				
							build_from_directory (l_dir, l_node)
						end			
					end				
				end
				cnt := cnt + 1
			end
		end

	build_from_tree (a_tree: EV_TREE_NODE_LIST; a_parent: XM_ELEMENT) is
				-- Initialize based on structure of `a_tree'
			local
				l_item: EV_TREE_ITEM
				l_xml_node: XML_TABLE_OF_CONTENTS_NODE				
				l_node: TABLE_OF_CONTENTS_WIDGET_NODE
				l_url, l_title: STRING
				l_is_parent: BOOLEAN
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
						l_node ?= l_item
						if l_node /= Void then
							l_url := l_node.file_url
							l_title := l_node.title
							l_is_parent := l_node.is_heading
						else
							l_title := l_item.text
							l_is_parent := not l_item.is_empty
						end			
								
						check
							title_not_void: l_title /= Void
							valid_id: l_id > 0
						end
								
								-- Create new node and append to `a_parent'						
						create l_xml_node.make (l_id, a_parent, l_url, l_title, l_is_parent)
						a_parent.put_last (l_xml_node)
						add_node (l_xml_node)
						
								-- Check if new node was a folder and if so process children
						if not l_item.is_empty then
							build_from_tree (l_item, l_xml_node)
						end
					end				
				end				
				a_tree.forth
			end		

feature {NONE} -- Implementation

	unique_id: INTEGER
			-- Unique node id

	next_id: INTEGER is
			-- Next unique id
		do
			Result := unique_id + 1
			unique_id := unique_id + 1
		end
		
	internal_nodes: HASH_TABLE [XML_TABLE_OF_CONTENTS_NODE, INTEGER]
			-- Hash of nodes with their ids

	save_dialog is
			-- Save Dialog
		local
			l_save_dialog: EV_FILE_SAVE_DIALOG
		do
			create l_save_dialog
			l_save_dialog.show_modal_to_window (Application_window)
			if l_save_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_save) then
				old_name := filename
				set_file_name (l_save_dialog.file_name)
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

feature {NONE} -- Sorting

	filter_function: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]
			-- Returns data to determine filtering of nodes

	filter_empty_elements: BOOLEAN
			-- Filter empty elements?
	
	filter_skipped_sub_elements: BOOLEAN
			-- Filter sub-elements of unwanted elements?
	
	filter_elements_no_index: BOOLEAN
			-- Should elements with a index file be filtered?
	
	order_alphabetically: BOOLEAN
			-- Order contents alphabetically?
	
	make_root_from_index: BOOLEAN
			-- Create root elements automatically from index elements?		

	internal_filter_function (a_el: XM_ELEMENT): BOOLEAN is
			-- Default filter function.  Filters out all file nodes except those
			-- which have the ALL following properties:
			-- 		a) a url attribute referencing an existing file
			-- 		b) a file which is relevant to the chosen output filter type
		local
			l_doc: DOCUMENT
			l_url: STRING	
			l_file: PLAIN_TEXT_FILE
		do			
			if a_el.name.is_equal (File_string) then
				if a_el.has_attribute_by_name (Url_string) then
					l_url := a_el.attribute_by_name (Url_string).value
					l_doc := Shared_document_manager.document_by_name (l_url)
					if l_doc = Void and then l_url /= Void then
						create l_file.make (l_url)
						if l_file.exists then
							create l_doc.make_from_file (l_file)							
							Shared_document_manager.add_document (l_doc)
						end
					end
					Result := l_doc /= Void and then l_doc.can_display								
				end
			else
				Result := True
			end			
		end		

	move_nodes_list: HASH_TABLE [STRING, XML_TABLE_OF_CONTENTS_NODE]
			-- Nodes which need moving to new toc location

	new_indexes: ARRAYED_LIST [INTEGER] is
			-- Id of nodes which have been made into index nodes in current sorting
			-- process.  Used to prevent bubble effect of index creation
		once
			create Result.make (2)
		end		

feature {NONE} -- Element Change

	move_elements (src, target: XML_TABLE_OF_CONTENTS_NODE) is
			-- Move elements from `src' to `target'
		local
			l_el: XML_TABLE_OF_CONTENTS_NODE
			l_elements: DS_LIST [XM_ELEMENT]
		do
			from
				l_elements := src.elements
				l_elements.start
			until
				l_elements.after
			loop
				l_el ?= l_elements.item_for_iteration
				if not l_el.is_file then				
					move_element (l_el, target)
				end
				l_elements.forth
			end
		end
	
	filter_element (a_element: XM_ELEMENT) is
			-- Filter element based on output type.  Once filtered we can confidently call `sort_element'
			-- to produce the expected sorting result.
		local
			l_el: XML_TABLE_OF_CONTENTS_NODE
			l_remove: BOOLEAN
			l_elements: DS_LIST [XM_ELEMENT]
			l_doc: DOCUMENT
			l_filtered_doc: FILTERED_DOCUMENT
			l_new_location, 
			l_url,
			l_title: STRING
		do
			l_el ?= a_element
			if l_el /= Void then
						-- Only filter elements whose url refers to a physically existing document
				if l_el.url_exists then
							-- First off check if document referred to is applicable to the sort type
					l_remove := not filter_function.item ([l_el])
					
					if not l_remove then								
						l_url := l_el.url
						if l_url /= Void then
							l_doc := Shared_document_manager.document_by_name (l_url)
						end					
						
						if l_doc /= Void then
									-- As document can be shown in toc retrieve filter specific information from it	
							if l_doc.is_valid_xml then
								l_filtered_doc := Shared_project.filter_manager.filtered_document (l_doc)
								l_title := l_filtered_doc.title
								a_element.attribute_by_name (Title_string).set_value (l_title)
								l_el.set_title (l_title)
							else
								a_element.attribute_by_name (Title_string).set_value (l_doc.title)
								l_el.set_title (l_doc.title)
							end
							
									-- Move node if it needs moving.  Currently the node is added to a move list
									-- and then moved AFTER all filtering and sorting.
							if l_doc.is_valid_to_schema then						
								l_new_location := l_filtered_doc.toc_location
								if l_new_location /= Void and then not l_new_location.is_empty then
									move_nodes_list.extend (l_new_location, l_el)
								end
							end							
						end					
					end
					
					if l_remove then
						remove_node (l_el)
					end	
				end
				
						-- Filter sub-elements
				from
					l_elements := l_el.elements
					l_elements.start
				until
					l_elements.after
				loop
					filter_element (l_elements.item_for_iteration)
					l_elements.forth
				end
			end					
		end		
	
	sort_element (a_element: XM_ELEMENT) is
			-- Sort `a_element'
		local
			l_el, l_par_el: XML_TABLE_OF_CONTENTS_NODE
			l_remove: BOOLEAN
			l_elements: DS_LIST [XM_ELEMENT]
		do
			l_el ?= a_element
			if l_el /= Void then										
				
				if not l_remove then
					if filter_elements_no_index and then not l_el.is_file and then not l_el.has_index then
							-- Element is a folder and has no index
						l_remove := True
					end
					if not l_remove then
						if filter_empty_elements and then not l_el.is_file and then not l_el.has_child then
								-- Element is a folder and has no files
							l_remove := True
						end
					end
				end			
				
						-- Sort sub-elements
				from
					l_elements := l_el.elements
					l_elements.start
				until
					l_elements.after
				loop
					sort_element (l_elements.item_for_iteration)
					l_elements.forth
				end
							
						-- Before removing check for child folder elements and copy to 
						-- parent if sort options require so
				if l_remove and then not l_el.is_root_node then							
					if not filter_skipped_sub_elements then
						if not l_elements.is_empty then
							l_par_el ?= l_el.parent
							move_elements (l_el, l_par_el)
						end						
					end
				end
				
					-- Check if has index and make as root node if sort options require
				if not l_el.is_root_node and then make_root_from_index and then l_el.has_index then						
					make_index (l_el)
				end
				
					-- Now all sub-elements are filtered the element may be empty even though
					-- it was not before.  Check if is empty and prepare to remove if sort options
					-- require it.
				if filter_empty_elements and then not l_el.is_file and then not l_el.has_child then								
					l_remove := True
				end			

						-- Finally remove if required
				if not l_el.is_root_node and then l_remove then
					remove_node (l_el)
				end
			end
		end
		
	move_nodes is
			-- Move nodes in `move_nodes_list' to appropriate location.
			-- Note: This index sorting assumes that any index node which requires moving
			-- will be moved to unique location in respect to other index nodex which need
			-- moving.  If 2 nodes attempt to move to the same location, only one will be
			-- in the resulting TOC, and which one is not guaranteed.
		local
			l_location,
			l_url: STRING
			l_data_location: DATA_STRING
			l_src_el: XML_TABLE_OF_CONTENTS_NODE
			l_index_locations: SORTED_TWO_WAY_LIST [DATA_STRING]
			l_element_hash_table: HASH_TABLE [XML_TABLE_OF_CONTENTS_NODE, STRING]
		do		
					-- Sort indexes.  We sort indexes so an index is not moved before a
					-- a parent index is.  			
			from
				create l_index_locations.make
				create l_element_hash_table.make (move_nodes_list.count)
				l_element_hash_table.compare_objects
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
					l_element_hash_table.extend (l_src_el, l_url)
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
				l_src_el := l_element_hash_table.item (l_url)	
				move_node (l_data_location, l_src_el)
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
					move_node (l_location, l_src_el)
				end			
				move_nodes_list.forth
			end
		end		
		
	move_node (new_location: STRING; src_el: XML_TABLE_OF_CONTENTS_NODE) is
			-- Move node `src_el' to toc defined `new_location'
		local
			l_location: STRING
			l_name_array: ARRAY [STRING]
			l_target_el,
			l_src_el: XML_TABLE_OF_CONTENTS_NODE
		do	
			l_location := new_location
			if not (l_location.item (l_location.count).is_equal ('\') or l_location.item (l_location.count).is_equal ('/')) then
				l_location.append_character ('/')
			end
			l_name_array := directory_array (l_location)
			if l_name_array /= Void then
						-- Find the target node
				l_target_el ?= root_element
				if l_target_el /= Void then
					l_target_el ?= l_target_el.element_by_title_location (l_name_array)
				end
			end
						
					-- Move the element.  If there is no target, do not move it.
			if l_target_el /= Void then
				move_element (src_el, l_target_el)
				if l_target_el.is_index then
					l_target_el.set_name (Folder_string)
				end
				src_el.parent.delete (src_el)
			end			
		end		
		
	pseudo_overrides: BOOLEAN is True
			-- If pseudo name is present in document does it override filename/direcory name
			-- for alphabetical ordering?
		
	sort_element_alphabetically (a_element: XM_ELEMENT) is
			-- Sort `a_element' sub elements alphabetically
		require
			has_children: not a_element.is_empty
		local			
			l_name: STRING			
			l_element, l_parent_element: XML_TABLE_OF_CONTENTS_NODE
			l_elements: DS_LIST [XM_ELEMENT]			
			l_sorted_element_list: DS_ARRAYED_LIST [XM_ELEMENT]
			l_sorted_list: SORTED_TWO_WAY_LIST [STRING]
			l_temp_hash: HASH_TABLE [XM_ELEMENT, STRING]
			l_doc: DOCUMENT
			l_filtered_doc: FILTERED_DOCUMENT
			l_saved_attributes: DS_LINEAR [XM_ATTRIBUTE]
		do
			l_parent_element ?= a_element
			if l_parent_element /= Void then				
				
						-- Extract name information from sub-elements
				from					 	
					l_elements := l_parent_element.elements
					create l_sorted_list.make
					create l_sorted_element_list.make (l_elements.count)
					create l_temp_hash.make (l_elements.count)
					l_temp_hash.compare_objects
					l_elements.start
				until
					l_elements.after
				loop
					l_element ?= l_elements.item_for_iteration			
					
					if l_element.url /= Void then
						if Pseudo_overrides then
									-- Try for pseudo name
							l_doc := Shared_document_manager.document_by_name (l_element.url)
							if l_doc /= Void then
								l_filtered_doc := Shared_project.filter_manager.filtered_document (l_doc)
								l_name := l_filtered_doc.pseudo_name															
							end
						end
						if l_name = Void then
									-- No pseudo name specified, use filename
							l_name := short_name (l_filtered_doc.name)
						end
					end							
					
					if l_name /= Void then
						if l_name.is_equal (shared_constants.application_constants.index_file_name) then	
								-- Is index file, so use directory name
							l_name := short_name (directory_no_file_name (l_filtered_doc.name))
						end
					else
							-- No filename, use title
						l_name := l_element.title
					end
					
					l_sorted_list.extend (l_name)
					l_temp_hash.extend (l_element, l_name)
					l_elements.forth
					
							-- Process sub element if there are any
					if not l_element.elements.is_empty then
						sort_element_alphabetically (l_element)
					end	
				end
						-- Sort the extracted names in the list alphabetically
				l_sorted_list.sort
				
						-- With the sorted name list sort the elements via the temp hash
				from
					l_sorted_list.start
				until
					l_sorted_list.after
				loop
					l_element ?= l_temp_hash.item (l_sorted_list.item)
					l_sorted_element_list.put_last (l_element)
					l_sorted_list.forth
				end
				
						-- Now remove the elements from the parent and add them back in sorted form
				from
					l_sorted_element_list.start
				until
					l_sorted_element_list.after
				loop
					l_saved_attributes := l_parent_element.attributes
					l_parent_element.wipe_out
					l_parent_element.append (l_saved_attributes, 1)
					l_parent_element.extend (l_sorted_element_list, l_saved_attributes.count + 1)
					l_sorted_element_list.forth
				end
			end
		end		

	make_index (a_el: XML_TABLE_OF_CONTENTS_NODE) is
			-- Make `a_el' index node
		require
			element_has_index: a_el.has_index
		local
			l_el: XML_TABLE_OF_CONTENTS_NODE
			l_elements: DS_LIST [XM_ELEMENT]
			done: BOOLEAN
		do		
			from
				l_elements := a_el.elements
				l_elements.start
			until
				l_elements.after or done 
			loop
				l_el ?= l_elements.item_for_iteration
				if l_el.is_index and then not new_indexes.has (l_el.id) then
							-- Found index node in `a_el', so copy found node over `a_el'
					a_el.set_title (l_el.attribute_by_name (Title_string).value)
					a_el.set_url (l_el.attribute_by_name (Url_string).value)
							-- Remove the node and then check it if it now empty, and if so make a file node
							-- rather than a folder node
					remove_node (node_by_id (l_el.id))
					remove_node (l_el)
					if a_el.elements.is_empty then
						a_el.set_name (File_string)
					end					
					new_indexes.extend (a_el.id)					
					done := True
				end
				l_elements.forth
			end
		end

invariant
	has_name: filename /= Void and then not	filename.is_empty
		
end -- class XML_TABLE_OF_CONTENTS
