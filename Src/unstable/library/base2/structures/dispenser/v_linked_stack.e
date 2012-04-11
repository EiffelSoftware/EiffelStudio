note
	description: "Linked implementation of stacks."
	author: "Nadia Polikarpova"
	model: sequence

class
	V_LINKED_STACK [G]

inherit
	V_STACK [G]
		redefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	default_create
			-- Create an empty stack.
		do
			create list
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
				if list = Void then
					-- Copy used as creation procedure
					list := other.list.twin
				else
					list.copy (other.list)
				end
			end
		ensure then
			sequence_effect: sequence |=| other.sequence
		end

feature -- Access

	item: G
			-- The top element.
		do
			Result := list.first
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		do
			Result := list.count
		end

feature -- Iteration

	new_cursor: V_ITERATOR [G]
			-- New iterator pointing to a position in the container, from which it can traverse all elements by going `forth'.
		do
			create {V_PROXY_ITERATOR [G]} Result.make (Current, list.new_cursor)
		end

feature -- Extension

	extend (v: G)
			-- Push `v' on the stack.
		do
			list.extend_front (v)
		end

feature -- Removal

	remove
			-- Pop the top element.
		do
			list.remove_front
		end

	wipe_out
			-- Pop all elements.
		do
			list.wipe_out
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	list: V_LINKED_LIST [G]
			-- Underlying list.
			-- Should not be reassigned after creation.			
end
