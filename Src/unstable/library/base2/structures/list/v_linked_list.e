note
	description: "[
		Singly linked lists.
		Random access takes linear time. 
		Once a position is found, inserting or removing elements to the right of it takes constant time 
		and doesn't require reallocation of other elements.
		]"
	author: "Nadia Polikarpova"
	model: sequence

class
	V_LINKED_LIST [G]

inherit
	V_LIST [G]
		redefine
			default_create,
			copy,
			first,
			last,
			exists,
			put,
			prepend,
			reverse
		end

feature {NONE} -- Initialization

	default_create
			-- Create an empty list.
		do
		ensure then
			sequence_effect: sequence.is_empty
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize by copying all the items of `other'.
		note
			modify: sequence
		do
			if other /= Current then
				wipe_out
				append (other.new_cursor)
			end
		ensure then
			sequence_effect: sequence |=| other.sequence
			other_sequence_effect: other.sequence |=| old other.sequence
		end

feature -- Access

	item alias "[]" (i: INTEGER): G assign put
			-- Value at position `i'.
		do
			if i = count then
				Result := last
			else
				Result := cell_at (i).item
			end
		end

	first: G
			-- First element.
		do
			Result := first_cell.item
		end

	last: G
			-- Last element.
		do
			Result := last_cell.item
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.

feature -- Search

	exists (pred: PREDICATE [ANY, TUPLE [G]]): BOOLEAN
			-- Is there an element that satisfies `pred'?
		do
			Result := cell_satisfying (pred) /= Void
		end

feature -- Iteration

	at (i: INTEGER): V_LINKED_LIST_ITERATOR [G]
			-- New iterator pointing at position `i'.
		do
			create Result.make (Current)
			if i < 1 then
				Result.go_before
			elseif i > count then
				Result.go_after
			else
				Result.go_to (i)
			end
		end

feature -- Replacement

	put (v: G; i: INTEGER)
			-- Associate `v' with index `i'.
		note
			modify: sequence
		do
			cell_at (i).put (v)
		end

	reverse
			-- Reverse the order of elements.
		note
			modify: sequence
		local
			rest, next: V_LINKABLE [G]
		do
			from
				last_cell := first_cell
				rest := first_cell
				first_cell := Void
			until
				rest = Void
			loop
				next := rest.right
				rest.put_right (first_cell)
				first_cell := rest
				rest := next
			end
		end

feature -- Extension

	extend_front (v: G)
			-- Insert `v' at the front.
		local
			cell: V_LINKABLE [G]
		do
			create cell.put (v)
			if is_empty then
				last_cell := cell
			else
				cell.put_right (first_cell)
			end
			first_cell := cell
			count := count + 1
		end

	extend_back (v: G)
			-- Insert `v' at the back.
		local
			cell: V_LINKABLE [G]
		do
			create cell.put (v)
			if is_empty then
				first_cell := cell
			else
				last_cell.put_right (cell)
			end
			last_cell := cell
			count := count + 1
		end

	extend_at (v: G; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			if i = 1 then
				extend_front (v)
			elseif i = count + 1 then
				extend_back (v)
			else
				extend_after (v, cell_at (i - 1))
			end
		end

	prepend (input: V_ITERATOR [G])
			-- Prepend sequence of values, over which `input' iterates.
		local
			it: V_LINKED_LIST_ITERATOR [G]
		do
			if not input.after then
				extend_front (input.item)
				input.forth
				from
					it := new_cursor
				until
					input.after
				loop
					it.extend_right (input.item)
					it.forth
					input.forth
				end
			end
		end

	insert_at (input: V_ITERATOR [G]; i: INTEGER)
			-- Insert sequence of values, over which `input' iterates, starting at position `i'.
		local
			it: V_LINKED_LIST_ITERATOR [G]
		do
			if i = 1 then
				prepend (input)
			else
				from
					it := at (i - 1)
				until
					input.after
				loop
					it.extend_right (input.item)
					it.forth
					input.forth
				end
			end
		end

feature -- Removal

	remove_front
			-- Remove first element.
		do
			if count = 1 then
				last_cell := Void
			end
			first_cell := first_cell.right
			count := count - 1
		end

	remove_back
			-- Remove last element.
		do
			if count = 1 then
				first_cell := Void
				last_cell := Void
				count := 0
			else
				remove_after (cell_at (count - 1))
			end
		end

	remove_at  (i: INTEGER)
			-- Remove element at position `i'.
		do
			if i = 1 then
				remove_front
			else
				remove_after (cell_at (i - 1))
			end
		end

	wipe_out
			-- Remove all elements.
		do
			first_cell := Void
			last_cell := Void
			count := 0
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	first_cell: V_LINKABLE [G]
			-- First cell of the list.

	last_cell: V_LINKABLE [G]
			-- Last cell of the list.

	cell_at (i: INTEGER): V_LINKABLE [G]
			-- Cell at position `i'.
		require
			valid_position: 1 <= i and i <= count
		local
			j: INTEGER
		do
			from
				j := 1
				Result := first_cell
			until
				j = i
			loop
				Result := Result.right
				j := j + 1
			end
		end

	cell_satisfying (pred: PREDICATE [ANY, TUPLE [G]]): V_LINKABLE [G]
			-- Cell where item satisfies `pred'.
		do
			from
				Result := first_cell
			until
				Result = Void or else pred.item ([Result.item])
			loop
				Result := Result.right
			end
		end

	extend_after (v: G; c: V_LINKABLE [G])
			-- Add a new cell with value `v' after `c'.
		require
			c_exists: c /= Void
		local
			new: V_LINKABLE [G]
		do
			create new.put (v)
			if c.right = Void then
				last_cell := new
			else
				new.put_right (c.right)
			end
			c.put_right (new)
			count := count + 1
		end

	remove_after (c: V_LINKABLE [G])
			-- Remove the cell to the right of `c'.
		require
			c_exists: c /= Void
			c_right_exists: c.right /= Void
		do
			c.put_right (c.right.right)
			if c.right = Void then
				last_cell := c
			end
			count := count - 1
		end

	merge_after (other: V_LINKED_LIST [G]; c: V_LINKABLE [G])
			-- Merge `other' into `Current' after cell `c'. If `c' is `Void', merge to the front.
		require
			other_exists: other /= Void
		local
			other_first, other_last: V_LINKABLE [G]
		do
			if not other.is_empty then
				other_first := other.first_cell
				other_last := other.last_cell
				count := count + other.count
				other.wipe_out
				if c = Void then
					if first_cell = Void then
						last_cell := other_last
					else
						other_last.put_right (first_cell)
					end
					first_cell := other_first
				else
					if c.right = Void then
						last_cell := other_last
					else
						other_last.put_right (c.right)
					end
					c.put_right (other_first)
				end
			end
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements.
		note
			status: specification
		local
			c: V_LINKABLE [G]
		do
			create Result
			from
				c := first_cell
			until
				c = Void
			loop
				Result := Result & c.item
				c := c.right
			end
		end

invariant
	first_cell_exists_in_nonempty: is_empty = (first_cell = Void)
	last_cell_exists_in_nonempty: is_empty = (last_cell = Void)
	count_definition: count = sequence.count
end
