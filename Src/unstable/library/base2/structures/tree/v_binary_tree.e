note
	description: "Binary trees (doubly linked implementation)."
	author: "Nadia Polikarpova"
	updated_by: "Alexander Kogtenkov"
	model: map

class
	V_BINARY_TREE [G]

inherit
	V_CONTAINER [G]
		rename
			new_cursor as inorder
		redefine
			copy,
			is_equal,
			out
		end

feature -- Initialization

	copy (other: like Current)
			-- Copy values and structure from `other'.
		note
			modify: map
		do
			if other /= Current then
				root := subtree_twin (other.root)
				count := other.count
			end
		ensure then
			map_effect: map |=| other.map
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.

feature -- Iteration

	at_root: V_BINARY_TREE_CURSOR [G]
			-- New cursor pointing to the root.
		do
			create Result.make (Current)
			Result.go_root
		ensure
			target_definition: Result.target = Current
			path_definition_non_empty: not map.is_empty implies Result.path |=| create {MML_SEQUENCE [BOOLEAN]}.singleton (True)
			path_definition_empty: map.is_empty implies Result.path.is_empty
		end

	inorder: V_INORDER_ITERATOR [G]
			-- New inorder iterator pointing to the first position.
		do
			create Result.make (Current)
			Result.start
		end

	preorder: V_PREORDER_ITERATOR [G]
			-- New preorder iterator pointing to the first position.
		do
			create Result.make (Current)
			Result.start
		ensure
			target_definition: Result.target = Current
			index_definition: Result.index = 1
		end

	postorder: V_POSTORDER_ITERATOR [G]
			-- New postorder iterator pointing to the first position.
		do
			create Result.make (Current)
			Result.start
		ensure
			target_definition: Result.target = Current
			index_definition: Result.index = 1
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' has the same structure and contain the same objects?
		do
			Result := equal_subtree (root, other.root)
		ensure then
			definition: Result = (map |=| other.map)
		end

feature -- Extension

	add_root (v: G)
			-- Add a root with value `v' to an empty tree.
		note
			modify: map
		require
			is_empty: is_empty
		do
			create root.put (v)
			count := 1
		ensure
			map_effect: map |=| create {like map}.singleton (create {MML_SEQUENCE [BOOLEAN]}.singleton (True), v)
		end

feature -- Removal

	wipe_out
			-- Remove all elements.
		note
			modify: map
		do
			root := Void
			count := 0
		ensure then
			map_effect: map.is_empty
		end

feature -- Output

	out: STRING
			-- String representation of the content.
		do
			Result := subtree_to_string (root, 0)
		end

feature {V_CONTAINER, V_BINARY_TREE_CURSOR} -- Implementation

	root: detachable V_BINARY_TREE_CELL [G]
			-- Root node.

feature {V_BINARY_TREE_CURSOR} -- Implementation

	extend_left (v: G; cell: V_BINARY_TREE_CELL [G])
			-- Add a left child with value `v' to `cell'.
		require
			not_cell_has_left: cell.left = Void
		do
			cell.connect_left_child (create {V_BINARY_TREE_CELL [G]}.put (v))
			count := count + 1
		end

	extend_right (v: G; cell: V_BINARY_TREE_CELL [G])
			-- Add a right child with value `v' to `cell'.
		require
			not_cell_has_left: cell.right = Void
		do
			cell.connect_right_child (create {V_BINARY_TREE_CELL [G]}.put (v))
			count := count + 1
		end

	remove (cell: V_BINARY_TREE_CELL [G])
			-- Remove `cell' from the tree (it must have less than two child nodes).
		require
			not_two_children: cell.left = Void or cell.right = Void
		local
			child: detachable V_BINARY_TREE_CELL [G]
		do
			if cell.left /= Void then
				child := cell.left
			else
				child := cell.right
			end
			if cell.is_root then
				root := child
				if child /= Void then
					child.put_parent (Void)
				end
			else
				check attached cell.parent as p then
					if cell.is_left then
						p.connect_left_child (child)
					else
						p.connect_right_child (child)
					end
				end
			end
			count := count - 1
		end

feature {NONE} -- Implementation

	subtree_twin (cell: detachable V_BINARY_TREE_CELL [G]): detachable V_BINARY_TREE_CELL [G]
			-- Copy of subtree with root `cell'.
		do
			if cell /= Void then
				create Result.put (cell.item)
				Result.connect_left_child (subtree_twin (cell.left))
				Result.connect_right_child (subtree_twin (cell.right))
			end
		end

	equal_subtree (i, j: detachable V_BINARY_TREE_CELL [G]): BOOLEAN
			-- Is subtree with root `i' equal to that with root `j' both in structure in values?
		do
			if i /= Void and j /= Void then
				Result := (i.item = j.item) and equal_subtree (i.left, j.left) and equal_subtree (i.right, j.right)
			else
				Result := (i = Void) and (j = Void)
			end
		end

	subtree_to_string (cell: detachable V_BINARY_TREE_CELL [G]; indent: INTEGER): STRING
			-- String representation of a subtree with root `cell' indented by `indent'.
		require
			indent_non_negative: indent >= 0
		do
			if cell /= Void then
				create Result.make_filled (' ', indent)
				;(create {V_STRING_OUTPUT}.make_with_separator (Result, "%N")).output (cell.item)
				Result.append (subtree_to_string (cell.left, indent + 1))
				Result.append (subtree_to_string (cell.right, indent + 1))
			else
				Result := ""
			end
		end

feature -- Specification

	map: MML_MAP [MML_SEQUENCE [BOOLEAN], G]
			-- Map of paths to elements.
		note
			status: specification
		do
			Result := map_from (root, create {MML_SEQUENCE [BOOLEAN]}.singleton (True))
		end

feature {NONE} -- Specification

	map_from (cell: detachable V_BINARY_TREE_CELL [G]; path: MML_SEQUENCE [BOOLEAN]): MML_MAP [MML_SEQUENCE [BOOLEAN], G]
			-- Map from paths to elements in a subtree starting from `cell' and `path' leading from `root' to `cell'.
		note
			status: specification
		do
			if cell = Void then
				create Result
			else
				create Result.singleton (path, cell.item)
				Result := Result + map_from (cell.left, path & False) + map_from (cell.right, path & True)
			end
		end

invariant
	bag_definition: bag |=| map.to_bag
	count_definition: count = map.count
end
