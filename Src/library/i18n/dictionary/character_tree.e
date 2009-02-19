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

feature {CHARACTER_TREE} -- Init

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
			tree_el: CHARACTER_TREE[G]
		do
			if not is_leaf then
					-- it is a node
				tree_el:= search_character_tree (a_key.substring (key.count+1, a_key.count))
				if tree_el = Void or  not  a_key.substring (1,key.count).is_equal (key) then
						-- element not in the node
					insert_character_tree (a_item, a_key)
				else -- similar element in the node, insert there
					tree_el.insert (a_item,a_key.substring (key.count+1, a_key.count))
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

	get (a_key: STRING_32): G
			-- get item with `a_key' as key
		require
			a_key_exists: a_key /= Void
			a_key_in_tree: get_item_with_key (a_key) /= Void
		local
			tree_el: CHARACTER_TREE[G]
		do
			if not is_leaf then
				tree_el := search_character_tree (a_key.substring (key.count +1, a_key.count))
				Result := tree_el.get (a_key.substring (key.count +1, a_key.count))
			else
				Result := item
			end
		end

	has (a_item: G; s: STRING_32): BOOLEAN
			-- Does current tree have `a_item' with `a_key' as key?
		local
			tree_el: CHARACTER_TREE[G]
		do
			if not is_leaf then
				tree_el := search_character_tree (s.substring (key.count +1, s.count))
				Result := tree_el /= Void and then tree_el.has (a_item, s.substring (key.count +1, s.count))
			else
				Result := key /= Void and then (key.is_equal (s) and item.is_equal (a_item))
			end
		end

	get_item_with_key (s: STRING_32): G
			-- get the item in the tree that has as key `s'
			-- if no item with this porperty, Result is void
		require
			a_key_exists: s /= Void
		local
			tree_el: CHARACTER_TREE[G]
		do
			if not is_leaf then
				tree_el := search_character_tree (s.substring (key.count +1, s.count))
				if tree_el /= Void then
					Result := tree_el.get_item_with_key (s.substring (key.count +1, s.count))
				end
			elseif key /= Void and then key.is_equal (s) then
				Result := item
			end
		end


feature {CHARACTER_TREE} -- character_trees_list

	character_trees_list: LINKED_LIST[CHARACTER_TREE[G]]
			-- list of all subtrees

	search_character_tree (a_string: STRING_32): CHARACTER_TREE[G]
			-- search tree which represents a_character
			-- void if not available
		do
				-- User move to front method
			from
				character_trees_list.start
			until
				Result /= Void or character_trees_list.after
			loop
				if character_trees_list.item.key_corresponds(a_string) then
					Result := character_trees_list.item.twin
					character_trees_list.remove
					character_trees_list.put_front (Result)
 						character_trees_list.start
 						Result := character_trees_list.item
				else
					character_trees_list.forth
				end
			end
		end

	insert_character_tree (a_item: G; a_key: STRING_32)
			-- Insert in `character_trees_list' a subtree with
			-- `a_item' es element and `a_key' as key
			-- If necessary, update `key' and all keys
			-- of the subtrees
		local
			l_tree, new_tree: CHARACTER_TREE[G]
			distance: INTEGER
			l_str: STRING_32
		do
			distance := minimum_distance (a_key)
			if distance < key.count  then
				l_str := key.substring (distance+1, key.count)
				create new_tree.make (l_str, character_trees_list)
				character_trees_list := Void
				create character_trees_list.make
				character_trees_list.extend (new_tree)
				key.keep_head (distance)
			end
			create l_tree
			l_tree.insert (a_item, a_key.substring (key.count+1, a_key.count))
			character_trees_list.put_front (l_tree)
		end

	split (a_item: G; a_string: STRING_32)
			-- split leaf in a node with a character tree list
		require
			is_leaf: is_leaf
		local
			distance: INTEGER
			l_key, r_key: STRING_32
			l_tree, r_tree: CHARACTER_TREE[G]
			l_default: G
		do
			create character_trees_list.make
			distance := minimum_distance (a_string)
			l_key := key.substring (distance+1, key.count)
			create l_tree
			l_tree.insert (item, l_key)
			character_trees_list.put_front (l_tree)
			r_key := a_string.substring (distance+1, a_string.count)
			create r_tree
			r_tree.insert (a_item, r_key)
			character_trees_list.put_front (r_tree)
			key := key.substring (1, distance)
			item := default_item
		ensure
			two_elements: character_trees_list.count = 2
			no_item: item = default_item
		end

feature {CHARACTER_TREE} -- Information

	is_leaf: BOOLEAN
			-- is current element a leaf?
		do
			Result := character_trees_list = Void
		end
	key: STRING_32

	key_corresponds (a_key: STRING_32): BOOLEAN
			-- does `a_key' correspond to a_string?
		do
			Result := minimum_distance (a_key) > 0
		end

	prepend_to_key (a_string: STRING_32)
			-- prepend `a_string' to `key'
		do
			key:= a_string + key
		end

	item: G

	default_item: G
		do
		end

feature {CHARACTER_TREE} -- Implementation

	minimum_distance (a_key: STRING_32): INTEGER
			-- find distance between `a_string' and `key'
			-- Result is the amount of equal characters from the beginning
			-- of the two strings
		do
			from
				Result := 1
			until
				Result > a_key.count.min (key.count) or else
				a_key.item (Result) /= key.item (Result)
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
		do
			create spaces.make_filled (' ',t*2)
			if is_leaf then
				Result := spaces+"LEAF with item: "+item.out+" ("+key.out+")%N"
			else
				Result := spaces+"NODE with key: "+key.out+"%N"
				from
					character_trees_list.start
					i := 1
				until
					character_trees_list.after
				loop
					spaces.make_filled (' ',(t+1)*2)
					Result.append (spaces+i.out+"th child%N"+character_trees_list.item.print_tree (t+2))
					character_trees_list.forth
					i := i + 1
				end
			end
		end


invariant
	i2:	is_leaf implies character_trees_list = Void

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
