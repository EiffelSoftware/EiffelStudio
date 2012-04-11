note
	description: "Iterators to traverse binary trees in order root - left subtree - right subtree."
	author: "Nadia Polikarpova"
	model: target, map, path, after

class
	V_PREORDER_ITERATOR [G]

inherit
	V_BINARY_TREE_ITERATOR [G]

create {V_CONTAINER}
	make

feature -- Cursor movement

	start
			-- Go to the first position.
		note
			modify: path, after
		do
			go_root
		end

	finish
			-- Go to the last position.
		note
			modify: path, after
		do
			if not target.is_empty then
				from
					go_root
				until
					active.is_leaf
				loop
					if active.right /= Void then
						right
					else
						left
					end
				end
			else
				active := Void
			end
			after := False
		end

	forth
			-- Go one position forward.
		note
			modify: path, after
		do
			if active.is_leaf then
				from
				until
					(active = Void) or else (active.is_left and active.parent.right /= Void)
				loop
					up
				end
				if not off then
					up
					right
				end
			elseif active.left /= Void then
				left
			else
				right
			end
			if active = Void then
				after := True
			end
		end

	back
			-- Go one position backward.
		note
			modify: path, after
		do
			if active.is_right and then active.parent.left /= Void then
				up
				left
				from
				until
					active.is_leaf
				loop
					if active.right /= Void then
						right
					else
						left
					end
				end
			else
				up
			end
		end

feature -- Specification

	subtree_path_sequence (root: MML_SEQUENCE [BOOLEAN]): MML_SEQUENCE [MML_SEQUENCE [BOOLEAN]]
			-- Sequence of paths in subtree of `target.map' strating from `root' in order of traversal.
		note
			status: specification
		do
			if not target.map.domain [root] then
				create Result
			else
				Result := subtree_path_sequence (root & False).prepended (root) + subtree_path_sequence (root & True)
			end
		ensure then
			definition_base: not target.map.domain [root] implies Result.is_empty
			definition_step: target.map.domain [root] implies
				Result |=| (subtree_path_sequence (root & False).prepended (root) + subtree_path_sequence (root & True))
		end
end
