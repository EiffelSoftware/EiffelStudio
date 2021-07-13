note
	description: "Iterators over hash tables."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, sequence, index_
	manual_inv: true
	false_guards: true

class
	V_HASH_TABLE_ITERATOR [K -> V_HASHABLE, V]

inherit
	V_TABLE_ITERATOR [K, V]
		redefine
			is_equal_,
			target
		end

create {V_HASH_TABLE}
	make

feature {NONE} -- Initialization

	make (t: V_HASH_TABLE [K, V])
			-- Create iterator over `t'.
		note
			explicit: contracts, wrapping
		require
			open: is_open
			t_wrapped: t.is_wrapped
			no_observers: observers.is_empty
			not_observing_t: not t.observers [Current]
		local
			i_: INTEGER
		do
			target := t
			t.unwrap

			t.observers := t.observers & Current
			t.lemma_lists_domain (1)
			list_iterator := t.buckets [1].new_cursor
			from
				i_ := 2
			invariant
				2 <= i_ and i_ <= t.lists.count + 1
				across 1 |..| t.lists.count as j all t.lists [j].is_wrapped end
				across 1 |..| (i_ - 1) as j all t.lists [j].observers = t.lists [j].observers.old_ & list_iterator end
				across i_ |..| t.lists.count as j all t.lists [j].observers = t.lists [j].observers.old_ end
				t.inv_only ("A2", "items_locked", "no_duplicates", "valid_buckets")
				modify_field (["observers", "closed"], t.lists.range)
			until
				i_ > t.lists.count
			loop
				t.lemma_lists_domain (i_)
				t.lists [i_].add_iterator (list_iterator)
				i_ := i_ + 1
			end
			t.wrap

			bucket_index := 0
			index_ := 0
			lemma_content (target.buckets_, target.map)
			wrap
		ensure
			wrapped: is_wrapped
			t_wrapped: t.is_wrapped
			target_effect: target = t
			t_observers_effect: t.observers = old t.observers & Current
			list_iterator.is_fresh
			modify_field (["observers", "closed"], t)
			modify (Current)
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			explicit: wrapping
		require
			target_wrapped: target.is_wrapped
			other_target_wrapped: other.target.is_wrapped
			target /= other.target implies not other.target.observers [Current]
		do
			if Current /= other then
				if target /= other.target then
					check inv_only ("no_observers") end
					target.forget_iterator (Current)
					make (other.target)
				end
				go_to_other (other)
			end
		ensure
			target_effect: target = old other.target
			index_effect: index_ = old other.index_
			old_target_wrapped: (old target).is_wrapped
			other_target_wrapped: other.target.is_wrapped
			old_target_observers_effect: other.target /= old target implies (old target).observers = old target.observers / Current
			other_target_observers_effect: other.target /= old target implies other.target.observers = old other.target.observers & Current
			target_observers_preserved: other.target = old target implies other.target.observers = old other.target.observers
			modify (Current)
			modify_model ("observers", [target, other.target])
		end

feature -- Access

	target: V_HASH_TABLE [K, V]
			-- Table to iterate over.

	key: K
			-- Key at current position.
		do
			check inv; target.inv end
			check list_iterator.inv_only ("sequence_definition", "subjects_definition") end
			Result := list_iterator.item.left
			lemma_single_out (target.buckets_, bucket_index)
		end

	item: V
			-- Value at current position.
		do
			check inv; target.inv end
			check list_iterator.inv_only ("sequence_definition", "subjects_definition") end
			Result := list_iterator.item.right
			lemma_single_out (target.buckets_, bucket_index)
			use_definition (value_sequence_from (sequence, target.map))
		end

feature -- Measurement		

	index: INTEGER
			-- Current position.
		do
			check inv; target.inv end
			if after then
				Result := target.count + 1
			elseif not before then
				check list_iterator.inv_only ("subjects_definition") end
				Result := count_sum (1, bucket_index - 1) + list_iterator.index
			end
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		do
			check inv end
			Result := bucket_index = 0
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		do
			check inv; list_iterator.inv_only ("sequence_definition") end
			check target.inv_only ("owns_definition", "lists_definition", "buckets_count", "lists_counts") end
			Result := bucket_index > target.capacity
			if target.buckets_.domain [bucket_index] then
				lemma_single_out (target.buckets_, bucket_index)
			end
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			check inv; list_iterator.inv_only ("sequence_definition") end
			check target.inv_only ("owns_definition", "lists_definition", "buckets_count", "lists_counts") end
			Result := not off and then (list_iterator.is_first and count_sum (1, bucket_index - 1) = 0)
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			check inv; list_iterator.inv_only ("sequence_definition") end
			check target.inv_only ("owns_definition", "lists_definition", "buckets_count", "lists_counts") end
			Result := not off and then (list_iterator.is_last and count_sum (bucket_index + 1, target.capacity) = 0)
			if sequence.domain [index_] then
				lemma_single_out (target.buckets_, bucket_index)
			end
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is iterator traversing the same container and is at the same position at `other'?
		do
			check inv; other.inv end
			if target = other.target then
				check target.inv end
				check list_iterator.inv; other.list_iterator.inv end
				if bucket_index = other.bucket_index then
					Result := not target.buckets.has_index (bucket_index) or list_iterator.is_equal_ (other.list_iterator)
				elseif 1 <= other.bucket_index and other.bucket_index < bucket_index then
					lemma_single_out (target.buckets_.front (bucket_index - 1), other.bucket_index)
					check target.buckets_.front (bucket_index - 1).front (other.bucket_index - 1) = target.buckets_.front (other.bucket_index - 1) end
				elseif 1 <= bucket_index and bucket_index < other.bucket_index then
					lemma_single_out (target.buckets_.front (other.bucket_index - 1), bucket_index)
					check target.buckets_.front (other.bucket_index - 1).front (bucket_index - 1) = target.buckets_.front (bucket_index - 1) end
				end
			end
		end

feature -- Cursor movement

	search_key (k: K)
			-- Move to an element equivalent to `v'.
			-- If `v' does not appear, go after.
			-- (Use object equality.)
		local
			c: V_LINKABLE [MML_PAIR [K, V]]
		do
			check target.inv_only ("items_locked", "locked_non_void", "locked_definition", "buckets_non_empty", "buckets_lower", "buckets_count", "lists_definition",
				"owns_definition", "list_observers_same", "domain_not_too_small", "lists_counts", "buckets_content", "no_duplicates", "valid_buckets") end
			check target.lock.inv end
			bucket_index := target.index (k)
			c := target.cell_equal (target.buckets [bucket_index], k)
			check across 1 |..| target.buckets_ [bucket_index].count as j all (target.buckets_ [bucket_index]) [j] =
				target.lists [bucket_index].sequence [j].left end end
			if c = Void then
				bucket_index := target.capacity + 1
				index_ := concat (target.buckets_).count + 1
			else
				check list_iterator.inv_only ("subjects_definition", "A2", "default_owns") end
				check target.buckets [bucket_index].inv_only ("cells_domain", "owns_definition", "sequence_implementation") end
				list_iterator.switch_target (target.buckets [bucket_index])
				list_iterator.go_to_cell (c)
				check list_iterator.inv_only ("sequence_definition") end
				index_ := concat (target.buckets_.front (bucket_index - 1)).count + list_iterator.index_
				lemma_single_out (target.buckets_, bucket_index)
				k.lemma_transitive (sequence [index_], create {MML_SET [K]}.singleton (target.domain_item (k)))
			end
		end

	start
			-- Go to the first position.
		do
			check target.inv_only ("buckets_count", "owns_definition", "lists_definition", "lists_counts", "buckets_lower", "list_observers_same") end
			from
				bucket_index := 1
			invariant
				1 <= bucket_index and bucket_index <= target.lists.count + 1
				across 1 |..| (bucket_index - 1) as j all target.buckets_ [j].is_empty end
				modify_field ("bucket_index", Current)
			until
				bucket_index > target.capacity or else not target.buckets [bucket_index].is_empty
			loop
				bucket_index := bucket_index + 1
			variant
				target.lists.count - bucket_index
			end
			if bucket_index <= target.capacity then
				check list_iterator.inv_only ("subjects_definition", "A2", "default_owns") end
				check list_iterator.target.observers = target.lists [bucket_index].observers end
				list_iterator.switch_target (target.buckets [bucket_index])
				list_iterator.start
			end
			index_ := 1
			lemma_empty (target.buckets_.front (bucket_index - 1))
			check list_iterator.inv_only ("sequence_definition") end
		end

	finish
			-- Go to the last position.
		do
			check target.inv_only ("buckets_count", "owns_definition", "lists_definition", "lists_counts", "buckets_lower", "list_observers_same") end
			from
				bucket_index := target.capacity
			invariant
				0 <= bucket_index and bucket_index <= target.lists.count
				across (bucket_index + 1) |..| target.lists.count as j all target.buckets_ [j].is_empty end
				modify_field ("bucket_index", Current)
			until
				bucket_index < 1 or else not target.buckets [bucket_index].is_empty
			loop
				bucket_index := bucket_index - 1
			variant
				bucket_index
			end
			if bucket_index >= 1 then
				check list_iterator.inv_only ("subjects_definition", "A2", "default_owns") end
				check list_iterator.target.observers = target.lists [bucket_index].observers end
				list_iterator.switch_target (target.buckets [bucket_index])
				check list_iterator.inv_only ("sequence_definition") end
				list_iterator.finish
				lemma_single_out (target.buckets_, bucket_index)
			end
			index_ := sequence.count
			lemma_empty (target.buckets_.tail (bucket_index + 1))
		end

	forth
			-- Move one position forward.
		note
			explicit: wrapping
		do
			unwrap
			check target.inv_only ("buckets_count", "owns_definition", "lists_definition", "lists_counts", "buckets_lower", "list_observers_same") end
			check list_iterator.inv_only ("sequence_definition", "subjects_definition", "default_owns") end
			list_iterator.forth
			index_ := index_ + 1
			if list_iterator.after then
				to_next_bucket
			else
				wrap
			end
		end

	back
			-- Go one position backwards.
		note
			explicit: wrapping
		do
			unwrap
			check target.inv_only ("buckets_count", "owns_definition", "lists_definition", "lists_counts", "buckets_lower", "list_observers_same") end
			check list_iterator.inv_only ("sequence_definition", "subjects_definition", "default_owns") end
			list_iterator.back
			check list_iterator.inv_only ("default_owns") end
			index_ := index_ - 1
			if list_iterator.before then
				to_prev_bucket
			else
				wrap
			end
		end

	go_before
			-- Go before any position of `target'.
		do
			bucket_index := 0
			index_ := 0
		end

	go_after
			-- Go after any position of `target'.
		do
			check target.inv end
			bucket_index := target.capacity + 1
			index_ := sequence.count + 1
		end

feature -- Replacement

	put (v: V)
			-- Replace item at current position with `v'.
		do
			check target.inv_only ("buckets_count", "lists_counts") end
			lemma_single_out (target.buckets_, bucket_index)

			target.replace_at (Current, v)

			check target.inv end
			lemma_content (target.buckets_, target.map)
			check list_iterator.inv_only ("sequence_definition") end
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		note
			explicit: wrapping
		do
			unwrap
			check target.inv_only ("buckets_count", "lists_counts") end
			lemma_single_out (target.buckets_, bucket_index)

			target.remove_at (Current)

			check target.inv end
			lemma_single_out (target.buckets_, bucket_index)
			check target.buckets_.tail (bucket_index + 1) = (target.buckets_.old_).tail (bucket_index + 1) end
			lemma_content (target.buckets_, target.map)
			sequence := concat (target.buckets_)
			value_sequence := value_sequence_from (sequence, target.map)
			check list_iterator.inv_only ("sequence_definition") end

			if list_iterator.after then
				to_next_bucket
			else
				wrap
			end
		end

feature {V_CONTAINER, V_ITERATOR, V_LOCK} -- Implementation

	list_iterator: V_LINKED_LIST_ITERATOR [MML_PAIR [K, V]]
			-- Iterator inside current bucket.

	bucket_index: INTEGER
			-- Index of current bucket.

	go_to_other (other: like Current)
			-- Move to the same position as `other'.
		require
			wrapped: is_wrapped
			other_closed: other.closed
			not_current: other /= Current
			same_target: target = other.target
			target_closed: target.closed
		do
			unwrap
			bucket_index := other.bucket_index
			check other.inv_only ("owns_definition", "bucket_index_in_bounds", "target_which_bucket") end
			check target.inv_only ("owns_definition", "lists_definition", "buckets_count", "list_observers_same") end

			if 1 <= bucket_index and bucket_index <= target.capacity then
				check inv_only ("target_is_bucket") end
				check list_iterator.inv_only ("subjects_definition", "A2", "default_owns") end
				list_iterator.switch_target (other.list_iterator.target)

				check other.inv_only ("index_not_off", "list_iterator_not_off") end
				check other.list_iterator.inv_only ("sequence_definition", "index_constraint", "cell_not_off") end
				check list_iterator.inv_only ("sequence_definition") end
				check target.lists [bucket_index].inv_only ("cells_domain") end
				check other.list_iterator.inv end
				if attached other.list_iterator.active as a then
					list_iterator.go_to_cell (a)
					list_iterator.target.lemma_cells_distinct
				else
					check from_condition: False then end
				end
			end
			index_ := other.index_

			check other.inv_only ("index_before", "index_after", "index_constraint", "sequence_implementation", "value_sequence_definition") end
			wrap
		ensure
			is_wrapped
			other.closed
			index_effect: index_ = old other.index_
			modify_model ("index_", Current)
		end

feature {NONE} -- Implementation

	count_sum (l, u: INTEGER): INTEGER
			-- Total number of elements in buckets `l' to `u'.
		note
			explicit: contracts
		require
			target_closed: target.closed
			in_bounds: 1 <= l and l <= u + 1 and u <= target.buckets_.count
		local
			i: INTEGER
		do
			from
				i := l
				use_definition (concat (target.buckets_.interval (l, l - 1)))
			invariant
				l <= i and i <= u + 1
				Result = concat (target.buckets_.interval (l, i - 1)).count
			until
				i > u
			loop
				check target.inv end
				Result := Result + target.buckets [i].count
				check target.buckets_.interval (l, i).but_last = target.buckets_.interval (l, i - 1) end
				use_definition (concat (target.buckets_.interval (l, i)))
				i := i + 1
			end
		ensure
			definition: Result = concat (target.buckets_.interval (l, u)).count
		end

	to_next_bucket
			-- Move to the start of next bucket is there is one, otherwise go `after'
		note
			explicit: contracts
		require
			open: is_open
			target_closed: target.closed
			list_iterator_wrapped: list_iterator.is_wrapped
			bucket_index_in_range: target.lists.domain [bucket_index]
			list_iterator_after: list_iterator.index_ = target.lists [bucket_index].sequence.count + 1
			almost_holds: inv_without ("list_iterator_not_off", "box_definition")
		do
			check target.inv_only ("buckets_exist", "lists_definition", "owns_definition", "buckets_lower", "buckets_count", "list_observers_same", "lists_counts") end
			from
				bucket_index := bucket_index + 1
			invariant
				bucket_index.old_ < bucket_index and bucket_index <= target.buckets.sequence.count + 1
				across (bucket_index.old_ + 1) |..| (bucket_index - 1) as i all target.buckets_ [i].is_empty end
				modify_field ("bucket_index", Current)
			until
				bucket_index > target.capacity or else not target.buckets [bucket_index].is_empty
			loop
				bucket_index := bucket_index + 1
			variant
				target.buckets.sequence.count - bucket_index
			end

			lemma_empty (target.buckets_.interval (bucket_index.old_ + 1, bucket_index - 1))

			if bucket_index <= target.capacity then
				check list_iterator.inv_only ("subjects_definition", "A2", "default_owns") end
				list_iterator.switch_target (target.buckets [bucket_index])
				list_iterator.start

				lemma_single_out (target.buckets_.front (bucket_index - 1), bucket_index.old_)
				check target.buckets_.front (bucket_index - 1).front (bucket_index.old_ - 1) = target.buckets_.front (bucket_index.old_ - 1) end
			else
				lemma_single_out (target.buckets_, bucket_index.old_)
			end
			check list_iterator.inv_only ("sequence_definition") end
			wrap
 		ensure
			wrapped: is_wrapped
			modify_field (["bucket_index", "closed", "box"], Current)
			modify (list_iterator)
		end

	to_prev_bucket
			-- Move to the end of previous bucket is there is one, otherwise go `before'
		note
			explicit: contracts
		require
			open: is_open
			target_closed: target.closed
			list_iterator_wrapped: list_iterator.is_wrapped
			bucket_index_in_range: target.lists.domain [bucket_index]
			list_iterator_before: list_iterator.index_ = 0
			almost_holds: inv_without ("list_iterator_not_off", "box_definition")
		do
			check target.inv_only ("buckets_exist", "lists_definition", "owns_definition", "buckets_lower", "buckets_count", "list_observers_same", "lists_counts") end
			from
				bucket_index := bucket_index - 1
			invariant
				0 <= bucket_index and bucket_index < bucket_index.old_
				across (bucket_index + 1) |..| (bucket_index.old_ - 1) as i all target.buckets_ [i].is_empty end
				modify_field ("bucket_index", Current)
			until
				bucket_index < 1 or else not target.buckets [bucket_index].is_empty
			loop
				bucket_index := bucket_index - 1
			variant
				bucket_index
			end

			lemma_empty (target.buckets_.interval (bucket_index + 1, bucket_index.old_ - 1))

			if bucket_index >= 1 then
				check list_iterator.inv_only ("subjects_definition", "A2", "default_owns") end
				list_iterator.switch_target (target.buckets [bucket_index])
				check list_iterator.inv_only ("sequence_definition") end
				list_iterator.finish
				lemma_single_out (target.buckets_.front (bucket_index.old_ - 1), bucket_index)
				check target.buckets_.front (bucket_index.old_ - 1).front (bucket_index - 1) = target.buckets_.front (bucket_index - 1) end
			end
			wrap
 		ensure
			wrapped: is_wrapped
			modify_field (["bucket_index", "closed", "box"], Current)
			modify (list_iterator)
		end

feature {V_CONTAINER, V_ITERATOR} -- Specification

	concat (seqs: like target.buckets_): MML_SEQUENCE [K]
			-- All sequences in `seqs' concatenated together.
		note
			status: functional, ghost, static, opaque
		require
			reads ([])
		do
			Result := if seqs.is_empty then {MML_SEQUENCE [K]}.empty_sequence else concat (seqs.but_last) + seqs.last end
		end

	lemma_append (a, b: like target.buckets_)
			-- Lemma: `concat' distributes over append.
		note
			status: lemma, static
		do
			use_definition (concat (b))
			if b.is_empty then
				check a + b = a end
			else
				check (a + b).but_last = a + b.but_last end
				lemma_append (a, b.but_last)
				use_definition (concat (a + b))
			end
		ensure
			concat (a + b) = concat (a) + concat (b)
		end

	lemma_single_out (seqs: like target.buckets_; i: INTEGER)
			-- Lemma that singles out `seqs [i]' from `concat (seqs)'.
		note
			status: lemma, static
		require
			i_in_bounds: 1 <= i and i <= seqs.count
		do
			use_definition (concat (seqs.front (i)))
			check seqs.front (i).but_last = seqs.front (i - 1) end
			check seqs = seqs.front (i) + seqs.tail (i + 1) end
			lemma_append (seqs.front (i), seqs.tail (i + 1))
		ensure
			concat (seqs) = concat (seqs.front (i - 1)) + seqs [i] + concat (seqs.tail (i + 1))
		end

	lemma_empty (seqs: like target.buckets_)
			-- Lemma: `concat' of empty sequences is an empty sequence.
		note
			status: lemma, static
		require
			all_empty: across 1 |..| seqs.count as i all seqs [i].is_empty end
		do
			use_definition (concat (seqs))
			if seqs.count > 0 then
				lemma_empty (seqs.but_last)
			end
		ensure
			concat (seqs).is_empty
		end

	lemma_content (bs: like target.buckets_; m: like target.map)
			-- If `m.domain' is the set of elements in `bs', then it is also the set elements in `concat (bs)';
			-- and the values in `m' are the same as the values in the `m'-image of `concat (bs)'.
		note
			status: lemma
		require
			target /= Void
			domain_non_void: m.domain.non_void
			domain_not_too_small: across 1 |..| bs.count as i all across 1 |..| bs [i].count as j all m.domain [(bs [i])[j]] end end
			domain_not_too_large: across m.domain as x all across 1 |..| bs.count as i some bs [i].has (x) end end
			no_precise_duplicates: across 1 |..| bs.count as i all across 1 |..| bs.count as j all
					across 1 |..| bs [i].count as k all across 1 |..| bs [j].count as l all
							i /= j or k /= l implies (bs [i])[k] /= (bs [j])[l] end end end end
		do
			use_definition (concat (bs))
			use_definition (value_sequence_from (concat (bs), m))
			use_definition (target.bag_from (m))
			if not bs.is_empty then
				check across 1 |..| (bs.count - 1) as i all bs [i] = bs.but_last [i] end end
				check  (m | (m.domain - bs.last.range)).domain = m.domain - bs.last.range end
				lemma_content (bs.but_last, m | (m.domain - bs.last.range))
				bs.last.lemma_no_duplicates

				use_definition (value_sequence_from (concat (bs.but_last), m | (m.domain - bs.last.range)))
				use_definition (target.bag_from (m | (m.domain - bs.last.range)))
				check (m | (m.domain - bs.last.range)).sequence_image (concat (bs.but_last)) = m.sequence_image (concat (bs.but_last)) end
				check m.sequence_image (concat (bs)) = m.sequence_image (concat (bs.but_last)) + m.sequence_image (bs.last) end
				check m = (m | (m.domain - bs.last.range)) + (m | bs.last.range) end
				m.lemma_sequence_image_bag (bs.last)
			else
				check m.is_empty end
			end
		ensure
			set_constraint: concat (bs).range = m.domain
			value_sequence_from (concat (bs), m).to_bag ~ target.bag_from (m)
		end

invariant
	list_iterator_exists: list_iterator /= Void
	bucket_index_in_bounds: 0 <= bucket_index and bucket_index <= target.lists.count + 1
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (list_iterator)
	target_is_bucket: target.lists.has (list_iterator.target)
	target_which_bucket: target.lists.domain [bucket_index] implies list_iterator.target = target.lists [bucket_index]
	list_iterator_not_off: target.lists.domain [bucket_index] implies 1 <= list_iterator.index_ and list_iterator.index_ <= list_iterator.sequence.count
	sequence_implementation: sequence = concat (target.buckets_)
	index_before: bucket_index = 0 implies index_ = 0
	index_after: bucket_index > target.lists.count implies index_ = concat (target.buckets_).count + 1
	index_not_off: target.lists.domain [bucket_index] implies index_ = concat (target.buckets_.front (bucket_index - 1)).count + list_iterator.index_


note
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
