note
	description: "Cursors to traverse binary trees."
	author: "Nadia Polikarpova"
	updated_by: "Alexander Kogtenkov"
	model: target, map, path

class
	V_BINARY_TREE_CURSOR [G]

inherit
	V_CELL_CURSOR [G]
		redefine
			copy,
			is_equal
		end

create {V_BINARY_TREE}
	make

feature {NONE} -- Initialization

	make (t: V_BINARY_TREE [G])
			-- Create iterator over `tree'.
		do
			target := t
		ensure
			target_effect: target = t
			path_effect: path.is_empty
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and `path' as in `other'.
		note
			modify: target, map, path
		do
			target := other.target
			active := other.active
		ensure then
			target_effect: target = other.target
			path_effect: path |=| other.path
		end

feature -- Access

	target: V_BINARY_TREE [G]
			-- Tree to traverse.

feature -- Status report

	is_root: BOOLEAN
			-- Is cursor at root?
		do
			Result := active /= Void and active = target.root
		ensure
			definition: Result = (path |=| create {MML_SEQUENCE [BOOLEAN]}.singleton (True))
		end

	is_leaf: BOOLEAN
			-- Is cursor at leaf?
		require
			not_off: not off
		do
			check not_off: attached active as a then
				Result := a.is_leaf
			end
		ensure
			definition: Result = (not map.domain [path & True] and not map.domain [path & False])
		end

	has_left: BOOLEAN
			-- Does current node have a left child?
		require
			not_off: not off
		do
			check not_off: attached active as a then
				Result := a.left /= Void
			end
		ensure
			definition: Result = map.domain [path & False]
		end

	has_right: BOOLEAN
			-- Does current node have a right child?
		require
			no_off: not off
		do
			check not_off: attached active as a then
				Result := a.right /= Void
			end
		ensure
			definition: Result = map.domain [path & True]
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' have the same `target' and `path'?
		do
			Result := same_type (other) and then
				target = other.target and (off and other.off or active = other.active)
		ensure then
			definition: Result = same_type (other) and then (target = other.target and path |=| other.path)
		end

feature -- Cursor movement

	up
			-- Move cursor up to the parent.
		note
			modify: path
		require
			not_off: not off
		do
			check not_off: attached active as a then
				active := a.parent
			end
		ensure
			path_effect: path |=| old path.but_last
		end

	left
			-- Move cursor down to the left child.
		note
			modify: path
		require
			not_off: not off
		do
			check not_off: attached active as a then
				active := a.left
			end
		ensure
			path_effect_not_off: old map.domain [path & False] implies path |=| old (path & False)
			path_effect_off: not old map.domain [path & False] implies path.is_empty
		end

	right
			-- Move cursor down to the right child.
		note
			modify: path
		require
			not_off: not off
		do
			check not_off: attached active as a then
				active := a.right
			end
		ensure
			path_effect_not_off: old map.domain [path & True] implies path |=| old (path & True)
			path_effect_off: not old map.domain [path & True] implies path.is_empty
		end

	go_root
			-- Move cursor to the root.
		note
			modify: path
		do
			active := target.root
		ensure
			path_effect_non_empty: not map.is_empty implies path |=| create {MML_SEQUENCE [BOOLEAN]}.singleton (True)
			path_effect_empty: map.is_empty implies path.is_empty
		end

feature -- Extension

	extend_left (v: G)
			-- Add a left child with value `v' to the current node.
		note
			modify: map
		require
			not_off: not off
			not_has_left: not has_left
		do
			check not_off: attached active as a then
				target.extend_left (v, a)
			end
		ensure
			map_effect: map |=| old map.updated (path & False, v)
		end

	extend_right (v: G)
			-- Add a left child with value `v' to the current node.
		note
			modify: map
		require
			not_off: not off
			not_has_right: not has_right
		do
			check not_off: attached active as a then
				target.extend_right (v, a)
			end
		ensure
			map_effect: map |=| old map.updated (path & True, v)
		end

feature -- Removal

	remove
			-- Remove current node (it must have less than two child nodes). Go off.
		note
			modify: map, path
		require
			not_off: not off
			not_two_children: not has_left or not has_right
		do
			check not_off: attached active as a then
				target.remove (a)
			end
			active := Void
		ensure
			map_domain_effect: map.domain |=| old (
				(map.domain - map.domain | agent path.is_prefix_of) +
				(map.domain | agent path.is_prefix_of).removed (path).mapped (agent {like path}.removed_at (path.count + 1)))
			map_effect_unchanged: map.restricted (old (map.domain - map.domain | agent path.is_prefix_of)) |=|
				old map.restricted (map.domain - map.domain | agent path.is_prefix_of)
			map_effect_changed: (old (map.domain | agent path.is_prefix_of).removed (path)).for_all (agent (x, p: like path; m: like map): BOOLEAN
				do
					Result := map [x.removed_at (p.count + 1)] = m [x]
				end (?, old path, old map))
			path_effect: path.is_empty
		end

feature {V_CELL_CURSOR, V_ITERATOR} -- Implementation

	active: detachable V_BINARY_TREE_CELL [G]
			-- Cell at current position.

feature {NONE} -- Implementation

	reachable: BOOLEAN
			-- Is `active' part of the target container?
		do
			Result := reachable_from (target.root)
		end

	reachable_from (c: detachable V_BINARY_TREE_CELL [G]): BOOLEAN
			-- Is `active' in subtree with root `c'?
		do
			if c = active then
				Result := True
			elseif attached c then
				Result := reachable_from (c.left) or reachable_from (c.right)
			end
		end

feature -- Specification

	path: MML_SEQUENCE [BOOLEAN]
			-- Path from root to current node.
		note
			status: specification
		local
			cell: detachable V_BINARY_TREE_CELL [G]
		do
			create Result
			if not off then
				from
					cell := active
				until
					cell = Void
				loop
					if cell.is_left then
						Result := Result.prepended (False)
					else
						Result := Result.prepended (True)
					end
					cell := cell.parent
				end
			end
		end

	map: MML_MAP [MML_SEQUENCE [BOOLEAN], G]
			-- Map of paths to values in the subtree starting from current node.
		note
			status: specification
		do
			Result := target.map
		end

invariant
	map_dependant: map |=| target.map
	box_definition_empty: not target.map.domain [path] implies box.is_empty
	box_definition_non_empty: target.map.domain [path] implies box |=| create {MML_SET [G]}.singleton (target.map [path])

end
