indexing
	description: "TOC node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_NODE

inherit	
	TABLE_OF_CONTENTS_CONSTANTS
		undefine
			is_equal
		end

	COMPARABLE

	HASHABLE
		rename
			hash_code as id
		undefine
			is_equal
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
			set_id (a_id)
			set_parent (a_parent)			
			set_title (a_title)
			if a_url /= Void then
				set_url (a_url)
			end
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

			if l_matches /= Void and then not l_matches.is_empty then		
				create l_new_titles.make_from_array (a_titles.subarray (a_titles.lower + 1, a_titles.upper))
						-- Limitation:  currently only take the FIRST match, so won't work
						-- where nodes have same titles on same level
				if not l_new_titles.is_empty then
					Result := l_matches.first.node_by_title_location (l_new_titles)
				else
					Result := l_matches.first
				end
			end
		end
		
	node_by_url (a_url: STRING): TABLE_OF_CONTENTS_NODE is
			-- Node matching `a_url'.
		require
			url_not_void: a_url /= Void
			url_not_empty: not a_url.is_empty
		local
			l_curr_node: like Current
		do
			if url /= Void and then url.is_equal (a_url) then
				Result := Current
			end
			if Result = Void and then has_child then
				from				
					children.start				
				until
					children.after or Result /= Void
				loop				
					l_curr_node := children.item					
					Result := l_curr_node.node_by_url (a_url)
					children.forth
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
		
	delete_node (a_id: INTEGER) is
			-- Delete child with `a_id' from `children' if it exists
		require
			valid_id: a_id > 0
		local
			done: BOOLEAN
			l_node: like Current
		do
			from
				children.start
			until
				children.after or done
			loop
				if children.item.id = a_id then
					l_node := children.item
					done := True
				else
					children.forth
				end
			end		
			
			if l_node /= Void then
				children.start
				children.prune (l_node)
			end
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
					delete_node (children.item.id)
					children.forth
				end
			end	
		end			
		
	sort is
			-- Sort children
		local
			l_sorted_list: SORTED_TWO_WAY_LIST [like Current]
		do
			if has_child then
				create l_sorted_list.make				
				l_sorted_list.append (children)
				l_sorted_list.sort
				children.wipe_out
				from
					l_sorted_list.start
				until
					l_sorted_list.after
				loop
					children.extend (l_sorted_list.item)
					l_sorted_list.forth
				end
			end	
		end		
		
	flatten_ids (a_start_index: INTEGER): INTEGER is
			-- Flatten ids of all nodes.
		local
			l_node: TABLE_OF_CONTENTS_NODE
		do			
			if has_child then				
				from
					Result := a_start_index
					children.start
				until
					children.after
				loop
					l_node := children.item
					l_node.set_id (Result)
					Result := Result + 1
					if l_node.has_child then
						Result := l_node.flatten_ids (Result)
					end
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
			l_index: INTEGER
		do
			if has_child then
				from				
					l_index := children.index
					children.start
				until
					children.after or Result
				loop
					l_el ?= children.item
					Result := l_el.url_is_file
					children.forth
				end
				children.go_i_th (l_index)
			end				
		end
		
	has_index: BOOLEAN is
			-- Does element contain a child index node?
		local
			l_el: like Current
			l_index: INTEGER				
		do			
			if has_child then				
				from 
					l_index := children.index
					children.start
				until
					children.after or Result
				loop
					l_el := children.item
					Result := l_el.is_index
					children.forth
				end
				children.go_i_th (l_index)
			end					
		end	
		
	has_parent: BOOLEAN is
			-- Has parent?
		do
			Result := parent /= Void	
		end		

feature -- Status Setting
	
	set_id (a_id: INTEGER) is
			-- Set `id'
		require
			id_valid: a_id > 0
		do
			id := a_id
		ensure
			id_Set: id = a_id
		end		
	
	set_url (a_url: STRING) is
			-- Set `url'
		require
			url_not_void: a_url /= Void
		do
			a_url.replace_substring_all ("\", "/")
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
				names_heap.put (a_title.string)
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
				names_heap.put (a_icon_name.string)
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
		
	icon_pixmap: EV_PIXMAP is
			-- Icon pixmap of icon
		do
			if icon /= Void then
				create Result
				Result.set_with_named_file (icon)
			end	
		end		
	
	children: ARRAYED_LIST [TABLE_OF_CONTENTS_NODE]
			-- Children
	
	include: BOOLEAN
			-- Include in sorting?
	
feature -- Convenience

	files (recursive: BOOLEAN): ARRAYED_LIST [STRING] is
			-- List of file names which `children' urls refer to.  If `recursive'
			-- include childrens files.  Includes directory file names also.
		local
			l_node: like Current
			l_filename: STRING
		do		
			if has_child then				
				create Result.make (children.count)
				Result.compare_objects
				from				
					children.start
				until
					children.after
				loop
					l_node := children.item
					l_filename := l_node.url
					if l_filename /= Void and then not Result.has (l_filename) then
						Result.extend (l_filename)
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
	
feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := other.title > title
		end
	
feature {TABLE_OF_CONTENTS, TABLE_OF_CONTENTS_NODE} -- Implementation

	url_id,
	title_id,
	icon_id: INTEGER
			-- Name Ids
			
	names_heap: NAMES_HEAP is
			-- Names heap
		once
			create Result.make			
		end		

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
end -- class TABLE_OF_CONTENTS_NODE
