indexing
	description: "Tree Node for a 2-3-4 balanced tree"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_NODE [G]

create
	make, make_with_child

feature -- Initialization

	make is
			-- Initialize as a blank tree.
		do
			create children.make (1, Child_number +1)
			create keys.make (1, Child_number)
			children.put (Void, 1)
			arity := 1			
			keys_plus_one := 1		
		end

	make_with_child (first_child: like Current) is
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

	parent: like Current
		-- parent of Current
		-- Void if Current is a root.

	children: ARRAY [like Current]
		-- children of Current

	keys: ARRAY [like item]
		-- keys contained by Current

	item (i: INTEGER): TREE_KEY [G] is
			-- `i'th key of the tree, if Current was the root node.
		require
			i_big_enough: i >= 1
			i_small_enough: i < keys_plus_one
		local
			pos : INTEGER
				-- Number of keys until the one we seek.
			aux, k: INTEGER
			bool: BOOLEAN
		do
			if is_leaf then
				Result := keys @ i
			else
				from
					k := 1
					pos := i
				invariant
					non_overflow: k <= arity
				until
					bool
				loop
					aux := pos - (children @ k).keys_plus_one
					if aux > 0 then
							--| The key isn't in child `k'.
						pos := aux
						k := k + 1
						bool := (k > arity)
						check
							research_always_successful: not (bool)
						end
					elseif aux < 0 then
							--| The key is in child `k'.
						bool := True
						Result := (children @ k).item (pos)
					else
							--| We found the key.
						bool := True
						Result := keys @ k
					end
				end
			end
		ensure
			final_Result_good: is_root implies (Result.number = i)
		end

	first_item: like item is
			-- first key of a tree
			-- goes much faster than "item (1)"
		do
			if is_leaf then
				Result := keys @ 1
			else
				Result := (children @ 1).first_item
			end
		end

	last_item: like item is
			-- last key of a tree
			-- goes much faster than "item (keys_plus_one - 1)"
		do
			if is_leaf then
				Result := keys @ (arity - 1)
			else
				Result := (children @ arity).last_item
			end
		end

feature -- Measurement

	arity: INTEGER
			-- Number of children

	keys_plus_one: INTEGER
			-- total number of keys of the node
			-- and its chilren, plus one

feature -- Status report

	is_root: BOOLEAN is
			-- Is Current the root node of the tree?
		do
			Result := (parent = Void)
		end

	is_leaf: BOOLEAN is
			-- Is Current a leaf?
		do
			Result := (children @ 1 = Void)
		end

	pos_in_parent: INTEGER is
			-- position of node in parent.
		require
			has_a_parent: not is_root
		local
			ch: like children
		do
			from
				ch := parent.children
				Result := 1
			variant
				parent.arity - Result
			until
				ch @ Result = Current
			loop
				Result := Result + 1
				check
					no_overflow: Result <= parent.arity
				end
			end			
		end
--| FIXME
--| Christophe, 14 jan 2000
--| Should we implement it as an attribute or as a function?


	keys_before_child (i: INTEGER): INTEGER is
			-- Number of keys in the tree before child number `i'
		local
			j: INTEGER
		do
			if is_root then
				Result := 0
			else
				Result := parent.keys_before_child (pos_in_parent)
			end
			if is_leaf then
				Result := Result + i - 1
			else
				from
					j:= 1
				variant
					i - j
				until
					j >= i
				loop
					Result := Result + (children @ j).keys_plus_one
					j := j + 1
				end
			end
		end

feature {TREE_NODE} -- Status report

--	key_number_not_to_be_updated: BOOLEAN
		-- Do we have to update the `keys_plus_one'
		-- by using `rec_update_key_number', or is
		-- it a waste of time as it has to be done
		-- later on the algorithm?
		--| False by default.

feature {TREE_NODE} -- Status setting

--	set_key_number_update_flag (b: BOOLEAN) is
			-- make `b' the value of
			-- `key_number_not_to_be_updated'
--		do
--			key_number_not_to_be_updated := b
--		end

feature -- Cursor movement

feature -- Element change

	set_parent (par: like Current) is
			-- make `par' the parent of Current
		do
			parent := par
		end

	insert_key_and_right_child (key : like item; node: like Current; pos: INTEGER) is
			-- insert `key' at position `pos', and `node' at right of `key'
			-- (so `node' will be @`pos'+1)
		local
			i: INTEGER
		do
				--| moving records located after `pos'
			from
				i := arity
			variant
				i - pos
			until
				i <= pos
			loop
				children.put (children @ i, i+1)	
				keys.put (keys @ (i-1), i)
				i := i - 1	
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

	insert_key_and_left_child (key : like item; node: like Current; pos: INTEGER) is
			-- insert `key' at position `pos', and `node' at left of `key'
			-- (so `node' will be @`pos')
		local
			i: INTEGER
		do
				--| moving records located after `pos'
			from
				i := arity
			variant
				i - pos
			until
				i <= pos
			loop
				children.put (children @ i, i+1)	
				keys.put (keys @ (i-1), i)
				i := i - 1	
			end
			children.put (children @ pos, pos +1)
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

	insert_first (key: like item) is
			-- Insert `key' in first position of the tree.
		do
			if is_leaf then
				insert_key_and_left_child (key, Void, 1)
			else
				children.item (1).insert_first (key)
			end
		end

	insert_last (key: like item) is
			-- Insert `key' in last position of the tree.
		do
			if is_leaf then
				insert_key_and_right_child (key, Void, arity)
			else
				children.item (arity).insert_last (key)
			end
		end

feature -- Removal

	delete (pos: INTEGER) is
			-- delete key in position `pos' in the node.
		local
			i: INTEGER
			previous_key: like item
			parent_pk: like Current
		do
			if is_leaf then
					--| Children are Void, so they do not ned to be changed:
					--| We move only the keys located after `pos'.
				from
					i := pos
				variant
					arity - i
				until
					i >= arity
						--| there are `arity'-1 keys in Current
				loop
					keys.put (keys @ (i+1), i)
					i := i + 1
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
				previous_key := (children @ pos).last_item
				parent_pk := previous_key.parent
				keys.put (previous_key, pos)
				previous_key.set_parent (Current)
				parent_pk.delete_key_and_right_child (parent_pk.arity -1)
			end
		end
				
feature -- Resizing

	Child_number: INTEGER is 5
		-- Maximum number of children
--| FIXME
--| Christophe, 14 jan 2000
--| To incrase efficiency, values calculated from this constant
--| have been hard-coded. So or we "softcode" the algorithms and
--| slow execution (especially for the value 5), or we forget
--| about generalisation.

feature -- Transformation

	balance_heavy_node is
			-- rebalance a heavy node (splitting it)
			--| Changes in this feature implementation
			--| may change "merge_left(right)" feature
			--| behaviour. be careful while changing it.
		local
			node2, aux_node: like Current
			parent_key: like item
		do
				--| Create the other node and fill it
			create node2.make_with_child (children @ 4)
			node2.insert_key_and_right_child (keys @ 4, children @ 5, 1)
			node2.insert_key_and_right_child (keys @ 5, children @ 6, 2)

			parent_key := keys @ 3

			if is_root then
					--| Current is root, so we have to create a third node.
					--| Current must remain root, because other objects may
					--| be referencing it.
				create aux_node.make_with_child (children @ 1)
				aux_node.insert_key_and_right_child (keys @ 1, children @ 2, 1)
				aux_node.insert_key_and_right_child (keys @ 2, children @ 3, 2)
				
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
					keys_plus_one := (children @ 1).keys_plus_one
						+ (children @ 2).keys_plus_one
						+ (children @ 3).keys_plus_one
				end
				parent.insert_key_and_right_child (parent_key, node2, pos_in_parent)
			end
		end		

	balance_light_root is
			-- Rebalance the root node by merging it with its children.
		require
			Current_is_root: is_root
			several_level_tree: not is_leaf
			node_and_children_can_merge: (arity < 3) and then ((children @ 1).arity + (children @ 2).arity < 6)
		local
			parent_key: like item
			node1, node2: like current
		do
				--| Copy old root contents.
				--| Root has two children only, otherwise
				--| no merging would have been compulsory.
			parent_key := keys @ 1
			node1 := children @ 1
			node2 := children @ 2
				--| Write first child contents.
			make_with_child (node1.children @ 1)
			insert_key_and_right_child (node1.keys @ 1, node1.children @ 2, arity)
			if node1.arity > 2 then
				insert_key_and_right_child (node1.keys @ 2, node1.children @ 3, arity)
			end
				--| Write second child contents.
			insert_key_and_right_child (parent_key, node2.children @ 1, arity)
			insert_key_and_right_child (node2.keys @ 1, node2.children @ 2, arity)
			if node2.arity > 2 then
				insert_key_and_right_child (node2.keys @ 2, node2.children @ 3, arity)
			end
		end

	balance_light_node is
			-- rebalance a light node (by key migration or merging)
		require
		local
			parent_key, aux_key: like item
			aux_node: like Current
			i: INTEGER
		do
			if is_root then
				check
					one_level_tree: is_leaf
				end
			else
				i := pos_in_parent
				if i > 1 then
						--| Get previous node (at same level),
						--| and key in parent between it and Current.
					aux_node := parent.children @ (i - 1)
					parent_key := parent.keys @ (i - 1)
					if aux_node.arity > 3 then
							--| Many childs? Take one of them.
						insert_key_and_left_child (parent_key, aux_node.children @ (aux_node.arity), 1)

						aux_key := aux_node.keys @ (aux_node.arity - 1)
						parent.keys.put (aux_key, i - 1)
						aux_key.set_parent (parent)

						aux_node.delete_key_and_right_child (aux_node.arity - 1)
					else
							--| Few childs? Merge the nodes.
						if parent.is_root and parent.arity = 2 then
							parent.balance_light_root
						else
							aux_node.insert_key_and_right_child (parent_key, children @ 1, aux_node.arity)
							aux_node.insert_key_and_right_child (keys @ 1, children @ 2, aux_node.arity)
							parent.delete_key_and_right_child (i - 1)
						end
					end
				elseif i < parent.arity then
						--| Get next node (at same level).
						--| and key in parent between it and Current.
					aux_node := parent.children @ (i+1)
					parent_key := parent.keys @ (i)
					if aux_node.arity > 3 then
							--| Many childs? Take one of them.
						insert_key_and_right_child (parent_key, aux_node.children @ 1, arity)

						aux_key := aux_node.keys @ 1
						parent.keys.put (aux_key, i)
						aux_key.set_parent (parent)

						aux_node.delete_key_and_left_child (1)
					else
							--| Few childs? Merge the nodes.
						if parent.is_root and parent.arity = 2 then
							parent.balance_light_root
						else
							aux_node.insert_key_and_left_child (parent_key, children @ 2, 1)
							aux_node.insert_key_and_left_child (keys @ 1, children @ 1, 1)
							parent.delete_key_and_left_child (i)
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

	merge_right (other: like Current) is
			-- Add `other' at the right of Current.
		local
			dummy		: like item
			current_node: like Current
			child		: like Current
			pos			: INTEGER
			i			: INTEGER
		do
			create dummy.make (Void)
			child := other.children @ 1
			insert_key_and_right_child (dummy, child, arity)
			from
				i := 1
				current_node := child.parent
				pos := child.pos_in_parent
			variant
				other.arity - i
			until
				i = other.arity
			loop
				child := other.children @ (i + 1)
				current_node.insert_key_and_right_child (other.keys @ i, child, pos)
					--| Node organisation may have changed if `current_node'
					--| has been split due to rebalancing. We are looking for the
					--| place the last child inserted is, to attach others after it.
				current_node := child.parent
				pos := child.pos_in_parent
				i := i + 1
			end
			dummy.delete
		end

	merge_left (other: like Current) is
			-- Add `other' at the left of Current.
		local
			dummy		: like item
			current_node: like Current
			child		: like Current
			pos			: INTEGER
			i			: INTEGER
		do
			create dummy.make (Void)
			child := other.children @ arity
			insert_key_and_left_child (dummy, child, 1)
			from
				i := other.arity - 1
				current_node := child.parent
				pos := child.pos_in_parent
			variant
				i
			until
				i = 0
			loop
				child := other.children @ i
				insert_key_and_left_child (other.keys @ i, child, pos)
				current_node := child.parent
				pos := child.pos_in_parent
				i := i - 1
			end
			dummy.delete
		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {TREE_NODE} -- Implementation

	delete_key_and_right_child (pos: INTEGER) is
			-- delete key in position `pos', and its
			-- right child (position `pos'+1)
		local
			i: INTEGER
		do
				--| Relocate children and keys after `pos'
			from
				i := pos
			variant
				arity - i
			until
				i >= arity
					--| there are `arity'-1 keys in Current
			loop
				keys.put (keys @ (i+1), i)
				children.put (children @ (i+2), i+1)
				i := i + 1
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

	delete_key_and_left_child (pos: INTEGER) is
			-- delete key in position `pos', and its
			-- left child (position `pos')
		do
			children.put (children @ (pos + 1), pos)
			delete_key_and_right_child (pos)
		end

	rec_update_key_number is
			-- update `key_number_plus_one' and
			-- propagate update to `parent', if not root.
		local
			i : INTEGER
		do
			if is_leaf then
				keys_plus_one := arity
			else
				from
					i := 2
					keys_plus_one := (children @ 1).keys_plus_one
				variant
					arity - i + 1
				until
					i > arity
				loop
					keys_plus_one := keys_plus_one + (children @ i).keys_plus_one
					i := i + 1
				end
			end
			if (not is_root) then
				parent.rec_update_key_number
			end
		end
invariant

--| FIXME
--| Christophe, 14 jan 2000
--| Invariants to declare are "for all x in children and keys, x.parent = Current"
--| It is possible they cause a failure due to current implementation.
--| It is not sure this can be fixed easily.
--| Anyway, it would slow down execution

end -- class TREE_NODE
