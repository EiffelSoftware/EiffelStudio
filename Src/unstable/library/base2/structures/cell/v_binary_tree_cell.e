note
	description: "[
		Binary tree cells with references to the parent and the left and right child.
		Cells provide a low-level interface and do not ensure neither the consistency of parent and child links, nor the acyclicity property.
		]"
	author: "Nadia Polikarpova"
	model: item, left, right, parent

class
	V_BINARY_TREE_CELL [G]

inherit
	V_CELL [G]

create
	put

feature -- Access

	right: V_BINARY_TREE_CELL [G]
			-- Right child.

	left: V_BINARY_TREE_CELL [G]
			-- Left child.

	parent: V_BINARY_TREE_CELL [G]
			-- Parent.

feature -- Status report

	is_root: BOOLEAN
			-- Does not have parent?
		do
			Result := (parent = Void)
		ensure
			definition: Result = (parent = Void)
		end

	is_leaf: BOOLEAN
			-- Does not have children?
		do
			Result := (left = Void and right = Void)
		ensure
			definition: Result = (left = Void and right = Void)
		end

	is_left: BOOLEAN
			-- Is the left child of its parent?
		do
			Result := (not is_root and then parent.left = Current)
		ensure
			definition: Result = (parent /= Void and then parent.left = Current)
		end

	is_right: BOOLEAN
			-- Is the right child of its parent?
		do
			Result := (not is_root and then parent.right = Current)
		ensure
			definition: Result = (parent /= Void and then parent.right = Current)
		end

feature -- Replacement

	connect_right_child (r: V_BINARY_TREE_CELL [G])
			-- Set `right' to `r' and `r.parent' to `Current'.
		note
			modify: right, r__parent
		do
			right := r
			if r /= Void then
				r.put_parent (Current)
			end
		ensure
			right_effect: right = r
			r_parent_effect: r /= Void implies r.parent = Current
		end

	connect_left_child (l: V_BINARY_TREE_CELL [G])
			-- Set `left' to `l' and `l.parent' to `Current'.
		note
			modify: left, l__parent
		do
			left := l
			if l /= Void then
				l.put_parent (Current)
			end
		ensure
			left_effect: left = l
			l_parent_effect: l /= Void implies l.parent = Current
		end

	put_right (r: V_BINARY_TREE_CELL [G])
			-- Set `right' to `r'.
		note
			modify: right
		do
			right := r
		ensure
			right_effect: right = r
		end

	put_left (l: V_BINARY_TREE_CELL [G])
			-- Set `left' to `l'.
		note
			modify: left
		do
			left := l
		ensure
			left_effect: left = l
		end

	put_parent (p: V_BINARY_TREE_CELL [G])
			-- Set `parent' to `p'.
		note
			modify: parent
		do
			parent := p
		ensure
			parent_effect: parent = p
		end

end
