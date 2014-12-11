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
					attached active as a and then a.is_leaf
				loop
					check attached active as a1 then
						if a1.right /= Void then
							right
						else
							left
						end
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
			check attached active as a then
				if a.is_leaf then
					from
					until
						(active = Void) or else
							(attached active as a1 and then a1.is_left and then attached a1.parent as p and then p.right /= Void)
					loop
						up
					end
					if not off then
						up
						right
					end
				elseif a.left /= Void then
					left
				else
					right
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
			if attached active as a and then a.is_right and then
				attached a.parent as p and then p.left /= Void then
				up
				left
				from
				until
					attached active as a1 and then a1.is_leaf
				loop
					if attached active as a2 and then a2.right /= Void then
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
