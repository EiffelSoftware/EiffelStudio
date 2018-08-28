note
	description: "[
			Hash tables with hash function provided by HASHABLE and object equality.
			Implementation uses chaining.
			Search, extension and removal are amortized constant time.
		]"
	author: "Nadia Polikarpova"
	model: map, lock
	manual_inv: true
	false_guards: true

frozen class
	V_HASH_TABLE [K -> V_HASHABLE, V]

inherit
	V_TABLE [K, V]
		redefine
			is_equal_,
			map,
			lock,
			forget_iterator
		end

create
	make

feature {NONE} -- Initialization

	make (l: V_HASH_LOCK [K])
			-- Create an empty table with lock `l'.
		note
			status: creator
			explicit: wrapping
		require
			l_wrapped: l.is_wrapped
			modify (Current)
			modify_model ("observers", l)
		do
			lock := l
			Current.subjects := [l]
			lock.add_client (Current)
			make_empty_buckets (default_capacity)
		ensure then
			map_empty: map.is_empty
			lock_set: lock = l
			observers_empty: observers.is_empty
		end

feature -- Initialization

	copy_ (other: V_HASH_TABLE [K, V])
			-- Initialize by copying all the items of `other'.
		note
			explicit: wrapping
		require
			lock_wrapped: lock.is_wrapped
			same_lock: lock = other.lock
			no_iterators: observers.is_empty
			modify_model ("map", Current)
			modify_model ("observers", [Current, other])
		local
			it: V_HASH_TABLE_ITERATOR [K, V]
		do
			if other /= Current then
				unwrap
				check other.inv_only ("items_locked", "locked_definition", "buckets_owned", "buckets_count", "buckets_non_empty", "lists_definition", "no_duplicates") end
				make_empty_buckets (other.capacity)

				from
					it := other.new_cursor
				invariant
					is_wrapped
					other.is_wrapped
					it.is_wrapped
					lock.inv_only ("locked_non_void", "owns_definition", "equivalence_definition")
					inv_only ("locked_non_void", "locked_definition")
					1 <= it.index_ and it.index_ <= it.sequence.count + 1
					across 1 |..| it.sequence.count as i all map.domain [it.sequence [i.item]] = (i.item < it.index_) end
					map.domain <= other.map.domain
					map = other.map | map.domain
					across other.map.domain - map.domain as x all not domain_has (x.item) end

					modify_model ("map", Current)
					modify_model ("index_", it)
				until
					it.after
				loop
					use_definition (it.value_sequence_from (it.sequence, other.map))
					simple_extend (it.item, it.key)
					it.lemma_sequence_no_duplicates
					it.forth
				variant
					it.sequence.count - it.index_
				end
				check map.domain = other.map.domain end
				other.forget_iterator (it)
			end
		ensure
			map_effect: map ~ old other.map
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		do
			check inv_only ("count_definition", "bag_definition") end
			use_definition (bag_from (map))
			Result := count_
		end

feature -- Search

	has_key (k: K): BOOLEAN
			-- Is key `k' contained?
			-- (Uses object equality.)
		do
			Result := cell_for_key (k) /= Void
		end

	key (k: K): K
			-- Element of `map.domain' equivalent to `v' according to object equality.
		do
			Result := cell_for_key (k).item.left
		end

	item alias "[]" (k: K): V assign force
			-- Value associated with `k'.
		do
			Result := cell_for_key (k).item.right
		end

feature -- Iteration

	new_cursor: V_HASH_TABLE_ITERATOR [K, V]
			-- New iterator pointing to a position in the map, from which it can traverse all elements by going `forth'.
		note
			status: impure
		do
			create Result.make (Current)
			Result.start
		end

	at_key (k: K): V_HASH_TABLE_ITERATOR [K, V]
			-- New iterator pointing to a position with key `k'.
			-- If key does not exist, iterator is off.
		note
			status: impure
		do
			create Result.make (Current)
			Result.search_key (k)
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is the abstract state of Current equal to that of `other'?
		local
			i: INTEGER
			l: V_LINKED_LIST [MML_PAIR [K, V]]
		do
			check inv_only ("count_definition", "subjects_definition") end
			check other.inv_only ("count_definition", "subjects_definition") end
			if count_ = other.count_ then
				from
					Result := True
					i := 1
				invariant
					inv
					1 <= i and i <= lists.count + 1
					Result implies across 1 |..| (i - 1) as j all
						across 1 |..| lists [j.item].sequence.count as k all
							other.map.domain [(lists [j.item].sequence) [k.item].left] and then
							other.map [(lists [j.item].sequence) [k.item].left] = (lists [j.item].sequence) [k.item].right end end
					not Result implies i > 1 and then not
						(across 1 |..| lists [i - 1].sequence.count as k all
							other.map.domain [(lists [i - 1].sequence) [k.item].left] and then
							other.map [(lists [i - 1].sequence) [k.item].left] = (lists [i - 1].sequence) [k.item].right end)
				until
					i > buckets.count or not Result
				loop
					l := buckets [i]
					Result := has_list (l, other)
					i := i + 1
				variant
					lists.count - i
				end
			end
			if Result then
				other.map.domain.lemma_subset (map.domain)
			end
		end

feature -- Extension

	extend (v: V; k: K)
			-- Extend table with key-value pair <`k', `v'>.
		note
			explicit: wrapping
		do
			check lock.inv_only ("owns_definition") end
			check inv_only ("items_locked", "locked_definition") end
			auto_resize (count_ + 1)
			simple_extend (v, k)
		end

feature -- Removal

	remove (k: K)
			-- Remove key `k' and its associated value.
		note
			explicit: wrapping
		local
			idx, i_: INTEGER
		do
			unwrap
			check lock.inv_only ("owns_definition", "equivalence_definition", "hash_definition") end
			idx := index (k)
			i_ := remove_equal (buckets [idx], k)
			count_ := count_ - 1
			k.lemma_transitive (domain_item (k), [(buckets_ [idx]) [i_]])
			map := map.removed ((buckets_ [idx]) [i_])
			buckets_ := buckets_.replaced_at (idx, buckets_ [idx].removed_at (i_))
			wrap
			auto_resize (count_)
		end

	wipe_out
			-- Remove all elements.
		note
			explicit: wrapping
		do
			unwrap
			make_empty_buckets (default_capacity)
		end

feature {NONE} -- Performance parameters

	default_capacity: INTEGER = 16
			-- Default size of `buckets'.		

	target_load_factor: INTEGER = 75
			-- Approximate percentage of elements per bucket that bucket array has after automatic resizing.

	growth_rate: INTEGER = 2
			-- Rate by which bucket array grows and shrinks.			

feature {V_CONTAINER, V_ITERATOR, V_LOCK} -- Implementation

	buckets: V_ARRAY [V_LINKED_LIST [MML_PAIR [K, V]]]
		-- Element storage.
		attribute
		end

	count_: INTEGER
			-- Number of elements.
		attribute
		end

	capacity: INTEGER
			-- Bucket array size.
		require
			buckets_closed: buckets.closed
		do
			Result := buckets.count
		ensure
			definition: Result = buckets.sequence.count
		end

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
			Result := hc \\ n + 1
		ensure
			in_bounds: 1 <= Result and Result <= n
		end

	index (k: K): INTEGER
			-- Index of `k' into in `buckets'.
		require
			k_closed: k.closed
			buckets_closed: buckets.closed
			positive_capacity: buckets.sequence.count > 0
		do
			check k.inv end
			Result := bucket_index (k.hash_code, capacity)
		ensure
			definition: Result = bucket_index (k.hash_code_, buckets.sequence.count)
		end

	cell_for_key (k: K): V_LINKABLE [MML_PAIR [K, V]]
			-- Cell of one of the buckets where the key is equal to `k' according to object equality.
			-- Void if the list has no such cell.
		require
			closed: closed
			k_closed_with_subjects: k.is_closed_with_subjects
			lock_closed: lock.closed
		do
			check inv_only ("locked_definition", "owns_definition", "buckets_non_empty", "buckets_lower", "buckets_count",
				"lists_definition", "lists_counts", "buckets_content", "domain_not_too_small", "map_implementation",
				"items_locked", "no_duplicates", "valid_buckets") end
			check lock.inv_only ("owns_definition", "equivalence_definition", "hash_domain_definition", "hash_definition") end
			Result := cell_equal (buckets [index (k)], k)
			check across 1 |..| buckets_ [index (k)].count as j all (buckets_ [index (k)]) [j.item] = lists [index (k)].sequence [j.item].left end end
			if domain_has (k) then
				k.lemma_transitive (Result.item.left, [domain_item (k)])
			end
		ensure
			definition_not_found: not domain_has (k) implies Result = Void
			definition_found: domain_has (k) implies Result /= Void and then
				Result.item.left = domain_item (k) and then map [Result.item.left] = Result.item.right
		end

	cell_equal (list: V_LINKED_LIST [MML_PAIR [K, V]]; k: K): V_LINKABLE [MML_PAIR [K, V]]
			-- Cell of `list' where the key is equal to `k' according to object equality.
			-- Void if the list has no such cell.
		require
			list_closed: list.closed
			k_closed_with_subjects: k.is_closed_with_subjects
			list_keys_closed_with_subjects: across 1 |..| list.sequence.count as i all list.sequence [i.item].left.is_closed_with_subjects end
		do
			check list.inv_only ("cells_domain", "cells_exist", "cells_linked", "cells_first", "first_cell_empty", "sequence_implementation") end
			if not list.is_empty then
				Result := cell_before (list, k)
				if Result = Void then
					Result := list.first_cell
				else
					Result := Result.right
				end
			end
		ensure
			definition_not_found: Result = Void implies
				across 1 |..| list.sequence.count as i all not k.is_model_equal (list.sequence [i.item].left) end
			definition_found: Result /= Void implies list.cells.has (Result) and list.sequence.has (Result.item) and k.is_model_equal (Result.item.left)
		end

	cell_before (list: V_LINKED_LIST [MML_PAIR [K, V]]; k: K): V_LINKABLE [MML_PAIR [K, V]]
			-- Cell of `list' to the left of the cell where the key is equal to `k' according to object equality.
			-- Void if the first list element is equal to `k'; last cell if no list element is equal to `k'.
		require
			list_closed: list.closed
			not_empty: not list.sequence.is_empty
			k_closed_with_subjects: k.is_closed_with_subjects
			list_keys_closed_with_subjects: across 1 |..| list.sequence.count as i all list.sequence [i.item].left.is_closed_with_subjects end
		local
			j_: INTEGER
		do
			check list.inv_only ("cells_domain", "cells_exist", "cells_first", "first_cell_empty", "sequence_implementation") end
			if not k.is_equal_ (list.first_cell.item.left) then
				from
					j_ := 1
					Result := list.first_cell
				invariant
					list.inv_only ("cells_domain", "cells_exist", "cells_linked", "cells_first", "cells_last", "first_cell_empty", "sequence_implementation")
					1 <= j_ and j_ <= list.sequence.count
					Result = list.cells [j_]
					list.sequence.domain [j_ + 1] implies Result.right = list.cells [j_ + 1]
					across 1 |..| j_ as l all not k.is_model_equal (list.sequence [l.item].left) end
				until
					Result.right = Void or else k.is_equal_ (Result.right.item.left)
				loop
					Result := Result.right
					j_ := j_ + 1
				variant
					list.sequence.count - j_
				end
			end
		ensure
			definition_not_found: Result /= Void and then Result.right = Void implies
				across 1 |..| list.sequence.count as i all not k.is_model_equal (list.sequence [i.item].left) end
			definition_found_first: Result = Void implies k.is_model_equal (list.sequence.first.left)
			definition_found_later: Result /= Void and then Result.right /= Void implies
				list.cells.has (Result) and list.cells.has (Result.right) and k.is_model_equal (Result.right.item.left)
		end

	make_empty_buckets (n: INTEGER)
			-- Create an empty set with `buckets' of size `n'.
		require
			open: is_open
			n_positive: n > 0
			no_iterators: observers.is_empty
			inv_only ("lock_exists", "subjects_definition", "A2")
			modify_field (["buckets", "count_", "map", "lists", "buckets_", "locked", "bag", "owns", "closed"], Current)
		local
			i: INTEGER
		do
			create buckets.make (1, n)
			check buckets.inv_only ("owns_definition"); buckets.area.inv_only ("default_owns") end
			from
				i := 1
			invariant
				1 <= i and i <= n + 1
				buckets.is_wrapped
				buckets.sequence.count = n
				across 1 |..| (i - 1) as j all
					buckets.sequence [j.item].is_wrapped and
					buckets.sequence [j.item].is_fresh and
					buckets.sequence [j.item].sequence.is_empty and
					buckets.sequence [j.item].observers.is_empty
				end
				across 1 |..| (i - 1) as k all across 1 |..| (i - 1) as l all
					k.item /= l.item implies buckets.sequence [k.item] /= buckets.sequence [l.item] end end
				modify_model ("sequence", buckets)
			until
				i > n
			loop
				buckets [i] := create {V_LINKED_LIST [MML_PAIR [K, V]]}
				i := i + 1
			end

			count_ := 0
			create map
			create buckets_.constant ({MML_SEQUENCE [K]}.empty_sequence, buckets.sequence.count)
			check map.domain.is_empty end
			wrap
		ensure
			wrapped: is_wrapped
			map_effect: map.is_empty
			locked_effect: locked.is_empty
			capacity_effect: lists.count = n
		end

	remove_at (it: V_HASH_TABLE_ITERATOR [K, V])
			-- Remove element to which `it' points.
		require
			wrapped: is_wrapped
			it_open: it.is_open
			valid_target: it.target = Current
			lock_wrapped: lock.is_wrapped
			only_iterator: observers = [it]
			1 <= it.bucket_index and it.bucket_index <= lists.count
			list_iterator_wrapped: it.list_iterator.is_wrapped
			it.inv_only ("target_which_bucket", "list_iterator_not_off")
			modify_model ("map", Current)
			modify_model (["index_", "sequence"], it.list_iterator)
		local
			idx_, i_: INTEGER
		do
			unwrap
			idx_ := it.bucket_index
			i_ := it.list_iterator.index_
			check it.list_iterator.inv_only ("subjects_definition", "A2", "sequence_definition") end

			check lists [idx_].observers = [it.list_iterator] end
			it.list_iterator.remove

			count_ := count_ - 1
			map := map.removed ((buckets_ [idx_]) [i_])
			buckets_ := buckets_.replaced_at (idx_, buckets_ [idx_].removed_at (i_))
			wrap
		ensure
			wrapped: is_wrapped
			list_iterator_wrapped: it.list_iterator.is_wrapped
			map_effect: map = old (map.removed ((buckets_ [it.bucket_index]) [it.list_iterator.index_]))
			same_index: it.list_iterator.index_ = old it.list_iterator.index_
			same_lists: lists = old lists
			buckets_effect: buckets_ = old (buckets_.replaced_at (it.bucket_index, buckets_ [it.bucket_index].removed_at (it.list_iterator.index_)))
		end

	remove_equal (list: V_LINKED_LIST [MML_PAIR [K, V]]; k: K): INTEGER
			-- Remove an element where key is equal to `k' from `list'; return the index of the element in the prestate.
		note
			status: impure
		require
			list_wrapped: list.is_wrapped
			not_empty: not list.sequence.is_empty
			lock_wrapped: lock.is_wrapped
			key_locked: lock.locked [k]
			list_keys_owned: across 1 |..| list.sequence.count as i all lock.locked [list.sequence [i.item].left] end
			has_equal: across 1 |..| list.sequence.count as i some k.is_model_equal (list.sequence [i.item].left) end
			no_observers: list.observers.is_empty
			modify_model ("sequence", list)
		local
			c: V_LINKABLE [MML_PAIR [K, V]]
		do
			check lock.inv_only ("owns_definition") end
			c := cell_before (list, k)
			if c = Void then
				Result := 1
				list.remove_front
			else
				Result := list.cells.index_of (c) + 1
				check list.inv_only ("cells_domain", "cells_exist", "cells_linked", "cells_last", "sequence_implementation") end
				list.remove_after (c, Result - 1)
			end
		ensure
			list_wrapped: list.is_wrapped
			found: k.is_model_equal ((old list.sequence) [Result].left)
			removed: list.sequence ~ old list.sequence.removed_at (Result)
		end

	replace_at (it: V_HASH_TABLE_ITERATOR [K, V]; v: V)
			-- Replace the value at the element to which `it' points.
		require
			wrapped: is_wrapped
			it_open: it.is_open
			valid_target: it.target = Current
			lock_wrapped: lock.is_wrapped
			only_iterator: observers = [it]
			1 <= it.bucket_index and it.bucket_index <= lists.count
			list_iterator_wrapped: it.list_iterator.is_wrapped
			it.inv_only ("target_which_bucket", "list_iterator_not_off")
			modify_field (["map", "bag", "closed"], Current)
			modify_model (["sequence", "box"], it.list_iterator)
		local
			idx_, i_: INTEGER
			x: K
		do
			unwrap
			idx_ := it.bucket_index
			i_ := it.list_iterator.index_
			check it.list_iterator.inv_only ("subjects_definition", "A2", "sequence_definition") end
			x := it.list_iterator.item.left
			check x = (buckets_ [idx_]) [i_] end

			check lists [idx_].observers = [it.list_iterator] end
			it.list_iterator.put (create {MML_PAIR [K, V]}.make (x, v))

			map := map.updated (x, v)
			check map.domain = map.domain.old_ end
			wrap
		ensure
			wrapped: is_wrapped
			list_iterator_wrapped: it.list_iterator.is_wrapped
			map_effect: map = old (map.updated ((buckets_ [it.bucket_index]) [it.list_iterator.index_], v))
			same_index: it.list_iterator.index_ = old it.list_iterator.index_
		end

	simple_extend (v: V; k: K)
			-- Extend table with key-value pair <`k', `v'> without resizing the buckets.
		require
			wrapped: is_wrapped
			k_locked: lock.locked [k]
			fresh_key: not domain_has (k)
			lock_wrapped: lock.is_wrapped
			no_iterators: observers.is_empty
			modify_model ("map", Current)
		local
			idx: INTEGER
			list: V_LINKED_LIST [MML_PAIR [K, V]]
		do
			unwrap
			check lock.inv_only ("owns_definition", "equivalence_definition", "hash_domain_definition", "hash_definition") end
			idx := index (k)
			list := buckets [idx]
			list.extend_back (create {MML_PAIR [K, V]}.make (k, v))
			buckets_ := buckets_.replaced_at (idx, buckets_ [idx] & k)
			map := map.updated (k, v)
			count_ := count_ + 1
			wrap
		ensure
			wrapped: is_wrapped
			map_effect: map ~ old map.updated (k, v)
			map_domain_effect: map.domain ~ old map.domain & k
			capacity_unchanged: lists.count = old lists.count
		end

	auto_resize (new_count: INTEGER)
			-- Resize `buckets' to an optimal size for `new_count'.
		require
			wrapped: is_wrapped
			no_iterators: observers.is_empty
			lock_wrapped: lock.is_wrapped
			modify_model ("map", Current)
		do
			check inv end
			if new_count * target_load_factor // 100 > growth_rate * capacity then
				resize (capacity * growth_rate)
			elseif capacity > default_capacity and new_count * target_load_factor // 100 < capacity // growth_rate then
				resize (capacity // growth_rate)
			end
			check inv_only ("locked_definition") end
		ensure
			wrapped: is_wrapped
			map_unchanged: map ~ old map
			locked_unchanged: locked ~ old locked
		end

	resize (c: INTEGER)
			-- Resize `buckets' to `c'.
		require
			wrapped: is_wrapped
			c_positive: c > 0
			no_iterators: observers.is_empty
			lock_wrapped: lock.is_wrapped
			modify_model ("map", Current)
		local
			i: INTEGER
			b: like buckets
			it: V_LINKED_LIST_ITERATOR [MML_PAIR [K, V]]
		do
			b := buckets
			check lock.inv_only ("owns_definition") end
			unwrap
			make_empty_buckets (c)
			from
				i := 1
			invariant
				is_wrapped
				across 1 |..| b.sequence.count as j all b.sequence [j.item].is_wrapped end
				lists.count = c
				inv_only ("locked_definition")
				locked <= locked.old_
				across locked as x all map [x.item] = map.old_ [x.item] end
				across 1 |..| buckets_.old_.count as k all across 1 |..| buckets_.old_ [k.item].count as l all
					map.domain [(buckets_.old_ [k.item])[l.item]] = (k.item < i) end end
				modify_model ("map", Current)
				modify_field (["observers", "closed"], lists.old_.range)
			until
				i > b.count
			loop
				from
					it := b [i].new_cursor
				invariant
					is_wrapped
					it.is_wrapped
					inv_only ("locked_definition")
					1 <= it.index_ and it.index_ <= b.sequence [i].count + 1
					lists.count = c
					across 1 |..| buckets_.old_.count as k all across 1 |..| buckets_.old_ [k.item].count as l all
						map.domain [(buckets_.old_ [k.item])[l.item]] = (k.item < i or (k.item = i and l.item < it.index_)) end end
					locked <= locked.old_
					across locked as x all map [x.item] = map.old_ [x.item] end
					modify_model ("map", Current)
					modify_model ("index_", it)
				until
					it.after
				loop
					check it.inv_only ("sequence_definition") end
					check lock.inv_only ("equivalence_definition") end

					simple_extend (it.item.right, it.item.left)
					it.forth
				variant
					lists.old_ [i].count - it.index_
				end
				i := i + 1
			end
		ensure
			wrapped: is_wrapped
			capacity_effect: lists.count = c
			map_unchanged: map = old map
		end

	has_list (list: V_LINKED_LIST [MML_PAIR [K, V]]; other: like Current): BOOLEAN
			-- Does `other' contain all elements stored in the bucket `list'?
		require
			list_closed: list.closed
			other_closed: other.closed
			lock_closed: lock.closed
			other_lock_closed: other.lock.closed
			list_items_locked: across 1 |..| list.sequence.count as j all lock.locked [list.sequence [j.item].left] end
		local
			c: V_LINKABLE [MML_PAIR [K, V]]
			i_: INTEGER
		do
			check list.inv_only ("cells_domain", "first_cell_empty", "cells_first", "cells_last", "cells_exist", "cells_linked", "sequence_implementation") end
			check lock.inv_only ("owns_definition") end
			check other.lock.inv_only ("owns_definition") end
			from
				Result := True
				c := list.first_cell
				i_ := 1
			invariant
				other.inv_only ("items_locked", "locked_definition")
				1 <= i_ and i_ <= list.sequence.count + 1
				i_ <= list.sequence.count implies c = list.cells [i_]
				i_ = list.sequence.count + 1 implies c = Void
				Result implies across 1 |..| (i_ - 1) as j all
					other.map.domain [list.sequence [j.item].left] and then other.map [list.sequence [j.item].left] = list.sequence [j.item].right end
				not Result implies i_ > 1 and then
					(not other.map.domain [list.sequence [i_ - 1].left] or else other.map [list.sequence [i_ - 1].left] /= list.sequence [i_ - 1].right)
			until
				c = Void or not Result
			loop
				Result := other.has_key (c.item.left) and then
					(other.key (c.item.left) = c.item.left and other.item (c.item.left) = c.item.right)
				if other.domain_has (c.item.left) and not Result then
					check other.inv_only ("no_duplicates") end
					check other.lock.inv_only ("equivalence_definition") end
					c.item.left.lemma_transitive (other.key (c.item.left), other.map.domain / other.key (c.item.left))
				end
				c := c.right
				i_ := i_ + 1
			variant
				list.sequence.count - i_
			end
		ensure
			definition: Result = across 1 |..| list.sequence.count as j all
				other.map.domain [list.sequence [j.item].left] and then other.map [list.sequence [j.item].left] = list.sequence [j.item].right end
		end

feature -- Specification

	map: MML_MAP [K, V]
			-- Map of keys to values.
		note
			status: ghost
		attribute
		end

	buckets_: MML_SEQUENCE [MML_SEQUENCE [K]]
			-- Abstract element storage.
		note
			status: ghost
		attribute
		end

	lock: V_HASH_LOCK [K]
			-- Helper object for keeping items consistent.
		note
			status: ghost
		attribute
		end

	forget_iterator (it: V_ITERATOR [V])
			-- Remove `it' from `observers'.
		note
			status: ghost
			explicit: contracts, wrapping
		local
			i, j: INTEGER
		do
			check it.inv_only ("subjects_definition", "A2") end
			unwrap
			check attached {V_HASH_TABLE_ITERATOR [K, V]} it as htit then
				check htit.inv_only ("target_is_bucket", "owns_definition") end
				check htit.list_iterator.inv_only ("subjects_definition", "default_owns", "A2") end
				i := htit.bucket_index
				htit.unwrap
				set_observers (observers / htit)

				if lists.domain [i] then
					lemma_lists_domain (i)
					lists [i].forget_iterator (htit.list_iterator)
				else
					htit.list_iterator.unwrap
				end

				from
					j := 1
				invariant
					1 <= j and j <= lists.count + 1
					htit.list_iterator.is_open
					across 1 |..| lists.count as k all lists [k.item].is_wrapped and then
						lists [k.item].observers = if k.item >= j and k.item /= i
							then lists [k.item].observers.old_
							else lists [k.item].observers.old_ / htit.list_iterator end end
					inv_only ("A2", "items_locked", "no_duplicates", "valid_buckets")
					modify_field (["observers", "closed"], lists.range)
				until
					j > lists.count
				loop
					if j /= i then
						lists [j].unwrap
						lists [j].observers := lists [j].observers / htit.list_iterator
						lists [j].wrap
					end
					j := j + 1
				end
			end
			wrap
		end

feature {V_CONTAINER, V_ITERATOR, V_LOCK} -- Specification

	lists: MML_SEQUENCE [V_LINKED_LIST [MML_PAIR [K, V]]]
			-- Cache of `buckets.sequence' (required in the invariant of the iterator).
		note
			status: ghost
		attribute
		end

	lemma_lists_domain (i: INTEGER)
			-- `lock' is not in the ownership domain of any of the `lists'.
		note
			status: lemma
		require
			1 <= i and i <= lists.count
			lists [i].closed
		do
			check lists [i].inv_only ("owns_definition") end
			check across 1 |..| lists [i].cells.count as j all lists [i].cells [j.item].inv_only ("default_owns") end end
			check not lists [i].transitive_owns [lock] end
		ensure
			not lists [i].ownership_domain [lock]
		end

	lemma_domain
			-- `lock' is not in the ownership domain of `Current'.
		note
			status: lemma
		require
			closed
		do
			check inv_only ("owns_definition") end
			check buckets.inv_only ("owns_definition"); buckets.area.inv_only ("default_owns") end

			check across 1 |..| lists.count as i all lists [i.item].inv_only ("owns_definition") end end
			check across 1 |..| lists.count as i all across 1 |..| lists [i.item].cells.count as j all lists [i.item].cells [j.item].inv_only ("default_owns") end end end
			check across 1 |..| lists.count as i all not lists [i.item].transitive_owns [lock] end end
			check not transitive_owns [lock] end
		ensure
			not ownership_domain [lock]
		end

invariant
		-- Abstract state:
	buckets_non_empty: not buckets_.is_empty
	valid_buckets: across map.domain as x all lock.hash.domain [x.item] and then lock.hash [x.item] >= 0 and then
		buckets_ [bucket_index (lock.hash [x.item], buckets_.count)].has (x.item) end
	domain_not_too_small: across 1 |..| buckets_.count as i all
		across 1 |..| buckets_ [i.item].count as j all map.domain [(buckets_ [i.item])[j.item]] end end
	no_precise_duplicates: across 1 |..| buckets_.count as i all -- ToDo: within is enough?
		across 1 |..| buckets_.count as j all
			across 1 |..| buckets_ [i.item].count as k all
				across 1 |..| buckets_ [j.item].count as l all
					i.item /= j.item or k.item /= l.item implies (buckets_ [i.item])[k.item] /= (buckets_ [j.item])[l.item] end end end end
		-- Concrete state:
	count_definition: count_ = map.count
	buckets_exist: buckets /= Void
	buckets_owned: owns [buckets]
	buckets_lower: buckets.lower_ = 1
	lists_definition: lists = buckets.sequence
	all_lists_exist: lists.non_void
	owns_definition: owns = create {MML_SET [ANY]}.singleton (buckets) + lists.range
	buckets_count: buckets_.count = lists.count
	lists_distinct: lists.no_duplicates
	lists_counts: across 1 |..| buckets_.count as i all lists [i.item].sequence.count = buckets_ [i.item].count end
	buckets_content: across 1 |..| buckets_.count as i all across 1 |..| buckets_ [i.item].count as j all
		(buckets_ [i.item]) [j.item] = lists [i.item].sequence [j.item].left end end
	map_implementation: across 1 |..| buckets_.count as i all across 1 |..| buckets_ [i.item].count as j all
		map [(buckets_ [i.item]) [j.item]] = lists [i.item].sequence [j.item].right end end
		-- Iterators:
	array_observers: buckets.observers.is_empty
	iterators_type: across observers as o all attached {V_HASH_TABLE_ITERATOR [K, V]} o.item end
	list_observers_same: across 1 |..| lists.count as i all
		across 1 |..| lists.count as j all lists [i.item].observers = lists [j.item].observers end end
	list_observers_count: across 1 |..| lists.count as i all lists [i.item].observers.count <= observers.count end

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
