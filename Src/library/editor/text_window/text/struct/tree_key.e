indexing
	description: "Key of a 3-4-5 tree"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

 class
	TREE_KEY [G]

inherit
	ANY

create
	make

feature -- Initialization

	make (d: G) is
			-- Initialize Current with `d' as `data'.
		do
			data := d
		end

feature -- Access

	data: G
		-- Data associated with Current

	parent: TREE_NODE [G]
		-- Tree Node of Current

feature -- Status report

	pos_in_parent: INTEGER is
			-- position of node in parent.
		require
			has_parent: parent /= Void
		do
			from
				Result := 1
			until
				parent.keys @ Result = Current
			loop
				Result := Result + 1
				check
					no_overflow: Result <= parent.arity - 1
				end
			end			
		end
--| FIXME
--| Christophe, 14 jan 2000
--| Should we implement it as an attribute or as a function?

	number: INTEGER is
			-- position of node in tree.
		require
			has_parent: parent /= Void	
		do
				Result := parent.keys_before_child (pos_in_parent + 1)
					--| Tricky: We ask for the number of keys
					--| before the child who is just after Current.
		end

feature -- Element change

	set_parent (par: like parent) is
			-- Make `par' the parent of Current
		do
			parent := par
		end

feature -- Removal

	delete is
			-- Supress Current
		do
			parent.delete (pos_in_parent)
		end

feature -- Basic operations

	add_right (other: like Current) is
			-- add `other' to the right of Current
		local
			next_node: like parent
		do
			if parent.is_leaf then
				parent.insert_key_and_right_child (other, Void, pos_in_parent + 1)
			else
				next_node := parent.children @ (pos_in_parent +1)
				next_node.insert_first (other)
			end
		end

	add_left (other: like Current) is
			-- add `other' to the left of Current
		local
			previous_node: like parent
		do
			if parent.is_leaf then
				parent.insert_key_and_left_child (other, Void, pos_in_parent)
			else
				previous_node := parent.children @ pos_in_parent
				previous_node.insert_last (other)
			end
		end

end -- class TREE_KEY
