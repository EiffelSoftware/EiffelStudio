note
	description: "Key of a 3-4-5 tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

 class
	TREE_KEY [G]

inherit
	ANY

create
	make

feature -- Initialization

	make (d: G)
			-- Initialize Current with `d' as `data'.
		do
			data := d
		end

feature -- Access

	data: G
		-- Data associated with Current

	parent: detachable TREE_NODE [G]
		-- Tree Node of Current

feature -- Status report

	is_valid: BOOLEAN
			-- Is current valid as key of parent?
		local
			l_parent: like parent
		do
			l_parent := parent
			Result := l_parent /= Void and then l_parent.valid_key (Current)
		end

	pos_in_parent: INTEGER
			-- position of node in parent.
		require
			valid_key: is_valid
		local
			l_parent: like parent
		do
			from
				Result := 1
				l_parent := parent
				check l_parent /= Void end -- Implied by precondition `is_valid'.
			until
				l_parent.keys [Result] = Current
			loop
				Result := Result + 1
				check
					no_overflow: Result <= l_parent.arity - 1
				end
			end
		end
--| FIXME
--| Christophe, 14 jan 2000
--| Should we implement it as an attribute or as a function?

	number: INTEGER
			-- position of node in tree.
		require
			valid_key: is_valid
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void end -- Implied by precondition `is_valid'.
			Result := l_parent.keys_before_child (pos_in_parent + 1)
					--| Tricky: We ask for the number of keys
					--| before the child who is just after Current.
		end

feature -- Element change

	set_parent (par: like parent)
			-- Make `par' the parent of Current
		do
			parent := par
		end

feature -- Removal

	delete
			-- Supress Current
		require
			is_valid: is_valid
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void end -- Implied by precondition `is_valid'.
			l_parent.delete (pos_in_parent)
		end

feature -- Basic operations

	add_right (other: like Current)
			-- add `other' to the right of Current
		require
			is_valid: is_valid
		local
			l_parent: like parent
			next_node: like parent
		do
			l_parent := parent
			check l_parent /= Void end -- Implied by precondition `is_valid'.
			if l_parent.is_leaf then
				l_parent.insert_key_and_right_child (other, Void, pos_in_parent + 1)
			else
				next_node := l_parent.children [pos_in_parent +1]
				check next_child_exist: next_node /= Void end
				next_node.insert_first (other)
			end
		end

	add_left (other: like Current)
			-- add `other' to the left of Current
		require
			is_valid: is_valid
		local
			l_parent: like parent
			previous_node: like parent
		do
			l_parent := parent
			check l_parent /= Void end -- Implied by precondition `is_valid'.
			if l_parent.is_leaf then
				l_parent.insert_key_and_left_child (other, Void, pos_in_parent)
			else
				previous_node := l_parent.children [pos_in_parent]
				check previous_child_exist: previous_node /= Void end
				previous_node.insert_last (other)
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
