note
	description: "Iterators over mutable sequences that allow only traversal, search and replacement."
	author: "Nadia Polikarpova"
	model: target, sequence, index

class
	V_ARRAY_ITERATOR [G]

inherit
	V_INDEX_ITERATOR [G]
		redefine
			copy
		end

	V_MUTABLE_SEQUENCE_ITERATOR [G]
		undefine
			go_to
		redefine
			copy
		end

create {V_CONTAINER}
	make

feature {NONE} -- Initialization

	make (t: V_MUTABLE_SEQUENCE [G]; i: INTEGER)
			-- Create an iterator at position `i' in `t'.
		do
			target := t
			if i < 1 then
				index := 0
			elseif i > t.count then
				index := t.count + 1
			else
				index := i
			end
		ensure
			target_effect: target = t
			index_effect_has: 1 <= i and i <= t.count implies index = i
			index_effect_before: i < 1 implies index = 0
			index_effect_after: i > t.count implies index = t.count + 1
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and `index' as in `other'.
		note
			modify: target, sequence, index
		do
			target := other.target
			index := other.index
		ensure then
			target_effect: target = other.target
			index_effect: index = other.index
		end

feature -- Access

	target: V_MUTABLE_SEQUENCE [G]
			-- Target container.

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		do
			target.put (v, target.lower + index - 1)
		end
end
