indexing
	description: "[
				Binary search trees; left child item is less than current item,
				right child item is greater
			  ]"
	external_name: "ISE.Base.BinarySearchTree"

class 
	BINARY_SEARCH_TREE [G -> ICOMPARABLE] 

inherit

	BINARY_TREE [G]
		rename
			make as bt_make,
			put as bt_put
		export {BINARY_SEARCH_TREE}
			put_left_child, put_right_child,
			remove_left_child, remove_right_child
		redefine
			parent, internal_parent, has,
			child, first_child, last_child,
			left_child, right_child,
			left_sibling, right_sibling,
			is_sibling, put_child, put_left_child,
			put_right_child, replace_child, prune,
			attach_to_parent, new_tree, child_put,
			child_replace, duplicate, duplicate_all
		end

create

	make

feature -- Initialization

	make (v: G) is
		indexing
			description: "Create single node with item `v'."
		do
			bt_make (v)
		ensure
			node_item: item = v
			no_child: (left_child = Void) and (right_child = Void)
		end

feature -- Access

	parent: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Parent of current node"
		do
			Result := internal_parent
		end

 	has (v: G): BOOLEAN is
		indexing
			description: "[
						Does tree contain a node whose item
						is equal to `v' (object comparison)?
					  ]"
		require else
			argument_not_void: v /= Void
		do
			if items_equal (item, v) then
				Result := True
			elseif v < item then
				if left_child /= Void then
					set_comparison_mode (left_child)
					Result := left_child.has (v)
				end
			else
				if right_child /= Void then
					set_comparison_mode (right_child)
					Result := right_child.has (v)
				end
			end
		end

	child: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Child at cursor position"
		do
			inspect
				child_index
			when 1 then
				Result := left_child
			when 2 then
				Result := right_child
			end
		end

	first_child: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Left child"
		do
			Result := left_child
		end

	last_child: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Right child"
		do
			Result := right_child
		end

	left_child: BINARY_SEARCH_TREE [G]
		indexing
			description: "Left child, if any"
		end

	right_child: BINARY_SEARCH_TREE [G]
		indexing
			description: "Right child, if any"
		end

	left_sibling: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Left neighbor, if any"
		do
			if parent.right_child = Current then
				Result := parent.left_child
			end
		end

	right_sibling: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Right neighbor, if any"
		do
			if parent.left_child = Current then
				Result := parent.right_child
			end
		end

feature -- Measurement

	min: G is
		indexing
			description: "Minimum item in tree"
		do
			if has_left then
				Result := left_child.min
			else
				Result := item
			end
		ensure
			minimum_present: has (Result)
			-- smallest: For every item `it' in tree, `Result' <= it
		end

	max: G is
		indexing
			description: "Maximum item in tree"
		do
			if has_right then
				Result := right_child.max
			else
				Result := item
			end
		ensure
			maximum_present: has (Result)
			-- largest: For every item `it' in tree, `it' <= Result
		end

feature -- Status report

	sorted: BOOLEAN is
		indexing
			description: "Is tree sorted?"
		do
			Result := True
			if
				(has_left and then left_item > item)
				or (has_right and then right_item < item)
			then
				Result := False
			else
				if has_left then
					Result := left_child.sorted_and_less (item)
				end
				if has_right and Result then
					Result := right_child.sorted
				end
			end
		end

	sorted_and_less (i: G): BOOLEAN is
		indexing
			description: "Is tree sorted and all its elements less then `i'?"
		do
			Result := True
			if
				(has_left and then left_item > item)
				or (has_right and then right_item < item)
			then
				Result := False
			else
				if has_left then
					Result := left_child.sorted_and_less (item)
				end
				if has_right and Result then
					Result := right_child.sorted_and_less (i)
				end
			end
		end

	is_sibling (other: BINARY_SEARCH_TREE [G]): BOOLEAN is
		indexing
			description: "Are current node and `other' siblings?"
		do
			Result := not is_root and other.parent = parent
		end

feature -- Cursor movement

	node_action (v: G) is
		indexing
			description: "[
						Operation on node item,
						to be defined by descendant classes.
						Here it is defined as an empty operation.
						Redefine this procedure in descendant classes if useful
						operations are to be performed during traversals.
					  ]"
		do
		end

	preorder is
		indexing
			description: "Apply `node_action' to every node's item in tree, using pre-order."
		do
			node_action (item)
			if left_child /= Void then
				left_child.preorder
			end
			if right_child /= Void then
				right_child.preorder
			end
		end

	i_infix is
		indexing
			description: "Apply node_action to every node's item in tree, using infix order."
		do
			if left_child /= Void then
				left_child.i_infix
			end
			node_action (item)
			if right_child /= Void then
				right_child.i_infix
			end
		end

	postorder is
		indexing
			description: "Apply node_action to every node's item in tree, using post-order."
		do
			if left_child /= Void then
				left_child.postorder
			end
			if right_child /= Void then
				right_child.postorder
			end
			node_action (item)
		end

feature -- Element change

	put (v: G) is
		indexing
			description: "[
						Put `v' at proper position in tree
						(unless `v' exists already).
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		require
			new_item_exists: v /= Void
		do
			if not items_equal (v, item) then
				if v < item then
					if left_child = Void then
						put_left_child (new_tree)
						left_child.replace (v)
					else
						left_child.put (v)
					end
				else
					if right_child = Void then
						put_right_child (new_tree)
						right_child.replace (v)
					else
						right_child.put (v)
					end
				end
			end
		ensure
			item_inserted: has (v)
		end

	extend (v: G) is
		indexing
			description: "[
						Put `v' at proper position in tree
						(unless `v' exists already).
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		require
			new_item_exists: v /= Void
		do
			if not items_equal (v, item) then
				if v < item then
					if left_child = Void then
						put_left_child (new_tree)
						left_child.replace (v)
					else
						left_child.put (v)
					end
				else
					if right_child = Void then
						put_right_child (new_tree)
						right_child.replace (v)
					else
						right_child.put (v)
					end
				end
			end
		ensure
			item_inserted: has (v)
		end
		
	put_left_child (n: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Set `left_child' to `n'."
		do
			if n /= Void then
				if object_comparison then
					n.compare_objects
				else
					n.compare_references
				end
			end
			if left_child /= Void then
				left_child.attach_to_parent (Void)
			end
			if n /= Void then
				n.attach_to_parent (Current)
			end
			left_child := n
		end

	put_right_child (n: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Set `right_child' to `n'."
		do
			if n /= Void then
				if object_comparison then
					n.compare_objects
				else
					n.compare_references
				end
			end
			if right_child /= Void then
				right_child.attach_to_parent (Void)
			end
			if n /= Void then
				n.attach_to_parent (Current)
			end
			right_child := n
		end

	child_put (v: G) is
		indexing
			description: "Put `v' at current child position."
		local
			node: BINARY_SEARCH_TREE [G]
		do
			if child /= Void then
				if object_comparison then
					child.compare_objects
				else
					child.compare_references
				end
				child.put (v)
			else
				create node.make (v)
				if object_comparison then
					node.compare_objects
				end
				put_child (node)
			end
		end

	child_replace (v: G) is
		indexing
			description: "Put `v' at current child position."
		local
			node: BINARY_SEARCH_TREE [G]
		do
			if child /= Void then
				if object_comparison then
					child.compare_objects
				else
					child.compare_references
				end
				child.put (v)
			else
				create node.make (v)
				if object_comparison then
					node.compare_objects
				end
				put_child (node)
			end
		end
		
	put_child (n: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Put `n' at current child position."
		do
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			n.attach_to_parent (Current)
			inspect
				child_index
			when 1 then
				left_child := n
			when 2 then
				right_child := n
			end
		end

	replace_child (n: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Put `n' at current child position."
		do
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			n.attach_to_parent (Current)
			inspect
				child_index
			when 1 then
				left_child := n
			when 2 then
				right_child := n
			end
		end

	prune (n: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "If `n' is a child of Current, prune it."
		do
			if left_child = n then
				remove_left_child
			elseif right_child = n then
				remove_right_child
			end
		end

feature -- Duplication

	duplicate (n: INTEGER): BINARY_SEARCH_TREE [G] is
		indexing
			description: "[
						Copy of sub-tree beginning at cursor position and
						having min (`n', `arity' - `child_index' + 1)
						children.
					  ]"
		do
			Result := new_tree
			if child_index <= 1 and child_index + n >= 1 and has_left then
				Result.put_left_child (left_child.duplicate_all)
			end
			if child_index <= 2 and child_index + n >= 2 and has_right then
				Result.put_right_child (right_child.duplicate_all)
			end
		end

	duplicate_all: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Duplicate Current and all its children."
		do
			Result := new_tree
			if has_left then
				Result.put_left_child (left_child.duplicate_all)
			end
			if has_right then
				Result.put_right_child (right_child.duplicate_all)
			end
		end
		
feature -- Transformation

	sort is
			--| Uses heapsort.
			--| The reason for the `external sort' is that
			--| the insertion order in the tree will ensure
			--| it is balanced
		indexing
			description: "Sort tree."
		local
			seq: LINEAR [G]
			temp: ARRAY [G]
			list: SYSTEM_COLLECTIONS_ARRAYLIST
			i, ind: INTEGER
			obj: G
		do
			seq := linear_representation
			i := count
			remove_left_child
			remove_right_child
			from
				seq.start
				create list.make_1 (i)
			until
				seq.off
			loop
				ind := list.extend (seq.item)
				seq.forth
			end
			list.sort
			from
				create temp.make (list.get_count)
				i := 0
			until
				i > list.get_count
			loop
				obj ?= list.get_item (i)
				temp.put (i, obj)
				i := i + 1
			end
			replace (temp.item ((temp.count) // 2 + 1))
			fill_from_sorted_special (temp, 0, temp.count - 1)
		ensure
			is_sorted: sorted
		end

feature {BINARY_SEARCH_TREE, BINARY_SEARCH_TREE_SET} -- Implementation

	is_subset (other: BINARY_SEARCH_TREE [G]): BOOLEAN is
		indexing
			description: "Is Current a subset of other?"
		do
			Result := other.has (item)
			if Result and left_child /= Void then
				Result := left_child.is_subset (other)
			end
			if Result and right_child /= Void then
				Result := right_child.is_subset (other)
			end
		end

	intersect (other: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Remove all items not in `other'."
		do
			if right_child /= Void then
				right_child.intersect (other)
			end
			if left_child /= Void then
				left_child.intersect (other)
			end
			if not other.has (item) then
				remove_node
			end
		end

	subtract (other: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Remove all items also in `other'."
		require
			set_exists: other /= Void
		do
			if right_child /= Void then
				right_child.subtract (other)
			end
			if left_child /= Void then
				left_child.subtract (other)
			end
			if other.has (item) then
				remove_node
			end
		end

	merge (other: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Add all items of `other'."
		do
			if other.right_child /= Void then
				merge (other.right_child)
			end
			if other.left_child /= Void then
				merge (other.left_child)
			end
			extend (other.item)
		end

	remove_node is
		indexing
			description: "Remove current node from the tree."
		require
			is_not_root: not is_root
		local
			is_left_child: BOOLEAN
			m: BINARY_SEARCH_TREE [G]
		do
			is_left_child := Current = parent.left_child
			if not has_right then
				if left_child /= Void then
					left_child.attach_to_parent (Void)
				end
				if is_left_child then
					parent.put_left_child (left_child)
				else
					parent.put_right_child (left_child)
				end
				internal_parent := Void
			elseif not has_left then
				if right_child /= Void then
					right_child.attach_to_parent (Void)
				end
				if is_left_child then
					parent.put_left_child (right_child)
				else
					parent.put_right_child (right_child)
				end
				internal_parent := Void
			else
				m := right_child.min_node
				m.remove_node
				internal_item := m.item
			end
		end

	pruned (v: G; par: BINARY_SEARCH_TREE [G]): BINARY_SEARCH_TREE [G] is
		indexing
			description: "[
						Prune `v'.
						(`par' is the parent node of the current node, needed to update
						`parent' correctly.)
					  ]"
		local
			m: BINARY_SEARCH_TREE [G]
		do
			if items_equal (item, v) then
				if has_none then
					-- Do nothing: Void Result
				elseif not has_right then
					left_child.attach_to_parent (par)
					Result := left_child
				elseif not has_left then
					right_child.attach_to_parent (par)
					Result := right_child
				else
					m := right_child.min_node
					m.remove_node
					internal_item := m.item
					Result := Current
				end
			else
				Result := Current
				if v < item then
					if left_child /= Void then
						left_child := left_child.pruned (v, Current)
					end
				else
					if right_child /= Void then
						right_child := right_child.pruned (v, Current)
					end
				end
			end
		end

	min_node: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Node containing min"
		do
			if has_left then
				Result := left_child.min_node
			else
				Result := Current
			end
		end

	max_node: BINARY_SEARCH_TREE [G] is
		indexing
			description: "Node containing max"
		do
			if has_right then
				Result := right_child.min_node
			else
				Result := Current
			end
		end

feature {TREE} -- Implementation

	attach_to_parent (n: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Make `n' parent of current node."
		do
			internal_parent := n
		end

feature {NONE} -- Implementation

	fill_from_sorted_special (t: ARRAY [G]; s, e: INTEGER) is
		indexing
			description: "[
						Put values from `t' into tree in such an order that
						the tree will be balanced if `t' is sorted.
					  ]"
		local
			m : INTEGER
		do
			m := (s + e) // 2
			put (t.item (m))
			if m - 1 >= s then
				fill_from_sorted_special (t, s, m - 1)
			end
			if m + 1 <= e then
				fill_from_sorted_special (t, m + 1, e)
			end
		end

	items_equal (src, dest: G): BOOLEAN is
		indexing
			description: "[
						Are `src' and `dest' equal?
						(depending on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		local
			a: ANY
		do
			if object_comparison then
				a := src
				Result := a /= Void and then a.is_equal (dest)
			else
				Result := src = dest
			end
		end

	set_comparison_mode (t: BINARY_SEARCH_TREE [G]) is
		indexing
			description: "Set comparison mode of `t' to the same mode as `Current'."
		require
			not_void: t /= Void
		do
			if object_comparison then
				t.compare_objects
			else
				t.compare_references
			end
		ensure
			mode_set: object_comparison = t.object_comparison
		end
		
feature {NONE} -- Implementation

	new_tree: BINARY_SEARCH_TREE [G] is
		indexing
			description: "New tree node"
		do
			create Result.make (item)
			if object_comparison then
				Result.compare_objects
			end
		end

	internal_parent:  BINARY_SEARCH_TREE [G]

end -- class BINARY_SEARCH_TREE


