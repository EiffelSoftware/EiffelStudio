note
	description: "A node in a graph structure that only has a reference to its parent and needs to maintain consistency with its children."
	explicit: "all"
	manual_inv: true

frozen class F_PIP_NODE_D

create
	make

feature {NONE} -- Initialization	

	make (v: INTEGER)
			-- Create a singleton node with initial value `v'		
		note
			status: creator
		require
			modify (Current)
		do
			init_value := v
			value := v
			wrap
		ensure
			init_value_set: init_value = v
			value_set: value = v
			no_parent: parent = Void
			no_children: children.is_empty
			default_wrapped: is_wrapped
		end

feature -- Access

	value: INTEGER
			-- Current value.

	init_value: INTEGER
			-- Initial value at node creation.

	parent: F_PIP_NODE_D
			-- Parent node.

	children: MML_SEQUENCE [F_PIP_NODE_D]
			-- Set of nodes whose `parent' is the current node.
		note
			status: ghost
		attribute
		end

	max_child: F_PIP_NODE_D
			-- Node from `children' with the maximum value greater than `init_value'
			-- or Void if it does not exist.
		note
			status: ghost
		attribute
		end

	is_max (v: INTEGER; init_v: INTEGER; nodes: MML_SET [F_PIP_NODE_D]; max_node: F_PIP_NODE_D): BOOLEAN
			-- Is `v' the maximum of `init_v' and all values of `nodes'?
		note
			status: functional, ghost
		require
			nodes_exist: across nodes as n all n.item /= Void end
			reads (nodes)
		do
			Result :=
				v >= init_v and
				across nodes as n all n.item.value <= v end and
				((max_node = Void and v = init_v) or (nodes [max_node] and then max_node.value = v))
		end

	acquire (n: F_PIP_NODE_D; ancestors: MML_SET [F_PIP_NODE_D])
			-- Connect `n' as a child to the current node, given the `ancestors' set of the Current node.
		require
			default_wrapped: is_wrapped
			default_arg_n_wrapped: n.is_wrapped
			n_exists: n /= Void
			n_different: n /= Current
			n_orphan: n.parent = Void
			ancestors_wrapped: across ancestors as p all p.item.is_wrapped end
			ancestors_has_current: ancestors [Current]
			ancestors_closed: across ancestors as p all p.item.parent /= Void implies ancestors [p.item.parent] end

			modify_field (["value", "max_child", "closed"], ancestors)
			modify_field (["children", "subjects", "observers"], Current)
			modify_field (["parent", "subjects", "observers", "closed"], n)
		do
			unwrap
			n.unwrap

			children := children & n -- preserves parent, children
			set_subjects (subjects & n)
			set_observers (observers & n)

			n.set_parent (Current)
			n.set_subjects (n.subjects & Current)
			n.set_observers (n.observers & Current)
			n.wrap

			if n.value > value then
				update_value (n, n, {MML_SET [F_PIP_NODE_D]}.empty_set, ancestors)
			else
				wrap
			end
		ensure
			default_wrapped: is_wrapped
			default_arg_n_wrapped: n.is_wrapped
			n_parent_set: n.parent = Current
			n_value_unchanged: n.value = old n.value
			children_set: children = old children & n
			max_child_set: max_child = if old (value >= n.value) then old max_child else n end
			ancestors_wrapped: across ancestors as p all p.item.is_wrapped end
		end

feature {F_PIP_NODE_D} -- Implementation

	set_parent (p: F_PIP_NODE_D)
			-- Set `parent' to `p'.
		require
			open: is_open
			no_parent: parent = Void
			p_exists: p /= Void
			observers = children.range
			modify_field (["parent"], Current)
		do
			parent := p
		ensure
			parent_set: parent = p
		end

	update_value (child, d: F_PIP_NODE_D; visited: MML_SET [F_PIP_NODE_D]; ancestors: MML_SET [F_PIP_NODE_D])
			-- Update `value' of this node and its `ancestors' taking into account an updated child `child' becuase of its new descendant `d';
			-- for all nodes in `visited' their `value' already has been fixed.
		require
			open: is_open
			partially_holds: inv_without ("value_consistent")
			child_is_child: children.has (child)
			child_value: child.value = d.value
			value_consistency_broken: child.value > value
			c_is_new_max: is_max (child.value, init_value, children.range, child)
			visited_fixed: across visited as o all o.item.is_wrapped and o.item.value = d.value end
			direct_ancestors_wrapped: across ancestors as p all p.item /= Current implies p.item.is_wrapped end
			ancestors_has_current: ancestors [Current]
			ancestors_closed: across ancestors as p all p.item.parent /= Void implies ancestors [p.item.parent] end

			modify_field (["closed"], ancestors)
			modify_field (["value", "max_child"], (ancestors - visited) / d)
			decreases (ancestors - visited)
		do
			if parent /= Void then
				parent.unwrap
			end
			value := child.value
			max_child := child
			wrap
			if parent /= Void then
				if value > parent.value then
					parent.update_value (Current, d, visited & Current, ancestors)
				else
					parent.wrap
				end
			end
		ensure
			value_set: value = d.value
			max_child_set: max_child = child
			d_value_unchnaged: d.value = old d.value
			ancestors_wrapped: across ancestors as p all p.item.is_wrapped end
		end

invariant
	subjects_structure: subjects = if parent = Void then children.range else children.range & parent end
	parent_consistent: parent /= Void implies parent.children.has (Current)
	children_consistent: across children.domain as i all children [i.item] /= Void and then children [i.item].parent = Current end
	value_consistent: is_max (value, init_value, children.range, max_child)
	no_direct_cycles: parent /= Current
	observers_structure: observers = subjects
	subjects_aware: across subjects as s all s.item.observers [Current] end
	default_owns: owns = []

end
