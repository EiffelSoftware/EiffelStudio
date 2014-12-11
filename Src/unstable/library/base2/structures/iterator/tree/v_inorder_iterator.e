note
	description: "Iterators to traverse binary trees in order left subtree - root - right subtree."
	author: "Nadia Polikarpova"
	model: target, map, path, after

class
	V_INORDER_ITERATOR [G]

inherit
	V_BINARY_TREE_ITERATOR [G]

create {V_CONTAINER, V_ITERATOR}
	make

feature -- Cursor movement

	start
			-- Go to the first position.
		note
			modify: path, after
		do
			if not target.is_empty then
				from
					go_root
				until
					attached active as a and then a.left = Void
				loop
					left
				end
				after := False
			else
				active := Void
				after := True
			end
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
					attached active as a and then a.right = Void
				loop
					right
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
			check not_off: attached active as a then
				if a.right /= Void then
					right
					from
					until
						attached active as a1 and then a1.left = Void
					loop
						left
					end
				else
					from
					until
						attached active as a2 and then (a2.is_root or a2.is_left)
					loop
						up
					end
					up
				end
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
			check attached active as a then
				if a.left /= Void then
					left
					from
					until
						attached active as a1 and then a1.right = Void
					loop
						right
					end
				else
					from
					until
						attached active as a2 and then (a2.is_root or a2.is_right)
					loop
						up
					end
					up
				end
			end
		end

feature -- Specification

	subtree_path_sequence (root: MML_SEQUENCE [BOOLEAN]): MML_SEQUENCE [MML_SEQUENCE [BOOLEAN]]
			-- Sequence of paths in subtree of `target.map' strating from `root' by order of traversal.
		note
			status: specification
		do
			if not target.map.domain [root] then
				create Result
			else
				Result := subtree_path_sequence (root & False) & root + subtree_path_sequence (root & True)
			end
		ensure then
			definition_base: not target.map.domain [root] implies Result.is_empty
			definition_step: target.map.domain [root] implies
				Result |=| (subtree_path_sequence (root & False) & root + subtree_path_sequence (root & True))
		end
end
