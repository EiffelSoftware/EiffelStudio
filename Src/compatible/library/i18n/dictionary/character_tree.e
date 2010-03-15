note
	description: "Datastructure that indexes items with a string_32 key by constructing a tree of characters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER_TREE[G]
inherit
	ANY

create
	default_create,
	make

feature {NONE} -- Init

	make (a_key: STRING_32; a_character_list: LINKED_LIST[CHARACTER_TREE[G]])
			-- Make a tree with `a_key' as key and `a_character_list' as character list
		require
			a_key_not_exists: a_key /= Void
			a_character_list_exists: a_character_list /= Void
		do
			key := a_key
			character_trees_list := a_character_list
		end

feature -- Interface

	insert (a_item: G; a_key: STRING_32)
			-- Insert an `a_item' with `a_key' as key in Current tree
		require
			item_and_key_exist: a_item /= Void and a_key /= Void
			not_yet_in_tree: not has (a_item, a_key)
		local
			tree_el: detachable CHARACTER_TREE[G]
			l_key: like key
		do
			if not is_leaf then
					-- it is a node
				l_key := key
				check l_key /= Void end -- Implied from invariant
				tree_el:= search_character_tree (a_key.substring (l_key.count+1, a_key.count))
				if tree_el = Void or not a_key.substring (1,l_key.count).is_equal (l_key) then
						-- element not in the node
					insert_character_tree (a_item, a_key)
				else -- similar element in the node, insert there
					tree_el.insert (a_item,a_key.substring (l_key.count+1, a_key.count))
				end
			elseif key = Void then
					-- it is a empty leaf
				key := a_key
				item := a_item
			else
					-- it is a 1 element leaf
				split (a_item, a_key)
			end
		end

	get (a_key: STRING_32): detachable G
			-- get item with `a_key' as key
		require
			a_key_exists: a_key /= Void
			a_key_in_tree: get_item_with_key (a_key) /= Void
		local
			tree_el: like search_character_tree
			l_item: like item
			l_key: like key
		do
			if not is_leaf then
				l_key := key
				check l_key /= Void end -- Implied by invariant
				tree_el := search_character_tree (a_key.substring (l_key.count +1, a_key.count))
				check tree_el /= Void end -- Implied by precondition.
				Result := tree_el.get (a_key.substring (l_key.count +1, a_key.count))
			else
				l_item := item
				check l_item /= Void end -- Implied by precondition.
				Result := l_item
			end
		end

	has (a_item: G; s: STRING_32): BOOLEAN
			-- Does current tree have `a_item' with `a_key' as key?
		require
			a_item_not_void: a_item /= Void
			s_not_void: s /= Void
		local
			tree_el: detachable CHARACTER_TREE[G]
			l_key: like key
		do
			if not is_leaf then
				l_key := key
				check l_key /= Void end -- Implied by invariant
				tree_el := search_character_tree (s.substring (l_key.count +1, s.count))
				Result := tree_el /= Void and then tree_el.has (a_item, s.substring (l_key.count +1, s.count))
			else
				Result := (s ~ key and then a_item ~ item)
			end
		end

	get_item_with_key (s: STRING_32): detachable G
			-- get the item in the tree that has as key `s'
			-- if no item with this porperty, Result is void
		require
			a_key_exists: s /= Void
		local
			tree_el: detachable CHARACTER_TREE[G]
			l_key: like key
		do
			if not is_leaf then
				l_key := key
				check l_key /= Void end -- Implied by invariant
				tree_el := search_character_tree (s.substring (l_key.count +1, s.count))
				if tree_el /= Void then
					Result := tree_el.get_item_with_key (s.substring (l_key.count +1, s.count))
				end
			elseif key ~ s then
				Result := item
			end
		end

feature {CHARACTER_TREE} -- Information

	key_corresponds (a_key: STRING_32): BOOLEAN
			-- does `a_key' correspond to a_string?
		require
			a_string_not_void: a_key /= Void
		do
			if key /= Void then
				Result := minimum_distance (a_key) > 0
			end
		end

feature {NONE} -- character_trees_list

	character_trees_list: detachable LINKED_LIST[CHARACTER_TREE[G]]
			-- list of all subtrees

	search_character_tree (a_string: STRING_32): detachable CHARACTER_TREE[G]
			-- search tree which represents a_character
			-- void if not available
		require
			not_is_leaf: not is_leaf
			a_string_not_void: a_string /= Void
		local
			l_tree: detachable CHARACTER_TREE [G]
			l_list: like character_trees_list
		do
				-- User move to front method
			l_list := character_trees_list
			check l_list /= Void end -- Implied by invariant
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

	insert_character_tree (a_item: G; a_key: STRING_32)
			-- Insert in `character_trees_list' a subtree with
			-- `a_item' es element and `a_key' as key
			-- If necessary, update `key' and all keys
			-- of the subtrees
		require
			not_is_leaf: not is_leaf
			key_not_void: key /= Void
		local
			l_tree, new_tree: CHARACTER_TREE[G]
			distance: INTEGER
			l_str: STRING_32
			l_key: like key
			l_list: like character_trees_list
		do
			distance := minimum_distance (a_key)

			l_list := character_trees_list
			check l_list /= Void end -- Implied by precondition and invariant

			l_key := key
			check l_key /= Void end -- Implied by precondition
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

	split (a_item: G; a_string: STRING_32)
			-- split leaf in a node with a character tree list
		require
			a_item_not_void: a_item /= Void
			a_string_not_void: a_string /= Void
			is_leaf: is_leaf
		local
			distance: INTEGER
			r_key: STRING_32
			l_key: detachable STRING_32
			l_tree, r_tree: CHARACTER_TREE[G]
			l_default: G
			l_item: like item
			l_list: like character_trees_list
		do
			create l_list.make
			character_trees_list := l_list

			l_key := key
			check l_key /= Void end -- Implied by precondition and invariant.

			distance := minimum_distance (a_string)

			create l_tree
			l_item := item
			check l_item /= Void end
			l_tree.insert (l_item, l_key.substring (distance+1, l_key.count))

			l_list.put_front (l_tree)

			r_key := a_string.substring (distance+1, a_string.count)
			create r_tree
			r_tree.insert (a_item, r_key)
			l_list.put_front (r_tree)
			key := l_key.substring (1, distance)
			item := default_item
		ensure
			two_elements: (attached character_trees_list as l) and then l.count = 2
			no_item: item = default_item
		end

feature {NONE} -- Information

	is_leaf: BOOLEAN
			-- is current element a leaf?
		do
			Result := character_trees_list = Void
		end

	key: detachable STRING_32

	prepend_to_key (a_string: STRING_32)
			-- prepend `a_string' to `key'
		require
			a_string_not_void: a_string /= Void
			key_not_void: key /= Void
		local
			l_key: like key
		do
			l_key := key
			check l_key /= Void end -- Implied by precondition.
			key:= a_string + l_key
		end

	item: detachable G

	default_item: detachable G
		do
		end

feature {NONE} -- Implementation

	minimum_distance (a_key: STRING_32): INTEGER
			-- find distance between `a_string' and `key'
			-- Result is the amount of equal characters from the beginning
			-- of the two strings
		require
			a_key_not_void: a_key /= Void
			key_not_void: key /= Void
		local
			l_key: like key
		do
			l_key := key
			check l_key /= Void end -- Implied from precondition
			from
				Result := 1
			until
				Result > a_key.count.min (l_key.count) or else
				a_key.item (Result) /= l_key.item (Result)
			loop
				Result := Result + 1
			end
			Result := Result - 1
		end

feature --display

	print_tree (t: INTEGER): STRING_32
			-- display current tree,
			-- `t' is the depth, of current item
		local
			i : INTEGER
			spaces: STRING_32
			l_key, l_item: STRING
		do
			create spaces.make_filled (' ',t*2)
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

				Result := spaces+"LEAF with item: "+l_item+" ("+l_key+")%N"
			else
				if attached character_trees_list as l_list then
					Result := spaces+"NODE with key: "+l_key+"%N"
					from
						l_list.start
						i := 1
					until
						l_list.after
					loop
						spaces.make_filled (' ',(t+1)*2)
						Result.append (spaces+i.out+"th child%N"+l_list.item.print_tree (t+2))
						l_list.forth
						i := i + 1
					end
				else
					Result := "Empty node%N"
				end
			end
		end


invariant
	is_leaf_implies_character_trees_list: is_leaf implies character_trees_list = Void
	is_leaf_implies_key_not_void: not is_leaf implies key /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"





end -- Class CHARACTER_TREE
