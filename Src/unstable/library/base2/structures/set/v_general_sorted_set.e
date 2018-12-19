note
	description: "[
			Sets implemented as binary search trees
			with arbitrary order relation and equivalence relation derived from order.
			Search, extension and removal are logarithmic on average.
			Iteration produces a sorted sequence.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: set, order

class
	V_GENERAL_SORTED_SET [G]

inherit
	V_SET [G]
		redefine
			copy
		end

	V_DEFAULT [G]
		undefine
			is_equal,
			out
		redefine
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (o: PREDICATE [G, G])
			-- Create an empty set with elements order `o'.
		require
			--- o_is_total: o.precondition |=| True
			--- o_is_total_order: is_total_order (o)
		do
			order := o
			create tree
		ensure
			set_effect: set.is_empty
			--- order_effect: order |=| o
		end

feature -- Initialization

	copy (other: like Current)
			-- Copy order relation and values values from `other'.
		note
			modify: set, order
		do
			if other /= Current then
				order := other.order
				if tree = Void then
					-- Copy used as a creation procedure
					tree := other.tree.twin
				else
					tree.copy (other.tree)
				end
			end
		ensure then
			set_effect: set |=| other.set
			--- order_effect: order |=| other.order
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		do
			Result := tree.count
		end

feature -- Search

	has (v: G): BOOLEAN
			-- Is `v' contained?
			-- (Uses `equivalence'.)
		do
			Result := cell_equivalent (v) /= Void
		end

	item (v: G): G
			-- Element of `set' equivalent to `v' according to `relation'.
		do
			if attached cell_equivalent (v) as c then
				Result := c.item
			else
				Result := default_value
			end
		end

	order: PREDICATE [G, G]
			-- Order relation on values.

	less_equal (x, y: G): BOOLEAN
			-- Is `x' <= `y' according to `order'?
		do
			Result := order.item ([x, y])
		ensure
			definition: Result = order.item ([x, y])
		end

	equivalence: PREDICATE [G, G]
			-- Equivalence relation derived from `less_order'.	
		do
			Result := agent (x, y: G): BOOLEAN
				do
					Result := less_equal (x, y) and less_equal (y, x)
				end
		ensure then
			--- definition: Result |=| agent (x, y: G): BOOLEAN -> order (x, y) and order (y, x) 	
		end

feature -- Iteration

	new_cursor: V_SORTED_SET_ITERATOR [G]
			-- New iterator pointing to a position in the set, from which it can traverse all elements by going `forth'.
		do
			create Result.make (Current, tree)
			Result.start
		end

	at (v: G): V_SORTED_SET_ITERATOR [G]
			-- New iterator over `Current' pointing at element `v' if it exists and `off' otherwise.
		do
			create Result.make (Current, tree)
			Result.search (v)
		end

feature -- Extension

	extend (v: G)
			-- Add `v' to the set.
		local
			done: BOOLEAN
			iterator: V_SORTED_SET_ITERATOR [G]
		do
			if tree.is_empty then
				tree.add_root (v)
			else
				from
					create iterator.make (Current, tree)
					iterator.go_root
				until
					done
				loop
					if equivalent (v, iterator.item) then
						done := True
					elseif less_equal (v, iterator.item) then
						if not iterator.has_left then
							iterator.extend_left (v)
							done := True
						else
							iterator.left
						end
					else
						if not iterator.has_right then
							iterator.extend_right (v)
							done := True
						else
							iterator.right
						end
					end
				end
			end
		end

feature -- Removal

	wipe_out
			-- Remove all elements.
		do
			tree.wipe_out
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	tree: V_BINARY_TREE [G]
			-- Element storage.
			-- Should not be reassigned after creation.

	cell_equivalent (v: G): detachable V_BINARY_TREE_CELL [G]
			-- Tree cell where item is equivalent to `v'.
		do
			from
				Result := tree.root
			until
				Result = Void or else equivalent (Result.item, v)
			loop
				if less_equal (v, Result.item) then
					Result := Result.left
				else
					Result := Result.right
				end
			end
		end

feature -- Specification
---	is_total_order (o: PREDICATE [ANY, TUPLE [G, G]])
			-- Is `o' a total order relation?
---		note
---			status: specification
---		deferred
---		ensure
			--- definition: Result = (
			--- (forall x: G :: o (x, x)) and
			--- (forall x, y, z: G :: o (x, y) and o (y, z) implies o (x, z) and
			--- (forall x, y: G :: o (x, y) or o (y, x)))
---		end

invariant
	--- order_is_total: order.precondition |=| True
	--- order_is_total_order: is_total_order (order)
end
