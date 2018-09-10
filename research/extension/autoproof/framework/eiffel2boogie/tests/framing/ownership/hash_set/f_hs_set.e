note
	description: "Simple hash set (with constant number of buckets). Uses a helper lock object to prevent unwwanted modification of set elements."
	manual_inv: true
	false_guards: true
	model: set, lock

class
	F_HS_SET [G -> F_HS_HASHABLE]

create
	make

feature {NONE} -- Initialization

	make (l: F_HS_LOCK [G])
			-- Create an empty set that will use the lock `l'.
		note
			status: creator
		do
			create buckets.constant ({MML_SEQUENCE [G]}.empty_sequence, 10)
			lock := l
			set_observers ([lock])
		ensure
			set_empty: set.is_empty
			lock_set: lock = l
		end

feature -- Status report

	has (v: G): BOOLEAN
			-- Does the set contain an element equal to `v'?
		require
			v_closed: v.closed
			lock_wrapped: lock.is_wrapped
			set_registered: lock.sets [Current]
		local
			b: MML_SEQUENCE [G]
		do
			check inv; lock.inv_only ("owns_items", "valid_buckets") end
			b := buckets [bucket_index (v.hash_code, buckets.count)]
			Result := b.domain [index_of (b, v)]
		ensure
			definition: Result = set_has (v)
		end

feature -- Modification

	extend (v: G)
			-- Add `v' to the set if not already present.
		require
			v_locked: lock.owns [v]
			lock_wrapped: lock.is_wrapped
			set_registered: lock.sets [Current]
			modify_model ("set", Current)
		local
			idx: INTEGER
			b: MML_SEQUENCE [G]
		do
			check lock.inv_only ("owns_items", "valid_buckets") end
			idx := bucket_index (v.hash_code, buckets.count)
			b := buckets [idx]
			if not b.domain [index_of (b, v)] then
				buckets := buckets.replaced_at (idx, b & v)
				set := set & v
				check set [v] end
			end
			check set_has (v) end
		ensure
			abstract_effect: set_has (v)
			precise_effect_has: old set_has (v) implies set = old set
			precise_effect_new: not old set_has (v) implies set = old set & v
		end

	join (other: F_HS_SET [G])
			-- Add all elements of `other' that are not already present.
			-- (The sets must share the same lock).
		note
			explicit: wrapping
		require
			lock_wrapped: lock.is_wrapped
			set_registered: lock.sets [Current]
			other_registered: lock.sets [other]
			modify_model ("set", Current)
		local
			i, j: INTEGER
			ss: MML_SEQUENCE [MML_SEQUENCE [G]]
			s: MML_SEQUENCE [G]
		do
			check inv_only ("set_non_void") end
			if other /= Current then
				from
					i := 1
					ss := other.buckets
				invariant
					is_wrapped
					other.inv
					1 <= i and i <= ss.count + 1
					across 1 |..| (i - 1) as k all
						across 1 |..| (ss [k.item].count) as l all set_has ((ss [k.item]) [l.item]) end end
					set.old_ <= set
					across set as x all x.item /= Void and then (set.old_ [x.item] or other.set_has (x.item).old_) end
				until
					i > ss.count
				loop
					s := other.buckets [i]
					from
						j := 1
					invariant
						is_wrapped
						lock.inv_only ("owns_items")
						1 <= j and j <= s.count + 1
						set.old_ <= set
						across 1 |..| (j - 1) as l all set_has (s [l.item]) end
						across 1 |..| (i - 1) as k all
							across 1 |..| (ss [k.item].count) as l all set_has ((ss [k.item]) [l.item]) end end
						across set as x all x.item /= Void and then (set.old_ [x.item] or other.set_has (x.item).old_) end
					until
						j > s.count
					loop
						extend (s [j])
						j := j + 1
					end
					i := i + 1
				end
				check lock.inv_only ("valid_buckets") end
			end
		ensure
			has_old: old set <= set
			has_other: across old other.set as y all y.item /= Void and then set_has (y.item) end
			no_extra: across set as x all set_has (x.item).old_ or other.set_has (x.item).old_ end
		end

	remove (v: G)
			-- Remove an element equal to `v' if present.
		require
			v_locked: lock.owns [v]
			lock_wrapped: lock.is_wrapped
			set_registered: lock.sets [Current]
			modify_model ("set", Current)
		local
			b: MML_SEQUENCE [G]
			idx, i: INTEGER
			x: G
		do
			check lock.inv_only ("owns_items", "valid_buckets", "no_duplicates") end
			idx := bucket_index (v.hash_code, buckets.count)
			b := buckets [idx]
			i := index_of (b, v)
			if b.domain [i] then
				x := b [i]
				set := set / x
				buckets := buckets.replaced_at (idx, b.removed_at (i))
				x.lemma_transitive (v, set)
			end
		ensure
			abstract_effect: not set_has (v)
			precise_effect_not_found: not old set_has (v) implies set = old set
			precise_effect_found: old set_has (v) implies
				across old set as y some (set = old set / y.item) and v.is_model_equal (y.item) end
		end

	wipe_out
			-- Remove all elements.
		require
			lock_wrapped: lock.is_wrapped
			set_registered: lock.sets [Current]
			modify_model ("set", Current)
		do
			create set
			create buckets.constant ({MML_SEQUENCE [G]}.empty_sequence, buckets.count)
		ensure
			set_empty: set.is_empty
		end

feature {F_HS_SET, F_HS_LOCK} -- Implementation

	bucket_index (hc, n: INTEGER): INTEGER
			-- The bucket an item with hash code `hc' belongs,
			-- if there are `n' buckets in total.
		note
			explicit: contracts
		require
			reads ([])
			n_positive: n > 0
			hc_non_negative: 0 <= hc
		do
			Result := (hc \\ n) + 1
		ensure
			in_bounds: 1 <= Result and Result <= n
		end

	index_of (b: MML_SEQUENCE [G]; v: G): INTEGER
			-- Index in `b' of an element that is equal to `v'.
		require
			v_closed: v.closed
			items_closed: across 1 |..| b.count as j all b [j.item].closed end
		do
			from
				Result := 1
			invariant
				1 <= Result and Result <= b.count + 1
				across 1 |..| (Result - 1) as j all not v.is_model_equal (b [j.item]) end
			until
				Result > b.count or else v.is_model_equal (b [Result])
			loop
				Result := Result + 1
			variant
				b.count - Result
			end
		ensure
			definition_found: b.domain [Result] implies v.is_model_equal (b [Result])
			definition_not_found: not b.domain [Result] implies across 1 |..| b.count as j all not v.is_model_equal (b [j.item]) end
		end

feature -- Specification

	set: MML_SET [G]
			-- Set of elements.
		note
			status: ghost
			guard: inv
		attribute
		end

	buckets: MML_SEQUENCE [MML_SEQUENCE [G]]
			-- Storage.
		note
			guard: inv
		attribute
		end

	lock: F_HS_LOCK [G]
			-- Helper object for keeping items consistent.
		note
			status: ghost
		attribute
		end

	set_has (v: G): BOOLEAN
			-- Does `set' contain an element equal to `v'?
		note
			status: ghost, functional
		require
			v_exists: v /= Void
			set_non_void: set.non_void
			reads (Current, set, v)
		do
			Result := across set as x some v.is_model_equal (x.item) end
		end

	no_duplicates (s: like set): BOOLEAN
			-- Are all objects in `s' unique by value?
		note
			status: ghost, functional
		require
			non_void: s.non_void
			reads (s)
		do
			Result := across s as x all across s as y all x.item /= y.item implies not x.item.is_model_equal (y.item) end end
		end

invariant
	buckets_non_empty: not buckets.is_empty
	observers_definition: observers = [lock]
	set_non_void: set.non_void
	set_not_too_small: across 1 |..| buckets.count as i all
		across 1 |..| buckets [i.item].count as j all set [(buckets [i.item])[j.item]] end end
	no_precise_duplicates: across 1 |..| buckets.count as i all
		across 1 |..| buckets.count as j all
			across 1 |..| buckets [i.item].count as k all
				across 1 |..| buckets [j.item].count as l all
					i.item /= j.item or k.item /= l.item implies (buckets [i.item])[k.item] /= (buckets [j.item])[l.item] end end end end

end
