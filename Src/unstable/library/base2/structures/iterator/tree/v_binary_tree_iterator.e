note
	description: "Iterators to traverse binary trees in some linear order."
	author: "Nadia Polikarpova"
	model: target, map, path, after

deferred class
	V_BINARY_TREE_ITERATOR [G]

inherit
	V_IO_ITERATOR [G]
		undefine
			off
		redefine
			copy
		end

	V_BINARY_TREE_CURSOR [G]
		undefine
			is_equal,
			box
		redefine
			copy,
			go_root
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			modify: target, map, path, after
		do
			after := other.after
			Precursor {V_BINARY_TREE_CURSOR} (other)
		ensure then
			sequence_effect: sequence |=| other.sequence
			path_effect: path |=| other.path
			after_effect: after = other.after
		end

feature -- Measurement

	index: INTEGER
			-- Index of current position.
		do
			if after then
				Result := target.count + 1
			elseif active /= Void then
				Result := active_index
			end
		end

feature -- Status report

	is_first: BOOLEAN
			-- Is cursor at the first position?
		local
			old_active: detachable V_BINARY_TREE_CELL [G]
			old_after: BOOLEAN
		do
			if not target.is_empty then
				old_active := active
				old_after := after
				start
				Result := active = old_active
				active := old_active
				after := old_after
			end
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		local
			old_active: detachable V_BINARY_TREE_CELL [G]
			old_after: BOOLEAN
		do
			if not target.is_empty then
				old_active := active
				old_after := after
				finish
				Result := active = old_active and after = old_after
				active := old_active
				after := old_after
			end
		end

	after: BOOLEAN
			-- Is current position after the last container position?

	before: BOOLEAN
			-- Is current position before the first container position?
		do
			Result := off and not after
		end

feature -- Cursor movement

	go_root
			-- Move cursor to the root.
		note
			modify: path, after
		do
			Precursor
			if not target.is_empty then
				after := False
			else
				after := True
			end
		ensure then
			after_effect_nonempty: not target.map.is_empty implies not after
			after_effect_empty: target.map.is_empty implies after
		end

	go_before
			-- Move cursor before any position of `target'.
		note
			modify: path, after
		do
			active := Void
			after := False
		end

	go_after
			-- Move cursor after any position of `target'.
		note
			modify: path, after
		do
			active := Void
			after := True
		end

feature {V_ITERATOR} -- Cursor movement

	go_to_cell (c: V_BINARY_TREE_CELL [G])
			-- Set cursor to cell `c'.
		do
			active := c
			after := False
		end

feature {NONE} -- Implementation

	active_index: INTEGER
			-- Index of `active' in inorder.
		require
			active_exists: active /= Void
		local
			old_active: detachable V_BINARY_TREE_CELL [G]
			old_after: BOOLEAN
		do
			old_active := active
			old_after := after
			from
				start
				Result := 1
			until
				active = old_active or active = Void
			loop
				forth
				Result := Result + 1
			end
			active := old_active
			after := old_after
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements.
		note
			status: specification
		local
			old_active: detachable V_BINARY_TREE_CELL [G]
			old_after: BOOLEAN
		do
			old_active := active
			old_after := after
			create Result
			from
				start
			until
				after
			loop
				Result := Result & item
				forth
			end
			active := old_active
			after := old_after
		end

	path_sequence: MML_SEQUENCE [MML_SEQUENCE [BOOLEAN]]
			-- Sequence of paths in `target.map' in order of traversal.
		note
			status: specification
		do
			Result := subtree_path_sequence (create {MML_SEQUENCE [BOOLEAN]}.singleton (True))
		ensure
			definition: Result |=| subtree_path_sequence (create {MML_SEQUENCE [BOOLEAN]}.singleton (True))
		end

	subtree_path_sequence (root: MML_SEQUENCE [BOOLEAN]): MML_SEQUENCE [MML_SEQUENCE [BOOLEAN]]
			-- Sequence of paths in subtree of `target.map' strating from `root' in order of traversal.
		note
			status: specification
		deferred
		end

invariant
	sequence_definition: sequence |=| target.map.sequence_image (path_sequence)
	index_definition_not_after: not after implies index = path_sequence.inverse.image_of (path).any_item
	index_definition_after: after implies index = target.map.count + 1

end
