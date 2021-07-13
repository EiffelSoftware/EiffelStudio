note
	description: "[
		Iterators to read from a container in linear order.
		Indexing starts from 1.
	]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, sequence, index_
	manual_inv: true
	false_guards: true

deferred class
	V_ITERATOR [G]

inherit
	V_INPUT_STREAM [G]
		rename
			search as search_forth
		redefine
			item,
			search_forth
		end

	ITERATION_CURSOR [G]
		rename
			after as off
		redefine
			item
		end

feature -- Access

	target: V_CONTAINER [G]
			-- Container to iterate over.

	item: G
			-- Item at current position.
		deferred
		ensure then
			definition: Result = sequence [index_]
		end

feature -- Measurement

	index: INTEGER
			-- Current position.
		require
			subjects_closed: subjects.any_item.closed
		deferred
		ensure
			definition: Result = index_
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid position for a cursor?
		note
			status: functional, ghost, nonvariant
		require
			target_exists: target /= Void
			reads (Current, target)
		do
			Result := 0 <= i and i <= target.bag.count + 1
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		deferred
		ensure
			definition: Result = (index_ = 0)
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		require
			target.closed
		deferred
		ensure
			definition: Result = (index_ = sequence.count + 1)
		end

	off: BOOLEAN
			-- Is current position off scope?
		note
			status: nonvariant
		do
			check inv end
			Result := before or after
		ensure then
			new_definition: Result = not sequence.domain [index_]
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		require
			target_closed: target.closed
		deferred
		ensure
			definition: Result = (not sequence.is_empty and index_ = 1)
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		require
			target_closed: target.closed
		deferred
		ensure
			definition: Result = (not sequence.is_empty and index_ = sequence.count)
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		require
			target_closed: target.closed
		deferred
		ensure
			index_effect: index_ = 1
			target_closed: target.closed
			modify_model ("index_", Current)
		end

	finish
			-- Go to the last position.
		require
			target_closed: target.closed
		deferred
		ensure
			index_effect: index_ = sequence.count
			target_closed: target.closed
			modify_model ("index_", Current)
		end

	forth
			-- Go one position forward.
		deferred
		ensure then
			index_effect: index_ = old index_ + 1
		end

	back
			-- Go one position backward.
		require
			not_off: not off
			target_closed: target.closed
		deferred
		ensure
			index_effect: index_ = old index_ - 1
			target_closed: target.closed
			modify_model ("index_", Current)
		end

	go_to (i: INTEGER)
			-- Go to position `i'.
		note
			status: nonvariant
		require
			has_index: valid_index (i)
			target_wrapped: target.is_wrapped
		local
			j: INTEGER
		do
			check inv end
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
				invariant
					is_wrapped
					sequence.domain [i]
					j_in_bounds: 1 <= j and j <= i
					index_counter: index_ = j
				until
					j = i
				loop
					check inv end
					forth
					j := j + 1
				end
			end
		ensure
			index_effect: index_ = i
			modify_model ("index_", Current)
		end

	go_before
			-- Go before any position of `target'.
		deferred
		ensure
			index_effect: index_ = 0
			modify_model ("index_", Current)
		end

	go_after
			-- Go after any position of `target'.
		require
			target_closed: target.closed
		deferred
		ensure
			index_effect: index_ = sequence.count + 1
			target_closed: target.closed
			modify_model ("index_", Current)
		end

	search_forth (v: G)
			-- Move to the first occurrence of `v' at or after current position.
			-- If `v' does not occur, move `after'.
			-- (Use reference equality.)
		note
			status: nonvariant
		do
			check inv_only ("subjects_definition") end
			if before then
				start
			end
			from
			invariant
				is_wrapped
				inv_only ("index_constraint", "box_definition")
				target.is_wrapped
				index_.old_ <= index_ and index_ <= sequence.count + 1
				not before
				across index_.old_.max (1) |..| (index_ - 1) as i all sequence [i] /= v end
			until
				after or else item = v
			loop
				forth
			variant
				sequence.count - index_
			end
		ensure then
			index_effect_not_found: not sequence.tail (old index_).has (v) implies index_ = sequence.count + 1
			index_effect_found: sequence.tail (old index_).has (v) implies index_ >= old index_ and sequence [index_] = v
			index_constraint: not sequence.interval (old index_, index_ - 1).has (v)
		end

	search_back (v: G)
			-- Move to the last occurrence of `v' at or before current position.
			-- If `v' does not occur, move `before'.
			-- (Use reference equality.)
		note
			status: nonvariant
		require
			target_wrapped: target.is_wrapped
		do
			if after then
				finish
			end
			from
			invariant
				is_wrapped
				inv_only ("index_constraint", "subjects_definition")
				target.is_wrapped
				0 <= index_
				index_ <= index_.old_
				index_ <= sequence.count
				across (index_ + 1) |..| index_.old_.min (sequence.count) as i all sequence [i] /= v end
			until
				before or else item = v
			loop
				back
			variant
				index_
			end
		ensure
			index_effect_not_found: not sequence.front (old index_).has (v) implies index_ = 0
			index_effect_found: sequence.front (old index_).has (v) implies
				(sequence [index_] = v and not sequence.interval (index_ + 1, old index_).has (v))
			modify_model ("index_", Current)
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements in `target'.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	index_: INTEGER
			-- Current position.
		note
			status: ghost
			replaces: box
		attribute
		end

invariant
	target_exists: target /= Void
	subjects_definition: subjects ~ create {MML_SET [ANY]}.singleton (target)
	target_bag_constraint: target.bag ~ sequence.to_bag
	index_constraint: 0 <= index_ and index_ <= sequence.count + 1
	box_definition: box ~ if sequence.domain [index_] then create {MML_SET [G]}.singleton (sequence [index_]) else {MML_SET [G]}.empty_set end

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
