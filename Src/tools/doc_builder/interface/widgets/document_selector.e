indexing
	description: "Tree selector for browsing projects and documents."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SELECTOR

inherit
	UTILITY_FUNCTIONS

	SHARED_OBJECTS

create
	make
	
feature -- Creation

	make (root_directory: STRING; widget: EV_TREE) is
			-- Make with `root_directory'
		require
			has_root: root_directory /= Void
			has_widget: widget /= Void
		local
			top_node: EV_DYNAMIC_TREE_ITEM
		do
			default_create
			internal_tree := widget
			create root.make_open_read (root_directory)
			create top_node.make_with_function (agent get_children (root, top_node))
			top_node.set_pixmap (Shared_constants.Graphical_constants.Folder_closed_icon)
			top_node.set_text (short_name (root.name))
			internal_tree.extend (top_node)
		end		

feature -- Commands

	clear is
			-- Wipe out widget
		do
			internal_tree.wipe_out	
		end		

feature -- Access
	
	root: DIRECTORY
			-- Root directory

feature -- Query
	
	get_children (root_dir: DIRECTORY; root_node: EV_DYNAMIC_TREE_ITEM): ARRAYED_LIST [EV_TREE_NODE] is
			-- Return child directory and file nodes list
		require
			dir_not_void: root_dir /= Void
		local
			node: EV_DYNAMIC_TREE_ITEM
			file_node: EV_TREE_ITEM
			dir: DIRECTORY
			cnt: INTEGER
			file: RAW_FILE
			l_last_entry: STRING
		do
			create Result.make (5)
			from
				cnt := 0
				root_dir.open_read
				root_dir.start
			until
				cnt = root_dir.count
			loop
				root_dir.readentry
				l_last_entry := root_dir.lastentry
				if l_last_entry /= Void and then not l_last_entry.is_equal (".") and then not l_last_entry.is_equal ("..") then
					create file.make (root_dir.name + "\" + root_dir.lastentry)
					create dir.make (root_dir.name + "\" + root_dir.lastentry)
					if dir.exists then
						create node.make_with_function (agent get_children (dir, node))
						node.set_text (short_name (dir.name))
						node.set_pixmap (Shared_constants.Graphical_constants.Folder_closed_icon)
						Result.extend (node)
					elseif file.exists and then Shared_project.allowed_file_types.has (file_type (short_name (file.name))) then								
						create file_node.make_with_text (root_dir.lastentry)
						file_node.pointer_double_press_actions.force_extend (agent Shared_document_manager.load_document_from_file (file.name))
						file_node.set_pixmap (Shared_constants.Graphical_constants.File_icon)
						Result.extend (file_node)					
					end
				end
				cnt := cnt + 1
			end	
		end		

feature {NONE} -- Implementation

	internal_tree: EV_TREE
			-- Internal widget
			
invariant
	has_root: root /= Void
	has_widget: internal_tree /= Void

end -- class DOCUMENT_SELECTOR
