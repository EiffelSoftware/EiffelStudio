indexing
	description: "A Table of Contents widget with sorting and filtering capability."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_TOC

inherit
	EV_TREE
	
	GENERATOR
		undefine
			default_create,
			is_equal,
			copy
		end
	
	SHARED_OBJECTS
		undefine
			default_create,
			is_equal,
			copy
		end
	
	UTILITY_FUNCTIONS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	default_create,
	make	

feature -- Creation

	make (root_directory: STRING) is
			-- Make with `root_directory' as top node.
		require
			has_root: root_directory /= Void
		local
			l_question_dialog: EV_MESSAGE_DIALOG
			l_constants: EV_DIALOG_CONSTANTS
			
			ltoc: XML_TABLE_OF_CONTENTS
			ltocfile: PLAIN_TEXT_FILE
		do
			default_create
			
			create index_nodes.make (10)
			create toc_move_nodes.make (10)
			create parent_nodes.make (5)
			create root.make (root_directory)
			generate
			if is_empty then
				create l_constants
				create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).empty_toc)
				l_question_dialog.set_title ((create {MESSAGE_CONSTANTS}).empty_toc_title)
				l_question_dialog.set_buttons (<<l_constants.ev_ok >>)
				l_question_dialog.show_modal_to_window (Application_window)
				if l_question_dialog.selected_button.is_equal (l_constants.ev_ok) then
					l_question_dialog.destroy
				end
			end
			
			create ltoc.make_from_tree (Current)
			ltocfile := ltoc.contents_file
		end
		
feature -- Commands

	update_node (a_doc: DOCUMENT) is
			-- Update node which is associated with `a_doc', if any
		local
			l_node: EV_TREE_ITEM
		do
			from
				start
			until
				after or l_node /= Void
			loop
				l_node := find_node_by_document (a_doc, item)
				forth
			end			
			if l_node /= Void then
				l_node.set_data (a_doc.toc_data)
				l_node.set_text (a_doc.toc_data.title)
				  	-- TO DO:  Here need to check if node needs to move, and move it accordingly.
				  	-- Also need to check if output type has changed and show or delete accordingly.
				  	
			end
		end		

	build_parent_node (a_dir: DIRECTORY): EV_TREE_ITEM is
			-- Build parent TOC node representing physical `a_dir'
		do
			create Result.make_with_text (short_name (a_dir.name))
			Result.set_pixmap (Shared_constants.Graphical_constants.Folder_closed_icon)
			Result.set_data (location_excluding_root_dir (a_dir.name))
			parent_nodes.extend (Result)
		end
	
	build_toc is
			-- Build TOC
		local
			top_node, l_node: EV_TREE_ITEM
			cnt: INTEGER
			l_dir: DIRECTORY
			root_name: STRING
			l_constants: APPLICATION_CONSTANTS
		do
			toc_move_nodes.wipe_out
			index_nodes.wipe_out
			parent_nodes.wipe_out
			l_constants := Shared_constants.Application_constants
			from
				root_name := root.name + "\"
				root.open_read
				root.start
			until
				cnt = root.count
			loop
				root.readentry
			 	create l_dir.make (root_name + root.lastentry)
			 	if l_dir.exists then
			 		l_node := build_parent_node (l_dir)
			 		extend (l_node)
			 		build_toc_flat (l_dir, l_node)
			 	end				
				cnt := cnt + 1
			end
			move_nodes
			if not l_constants.include_directories_no_index then
				remove_indexless_parents
			elseif l_constants.include_empty_directories then
					-- Only called if `remove_indexless_parents' is not called since an empty parent
					-- node is by definition indexless and will get removed anyway
				remove_empty_parents
			end
			if l_constants.make_root_from_index then
				sort_toc_indexes
			end
		end		
		
	build_toc_flat (root_dir: DIRECTORY; a_parent: EV_TREE_ITEM) is
			-- Starting from `root_dir' build a TOC that contains nodes for
			-- files recursively in `root_dir'. Resulting TOC is identical in structure to
			-- `root_dir' and does not apply any filtering or sorting.
		require
			dir_not_void: root_dir /= Void
			parent_not_void: a_parent /= Void
		local
			parent_node, file_node: EV_TREE_ITEM
			dir: DIRECTORY
			cnt: INTEGER
			file: RAW_FILE
			a_doc: DOCUMENT
			index_processed: BOOLEAN
			curr_item: STRING
		do
			from
				cnt := 0
				root_dir.open_read
				root_dir.start
			until
				cnt = root_dir.count
			loop
				root_dir.readentry
				curr_item := root_dir.lastentry			
				if curr_item /= Void then
					if Shared_project.allowed_file_types.has (file_type (short_name (curr_item))) then
						create a_doc.make_from_file (create {PLAIN_TEXT_FILE}.make (root_dir.name + "\" + curr_item), Void)
						if a_doc.file.exists then
							file_node := process_document (a_parent, a_doc)
							if file_node /= Void then
								a_parent.extend (file_node)
							end
						end
					else
						create dir.make (root_dir.name + "\" + curr_item)
						if dir.exists then
							parent_node := build_parent_node (dir)
							a_parent.extend (parent_node)
							build_toc_flat (dir, parent_node)
						end
					end
				end
				cnt := cnt + 1
				update_progress_report
			end
		end
	
	remove_empty_parents is
			-- Remove all empty parent nodes
		do
			from
				parent_nodes.start
			until
				parent_nodes.after
			loop
				if parent_nodes.item.is_empty then
					parent_nodes.item.parent.prune (parent_nodes.item)
				end
				parent_nodes.forth
			end
		end
	
	remove_indexless_parents is
			-- Remove all parent nodes not containing index file
		do
			parent_nodes.do_all (agent remove_indexless_node)
		end
		
	sort_toc_indexes is
			-- Sort the indexes in Current to represent parent nodes
		local
			l_toc_data: DOCUMENT_TOC_DATA
			l_parent: EV_TREE_ITEM
		do
			from
				index_nodes.start
			until
				index_nodes.after
			loop
				l_parent ?= index_nodes.item.parent
				if l_parent /= Void then
					l_toc_data ?= index_nodes.item.data
					if l_toc_data /= Void then
						l_parent.set_data (l_toc_data)
						l_parent.pointer_double_press_actions.force_extend 
							(agent Shared_document_editor.load_document_from_file (l_toc_data.filename))
						l_parent.set_text (l_toc_data.title)
					end			
					l_parent.prune (index_nodes.item)
					if l_parent.is_empty then
						l_parent.set_pixmap (Shared_constants.Graphical_constants.File_icon)
					end
				end
				index_nodes.forth
				update_progress_report
			end
		end
		
	move_nodes is
			-- Move the nodes in Current which specify a different location to
			-- the physical disk location.
		local
			l_toc_data: DOCUMENT_TOC_DATA
			l_child, l_new_parent: EV_TREE_ITEM
		do
			from
				toc_move_nodes.start
			until
				toc_move_nodes.after
			loop
				l_child := toc_move_nodes.item
				l_toc_data ?= l_child.data
				if l_toc_data /= Void then
					l_new_parent := find_node (l_toc_data.toc_location)
					if l_new_parent /= Void then
						l_child.parent.prune (l_child)
						l_new_parent.extend (l_child)
					end
				end
				toc_move_nodes.forth
			end
		end		
	
	find_node (a_location: STRING): EV_TREE_ITEM is
			-- Find the node that `a_location' refers to.  Return the found
			-- node or void if none exists.  
			-- Note: Since a toc location will always refer to a parent node
			-- only the `parent_nodes' are iterated.
		require
			location_not_void: a_location /= Void
			location_not_empty: not a_location.is_empty
		local
			found: BOOLEAN
			l_parent: EV_TREE_ITEM
			l_node_location: like a_location
		do
			from
				parent_nodes.start
			until
				parent_nodes.after or found
			loop
				l_parent := parent_nodes.item
				if l_parent /= Void then
					l_node_location ?= l_parent.data
					if l_node_location /= Void then
						if l_node_location.is_equal (a_location) then
							found := True
							Result := l_parent
						end
					end
				end
				parent_nodes.forth
			end
		end

feature -- Access

	root: DIRECTORY
			-- Root directory (top node)

	process_document (a_parent: EV_TREE_ITEM; a_doc: DOCUMENT): EV_TREE_ITEM is
			-- Process `a_doc' with `parent' item.  Return the item node.
		require
			doc_not_void: a_doc /= Void
			parent_not_void: a_parent /= Void
		local
			l_doc_toc: DOCUMENT_TOC_DATA
			
			temp_s: STRING
		do			
			if a_doc.can_display then
				l_doc_toc := a_doc.toc_data
				if l_doc_toc /= Void then
					create Result.make_with_text (l_doc_toc.title)
					Result.set_data (l_doc_toc)
					Result.pointer_double_press_actions.force_extend (agent Shared_document_editor.load_document_from_file (a_doc.file.name))
					if not l_doc_toc.is_toc_location_same_as_physical then
						toc_move_nodes.extend (Result)
					end
					if l_doc_toc.is_parent_node then
						index_nodes.extend (Result)
					end
					Result.set_pixmap (Shared_constants.Graphical_constants.File_icon)
				end
			end
		end

feature {NONE} -- Implementation

	parent_nodes: ARRAYED_LIST [EV_TREE_ITEM]
			-- All parent nodes in TOC
		
	index_nodes: ARRAYED_LIST [EV_TREE_ITEM]
			-- Nodes in Current which have children
			
	toc_move_nodes: ARRAYED_LIST [EV_TREE_ITEM]
			-- Hash of node along with keys
	
	remove_empty_node (a_node: EV_TREE_NODE) is
			-- Remove node if empty and not a file node
		local
			l_toc_data: DOCUMENT_TOC_DATA
		do
			if a_node.is_empty then
				l_toc_data ?= a_node.data
				if l_toc_data /= Void and then l_toc_data.is_parent_node then
					a_node.parent.prune (a_node)	
				end				
			end
		end
		
	remove_indexless_node (a_node: EV_TREE_ITEM) is
			-- Remove node if it has no index file
		local
			l_toc_data: DOCUMENT_TOC_DATA
			found: BOOLEAN
			l_item, l_new_parent: EV_TREE_ITEM
		do
			from
				index_nodes.start
			until
				index_nodes.after or found
			loop
				if a_node.has (index_nodes.item) then
					found := True
				end 
				index_nodes.forth
			end
			if not found then
				if Shared_constants.Application_constants.include_skipped_sub_directories then
					l_new_parent ?= a_node.parent
					from
						a_node.start
					until
						a_node.after
					loop		
						l_item ?= a_node.item
						if l_new_parent /= Void and then l_item /= Void and then node_is_directory (l_item) then
							move_node (l_item, l_new_parent)
						end						
						a_node.forth
					end
				end
				a_node.parent.prune (a_node)
			end
		end
			
	move_node (a_node, a_parent: EV_TREE_ITEM) is
			-- Move `a_node' from it's parent into `a_parent'
		do
			a_node.parent.prune (a_node)
			a_parent.extend (a_node)			
		end		

	node_is_directory (a_item: EV_TREE_ITEM): BOOLEAN is
			-- Is `a_item a directory'
		local
			l_dir: DIRECTORY
			l_doc_toc_data: DOCUMENT_TOC_DATA
		do
			l_doc_toc_data ?= a_item.data
			if l_doc_toc_data = Void then
				Result := True
			end			
		end

	find_node_by_document (a_doc: DOCUMENT; a_parent: EV_TREE_NODE): EV_TREE_ITEM is
			-- Find node associated with `a_doc' in `a_parent'
		local
			l_doc_toc: DOCUMENT_TOC_DATA
		do
					-- Check the actual parent first
			l_doc_toc ?= a_parent.data
			if l_doc_toc /= Void then
				if l_doc_toc.filename.is_equal (a_doc.name) then
					Result ?= a_parent
				end
			end
			
			if Result /= Void then
					-- Check children	
				from
					a_parent.start
				until
					a_parent.after or Result /= Void
				loop
					if not a_parent.item.is_empty then
						Result := find_node_by_document (a_doc, a_parent.item)
					end
					l_doc_toc ?= a_parent.item.data
					if l_doc_toc /= Void then
						if l_doc_toc.filename.is_equal (a_doc.name) then
							Result ?= a_parent.item
						end				
					end
					a_parent.forth
				end
			end		
		end		
		
	location_excluding_root_dir (a_location: STRING): STRING is
			-- The location of `a_location' without the root directory prefix
		do
			Result := a_location.substring (root.name.count + 2, a_location.count)	
		end		

feature {NONE} -- Generation

	progress_title: STRING is "Generating Table of Contents"
			-- Title of pregress report dialog

	upper_range_value: INTEGER is
			-- Upper Range for Generation time calculation
		once
			Result := Shared_project.file_count
		end

	internal_generate is
			-- Generate
		do
			build_toc	
		end		

invariant
	has_root_directory: root /= Void

end -- class DOCUMENT_TOC
