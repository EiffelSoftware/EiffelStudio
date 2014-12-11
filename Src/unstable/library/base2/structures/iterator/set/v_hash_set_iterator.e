note
	description: "Iterators over hash sets."
	author: "Nadia Polikarpova"
	model: target, sequence, index

class
	V_HASH_SET_ITERATOR [G]

inherit
	V_SET_ITERATOR [G]
		redefine
			copy
		end

create {V_GENERAL_HASH_SET}
	make

feature {NONE} -- Initialization

	make (s: V_GENERAL_HASH_SET [G])
			-- Create an iterator over `s'.
		do
			target := s
			create list_iterator.make (create {V_LINKED_LIST [G]})
		ensure
			target_effect: target = s
			index_effect: index = 0
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			modify: target, sequence, index
		do
			if other /= Current then
				target := other.target
				list_iterator := other.list_iterator.twin
				bucket_index := other.bucket_index
			end
		ensure then
			target_effect: target = other.target
			sequence_effect: sequence |=| other.sequence
			index_effect: index = other.index
		end

feature -- Access

	target: V_GENERAL_HASH_SET [G]
			-- Set to iterate over.

	item: G
			-- Item at current position.
		do
			Result := list_iterator.item
		end

feature -- Measurement		

	index: INTEGER
			-- Current position.
		do
			if after then
				Result := target.count + 1
			elseif not before then
				Result := count_sum (1, bucket_index - 1) + list_iterator.index
			end
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		do
			Result := bucket_index = 0 or else (bucket_index <= target.capacity and
				(list_iterator.target /= target.buckets [bucket_index] or list_iterator.off))
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		do
			Result := bucket_index > target.capacity
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			Result := not off and list_iterator.is_first and count_sum (1, bucket_index - 1) = 0
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			Result := not off and list_iterator.is_last and count_sum (bucket_index + 1, target.capacity) = 0
		end

feature -- Cursor movement

	search (v: G)
			-- Move to an element equivalent to `v'.
			-- If `v' does not appear, go after.
			-- (Use `target.equivalence'.)
		do
			bucket_index := target.index (v)
			list_iterator.make (target.buckets [bucket_index])
			list_iterator.satisfy_forth (agent target.equivalent (v, ?))
			if list_iterator.after then
				go_after
			end
		end

	start
			-- Go to the first position.
		do
			from
				bucket_index := 1
			until
				bucket_index > target.capacity or else not target.buckets [bucket_index].is_empty
			loop
				bucket_index := bucket_index + 1
			end
			if bucket_index <= target.capacity then
				list_iterator.make (target.buckets [bucket_index])
				list_iterator.start
			end
		end

	finish
			-- Go to the last position.
		do
			from
				bucket_index := target.capacity
			until
				bucket_index < 1 or else not target.buckets [bucket_index].is_empty
			loop
				bucket_index := bucket_index - 1
			end
			if bucket_index >= 1 then
				list_iterator.make (target.buckets [bucket_index])
				list_iterator.finish
			end
		end

	forth
			-- Move one position forward.
		do
			list_iterator.forth
			to_next_bucket
		end

	back
			-- Go one position backwards.
		do
			list_iterator.back
			if list_iterator.before then
				from
					bucket_index := bucket_index - 1
				until
					bucket_index < 1 or else not target.buckets [bucket_index].is_empty
				loop
					bucket_index := bucket_index - 1
				end
				if bucket_index >= 1 then
					list_iterator.make (target.buckets [bucket_index])
					list_iterator.finish
				end
			end
		end

	go_before
			-- Go before any position of `target'.
		do
			bucket_index := 0
		end

	go_after
			-- Go after any position of `target'.
		do
			bucket_index := target.capacity + 1
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		do
			target.remove_at (list_iterator)
			to_next_bucket
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	list_iterator: V_LINKED_LIST_ITERATOR [G]
			-- Iterator inside current bucket.

	bucket_index: INTEGER
			-- Index of current bucket.

feature {NONE} -- Implementation

	count_sum (l, u: INTEGER): INTEGER
			-- Total number of elements in buckets `l' to `u'.
		local
			i: INTEGER
		do
			from
				i := l
			until
				i > u
			loop
				Result := Result + target.buckets [i].count
				i := i + 1
			end
		end

	to_next_bucket
			-- If `list_iterator' is `after' move to the start of next bucket is there is one, otherwise go `after'
		do
			if list_iterator.after then
				from
					bucket_index := bucket_index + 1
				until
					bucket_index > target.capacity or else not target.buckets [bucket_index].is_empty
				loop
					bucket_index := bucket_index + 1
				end
				if bucket_index <= target.capacity then
					list_iterator.make (target.buckets [bucket_index])
					list_iterator.start
				end
			end
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements	in `target'.
		note
			status: specification
		local
			i: INTEGER
		do
			from
				i := 1
				create Result
			until
				i > target.capacity
			loop
				Result := Result + target.buckets [i].sequence
				i := i + 1
			end
		end

invariant
	bucket_index_non_negative: bucket_index >= 0
	-- Cannot guarantee bucket_index <= target.capacity + 1 because target might shrink behind my back
end
