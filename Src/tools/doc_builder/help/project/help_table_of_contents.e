indexing
	description: "Help Table of contents"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HELP_TABLE_OF_CONTENTS
	
inherit
	ARRAYED_LIST [HELP_TOPIC]
	
	TABLE_OF_CONTENTS_CONSTANTS
		undefine
			copy,
			is_equal
		end
	
	UTILITY_FUNCTIONS
		undefine
			is_equal,
			copy
		end
		
feature -- Creation

	make_from_directory (a_project: HELP_PROJECT; a_directory: DIRECTORY) is
			-- Make with `a_directory' as root directory
		require
			project_not_void: a_project /= Void
			directory_exists: a_directory.exists
		local
			node: HELP_TOPIC_FOLDER
		do
			make (10)
			project := a_project
			initialize (a_directory)
			create node.make_from_directory (root.name, root)
			root_node := node
			extend (root_node)
		end
		
	make_from_widget (a_project: HELP_PROJECT; a_toc_tree: DOCUMENT_TOC) is
			-- Make from structure of `a_toc_tree'
		require
			project_not_void: a_project /= Void
			tree_not_void: a_toc_tree /= Void
		local
			folder_node: HELP_TOPIC_FOLDER
			file_node: HELP_TOPIC_FILE
			l_root, l_item: EV_TREE_ITEM
			l_dir: DIRECTORY
		do
			make (10)
			project := a_project
			create l_dir.make (Shared_constants.Application_constants.html_location)
			if l_dir.exists then
				initialize (l_dir)
			end
					-- Must create dummy root node because HTML Help 1.x generation
					-- requires a root which is not shown in the final TOC.
			create l_root.default_create
			from
				a_toc_tree.start
			until
				a_toc_tree.after
			loop
				l_item ?= a_toc_tree.item
				if l_item /= Void then
					l_item.parent.prune (l_item)
					l_root.extend (l_item)
				end
				a_toc_tree.forth
			end
			create root_node.make_from_node (l_root)
			extend (root_node)
		
					-- Now must remove dummy root and put tree back to original status
			from
				l_root.start
			until
				l_root.after
			loop
				l_item ?= l_root.item
				if l_item /= Void then
					l_item.parent.prune (l_item)
					a_toc_tree.extend (l_item)
				end
				l_root.forth
			end
			a_toc_tree.prune (l_root)
		end

feature -- Initialization

	initialize (a_dir: DIRECTORY) is
			-- Initialize
		require
			dir_not_void: a_dir /= Void
		local
			root_path: DIRECTORY_NAME
		do
			create root_path.make_from_string (Shared_constants.Application_constants.Temporary_help_directory)
			create root.make (root_path)
			copy_directory (a_dir, root)
		end		

feature -- Access

	project: HELP_PROJECT
			-- Project to which this TOC belongs

	root: DIRECTORY
			-- Root directory from which Current begins

	root_node: HELP_TOPIC_FOLDER
			-- Root topic node

	contents_file: PLAIN_TEXT_FILE
		 	-- File on disk holding content information

	write_contents_file is
			-- Write new `contents_file' based on Current
		deferred
		end	

invariant
	has_project: project /= Void

end -- class HELP_TABLE_OF_CONTENTS
