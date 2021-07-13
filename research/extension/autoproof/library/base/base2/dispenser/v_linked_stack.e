note
	description: "Linked implementation of stacks."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence
	manual_inv: true
	false_guards: true

frozen class
	V_LINKED_STACK [G]

inherit
	V_STACK [G]
		redefine
			default_create,
			is_equal_,
			forget_iterator
		end

feature {NONE} -- Initialization

	default_create
			-- Create an empty stack.
		note
			status: creator
		do
			create list
		ensure then
			sequence_effect: sequence.is_empty
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize by copying all the items of `other'.
		require
			no_observers: observers.is_empty
		do
			if other /= Current then
				other.unwrap
				list.copy_ (other.list)
				other.wrap
			end
		ensure then
			sequence_effect: sequence ~ other.sequence
			modify_model ("sequence", Current)
			modify_field ("closed", other)
		end

feature -- Access

	item: G
			-- The top element.
		do
			check inv end
			check list.transitive_owns <= transitive_owns end
			Result := list.first
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		do
			check inv end
			check list.transitive_owns <= transitive_owns end
			Result := list.count
		end

feature -- Iteration

	new_cursor: V_LINKED_STACK_ITERATOR [G]
			-- New iterator pointing to a position in the container, from which it can traverse all elements by going `forth'.
		note
			status: impure
		do
			create Result.make (Current)
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is stack made of the same values in the same order as `other'?
			-- (Use reference comparison.)
		do
			check inv; other.inv; list.inv; other.list.inv end
			Result := list.is_equal_ (other.list)
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

feature -- Specification

	forget_iterator (it: V_ITERATOR [G])
			-- Remove `it' from `observers'.
		note
			status: ghost
			explicit: contracts
		do
			check it.inv_only ("subjects_definition", "A2") end
			check attached {V_LINKED_STACK_ITERATOR [G]} it as lsit then
				lsit.unwrap
				set_observers (observers / lsit)
				check lsit.iterator.inv_only ("subjects_definition", "A2") end
				list.forget_iterator (lsit.iterator)
			end
		end

invariant
	list_exists: list /= Void
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (list)
	sequence_implementation: sequence ~ list.sequence
	observers_type: across observers as o all attached {V_LINKED_STACK_ITERATOR [G]} o end
	observers_correspond: list.observers.count <= observers.count

note
	explicit: observers
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
