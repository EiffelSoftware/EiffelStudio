indexing
	description: "Binary tree: each node may have a left child and a right child"
	external_name: "ISE.Base.BinaryTree"

class 
	BINARY_TREE [G] 

inherit

		CELL [G]

		TREE [G]

create

	make

feature -- Initialization

	make (v: G) is
		indexing
			description: "Create a root node with value `v'."
		do
			internal_item := v
		ensure
			is_root
			is_leaf
		end

feature -- Access

	parent: BINARY_TREE [G] is
		indexing
			description: "Parent of current node"
		do
			Result := internal_parent
		end

	child_item: G is
		indexing
			description: "Item in current child node"
		do
			Result := child.item
		end

	child_index: INTEGER is
		indexing
			description: "Index of cursor position"
		do
			Result := internal_child_index
		end

	left_child: BINARY_TREE [G]
		indexing
			description: "Left child, if any"
		end
		
	right_child: BINARY_TREE [G]
		indexing
			description: "Right child, if any"
		end

	left_item: G is
		indexing
			description: "Value of left child"
		require
			has_left: left_child /= Void
		do
			Result := left_child.item
		end

	right_item: G is
		indexing
			description: "Value of right child"
		require
			has_right: right_child /= Void
		do
			Result := right_child.item
		end

	first_child: BINARY_TREE [G] is
		indexing
			description: "Left child"
		do
			Result := left_child
		end

	last_child: BINARY_TREE [G] is
		indexing
			description: "Right child"
		do
			Result := right_child
		end

	child: BINARY_TREE [G] is
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

	child_cursor: CURSOR is
		indexing
			description: "Current cursor position"
		do
			create {ARRAYED_LIST_CURSOR} Result.make (child_index)
		end

	left_sibling: BINARY_TREE [G] is
		indexing
			description: "Left neighbor, if any"
		do
			if parent.right_child = Current then
				Result := parent.left_child
			end
		end

	right_sibling: BINARY_TREE [G] is
		indexing
			description: "Right neighbor, if any"
		do
			if parent.left_child = Current then
				Result := parent.right_child
			end
		end
		
	has (v: G): BOOLEAN is
		indexing
			description: "[
						Does subtree include `v'?
 						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		local
			a: ANY
		do
			if object_comparison then
				a := v
				Result := (a /= Void) and then (item /= Void) and then (a.is_equal (item) or else subtree_has (v))
			else
				Result := v = item or else subtree_has (v)
			end
		end

	is_sibling (other: BINARY_TREE [G]): BOOLEAN is
		indexing
			description: "Are current node and `other' siblings?"
		do
			Result := not is_root and other.parent = parent
		end

feature -- Status setting

	compare_objects is
		indexing
			description: "[
						Ensure that future search operations will use `equal'
						rather than `=' for comparing references.
					  ]"
		do
			internal_object_comparison := True
		end

	compare_references is
		indexing
			description: "[
						Ensure that future search operations will use `='
						rather than `equal' for comparing references.
					  ]"
		do
			internal_object_comparison := False
		end
	
feature -- Measurement

	arity: INTEGER is
		indexing
			description: "Number of children"
		do
			if has_left then
				Result := Result + 1
			end
			if has_right then
				Result := Result + 1
			end
		ensure then
			valid_arity: Result <= 2
		end

	count: INTEGER is
		indexing
			description: "Number of items"
		do
			Result := subtree_count + 1
		end

feature -- Status report

	readable: BOOLEAN is
		indexing
			description: "Is there a current item to be read?"
		do
			Result := True
		end

	child_readable: BOOLEAN is
		indexing
			description: "Is there a current `child_item' to be read?"
		do
			Result := not child_off and then (child /= Void)
		end

	readable_child: BOOLEAN is
		indexing
			description: "Is there a current child to be read?"
		do
			Result := not child_off
		end

	writable: BOOLEAN is
		indexing
			description: "Is there a current item that may be modified?"
		do
			Result := True
		end

	child_writable: BOOLEAN is
		indexing
			description: "Is there a current `child_item' that may be modified?"
		do
			Result := not child_off and then (child /= Void)
		end
		
	writable_child: BOOLEAN is
		indexing
			description: "Is there a current child that may be modified?"
		do
			Result := not child_off
		end

	child_off: BOOLEAN is
		indexing
			description: "Is there no current child?"
		do
			Result := child_before or child_after
		end

	child_before: BOOLEAN is
		indexing
			description: "Is there no valid child position to the left of cursor?"
		do
			Result := child_index = 0
		end

	child_after: BOOLEAN is
		indexing
			description: "Is there no valid child position to the right of cursor?"
		do
			Result := child_index >= child_capacity + 1
		end

	is_empty: BOOLEAN is
		indexing
			description: "Is structure empty of items?"
		do
			Result := False
		end

	is_leaf: BOOLEAN is
		indexing
			description: "Are there no children?"
		do
			Result := left_child = Void and right_child = Void
		end

	has_none: BOOLEAN is
		indexing
			description: "Are there no children?"
		do
			Result := left_child = Void and right_child = Void
		end
		
	is_root: BOOLEAN is
		indexing
			description: "Is there no parent?"
		do
			Result := parent = Void
		end

	child_isfirst: BOOLEAN is
		indexing
			description: "Is cursor under first child?"
		do
			Result := not is_leaf and child_index = 1
		end

	child_islast: BOOLEAN is
		indexing
			description: "Is cursor under last child?"
		do
			Result := not is_leaf and child_index = child_capacity
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' correctly bounded for cursor movement?"
		do
			Result := (i >= 0) and (i <= child_capacity + 1)
		end

	has_left: BOOLEAN is
		indexing
			description: "Has current node a left child?"
		do
			Result := left_child /= Void
		ensure
			Result = (left_child /= Void)
		end

	has_right: BOOLEAN is
		indexing
			description: "Has current node a right child?"
		do
			Result := right_child /= Void
		ensure
			Result = (right_child /= Void)
		end

	has_both: BOOLEAN is
		indexing
			description: "Has current node two children?"
		do
			Result := left_child /= Void and right_child /= Void
		ensure
			Result = (has_left and has_right)
		end

	object_comparison: BOOLEAN is
		indexing
			description: "[
						Must search operations use `equal' rather than `='
						for comparing references? (Default: no, use `='.)
					  ]"
		do
			Result := internal_object_comparison
		end

	changeable_comparison_criterion: BOOLEAN is
		indexing
			description: "May `object_comparison' be changed? (Answer: yes by default.)"
		do
			Result := True
		end

feature -- Element change

	put_left_child (n: BINARY_TREE [G]) is
		indexing
			description: "Set `left_child' to `n'."
		require
			no_parent: n = Void or else n.is_root
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

	put_right_child (n: BINARY_TREE [G]) is
		indexing
			description: "Set `right_child' to `n'."
		require
			no_parent: n = Void or else n.is_root
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
			node: BINARY_TREE [G]
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
			node: BINARY_TREE [G]
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
		
	put_child (n: BINARY_TREE [G]) is
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

	replace_child (n: BINARY_TREE [G]) is
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
		
feature -- Removal

	sprout is
		indexing
			description: "Make current node a root."
		do
			if parent /= Void then
				parent.prune (Current)
			end
		end

	remove_left_child is
		indexing
			description: "Remove left child."
		do
			if left_child /= Void then
				left_child.attach_to_parent (Void)
			end
			left_child := Void
		ensure
			not has_left
		end

	remove_right_child is
		indexing
			description: "Remove right child."
		do
			if right_child /= Void then
				right_child.attach_to_parent (Void)
			end
			right_child := Void
		ensure
			not has_right
		end

	child_remove is
		do
			inspect
		 		child_index
			when 1 then
				left_child.attach_to_parent (Void)
				left_child := Void
			when 2 then
				right_child.attach_to_parent (Void)
				right_child := Void
			end
		end

	prune (n: BINARY_TREE [G]) is
		do
			if left_child = n then
				remove_left_child
			elseif right_child = n then
				remove_right_child
			end
		end

	fill (other: TREE [G]) is
		indexing
			description: "[
						Fill with as many items of `other' as possible.
						The representations of `other' and current node
						need not be the same.
					  ]"
		do
			replace (other.item)
			fill_subtree (other)
		end

feature -- Conversion

	linear_representation: LINEAR [G] is
		indexing
			description: "Representation as a linear structure"
		local
			al: ARRAYED_LIST [G]
		do
			!! al.make (count)
			al.start
			al.extend (item)
			fill_list (al)
			Result := al
		end

	binary_representation: BINARY_TREE[G] is
		indexing
			description: "[
						Convert to binary tree representation:
						first child becomes left child,
						right sibling becomes right child.
					  ]"
		local
			current_sibling: BINARY_TREE [G]
		do
			create Result.make (item)
			if not is_leaf then
				Result.put_left_child (first_child.binary_representation)
				from
					child_start
					child_forth
					current_sibling := Result.left_child
				until
					child_after
				loop
					current_sibling.put_right_child (child.binary_representation)
					current_sibling := current_sibling.right_child
					child_forth
				end
			end
		end

feature -- Cursor movement

	child_go_to (p: ARRAYED_LIST_CURSOR) is
		indexing
			description: "Move cursor to child remembered by `p'."
		do
			internal_child_index := p.index
		end

	child_start is
		indexing
			description: "Move to first child."
		do
			internal_child_index := 1
		end

	child_finish is
		indexing
			description: "Move cursor to last child."
		do
			internal_child_index := 2
		end

	child_forth is
		indexing
			description: "Move cursor to next child."
		do
			internal_child_index := child_index + 1
		end

	child_back is
		indexing
			description: "Move cursor to previous child."
		do
			internal_child_index := child_index - 1
		end

	child_go_i_th (i: INTEGER) is
		indexing
			description: "Move cursor to `i'-th child."
		do
			internal_child_index := i
		end

feature -- Duplication

	duplicate (n: INTEGER): TREE [G] is
		indexing
			description: "[
						Copy of sub-tree beginning at cursor position and
						having min (`n', `arity' - `child_index' + 1)
						children.
					  ]"
		local
			local_Result: BINARY_TREE [G]
		do
			local_Result := new_tree
			if child_index <= 1 and child_index + n >= 1 and has_left then
				local_Result.put_left_child (left_child.duplicate_all)
			end
			if child_index <= 2 and child_index + n >= 2 and has_right then
				local_Result.put_right_child (right_child.duplicate_all)
			end
			Result := local_Result
		end

	duplicate_all: BINARY_TREE [G] is
		do
			Result := new_tree
			if has_left then
				Result.put_left_child (left_child.duplicate_all)
			end
			if has_right then
				Result.put_right_child (right_child.duplicate_all)
			end
		end

feature {TREE} -- Implementation

	attach_to_parent (n: BINARY_TREE [G]) is
		indexing
			description: "Make `n' parent of current node."
		do
			internal_parent := n
		end

feature {BINARY_TREE} -- Implementation

	fill_list (al: ARRAYED_LIST [G]) is
		indexing
			description: "Fill `al' with all the children's items."
		do
			if left_child /= Void then
				al.extend (left_child.item)
				left_child.fill_list (al)
			end
			if right_child /= Void then
				al.extend (right_child.item)
				right_child.fill_list (al)
			end
		end

feature {NONE} -- Implementation

	subtree_has (v: G): BOOLEAN is
		do
			if left_child /= Void then
				Result := left_child.has (v)
			end
			if right_child /= Void and not Result then
				Result := right_child.has (v)
			end
		end

	subtree_count: INTEGER is
		do
			if left_child /= Void then
				Result := left_child.count
			end
			if right_child /= Void then
				Result := Result + right_child.count
			end
		end

	fill_subtree (other: TREE [G]) is
		local
			binary_other: BINARY_TREE [G]
		do
			binary_other ?= other
			check
				binary_other /= Void
			end
			if not binary_other.is_leaf then
				put_left_child (binary_other.left_child.duplicate_all)
			end
			if binary_other.arity >= 2 then
				put_right_child (binary_other.right_child.duplicate_all)
			end
		end

	new_tree: BINARY_TREE [G] is
		indexing
			description: "New tree node"
		do
			create Result.make (item)
			if object_comparison then
				Result.compare_objects
			end
		end

	child_capacity: INTEGER is 2

	remove is
		indexing
			description: "Remove current item"
		do
		end

	implementation: SYSTEM_COLLECTIONS_ICOLLECTION is
		indexing
			description: "Object for .NET access and implementation"
		do
		end
		
feature {NONE} -- Implementation

	internal_object_comparison: BOOLEAN
	
	internal_parent: BINARY_TREE [G]
	
	internal_child_index: INTEGER


invariant

	child_capacity = 2

end -- class BINARY_TREE



