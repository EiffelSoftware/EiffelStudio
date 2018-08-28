note
	description: "[
		Container where all elements are unique with respect to object equality. 
		Elements can be added and removed.
		]"
	author: "Nadia Polikarpova"
	model: set, lock
	manual_inv: true
	false_guards: true

deferred class
	V_SET [G]

inherit
	V_CONTAINER [G]
		rename
			has as has_exactly
		redefine
			count,
			is_empty,
			occurrences,
			is_model_equal
		end

	V_LOCKER [G]
		rename
			locked as set
		redefine
			set,
			is_model_equal
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		deferred
		ensure then
			definition_set: Result = set.count
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is container empty?
		note
			status: nonvariant
		do
			check inv end
			Result := count = 0
		ensure then
			definition_set: Result = set.is_empty
		end

feature -- Search

	has (v: G): BOOLEAN
			-- Is `v' contained?
			-- (Uses object equality.)
		require
			v_closed_with_subjects: v.is_closed_with_subjects
			lock_closed: lock.closed
		deferred
		ensure
			definition: Result = set_has (v)
		end

	item (v: G): G
			-- Element of `set' equivalent to `v' according to object equality.
		require
			v_closed_with_subjects: v.is_closed_with_subjects
			has: set_has (v)
			lock_closed: lock.closed
		deferred
		ensure
			definition: Result = set_item (v)
		end

	occurrences (v: G): INTEGER
			-- How many times is `v' contained?
			-- (Uses reference equality.)
		note
			status: impure, nonvariant
		do
			if has_exactly (v) then
				Result := 1
			end
			check inv end
		end

feature -- Iteration

	new_cursor: V_SET_ITERATOR [G]
			-- New iterator pointing to a position in the set, from which it can traverse all elements by going `forth'.
		note
			status: impure
		deferred
		end

	at (v: G): V_SET_ITERATOR [G]
			-- New iterator over `Current' pointing at element `v' if it exists and `after' otherwise.
		note
			status: impure
		require
			lock_wrapped: lock.is_wrapped
			v_locked: lock.locked [v]
			modify_field (["observers", "closed"], Current)
		deferred
		ensure
			result_fresh: Result.is_fresh
			result_wrapped: Result.is_wrapped and Result.inv
			result_in_observers: observers = old observers & Result
			target_definition: Result.target = Current
			index_definition_found: set_has (v) implies Result.sequence [Result.index_] = set_item (v)
			index_definition_not_found: not set_has (v) implies Result.index_ = Result.sequence.count + 1
		end

feature -- Comparison

	is_subset_of (other: V_SET [G]): BOOLEAN
			-- Does `other' have all elements of `Current'?
			-- (Uses object equality.)
		note
			status: impure, nonvariant
		require
			lock_wrapped: lock.is_wrapped
			same_lock: other.lock = lock
			modify_model ("observers", [Current, other])
		local
			it: V_SET_ITERATOR [G]
		do
			Result := True
			if other /= Current then
				from
					it := new_cursor
				invariant
					is_wrapped
					other.is_wrapped
					it.is_wrapped
					inv_only ("lock_non_current", "items_locked")
					other.inv_only ("items_locked")
					lock.inv_only ("owns_definition")
					1 <= it.index_ and it.index_ <= it.sequence.count + 1
					Result implies across 1 |..| (it.index_ - 1) as i all other.set_has (it.sequence [i.item]) end
					not Result implies not other.set_has (it.sequence [it.index_ - 1])
					modify_model ("index_", it)
				until
					it.after or not Result
				loop
					Result := other.has (it.item)
					it.forth
				variant
					it.sequence.count - it.index_
				end
				forget_iterator (it)
			end
			check inv_only ("locked_non_void") end
		ensure
			definition: Result = across set as x all other.set_has (x.item) end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

	is_superset_of (other: V_SET [G]): BOOLEAN
			-- Does `Current' have all elements of `other'?
			-- (Uses object equality..)
		note
			status: impure, nonvariant
		require
			lock_wrapped: lock.is_wrapped
			same_lock: other.lock = lock
			modify_model ("observers", [Current, other])
		do
			Result := other.is_subset_of (Current)
		ensure
			definition: Result = across other.set as x all set_has (x.item) end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

	disjoint (other: V_SET [G]): BOOLEAN
			-- Do no elements of `other' occur in `Current'?
			-- (Uses object equality.)
		note
			status: impure, nonvariant
		require
			lock_wrapped: lock.is_wrapped
			same_lock: other.lock = lock
			modify_model ("observers", [Current, other])
		local
			it: V_SET_ITERATOR [G]
		do
			if other.is_empty then
				Result := True
			elseif other /= Current then
				from
					it := new_cursor
					Result := True
				invariant
					is_wrapped
					other.is_wrapped
					it.is_wrapped
					inv_only ("lock_non_current", "items_locked")
					other.inv_only ("items_locked")
					lock.inv_only ("owns_definition")
					1 <= it.index_ and it.index_ <= it.sequence.count + 1
					Result implies across 1 |..| (it.index_ - 1) as i all not other.set_has (it.sequence [i.item]) end
					not Result implies other.set_has (it.sequence [it.index_ - 1])
					modify_model ("index_", it)
				until
					it.after or not Result
				loop
					Result := not other.has (it.item)
					it.forth
				variant
					it.sequence.count - it.index_
				end
				forget_iterator (it)
			end
			check inv_only ("locked_non_void") end
		ensure
			definition: Result = across set as x all not other.set_has (x.item) end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

feature -- Extension

	extend (v: G)
			-- Add `v' to the set.
		require
			v_locked: lock.locked [v]
			lock_wrapped: lock.is_wrapped
			no_iterators: observers.is_empty
			modify_model ("set", Current)
		deferred
		ensure
			abstract_effect: set_has (v)
			precise_effect_has: old set_has (v) implies set = old set
			precise_effect_new: not old set_has (v) implies set = old set & v
		end

	join (other: V_SET [G])
			-- Add all elements from `other'.
		note
			status: nonvariant
		require
			lock_wrapped: lock.is_wrapped
			same_lock: other.lock = lock
			no_iterators: observers.is_empty
			modify_model ("set", Current)
			modify_model ("observers", [Current, other])
		local
			it: V_SET_ITERATOR [G]
		do
			check inv_only ("locked_non_void") end
			if other /= Current then
				from
					it := other.new_cursor
				invariant
					is_wrapped
					other.is_wrapped
					it.is_wrapped
					inv_only ("lock_non_current", "items_locked")
					other.inv_only ("lock_non_current", "items_locked")
					lock.inv_only ("owns_definition")
					1 <= it.index_ and it.index_ <= it.sequence.count + 1
					set.old_ <= set
					across 1 |..| (it.index_ - 1) as i all set_has (it.sequence [i.item]) end
					across set as x all set.old_ [x.item] or other.set.old_ [x.item] end
					modify_model ("set", Current)
					modify_model ("index_", it)
				until
					it.after
				loop
					extend (it.item)
					it.forth
				variant
					it.sequence.count - it.index_
				end
				other.forget_iterator (it)
			end
		ensure
			has_old: old set <= set
			has_other: across old other.set as y all set_has (y.item) end
			no_extra: across set as x all set.old_ [x.item] or other.set.old_ [x.item] end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

feature -- Removal

	remove (v: G)
			-- Remove `v' from the set, if contained.
			-- Otherwise do nothing.		
		note
			status: nonvariant
		require
			v_locked: lock.locked [v]
			lock_wrapped: lock.is_wrapped
			no_iterators: observers.is_empty
			modify_model (["set", "observers"], Current)
		local
			it: V_SET_ITERATOR [G]
		do
			check inv_only ("lock_non_current", "items_locked", "no_duplicates") end
			check lock.inv_only ("owns_definition", "equivalence_definition") end
			it := at (v)
			if not it.after then
				v.lemma_transitive (it.sequence [it.index_], set / it.sequence [it.index_])
				it.remove
				check it.inv end
			end
			forget_iterator (it)
		ensure
			abstract_effect: not set_has (v)
			precise_effect_not_found: not old set_has (v) implies set = old set
			precise_effect_found: old set_has (v) implies set = old (set / set_item (v))
			observers_restored: observers ~ old observers
		end

	meet (other: V_SET [G])
			-- Keep only elements that are also in `other'.
		note
			status: nonvariant
		require
			lock_wrapped: lock.is_wrapped
			same_lock: lock = other.lock
			no_iterators: observers.is_empty
			modify_model ("set", Current)
			modify_model ("observers", [Current, other])
		local
			it: V_SET_ITERATOR [G]
		do
			check inv_only ("locked_non_void") end
			if other /= Current then
				from
					it := new_cursor
				invariant
					is_wrapped
					other.is_wrapped
					it.is_wrapped
					it.inv
					inv_only ("lock_non_current", "items_locked", "no_duplicates")
					other.inv_only ("lock_non_current", "items_locked")
					lock.inv_only ("owns_definition", "equivalence_definition")
					1 <= it.index_ and it.index_ <= it.sequence.count + 1
					set <= set.old_
					across 1 |..| (it.index_ - 1) as i all other.set_has (it.sequence [i.item]) end
					across set.old_ as y all other.set_has (y.item) implies set [y.item] end
					modify_model ("set", Current)
					modify_model (["sequence", "index_"], it)
				until
					it.after
				loop
					if not other.has (it.item) then
						it.remove
					else
						it.forth
					end
				variant
					it.sequence.count - it.index_
				end
				forget_iterator (it)
			end
		ensure
			only_old: set <= old set
			not_too_few: across old set as y all other.set_has (y.item).old_ = set_has (y.item) end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

	subtract (other: V_SET [G])
			-- Remove elements that are in `other'.
		note
			status: nonvariant
		require
			lock_wrapped: lock.is_wrapped
			same_lock: lock = other.lock
			no_iterators: observers.is_empty
			modify_model ("set", Current)
			modify_model ("observers", [Current, other])
		local
			it: V_SET_ITERATOR [G]
		do
			check inv_only ("locked_non_void") end
			if other /= Current then
				from
					it := other.new_cursor
				invariant
					is_wrapped
					other.is_wrapped
					it.is_wrapped
					inv_only ("lock_non_current", "items_locked", "no_duplicates")
					other.inv_only ("lock_non_current", "items_locked")
					lock.inv_only ("owns_definition", "equivalence_definition")
					1 <= it.index_ and it.index_ <= it.sequence.count + 1
					set <= set.old_
					across 1 |..| (it.index_ - 1) as i all not set_has (it.sequence [i.item]) end
					across set.old_ as y all not other.set_has (y.item) implies set [y.item] end
					observers ~ observers.old_
					modify_model (["set", "observers"], Current)
					modify_model ("index_", it)
				until
					it.after
				loop
					remove (it.item)
					it.forth
				variant
					it.sequence.count - it.index_
				end
				other.forget_iterator (it)
			else
				wipe_out
			end
		ensure
			only_old: set <= old set
			not_too_few: across old set as y all other.set_has (y.item).old_ /= set_has (y.item) end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

	symmetric_subtract (other: V_SET [G])
			-- Keep elements that are only in `Current' or only in `other'.
		note
			status: nonvariant
		require
			lock_wrapped: lock.is_wrapped
			same_lock: lock = other.lock
			no_iterators: observers.is_empty
			modify_model ("set", Current)
			modify_model ("observers", [Current, other])
		local
			it: V_SET_ITERATOR [G]
			seq: MML_SEQUENCE [G]
		do
			check inv_only ("locked_non_void", "lock_non_current") end
			if other /= Current then
				from
					it := other.new_cursor
					seq := it.sequence
					check other.inv_only ("locked_non_void", "lock_non_current", "bag_definition") end
				invariant
					is_wrapped
					it.is_wrapped
					inv_only ("items_locked")
					other.inv_only ("items_locked")
					lock.inv_only ("owns_definition")
					1 <= it.index_ and it.index_ <= seq.count + 1
					across set.old_ as x all other.set_has (x.item).old_ or set [x.item]  end
					across 1 |..| (it.index_ - 1) as j all lock.set_has (set.old_, seq [j.item]) or set [seq [j.item]] end
					across set as x all set.old_ [x.item] or across 1 |..| (it.index_ - 1) as j some x.item = seq [j.item] end end
					observers ~ observers.old_
					modify_model (["set", "observers"], Current)
					modify_model ("index_", it)
				until
					it.after
				loop
					if has (it.item) then
						check it.inv_only ("target_bag_constraint") end
						seq.lemma_no_duplicates
						check other.inv_only ("items_locked", "no_duplicates") end
						check inv_only ("items_locked", "no_duplicates") end
						check lock.inv_only ("equivalence_definition") end
						remove (it.item)
					else
						extend (it.item)
					end
					it.forth
				variant
					seq.count - it.index_
				end
				other.forget_iterator (it)
			else
				wipe_out
			end
		ensure
			set_effect_old: across old set as x all other.set_has (x.item).old_ or set [x.item]  end
			set_effect_other: across other.set.old_ as x all set_has (x.item).old_ or set [x.item] end
			set_effect_new: across set as x all set.old_ [x.item] or other.set.old_ [x.item] end
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

	wipe_out
			-- Remove all elements.
		require
			no_iterators: observers.is_empty
			modify_model ("set", Current)
		deferred
		ensure
			set_effect: set.is_empty
		end

feature -- Specification

	set: MML_SET [G]
			-- Set of elements.
		note
			status: ghost
			replaces: bag
		attribute
		end

	set_has (v: G): BOOLEAN
			-- Does `set' contain an element equal to `v' under object equality?
		note
			status: ghost, functional, nonvariant
		require
			lock_exists: lock /= Void
			v_exists: v /= Void
			set_non_void: set.non_void
			reads_field (["set", "lock"], Current)
			reads (set, v)
		do
			Result := lock.set_has (set, v)
		end

	set_item (v: G): G
			-- Element of `set' that is equal to `v' under object equality.
		note
			status: ghost, functional, nonvariant
		require
			lock_exists: lock /= Void
			v_exists: v /= Void
			v_in_set: set_has (v)
			set_non_void: set.non_void
			reads_field (["set", "lock"], Current)
			reads (set, v)
		do
			Result := lock.set_item (set, v)
		end

	bag_from (s: like set): like bag
			-- A bag that contains all elements of `s' exactly once.
		note
			status: ghost, nonvariant, static
			explicit: contracts
		require
			reads ([])
		local
			x: G
			s1: like set
		do
			from
				s1 := s
			invariant
				s = s1 + Result.domain
				s1.is_disjoint (Result.domain)
				Result.is_constant (1)
				s.count = s1.count + Result.count
				decreases (s1)
			until
				s1.is_empty
			loop
				x := s1.any_item
				Result := Result & x
				s1 := s1 / x
			end
		ensure
			Result.domain = s
			Result.count = s.count
			Result.is_constant (1)
		end

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost, functional, nonvariant
		do
			Result := set ~ other.set
		end

invariant
	bag_definition: bag = bag_from (set)

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
