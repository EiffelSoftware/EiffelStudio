note
	description: "[
		Iterators to read from a container in linear order.
		Indexing starts from 1.
	]"
	author: "Nadia Polikarpova"
	model: target, sequence, index

deferred class
	V_ITERATOR [G]

inherit
	V_INPUT_STREAM [G]
		rename
			search as search_forth,
			satisfy as satisfy_forth
		redefine
			is_equal,
			search_forth,
			satisfy_forth
		end

	ITERATION_CURSOR [G]
		rename
			after as off
		redefine
			is_equal
		end

feature -- Access

	target: V_CONTAINER [G]
			-- Container to iterate over.
		deferred
		end

feature -- Measurement

	index: INTEGER
			-- Current position.
		deferred
		end

	count_left: INTEGER
			-- Number of elements left to iterate over.
		do
			Result := target.count - index + 1
		ensure
			definition: Result = target.count - index + 1
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid position for a cursor?
		do
			Result := 0 <= i and i <= target.count + 1
		ensure
			definition: Result = (0 <= i and i <= sequence.count + 1)
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		deferred
		ensure
			definition: Result = (index = 0)
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		deferred
		ensure
			definition: Result = (index = sequence.count + 1)
		end

	off: BOOLEAN
			-- Is current position off scope?
		do
			Result := before or after
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		deferred
		ensure
			definition: Result = (not sequence.is_empty and index = 1)
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		deferred
		ensure
			definition: Result = (not sequence.is_empty and index = sequence.count)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to the same container at the same position?
			-- (Use reference comparison)
		do
			if other = Current then
				Result := True
			else
				Result := target = other.target and index = other.index
			end
		ensure then
			definition: Result = (target = other.target and sequence |=| other.sequence and index = other.index)
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		note
			modify: index
		deferred
		ensure then
			index_effect: index = 1
		end

	finish
			-- Go to the last position.
		note
			modify: index
		deferred
		ensure
			index_effect: index = sequence.count
		end

	forth
			-- Go one position forward.
		note
			modify: index
		deferred
		ensure then
			index_effect: index = old index + 1
		end

	back
			-- Go one position backward.
		note
			modify: index
		require
			not_off: not off
		deferred
		ensure
			index_effect: index = old index - 1
		end

	go_to (i: INTEGER)
			-- Go to position `i'.
		note
			modify: index
		require
			has_index: valid_index (i)
		local
			j: INTEGER
		do
			if i = 0 then
				go_before
			elseif i = target.count + 1 then
				go_after
			elseif i = target.count then
				finish
			else
				from
					start
					j := 1
				until
					j = i
				loop
					forth
					j := j + 1
				end
			end
		ensure
			index_effect: index = i
		end

	go_before
			-- Go before any position of `target'.
		note
			modify: index
		deferred
		ensure
			index_effect: index = 0
		end

	go_after
			-- Go after any position of `target'.
		note
			modify: index
		deferred
		ensure
			index_effect: index = sequence.count + 1
		end

	search_forth (v: G)
			-- Move to the first occurrence of `v' at or after current position.
			-- If `v' does not occur, move `after'.
			-- (Use reference equality.)
		note
			modify: index
		do
			if before then
				start
			end
			from
			until
				after or else item = v
			loop
				forth
			end
		ensure then
			index_effect_not_found: not sequence.tail (old index).has (v) implies index = target.count + 1
			index_effect_found: sequence.tail (old index).has (v) implies
				(sequence [index] = v and not sequence.interval (old index, index - 1).has (v))
		end

	satisfy_forth (pred: PREDICATE [G])
			-- Move to the first position at or after current where `pred' holds.
			-- If `pred' never holds, move `after'.
		note
			modify: index
		require else
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: target.bag.domain.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
		do
			if before then
				start
			end
			from
			until
				after or else pred.item ([item])
			loop
				forth
			end
		ensure then
			index_effect_not_found: not sequence.tail (old index).range.exists (pred) implies index = target.count + 1
			index_effect_found: sequence.tail (old index).range.exists (pred) implies
				(pred.item ([sequence [index]]) and not sequence.interval (old index, index - 1).range.exists (pred))
		end

	search_back (v: G)
			-- Move to the last occurrence of `v' at or before current position.
			-- If `v' does not occur, move `before'.
			-- (Use reference equality.)
		note
			modify: index
		do
			if after then
				finish
			end
			from
			until
				before or else item = v
			loop
				back
			end
		ensure
			index_effect_not_found: not sequence.front (old index).has (v) implies index = 0
			index_effect_found: sequence.front (old index).has (v) implies
				(sequence [index] = v and not sequence.interval (index + 1, old index).has (v))
		end

	satisfy_back (pred: PREDICATE [G])
			-- Move to the first position at or before current where `p' holds.
			-- If `pred' never holds, move `after'.
		note
			modify: index
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: target.bag.domain.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
		do
			if after then
				finish
			end
			from
			until
				before or else pred.item ([item])
			loop
				back
			end
		ensure
			index_effect_not_found: not sequence.front (old index).range.exists (pred) implies index = 0
			index_effect_found: sequence.front (old index).range.exists (pred) implies
				(pred.item ([sequence [index]]) and not sequence.interval (index + 1, old index).range.exists (pred))
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements in `target'.
		note
			status: specification
		deferred
		end

invariant
	target_bag_constraint: target.bag |=| sequence.to_bag
	index_constraint: 0 <= index and index <= sequence.count + 1
	box_definition_empty: not sequence.domain [index] implies box.is_empty
	box_definition_non_empty: sequence.domain [index] implies box |=| create {MML_SET [G]}.singleton (sequence [index])
end
