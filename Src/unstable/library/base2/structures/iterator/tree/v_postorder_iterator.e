note
	description: "Iterators to traverse binary trees in order left subtree - right subtree - root."
	author: "Nadia Polikarpova"
	model: target, map, path, after

class
	V_POSTORDER_ITERATOR [G]

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
			if not target.is_empty then
				from
					go_root
				until
					attached active as a and then a.is_leaf
				loop
					check attached active as a1 then
						if a1.left /= Void then
							left
						else
							right
						end
					end
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
			go_root
			after := False
		end

	forth
			-- Go one position forward.
		note
			modify: path, after
		do
			check not_off: attached active as a then
				if a.is_left and then attached a.parent as p and then p.right /= Void then
					up
					right
					from
					until
						attached active as a1 and then a1.is_leaf
					loop
						check attached active as a2 then
							if a2.left /= Void then
								left
							else
								right
							end
						end
					end
				else
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
			check not_off: attached active as a then
				if a.is_leaf then
					from
					until
						(active = Void) or else
						(attached active as a1 and then a1.is_right and then attached a1.parent as p and then p.left /= Void)
					loop
						up
					end
					if not off then
						up
						left
					end
				elseif a.right /= Void then
					right
				else
					left
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
				Result := subtree_path_sequence (root & False) + subtree_path_sequence (root & True) & root
			end
		ensure then
			definition_base: not target.map.domain [root] implies Result.is_empty
			definition_step: target.map.domain [root] implies
				Result |=| (subtree_path_sequence (root & False) + subtree_path_sequence (root & True) & root)
		end
end
