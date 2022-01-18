note
	description: "A node in a graph structure that only has a reference to its parent and needs to maintain consistency with its children."
	manual_inv: true

frozen class F_PIP_NODE

create
	make

feature {NONE} -- Initialization	

	make (v: INTEGER)
			-- Create a singleton node with initial value `v'		
		note
			status: creator
		do
			init_value := v
			value := v
		ensure
			init_value_set: init_value = v
			value_set: value = v
			no_parent: parent = Void
			no_children: children.is_empty
		end

feature -- Access

	value: INTEGER
			-- Current value.

	init_value: INTEGER
			-- Initial value at node creation.

	parent: F_PIP_NODE
			-- Parent node.

	children: MML_SEQUENCE [F_PIP_NODE]
			-- Set of nodes whose `parent' is the current node.
		note
			status: ghost
		attribute
		end

	max_child: F_PIP_NODE
			-- Node from `children' with the maximum value greater than `init_value'
			-- or Void if it does not exist.
		note
			status: ghost
		attribute
		end

	is_max (v: INTEGER; init_v: INTEGER; nodes: MML_SET [F_PIP_NODE]; max_node: F_PIP_NODE): BOOLEAN
			-- Is `v' the maximum of `init_v' and all values of `nodes'?
		note
			status: functional, ghost
		require
			nodes_exist: across nodes as n all n /= Void end
			reads (nodes)
		do
			Result :=
				v >= init_v and
				across nodes as n all n.value <= v end and
				((max_node = Void and v = init_v) or (nodes [max_node] and then max_node.value = v))
		end

	acquire (n: F_PIP_NODE; ancestors: MML_SET [F_PIP_NODE])
			-- Connect `n' as a child to the current node, given the `ancestors' set of the Current node.
		note
			explicit: wrapping
		require
			n_exists: n /= Void
			n_different: n /= Current
			n_orphan: n.parent = Void
			ancestors_wrapped: across ancestors as p all p.is_wrapped end
			ancestors_has_current: ancestors [Current]
			ancestors_closed: across ancestors as p all p.parent /= Void implies ancestors [p.parent] end

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
				update_value (n, n, {MML_SET [F_PIP_NODE]}.empty_set, ancestors)
			else
				wrap
			end
		ensure
			n_parent_set: n.parent = Current
			n_value_unchanged: n.value = old n.value
			children_set: children = old children & n
			max_child_set: max_child = if old (value >= n.value) then old max_child else n end
			ancestors_wrapped: across ancestors as p all p.is_wrapped end
		end

feature {F_PIP_NODE} -- Implementation

	set_parent (p: F_PIP_NODE)
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

	update_value (child, d: F_PIP_NODE; visited: MML_SET [F_PIP_NODE]; ancestors: MML_SET [F_PIP_NODE])
			-- Update `value' of this node and its `ancestors' taking into account an updated child `child' becuase of its new descendant `d';
			-- for all nodes in `visited' their `value' already has been fixed.
		require
			open: is_open
			partially_holds: inv_without ("value_consistent")
			child_is_child: children.has (child)
			child_value: child.value = d.value
			value_consistency_broken: child.value > value
			c_is_new_max: is_max (child.value, init_value, children.range, child)
			visited_fixed: across visited as o all o.is_wrapped and o.value = d.value end
			direct_ancestors_wrapped: across ancestors as p all p /= Current implies p.is_wrapped end
			ancestors_has_current: ancestors [Current]
			ancestors_closed: across ancestors as p all p.parent /= Void implies ancestors [p.parent] end

			modify_field ("closed", ancestors)
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
			ancestors_wrapped: across ancestors as p all p.is_wrapped end
		end

invariant
	subjects_structure: subjects = if parent = Void then children.range else children.range & parent end
	parent_consistent: parent /= Void implies parent.children.has (Current)
	children_consistent: across children.domain as i all children [i] /= Void and then children [i].parent = Current end
	value_consistent: is_max (value, init_value, children.range, max_child)
	no_direct_cycles: parent /= Current
	observers_structure: observers = subjects

note
	explicit: subjects, observers
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
