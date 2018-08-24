note
	description: "Node in a tree structure, which needs to maintain consistency with its child nodes."
	explicit: "all"
	manual_inv: true

frozen class F_COM_COMPOSITE_D

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
			create children.make
			init_value := v
			value := v
			set_owns ([children])
			wrap
		ensure
			init_value_set: init_value = v
			value_set: value = v
			no_parent: parent = Void
			no_children: children.is_empty
			default_wrapped: is_wrapped
		end

feature -- Access

	children: F_COM_LIST [F_COM_COMPOSITE_D]
			-- List of child nodes.

	parent: F_COM_COMPOSITE_D
			-- Parent node.

	value: INTEGER
			-- Current value.

	init_value: INTEGER
			-- Initial value at node creation.

	ancestors: MML_SET [F_COM_COMPOSITE_D]
			-- Set of transitive parent nodes.
		note
			status: ghost
		attribute
		end

	children_set: MML_SET [F_COM_COMPOSITE_D]
			-- Set of child nodes.
		note
			status: functional, ghost
		require
			children_exists: children /= Void
			reads (Current, children)
		do
			Result := children.sequence.range
		end

	max_child: F_COM_COMPOSITE_D
			-- Node from `children_set' with the maximum value greater than `init_value'
			-- or Void if it does not exist.
		note
			status: ghost
		attribute
		end

	is_max (v: INTEGER; init_v: INTEGER; nodes: MML_SET [F_COM_COMPOSITE_D]; max_node: F_COM_COMPOSITE_D): BOOLEAN
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

feature -- Update

	add_child (c: F_COM_COMPOSITE_D)
			-- Add `c' to `children'.
		require
			c_exists: c /= Void
			c_different: c /= Current
			c_singleton_1: c.parent = Void
			c_singleton_2: c.children.is_empty
			ancestors_wrapped: across ancestors as p all p.item.is_wrapped end
			default_wrapped: is_wrapped
			default_observers_wrapped: across observers as o all o.item.is_wrapped end
			default_arg_c_wrapped: c.is_wrapped
			modify (Current, c)
			modify_field (["value", "max_child", "closed"], ancestors)
		do
			lemma_ancestors_have_children (c)
			check c.inv end

			unwrap
			c.unwrap

			c.set_parent (Current)
			c.set_subjects (c.subjects & Current)
			c.set_observers (c.observers & Current)

			set_observers (observers & c)
			set_subjects (subjects & c)
			check children.inv_only ("default_observers") end
			children.extend_back (c)

			c.wrap
			update (c)
		ensure
			child_added: children.has (c)
			c_value_unchanged: c.value = old c.value
			c_children_unchanged: c.children.sequence = old c.children.sequence
			ancestors_unchengd: ancestors = old ancestors
			ancestors_wrapped: across ancestors as p all p.item.is_wrapped end
			default_wrapped: is_wrapped
			default_observers_wrapped: across observers as o all o.item.is_wrapped end
			default_arg_c_wrapped: c.is_wrapped
		end

feature {F_COM_COMPOSITE_D} -- Implementation

	set_parent (p: F_COM_COMPOSITE_D)
			-- Set `parent' to `p'.
		require
			open: is_open
			p_exists: p /= Void
			no_observers: observers.is_empty
			modify_field (["parent", "ancestors"], Current)
		do
			parent := p
			ancestors := p.ancestors & p
		ensure
			parent_set: parent = p
			ancestors_set: ancestors = p.ancestors & p
		end

	update (c: F_COM_COMPOSITE_D)
			-- Update `value' of this node and its ancestors taking into account an updated child `c'.
		require
			c_exists: c /= Void
			c_is_child: children.sequence.has (c)
			open: is_open
			children_list_wrapped: children.is_wrapped
			ancestors_wrapped: across ancestors as p all p.item.is_wrapped end
			partially_holds: inv_without ("value_consistent")
			almost_max: if value >= c.value
				then is_max (value, init_value, children_set, max_child)
				else is_max (c.value, init_value, children_set, c) end
			modify_field (["value", "max_child", "closed"], Current, ancestors)
			modify_field (["owner"], children)
			decreases (ancestors)
		do
			if value < c.value then
				if parent /= Void then
					parent.unwrap
				end
				value := c.value
				max_child := c
				wrap
				if parent /= Void then
					parent.update (Current)
				end
			else
				wrap
			end
		ensure
			wrapped: is_wrapped
			ancestors_wrapped: across ancestors as p all p.item.is_wrapped end
		end

	lemma_ancestors_have_children (c: F_COM_COMPOSITE_D)
			-- Lemma: if `c' is in `ancestors' its `chilren' is not empty.
		note
			status: lemma
		require
			c_exists: c /= Void
			wrapped: is_wrapped
			ancestors_wrapped: across ancestors as a all a.item.is_wrapped  end
			decreases (ancestors)
		do
			check inv end
			if ancestors [c] then
				check c.inv and parent.inv end
				if c /= parent then
					parent.lemma_ancestors_have_children (c)
				end
			end
		ensure
			ancestors [c] implies not c.children.sequence.is_empty
		end

invariant
	children_exists: children /= Void
	owns_structure: owns = [children]
	subjects_structure: subjects = if parent = Void then children_set else children.sequence.range & parent end
	tree: not ancestors [Current]
	children_consistent: across children.sequence.domain as i all children.sequence [i.item] /= Void and then children.sequence [i.item].parent = Current end
	ancestors_structure: ancestors = if parent = Void then {MML_SET [F_COM_COMPOSITE_D]}.empty_set else parent.ancestors & parent end
	value_consistent: is_max (value, init_value, children_set, max_child)
	observers_structure: observers = subjects
	default_subjects_aware: across subjects as s all s.item.observers.has (Current) end

end
