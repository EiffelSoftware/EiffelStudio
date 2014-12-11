note
	description: "Iterators over containers that store their elements in another container."
	author: "Nadia Polikarpova"
	model: target, sequence, index

class
	V_PROXY_ITERATOR [G]

inherit
	V_ITERATOR [G]
		redefine
			copy
		end

create {V_CONTAINER}
	make

feature {NONE} -- Initialization

	make (t: V_CONTAINER [G]; it: V_ITERATOR [G])
			-- Create a proxy for `it' with target `t'.
		do
			target := t
			iterator := it
		ensure
			target_effect: target = t
			sequence_effect: sequence |=| it.sequence
			index_effect: index = it.index
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize by copying `other'.
		note
			modify: target, sequence, index
		do
			if other /= Current then
				target := other.target
				iterator := other.iterator.twin
			end
		ensure then
			target_effect: target = other.target
			sequence_effect: sequence |=| other.sequence
			index_effect: index = other.index
		end

feature -- Access

	target: V_CONTAINER [G]
			-- Container to iterate over.

	item: G
			-- Item at current position.
		do
			Result := iterator.item
		end

feature -- Measurement		

	index: INTEGER
			-- Current position.
		do
			Result := iterator.index
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		do
			Result := iterator.before
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		do
			Result := iterator.after
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			Result := iterator.is_first
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			Result := iterator.is_last
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		do
			iterator.start
		end

	finish
			-- Go to the last position.
		do
			iterator.finish
		end

	forth
			-- Move one position forward.
		do
			iterator.forth
		end

	back
			-- Go one position backwards.
		do
			iterator.back
		end

	go_before
			-- Go before any position of `target'.
		do
			iterator.go_before
		end

	go_after
			-- Go after any position of `target'.
		do
			iterator.go_after
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	iterator: V_ITERATOR [G]
			-- Iterator over the storage.

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements	in `target'.
		note
			status: specification
		do
			Result := iterator.sequence
		end
end
