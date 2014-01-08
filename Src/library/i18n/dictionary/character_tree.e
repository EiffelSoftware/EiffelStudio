note
	description: "Data structure that indexes items with a string_32 key by constructing a tree of characters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER_TREE [G -> ANY]

create
	default_create,
	make

feature {NONE} -- Creation

	make (a_key: STRING_32; a_character_list: LINKED_LIST[CHARACTER_TREE[G]])
			-- Make a tree with `a_key' as a key and `a_character_list' as a character list.
		require
			a_key_not_exists: a_key /= Void
			a_character_list_exists: a_character_list /= Void
		do
			key := a_key
			character_trees_list := a_character_list
		end

feature -- Modification

	insert (a_item: G; a_key: STRING_32)
			-- Insert an `a_item' with `a_key' as key in Current tree.
		require
			item_and_key_exist: a_item /= Void and a_key /= Void
			not_yet_in_tree: not has (a_item, a_key)
		local
			tree_el: detachable CHARACTER_TREE[G]
			l_list: like character_trees_list
			distance: INTEGER
			l_tree, r_tree: CHARACTER_TREE [G]
			r_key: detachable STRING_32
		do
			if attached key as l_key then
				if not is_leaf then
						-- It is a node.
					tree_el:= search_character_tree (a_key.substring (l_key.count+1, a_key.count))
					if tree_el = Void or not a_key.substring (1,l_key.count).is_equal (l_key) then
							-- Element is not in the node.
						insert_character_tree (a_item, a_key)
					else
							-- Similar element is in the node, insert there.
						tree_el.insert (a_item,a_key.substring (l_key.count+1, a_key.count))
					end
				else
						-- It is a 1-element leaf, we split.
					create l_list.make
					character_trees_list := l_list

					distance := minimum_distance (a_key, l_key)

					create l_tree
					check attached item as l_item then
						l_tree.insert (l_item, l_key.substring (distance+1, l_key.count))
					end

					l_list.put_front (l_tree)

					r_key := a_key.substring (distance+1, a_key.count)
					create r_tree
					r_tree.insert (a_item, r_key)
					l_list.put_front (r_tree)
					key := l_key.substring (1, distance)
					item := default_item
				end
			else
					-- It is an empty leaf.
				key := a_key
				item := a_item
			end
		end

feature -- Access

	get (a_key: STRING_32): detachable G
			-- Get item with `a_key' as key.
		require
			a_key_exists: a_key /= Void
			a_key_in_tree: get_item_with_key (a_key) /= Void
		local
			tree_el: like search_character_tree
		do
			if not is_leaf then
				if attached key as l_key then
					tree_el := search_character_tree (a_key.substring (l_key.count +1, a_key.count))
					if tree_el /= Void then
						Result := tree_el.get (a_key.substring (l_key.count +1, a_key.count))
					end
				end
			else
				Result := item
			end
		end

	has (a_item: G; s: STRING_32): BOOLEAN
			-- Does current tree have `a_item' with `s' as a key?
		require
			a_item_not_void: a_item /= Void
			s_not_void: s /= Void
		local
			tree_el: detachable CHARACTER_TREE[G]
		do
			if not is_leaf then
				if attached key as l_key then
					tree_el := search_character_tree (s.substring (l_key.count + 1, s.count))
					Result := tree_el /= Void and then tree_el.has (a_item, s.substring (l_key.count + 1, s.count))
				end
			else
				Result := (s ~ key and then a_item ~ item)
			end
		end

	get_item_with_key (s: STRING_32): detachable G
			-- Get an item in the tree that has as key `s',
			-- return Void otherwise.
		require
			a_key_exists: s /= Void
		local
			tree_el: detachable CHARACTER_TREE[G]
		do
			if not is_leaf then
				if attached key as l_key then
					tree_el := search_character_tree (s.substring (l_key.count + 1, s.count))
					if tree_el /= Void then
						Result := tree_el.get_item_with_key (s.substring (l_key.count + 1, s.count))
					end
				end
			elseif key ~ s then
				Result := item
			end
		end

feature {CHARACTER_TREE} -- Information

	key_corresponds (a_key: STRING_32): BOOLEAN
			-- Does `a_key' correspond to a_string?
		require
			a_string_not_void: a_key /= Void
		do
			if key /= Void then
				Result := minimum_distance (a_key, key) > 0
			end
		end

feature {NONE} -- character_trees_list

	character_trees_list: detachable LINKED_LIST [CHARACTER_TREE[G]]
			-- List of all subtrees

	search_character_tree (a_string: STRING_32): detachable CHARACTER_TREE[G]
			-- Search for a tree that represents a_string,
			-- return Void if not found.
		require
			a_string_not_void: a_string /= Void
		local
			l_tree: detachable CHARACTER_TREE [G]
		do
			if attached character_trees_list as l_list then
					-- User move to front method.
				from
					l_list.start
				until
					Result /= Void or l_list.after
				loop
					if l_list.item.key_corresponds(a_string) then
						l_tree := l_list.item
						check l_tree /= Void end
						Result := l_tree
						Result := Result.twin
						l_list.remove
						l_list.put_front (Result)
						l_list.start
	 					Result := l_list.item
					else
						l_list.forth
					end
				end
			end
		end

	insert_character_tree (a_item: G; a_key: STRING_32)
			-- If `key' and `character_trees_list' are set, insert in
			-- `character_trees_list' a subtree with `a_item' as an
			-- element and `a_key' as a key. If necessary, update `key'
			-- and all keys of the subtrees.
		local
			l_tree, new_tree: CHARACTER_TREE[G]
			distance: INTEGER
			l_str: STRING_32
			l_list: like character_trees_list
		do
			l_list := character_trees_list
			if attached key as l_key and l_list /= Void then
				distance := minimum_distance (a_key, l_key)
				if distance < l_key.count  then
					l_str := l_key.substring (distance+1, l_key.count)
					create new_tree.make (l_str, l_list)

					create l_list.make
					l_list.extend (new_tree)
					character_trees_list := l_list
					l_key.keep_head (distance)
				end
				create l_tree
				l_tree.insert (a_item, a_key.substring (l_key.count+1, a_key.count))
				l_list.put_front (l_tree)
			end
		end

feature {NONE} -- Information

	is_leaf: BOOLEAN
			-- Is current element a leaf?
		do
			Result := character_trees_list = Void
		end

	key: detachable STRING_32

	prepend_to_key (a_string: STRING_32)
			-- Prepend `a_string' to `key' if set.
		require
			a_string_not_void: a_string /= Void
		do
			if attached key as l_key then
				key := a_string + l_key
			end
		end

	item: detachable G

	default_item: detachable G
		do
		end

feature {NONE} -- Measurement

	minimum_distance (a_key: STRING_32; a_reference_key: detachable STRING_32): INTEGER
			-- Find distance between `a_key' and `a_reference_key', and `0' if `a_reference_key' is not set.
			-- Result is the amount of equal characters from the beginning
			-- of the two strings
		require
			a_key_not_void: a_key /= Void
		do
			if a_reference_key /= Void then
				from
					Result := 1
				until
					Result > a_key.count.min (a_reference_key.count) or else
					a_key.item (Result) /= a_reference_key.item (Result)
				loop
					Result := Result + 1
				end
				Result := Result - 1
			else
				Result := 0
			end
		end

feature -- Output

	print_tree (t: INTEGER): STRING_32
			-- Printable representation of the current tree,
			-- `t' is a depth of the current item.
		local
			i : INTEGER
			spaces: STRING_32
			l_key, l_item: STRING
		do
			create spaces.make_filled (' ', t*2)
			if attached key as k then
				l_key := k.out
			else
				l_key := ""
			end
			if attached item as it then
				l_item := it.out
			else
				l_item := ""
			end
			if is_leaf then
				Result := spaces + "LEAF with item: " + l_item + " (" + l_key + ")%N"
			else
				if attached character_trees_list as l_list then
					Result := spaces+"NODE with key: "+l_key+"%N"
					from
						l_list.start
						i := 1
					until
						l_list.after
					loop
						spaces.make_filled (' ', (t + 1) * 2)
						Result.append (spaces+i.out+"th child%N"+l_list.item.print_tree (t+2))
						l_list.forth
						i := i + 1
					end
				else
					Result := {STRING_32} "Empty node%N"
				end
			end
		end


invariant
	is_leaf_implies_character_trees_list: is_leaf implies character_trees_list = Void
	is_leaf_implies_key_not_void: not is_leaf implies key /= Void and character_trees_list /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- Class CHARACTER_TREE
