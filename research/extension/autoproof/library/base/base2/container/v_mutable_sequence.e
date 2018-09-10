note
	description: "Sequences where values can be updated."
	author: "Nadia Polikarpova"
	model: sequence, lower_
	manual_inv: true
	false_guards: true

deferred class
	V_MUTABLE_SEQUENCE [G]

inherit
	V_SEQUENCE [G]
		redefine
			item
		end

feature -- Access

	item alias "[]" (i: INTEGER): G assign put
			-- Value at position `i'.
		deferred
		end

feature -- Iteration

	at (i: INTEGER): V_MUTABLE_SEQUENCE_ITERATOR [G]
			-- New iterator pointing at position `i'.
		note
			status: impure
		deferred
		end

feature -- Replacement

	put (v: G; i: INTEGER)
			-- Replace value at position `i' with `v'.
		require
			has_index: has_index (i)
			observers_open: across observers as o all o.item.is_open end
			modify_model ("sequence", Current)
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.replaced_at (idx (i), v)
		end

	swap (i1, i2: INTEGER)
			-- Swap values at positions `i1' and `i2'.
		note
			status: nonvariant
		require
			has_index_one: has_index (i1)
			has_index_two: has_index (i2)
			observers_open: across observers as o all o.item.is_open end
			modify_model ("sequence", Current)
		local
			v: G
		do
			v := item (i1)
			put (item (i2), i1)
			put (v, i2)
		ensure
			sequence_effect: sequence ~ old sequence.replaced_at (idx(i1), sequence [idx(i2)]).replaced_at (idx(i2), sequence [idx(i1)])
		end

	fill (v: G; l, u: INTEGER)
			-- Put `v' at positions [`l', `u'].
		note
			status: nonvariant
		require
			l_not_too_small: l >= lower_
			u_not_too_large: u <= upper_
			l_not_too_large: l <= u + 1
			observers_open: across observers as o all o.item.is_open end
			modify_model (["sequence", "observers"], Current)
		local
			it: V_MUTABLE_SEQUENCE_ITERATOR [G]
			j: INTEGER
		do
			from
				it := at (l)
				j := l
			invariant
				is_wrapped and it.is_wrapped
				it.inv_only ("sequence_definition")
				it.index_ = idx(j)
				l <= j and j <= u + 1
				upper_ = upper_.old_
				across 1 |..| sequence.count as i all sequence [i.item] = if idx(l) <= i.item and i.item < idx(j) then v else sequence.old_ [i.item] end end
				modify_model (["index_", "sequence"], it)
				modify_model ("sequence", Current)
			until
				j > u
			loop
				it.put (v)
				it.forth
				j := j + 1
			end

			forget_iterator (it)
		ensure
			sequence_domain_effect: sequence.count = old sequence.count
			sequence_changed_effect: across idx (l) |..| idx (u) as i all sequence [i.item] = v end
			sequence_front_unchanged: across 1 |..| idx (l - 1) as i all sequence [i.item] = (old sequence) [i.item] end
			sequence_tail_unchanged: across idx (u + 1) |..| sequence.count as i all sequence [i.item] = (old sequence) [i.item] end
			observers_restored: observers ~ old observers
		end

	clear (l, u: INTEGER)
			-- Put default value at positions [`l', `u'].
		note
			status: nonvariant
		require
			l_not_too_small: l >= lower_
			u_not_too_large: u <= upper_
			l_not_too_large: l <= u + 1
			observers_open: across observers as o all o.item.is_open end
			modify_model (["sequence", "observers"], Current)
		do
			fill (({G}).default, l, u)
		ensure
			sequence_domain_effect: sequence.count = old sequence.count
			sequence_changed_effect: across idx (l) |..| idx (u) as i all sequence [i.item] = ({G}).default end
			sequence_front_unchanged: across 1 |..| idx (l - 1) as i all sequence [i.item] = (old sequence) [i.item] end
			sequence_tail_unchanged: across idx (u + 1) |..| sequence.count as i all sequence [i.item] = (old sequence) [i.item] end
			observers_restored: observers ~ old observers
		end

	copy_range (other: V_SEQUENCE [G]; other_first, other_last, index: INTEGER)
			-- Copy items of `other' within bounds [`other_first', `other_last'] to current sequence starting at index `index'.
		note
			status: nonvariant
		require
			other_not_current: other /= Current
			other_first_not_too_small: other_first >= other.lower_
			other_last_not_too_large: other_last <= other.upper_
			other_first_not_too_large: other_first <= other_last + 1
			index_not_too_small: index >= lower_
			enough_space: upper_ - index >= other_last - other_first
			observers_open: across observers as o all o.item.is_open end
			modify_model (["sequence", "observers"], Current)
			modify_model ("observers", other)
		local
			other_it: V_SEQUENCE_ITERATOR [G]
			it: V_MUTABLE_SEQUENCE_ITERATOR [G]
			j, n: INTEGER
		do
			n := other_last - other_first + 1
			from
				j := 0
				other_it := other.at (other_first)
				it := at (index)
			invariant
				is_wrapped and other.is_wrapped
				it.is_wrapped and other_it.is_wrapped
				it.inv_only ("sequence_definition")
				it.index_ = idx (index + j)
				other_it.index_ = other.idx (other_first + j)
				0 <= j and j <= n
				upper_ = upper_.old_
				across 1 |..| sequence.count as i all not (idx (index) <= i.item and i.item < idx (index + j)) implies
					sequence [i.item] = sequence.old_ [i.item] end
				across 1 |..| sequence.count as i all idx (index) <= i.item and i.item < idx (index + j) implies
					sequence [i.item] = other.sequence [i.item - idx (index) + other.idx (other_first)] end
				modify_model (["index_", "sequence"], it)
				modify_model ("index_", other_it)
				modify_model ("sequence", Current)
			until
				j >= n
			loop
				it.put (other_it.item)
				other_it.forth
				it.forth
				j := j + 1
			end

			other.forget_iterator (other_it)
			forget_iterator (it)
		ensure
			sequence_domain_effect: sequence.count = old sequence.count
			sequence_effect: across 1 |..| sequence.count as i all if idx (index) <= i.item and i.item < idx (index + other_last - other_first + 1)
					then sequence [i.item] = other.sequence [i.item - idx (index) + other.idx (other_first)]
					else sequence [i.item] = (old sequence) [i.item] end end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

	reverse
			-- Reverse the order of elements.
		note
			status: nonvariant
		require
			observers_open: across observers as o all o.item.is_open end
			modify_model (["sequence"], Current)
		local
			j, k: INTEGER
		do
			from
				j := lower
				k := upper
			invariant
				upper_ = upper_.old_
				lower_ <= j and j <= k + 1 and k <= upper_
				k = lower_ + upper_ - j
				across idx (j) |..| idx (k) as i all sequence [i.item] = sequence.old_ [i.item] end
				across 1 |..| idx (j - 1) as i all sequence [i.item] = sequence.old_ [sequence.count - i.item + 1] end
				across idx (k + 1) |..| sequence.count as i all sequence [i.item] = sequence.old_ [sequence.count - i.item + 1] end
				is_wrapped
				observers ~ observers.old_
			until
				j >= k
			loop
				swap (j, k)
				j := j + 1
				k := k - 1
			end
		ensure
			sequence_domain_effect: sequence.count = old sequence.count
			sequence_effect: across 1 |..| sequence.count as i all sequence [i.item] = (old sequence) [sequence.count - i.item + 1] end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
