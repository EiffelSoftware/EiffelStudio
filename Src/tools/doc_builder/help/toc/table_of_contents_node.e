indexing
	description: "TOC node"
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_NODE

inherit	
	TABLE_OF_CONTENTS_CONSTANTS		

	HASHABLE
		rename
			hash_code as id
		end
		
create
	make,
	make_root

feature -- Creation

	make (a_id: INTEGER; a_parent: like Current; a_url, a_title: STRING) is
			-- New node
		require
			valid_id: a_id > 0
			parent_not_void: a_parent /= Void
			title_not_void: a_title /= Void
		do
			id := a_id
			set_parent (a_parent)
			set_url (a_url)
			set_title (a_title)		
		end	

	make_root is
			-- Make as root node
		do			
		end		

feature -- Retrieval

	node_by_title_location (a_titles: ARRAY [STRING]): like Current is
			-- Node at title location of `titles'.  Loop through elements
			-- of Current and match title strings.  
		require
			titles_not_void: a_titles /= Void
			titles_not_empty: not a_titles.is_empty
		local
			l_curr_node: like Current
			l_matches: ARRAYED_LIST [like Current]
			l_new_titles: like a_titles
			l_first_item: STRING
		do		
			if has_child then
				create l_matches.make (a_titles.count)
				l_first_item := a_titles.item (a_titles.lower)
				from				
					children.start				
				until
					children.after
				loop				
					l_curr_node := children.item
					if 
						l_curr_node.title /= Void and then l_curr_node.title.is_equal (l_first_item)
					then
						l_matches.extend (l_curr_node)
					end
					children.forth
				end
			end

			if not l_matches.is_empty then		
				create l_new_titles.make_from_array (a_titles.subarray (a_titles.lower + 1, a_titles.upper))
						-- Limitation:  currently only take the FIRST match, so won't work
						-- where nodes have same titles on same level
				if not l_new_titles.is_empty then
					Result := l_matches.first.node_by_title_location  (l_new_titles)
				else
					Result := l_matches.first
				end
			end
		end
		
feature -- Element change

	add_node (a_child: like Current) is
			-- Add child
		require
			node_not_void: a_child /= Void
		do
			if children = Void then
				create children.make (1)
				children.compare_objects
			end	
			children.extend (a_child)
		ensure
			has_child: children.has (a_child)
		end		
		
	delete_node (a_child: TABLE_OF_CONTENTS_NODE) is
			-- Delete child
		require
			node_not_void: a_child /= Void
		do
			if children.has (a_child) then
				children.start
				children.prune (a_child)
				print ("deleted " + a_child.url)
			end
		ensure
			not_has_child: not children.has (a_child)
		end
		
	move_nodes_to_parent is
			-- Move nodes of Current into parent
		do
			if parent /= Void and has_child then
				from
					children.start
				until
					children.after
				loop
					parent.add_node (children.item)
					delete_node (children.item)
					children.forth
				end
			end	
		end		
		
feature -- Query		
	
	is_index: BOOLEAN is
			-- Is index node?
		do
			if url /= Void then
				Result := (create {UTILITY_FUNCTIONS}).short_name (url).is_equal (Default_url)
			end		
		end
		
	url_is_file: BOOLEAN is
			-- Is url a file reference?
		local
			l_file: PLAIN_TEXT_FILE
		do
			if url /= Void then
				create l_file.make (url)
				Result := l_file.exists and then not l_file.is_directory
			end	
		end		
		
	url_is_directory: BOOLEAN is
			-- Represent physical directory?
		do
			if url /= Void then
				Result := (create {DIRECTORY}.make (url)).exists	
			end				
		end			
		
	has_child: BOOLEAN is
			-- Does Current have a child nodes?
		do
			Result := children /= Void and then not children.is_empty	
		end		
		
	has_file: BOOLEAN is
			-- Does element contain a child file node?  Not recursive.
		local
			l_el: like Current
		do
			if has_child then
				from				
					children.start
				until
					children.after or Result
				loop
					l_el ?= children.item
					Result := l_el.url_is_file
					children.forth
				end
			end				
		end
		
	has_index: BOOLEAN is
			-- Does element contain a child index node?
		local
			l_el: like Current
		do
			if has_child then
				from 
					children.start
				until
					children.after or Result
				loop
					l_el := children.item
					Result := l_el.is_index
					children.forth
				end	
			end			
		end	
		
	has_parent: BOOLEAN is
			-- Has parent?
		do
			Result := parent /= Void	
		end		

feature -- Status Setting
	
	set_url (a_url: STRING) is
			-- Set `url'
		require
			url_not_void: a_url /= Void
		do
			if not names_heap.has (a_url) then		
				names_heap.put (a_url)
			end
			url_id := names_heap.found_item
		ensure
			known_name: names_heap.has (a_url)
			id_is_name: names_heap.item (url_id).is_equal (a_url)
		end	
		
	set_title (a_title: STRING) is
			-- Set `title'
			require
		title_not_void: a_title /= Void
		do
			if not names_heap.has (a_title) then
				names_heap.put (a_title)
			end
			title_id := names_heap.found_item
		ensure
			known_name: names_heap.has (a_title)
			id_is_name: names_heap.item (title_id).is_equal (a_title)
		end	

	set_icon (a_icon_name: STRING) is
			-- Set custom icon
		require
			icon_not_void: a_icon_name /= Void
		do
			if not names_heap.has (a_icon_name) then
				names_heap.put (a_icon_name)
			end
			icon_id := names_heap.found_item
		ensure
			known_name: names_heap.has (a_icon_name)
			id_is_name: names_heap.item (icon_id).is_equal (a_icon_name)
		end		

	set_parent (a_parent: like Current) is
			-- Set parent
		require
			parent_not_void: a_parent /= Void
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end	

	set_children (a_children: like children) is
			-- Set children
		do
			children := a_children
			children.compare_objects
		ensure
			children_set: children = a_children
		end		

feature -- Access
	
	id: INTEGER
			-- Unique identifier
	
	parent: like Current
			-- Parent
	
	url: STRING is
			-- Url attribute
		do
			Result := names_heap.item (url_id)
		end
			
	title: STRING is
			-- Title attribute
		do
			Result := names_heap.item (title_id)
		end
	
	icon: STRING is
			-- Custom icon
		do
			Result := names_heap.item (icon_id)
		end
	
	children: ARRAYED_LIST [TABLE_OF_CONTENTS_NODE]
			-- Children
	
feature -- Convenience

	files (recursive: BOOLEAN): ARRAYED_LIST [FILE_NAME] is
			-- List of file names which `children' urls refer to.  If `recursive'
			-- include childrens files.  Includes directory file names also.
		local
			l_node: like Current
			l_filename: STRING
		do			
			if has_child then
				create Result.make (children.count)
				from				
					children.start
				until
					children.after
				loop
					l_node := children.item
					l_filename := l_node.url
					if l_filename /= Void then
						Result.extend (create {FILE_NAME}.make_from_string (l_filename))
					end					
					if recursive and then l_node.has_child then
						Result.append (l_node.files (recursive))
					end					
					children.forth			
				end
			end			
		end		
	
	nodes (recursive: BOOLEAN): ARRAYED_LIST [TABLE_OF_CONTENTS_NODE] is
			-- List of nodes in Current.
		local
			l_node: like Current
		do			
			if has_child then				
				create Result.make (children.count)
				from				
					children.start
				until
					children.after
				loop
					l_node := children.item
					Result.extend (l_node)
					if recursive and then l_node.has_child then
						Result.append (l_node.nodes (recursive))
					end					
					children.forth			
				end
			end			
		end
		
	parent_children: like children is
			-- List of children which are parents (i.e not files)
		do			
			create Result.make (1)
			if has_child then
				from
					children.start
				until
					children.after
				loop
					if children.item.url_is_directory then
						Result.extend (children.item)
					end
					children.forth
				end
			end
		end		
	
feature {TABLE_OF_CONTENTS, TABLE_OF_CONTENTS_WIDGET_FORMATTER} -- Implementation

	url_id,
	title_id,
	icon_id: INTEGER
			-- Name Ids
			
	names_heap: NAMES_HEAP is
			-- Names heap
		once
			create Result.make			
		end

end -- class TABLE_OF_CONTENTS_NODE
