note
	description: "Tree Node for a 2-3-4 balanced tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_NODE [G]

create
	make, make_with_child

feature -- Initialization

	make
			-- Initialize as a blank tree.
		do
			create children.make_filled (Void, 1, Child_number +1)
			create keys.make_filled (Void, 1, Child_number)
			children.put (Void, 1)
			arity := 1
			keys_plus_one := 1
		end

	make_with_child (first_child: detachable like Current)
			-- Initialize Current with a `first_child'.
			-- `first_child''s parent is changed as a side effect.
		do
			make
			children.put (first_child, 1)
			if first_child /= Void then
				keys_plus_one := first_child.keys_plus_one
				first_child.set_parent (Current)
			end
		end

feature -- Access

	parent: detachable like Current
		-- parent of Current
		-- Void if Current is a root.

	children: ARRAY [detachable like Current]
		-- children of Current

	keys: ARRAY [detachable like item]
		-- keys contained by Current

	item (i: INTEGER): TREE_KEY [G]
			-- `i'th key of the tree, if Current was the root node.
		require
			i_big_enough: i >= 1
			i_small_enough: i < keys_plus_one
		local
			pos : INTEGER
				-- Number of keys until the one we seek.
			aux, k: INTEGER
			bool: BOOLEAN
			l_key: detachable like item
			l_child: detachable like Current
		do
			if is_leaf then
				l_key := keys [i]
				check l_key /= Void end -- Key in the range should not be void.
			else
				from
					k := 1
					pos := i
				invariant
					non_overflow: k <= arity
				until
					bool
				loop
					l_child := children [k]
					check l_child /= Void end -- Controlled by `bool'
					aux := pos - l_child.keys_plus_one
					if aux > 0 then
							--| The key isn't in child `k'.
						pos := aux
						k := k + 1
						bool := k > arity
						check
							research_always_successful: not (bool)
						end
					elseif aux < 0 then
							--| The key is in child `k'.
						bool := True
						l_child := children [k]
						check l_child /= Void end -- Controlled by `bool'
						l_key := l_child.item (pos)
					else
							--| We found the key.
						bool := True
						l_key := keys [k]
					end
				end
				check l_key /= Void end -- Implied by `bool'
			end
			Result := l_key
		ensure
			final_Result_good: is_root implies (Result.number = i)
		end

	first_item: detachable like item
			-- first key of a tree
			-- goes much faster than "item (1)"
		require
			has_children: not is_leaf implies children [1] /= Void
		local
			l_fisrt: detachable like Current
		do
			if is_leaf then
				Result := keys [1]
			else
				l_fisrt := children [1]
				check l_fisrt /= Void end -- Implied by precondition.
				Result := l_fisrt.first_item
			end
		end

	last_item: detachable like item
			-- last key of a tree
			-- goes much faster than "item (keys_plus_one - 1)"
		local
			l_last: detachable like Current
		do
			if is_leaf then
				Result := keys [arity - 1]
			else
				l_last := children [arity]
				check l_last_not_void: l_last /= Void end -- Implied by not `is_leaf'.
				Result := l_last.last_item
			end
		end

feature -- Measurement

	arity: INTEGER
			-- Number of children

	keys_plus_one: INTEGER
			-- Total number of keys of the node and its children, plus one.

feature -- Status report

	is_root: BOOLEAN
			-- Is Current the root node of the tree?
		do
			Result := parent = Void
		end

	is_leaf: BOOLEAN
			-- Is Current a leaf?
		do
			Result := children [1] = Void
		end

	pos_in_parent: INTEGER
			-- position of node in parent.
		require
			has_a_parent: not is_root
		local
			ch: like children
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void end -- Implied by not `is_root'
			from
				ch := l_parent.children
				Result := 1
			until
				ch [Result] = Current
			loop
				Result := Result + 1
				check
					no_overflow: Result <= l_parent.arity
				end
			variant
				l_parent.arity - Result
			end
		end
--| FIXME
--| Christophe, 14 jan 2000
--| Should we implement it as an attribute or as a function?


	keys_before_child (i: INTEGER): INTEGER
			-- Number of keys in the tree before child number `i'
		require
			i_valid: i >= 1 and then i <= children.upper
		local
			j: INTEGER
			l_parent: like parent
			l_child: detachable like Current
		do
			if is_root then
				Result := 0
			else
				l_parent := parent
				check l_parent /= Void end -- Implied by not `is_root'
				Result := l_parent.keys_before_child (pos_in_parent)
			end
			if is_leaf then
				Result := Result + i - 1
			else
				from
					j:= 1
				until
					j >= i
				loop
					l_child := children [j]
					check l_child /= Void end
					Result := Result + l_child.keys_plus_one
					j := j + 1
				variant
					i - j
				end
			end
		end

feature -- Status report

	valid_key (a_key: like item): BOOLEAN
			-- Is `a_key' valid as in current node?
		do
			Result := keys.has (a_key)
		end

feature {TREE_NODE} -- Status report

--	key_number_not_to_be_updated: BOOLEAN
		-- Do we have to update the `keys_plus_one'
		-- by using `rec_update_key_number', or is
		-- it a waste of time as it has to be done
		-- later on the algorithm?
		--| False by default.

feature -- Element change

	set_parent (par: detachable like Current)
			-- make `par' the parent of Current
		do
			parent := par
		end

	insert_key_and_right_child (key : like item; node: detachable like Current; pos: INTEGER)
			-- insert `key' at position `pos', and `node' at right of `key'
			-- (so `node' will be @`pos'+1)
		require
			key_not_void: key /= Void
		local
			i: INTEGER
		do
				--| moving records located after `pos'
			from
				i := arity
			until
				i <= pos
			loop
				children.put (children [i], i+1)
				keys.put (keys [i-1], i)
				i := i - 1
			variant
				i - pos
			end
			children.put (node, pos +1)
			keys.put (key, pos)
			key.set_parent (Current)
				--| we use `pos'+1 and not `i' because
				--| `i' is not necessary equal to `pos'+1
				--| at the end of the loop.
				--| (if `pos' = `arity', `i' = `pos')
			arity := arity + 1
			if node /= Void then
				keys_plus_one := keys_plus_one + node.keys_plus_one
				node.set_parent (Current)
			end
			if arity > Child_number then
				balance_heavy_node
			else
				rec_update_key_number
			end
		end

	insert_key_and_left_child (key : like item; node: detachable like Current; pos: INTEGER)
			-- insert `key' at position `pos', and `node' at left of `key'
			-- (so `node' will be @`pos')
		local
			i: INTEGER
		do
				--| moving records located after `pos'
			from
				i := arity
			until
				i <= pos
			loop
				children.put (children [i], i+1)
				keys.put (keys [i-1], i)
				i := i - 1
			variant
				i - pos
			end
			children.put (children [pos], pos +1)
			children.put (node, pos)
			keys.put (key, pos)
			key.set_parent (Current)
				--| we use `pos'+1 and not `i' because
				--| `i' is not necessary equal to `pos'+1
				--| at the end of the loop.
				--| (if `pos' = `arity', `i' = `pos')
			arity := arity + 1
			if node /= Void then
				keys_plus_one := keys_plus_one + node.keys_plus_one
				node.set_parent (Current)
			end
			if arity > Child_number then
				balance_heavy_node
			else
				rec_update_key_number
			end
		end

	insert_first (key: like item)
			-- Insert `key' in first position of the tree.
		require
			has_children: not is_leaf implies children [1] /= Void
		local
			l_fisrt: detachable like Current
		do
			if is_leaf then
				insert_key_and_left_child (key, Void, 1)
			else
				l_fisrt := children [1]
				check l_fisrt /= Void end -- Implied by precondition.
				l_fisrt.insert_first (key)
			end
		end

	insert_last (key: like item)
			-- Insert `key' in last position of the tree.
		require
			has_last_item: not is_leaf implies children [arity] /= Void
		local
			l_last: detachable like Current
		do
			if is_leaf then
				insert_key_and_right_child (key, Void, arity)
			else
				l_last := children [arity]
				check l_last_not_void: l_last /= Void end -- Implied by not `is_leaf'.
				l_last.insert_last (key)
			end
		end

feature -- Removal

	delete (pos: INTEGER)
			-- delete key in position `pos' in the node.
		local
			i: INTEGER
			previous_key: detachable like item
			parent_pk: detachable like Current
			l_child: detachable like Current
		do
			if is_leaf then
					--| Children are Void, so they do not ned to be changed:
					--| We move only the keys located after `pos'.
				from
					i := pos
				until
					i >= arity
						--| there are `arity'-1 keys in Current
				loop
					keys.put (keys [i+1], i)
					i := i + 1
				variant
					arity - i
				end
				arity := arity -1
				keys_plus_one := keys_plus_one - 1
				if (arity <3) and (not is_root) then
					balance_light_node
				else
					rec_update_key_number
				end
			else
					--| We cannot move this key directly, so we put the previous key
					--| in his place,and free the previous key's room.
				l_child := children [pos]
				check l_child /= Void end
				previous_key := l_child.last_item
				check previous_key /= Void end
				parent_pk := previous_key.parent
				keys.put (previous_key, pos)
				previous_key.set_parent (Current)
				check parent_pk /= Void end
				parent_pk.delete_key_and_right_child (parent_pk.arity -1)
			end
		end

feature -- Resizing

	Child_number: INTEGER = 5
		-- Maximum number of children
--| FIXME
--| Christophe, 14 jan 2000
--| To incrase efficiency, values calculated from this constant
--| have been hard-coded. So or we "softcode" the algorithms and
--| slow execution (especially for the value 5), or we forget
--| about generalisation.

feature -- Transformation

	balance_heavy_node
			-- rebalance a heavy node (splitting it)
			--| Changes in this feature implementation
			--| may change "merge_left(right)" feature
			--| behaviour. be careful while changing it.
		local
			node2, aux_node: like Current
			parent_key, l_key1, l_key2, l_key4, l_key5: detachable like item
			l_child_1, l_child_2, l_child_3: detachable like Current
			l_parent: like parent
		do
				--| Create the other node and fill it
			create node2.make_with_child (children [4])
			l_key4 := keys [4]
			l_key5 := keys [5]
			check l_key4 /= Void end
			check l_key5 /= Void end
			node2.insert_key_and_right_child (l_key4, children [5], 1)
			node2.insert_key_and_right_child (l_key5, children [6], 2)

			parent_key := keys [3]
			check parent_key /= Void end

			if is_root then
					--| Current is root, so we have to create a third node.
					--| Current must remain root, because other objects may
					--| be referencing it.
				create aux_node.make_with_child (children [1])
				l_key1 := keys [1]
				l_key2 := keys [2]
				check l_key1 /= Void end
				check l_key2 /= Void end
				aux_node.insert_key_and_right_child (l_key1, children [2], 1)
				aux_node.insert_key_and_right_child (l_key2, children [3], 2)

				make_with_child (aux_node)
				insert_key_and_right_child (parent_key, node2, 1)
			else
					--| Erase entries in surplus.
				keys.put (Void, 3)
				keys.put (Void, 4)
				keys.put (Void, 5)
				children.put (Void, 4)
				children.put (Void, 5)
				children.put (Void, 6)
				arity := 3
				if is_leaf then
					keys_plus_one := 3
				else
					l_child_1 := children [1]
					l_child_2 := children [2]
					l_child_3 := children [3]
					check l_child_1 /= Void and then l_child_2 /= Void and then l_child_3 /= Void end
					keys_plus_one := l_child_1.keys_plus_one
						+ l_child_2.keys_plus_one
						+ l_child_3.keys_plus_one
				end
				l_parent := parent
				check l_parent /= Void end -- Implied by not `is_root'.
				l_parent.insert_key_and_right_child (parent_key, node2, pos_in_parent)
			end
		end

	balance_light_root
			-- Rebalance the root node by merging it with its children.
		require
			Current_is_root: is_root
			several_level_tree: not is_leaf
			node_and_children_can_merge: (arity < 3) and then
							(attached children.item (1) as l_chi_1 and then attached children.item (2) as l_chi_2
							 and then (l_chi_1.arity + l_chi_2.arity < 6))

		local
			parent_key: detachable like item
			key1, key2: detachable like item
		do
				--| Copy old root contents.
				--| Root has two children only, otherwise
				--| no merging would have been compulsory.
			parent_key := keys [1]
			check parent_key /= Void end
			check attached children.item (1) as node1 and attached children.item (2) as node2 then
					--| Write first child contents.
				make_with_child (node1.children [1])
				key1 := node1.keys [1]
				check key1 /= Void end
				insert_key_and_right_child (key1, node1.children [2], arity)
				if node1.arity > 2 then
					key2 := node1.keys [2]
					check key2 /= Void end
					insert_key_and_right_child (key2, node1.children [3], arity)
				end
					--| Write second child contents.
				insert_key_and_right_child (parent_key, node2.children [1], arity)
				key1 := node2.keys [1]
				check key1 /= Void end
				insert_key_and_right_child (key1, node2.children [2], arity)
				if node2.arity > 2 then
					key2 := node2.keys [2]
					check key2 /= Void end
					insert_key_and_right_child (key2, node2.children [3], arity)
				end
			end
		end

	balance_light_node
			-- rebalance a light node (by key migration or merging)
		local
			parent_key, aux_key: detachable like item
			aux_node: detachable like Current
			i: INTEGER
			l_parent: like parent
			l_key1: detachable like item
		do
			if is_root then
				check
					one_level_tree: is_leaf
				end
			else
				l_parent := parent
				check l_parent /= Void end -- Implied by not `is_root'
				i := pos_in_parent
				if i > 1 then
						--| Get previous node (at same level),
						--| and key in parent between it and Current.
					aux_node := l_parent.children [i - 1]
					check aux_node /= Void end -- Implied by "i > 1"
					parent_key := l_parent.keys [i - 1]
					check parent_key /= Void end -- Implied by "i > 1"
					if aux_node.arity > 3 then
							--| Many childs? Take one of them.
						insert_key_and_left_child (parent_key, aux_node.children [aux_node.arity], 1)

						aux_key := aux_node.keys [aux_node.arity - 1]
						check aux_key /= Void end -- Implied by `aux_node.arity > 3'
						l_parent.keys.put (aux_key, i - 1)
						aux_key.set_parent (parent)

						aux_node.delete_key_and_right_child (aux_node.arity - 1)
					else
							--| Few childs? Merge the nodes.
						if l_parent.is_root and l_parent.arity = 2 then
							l_parent.balance_light_root
						else
							l_key1 := keys [1]
							check l_key1 /= Void end
							aux_node.insert_key_and_right_child (parent_key, children [1], aux_node.arity)
							aux_node.insert_key_and_right_child (l_key1, children [2], aux_node.arity)
							l_parent.delete_key_and_right_child (i - 1)
						end
					end
				elseif i < l_parent.arity then
						--| Get next node (at same level).
						--| and key in parent between it and Current.
					aux_node := l_parent.children [i+1]
					check aux_node /= Void end -- The algerithm implies there must be the next node.
					parent_key := l_parent.keys [i]
					check parent_key /= Void end -- The algerithm implies there must be a corresponding key.
					if aux_node.arity > 3 then
							--| Many childs? Take one of them.
						insert_key_and_right_child (parent_key, aux_node.children [1], arity)

						aux_key := aux_node.keys [1]
						check aux_key /= Void end -- Implied by `aux_node.arity > 3'
						l_parent.keys.put (aux_key, i)
						aux_key.set_parent (l_parent)

						aux_node.delete_key_and_left_child (1)
					else
							--| Few childs? Merge the nodes.
						if l_parent.is_root and l_parent.arity = 2 then
							l_parent.balance_light_root
						else
							l_key1 := keys [1]
							check l_key1 /= Void end
							aux_node.insert_key_and_left_child (parent_key, children [2], 1)
							aux_node.insert_key_and_left_child (l_key1, children [1], 1)
							l_parent.delete_key_and_left_child (i)
						end
					end
				else
					check
						never_reach: false
					end
				end
			end
		end

feature -- Conversion

--| FIXME
--| christophe, 25 jan 2000
--| This features cannot work, because of changes during rebalancing nodes.

	merge_right (other: like Current)
			-- Add `other' at the right of Current.
		require
			other_not_void: other /= Void
			other_has_children: children.valid_index (1)
		local
			dummy: like item
			current_node: detachable like Current
			child: detachable like Current
			pos: INTEGER
			i: INTEGER
			l_key: detachable like item
		do
			create dummy.make (({G}).default)
			child := other.children [1]
			check child /= Void end -- Implied by precondition
			insert_key_and_right_child (dummy, child, arity)
			from
				i := 1
				current_node := child.parent
				check current_node /= Void end -- Children are never a root.
				pos := child.pos_in_parent
			until
				i = other.arity
			loop
				child := other.children [i + 1]
				check child /= Void end -- Children in range should never be void
				l_key := other.keys [i]
				check l_key /= Void end -- keys in range should never be void.
				check current_node /= Void end -- Should never reach a root, otherwise implies a bug.
				current_node.insert_key_and_right_child (l_key, child, pos)
					--| Node organisation may have changed if `current_node'
					--| has been split due to rebalancing. We are looking for the
					--| place the last child inserted is, to attach others after it.
				current_node := child.parent
				pos := child.pos_in_parent
				i := i + 1
			variant
				other.arity - i
			end
			dummy.delete
		end

	merge_left (other: like Current)
			-- Add `other' at the left of Current.
		local
			dummy: like item
			current_node: detachable like Current
			child: detachable like Current
			pos: INTEGER
			i: INTEGER
			l_key: detachable like item
		do
			create dummy.make (({G}).default)
			child := other.children [arity]
			check child /= Void end
			insert_key_and_left_child (dummy, child, 1)
			from
				i := other.arity - 1
				current_node := child.parent
				pos := child.pos_in_parent
			until
				i = 0
			loop
				child := other.children [i]
				check child /= Void end
				l_key := other.keys [i]
				check l_key /= Void end
				insert_key_and_left_child (l_key, child, pos)
				current_node := child.parent
				pos := child.pos_in_parent
				i := i - 1
			variant
				i
			end
			dummy.delete
		end

feature {TREE_NODE} -- Implementation

	delete_key_and_right_child (pos: INTEGER)
			-- delete key in position `pos', and its
			-- right child (position `pos'+1)
		local
			i: INTEGER
		do
				--| Relocate children and keys after `pos'
			from
				i := pos
			until
				i >= arity
					--| there are `arity'-1 keys in Current
			loop
				keys.put (keys [i+1], i)
				children.put (children [i+2], i+1)
				i := i + 1
			variant
				arity - i
			end
			arity := arity -1
			keys_plus_one := keys_plus_one - 2
				--| Works because deleted child has 1 key.
			if (arity < 3) and (not is_root) then
				balance_light_node
			else
				rec_update_key_number
			end
		end

	delete_key_and_left_child (pos: INTEGER)
			-- delete key in position `pos', and its
			-- left child (position `pos')
		do
			children.put (children [pos + 1], pos)
			delete_key_and_right_child (pos)
		end

	rec_update_key_number
			-- update `key_number_plus_one' and
			-- propagate update to `parent', if not root.
		local
			i: INTEGER
			l_child: detachable like Current
			l_parent: like parent
		do
			if is_leaf then
				keys_plus_one := arity
			else
				from
					i := 2
					l_child := children [1]
					check l_child /= Void end
					keys_plus_one := l_child.keys_plus_one
				until
					i > arity
				loop
					l_child := children [i]
					check l_child /= Void end
					keys_plus_one := keys_plus_one + l_child.keys_plus_one
					i := i + 1
				variant
					arity - i + 1
				end
			end
			if not is_root then
				l_parent := parent
				check l_parent /= Void end -- Implied by not `is_root'
				l_parent.rec_update_key_number
			end
		end
invariant

--| FIXME
--| Christophe, 14 jan 2000
--| Invariants to declare are "for all x in children and keys, x.parent = Current"
--| It is possible they cause a failure due to current implementation.
--| It is not sure this can be fixed easily.
--| Anyway, it would slow down execution

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
