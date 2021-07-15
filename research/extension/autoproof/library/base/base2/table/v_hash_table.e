note
	description: "[
			Hash tables with hash function provided by HASHABLE and object equality.
			Implementation uses chaining.
			Search, extension and removal are amortized constant time.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
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
		do
			lock := l
			set_subjects (create {MML_SET [ANY]}.singleton (l))
			l.add_client (Current)
			make_empty_buckets (default_capacity)
		ensure then
			map_empty: map.is_empty
			lock_set: lock = l
			lock_observers_effect: l.observers = old l.observers & Current
			is_empty
			observers_empty: observers.is_empty
			modify (Current)
			modify_model ("observers", l)
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
					∀ i: 1 |..| it.sequence.count ¦ map.domain [it.sequence [i]] = (i < it.index_)
					map.domain <= other.map.domain
					map = other.map | map.domain
					∀ x: other.map.domain - map.domain ¦ not domain_has (x)

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
			modify_model ("map", Current)
			modify_model ("observers", [Current, other])
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
			if attached cell_for_key (k) as c then
				Result := c.item.left
			else
				check
					from_precondition: False
				then
				end
			end
		end

	item alias "[]" (k: K): V assign force
			-- Value associated with `k'.
		do
			if attached cell_for_key (k) as c then
				Result := c.item.right
			else
				check
					from_precondition: False
				then
				end
			end
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
					Result implies ∀ j: 1 |..| (i - 1) ¦
							∀ k: 1 |..| lists [j].sequence.count ¦
								other.map.domain [lists [j].sequence [k].left] and then
								other.map [lists [j].sequence [k].left] = lists [j].sequence [k].right
					not Result implies i > 1 and then not
							(∀ k: 1 |..| lists [i - 1].sequence.count ¦
									other.map.domain [lists [i - 1].sequence [k].left] and then
									other.map [lists [i - 1].sequence [k].left] = lists [i - 1].sequence [k].right)
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
			k.lemma_transitive (domain_item (k), create {MML_SET [K]}.singleton (buckets_ [idx] [i_]))
			map := map.removed (buckets_ [idx] [i_])
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

	cell_for_key (k: K): detachable V_LINKABLE [MML_PAIR [K, V]]
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
			check ∀ j: 1 |..| buckets_ [index (k)].count ¦ buckets_ [index (k)] [j] = lists [index (k)].sequence [j].left end
			if domain_has (k) and then attached Result then
				k.lemma_transitive (Result.item.left, create {MML_SET [K]}.singleton (domain_item (k)))
			end
		ensure
			definition_not_found: not domain_has (k) implies Result = Void
			definition_found: domain_has (k) implies Result /= Void and then
				Result.item.left = domain_item (k) and then map [Result.item.left] = Result.item.right
		end

	cell_equal (list: V_LINKED_LIST [MML_PAIR [K, V]]; k: K): detachable V_LINKABLE [MML_PAIR [K, V]]
			-- Cell of `list' where the key is equal to `k' according to object equality.
			-- Void if the list has no such cell.
		require
			list_closed: list.closed
			k_closed_with_subjects: k.is_closed_with_subjects
			list_keys_closed_with_subjects: ∀ i: 1 |..| list.sequence.count ¦ list.sequence [i].left.is_closed_with_subjects
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
				∀ i: 1 |..| list.sequence.count ¦ not k.is_model_equal (list.sequence [i].left)
			definition_found: Result /= Void implies list.cells.has (Result) and list.sequence.has (Result.item) and k.is_model_equal (Result.item.left)
		end

	cell_before (list: V_LINKED_LIST [MML_PAIR [K, V]]; k: K): detachable V_LINKABLE [MML_PAIR [K, V]]
			-- Cell of `list' to the left of the cell where the key is equal to `k' according to object equality.
			-- Void if the first list element is equal to `k'; last cell if no list element is equal to `k'.
		require
			list_closed: list.closed
			not_empty: not list.sequence.is_empty
			k_closed_with_subjects: k.is_closed_with_subjects
			list_keys_closed_with_subjects: ∀ i: 1 |..| list.sequence.count ¦ list.sequence [i].left.is_closed_with_subjects
		local
			j_: INTEGER
		do
			check list.inv_only ("cells_domain", "cells_exist", "cells_first", "first_cell_empty", "sequence_implementation") end
			if attached list.first_cell as c then
				if not k.is_equal_ (c.item.left) then
					from
						j_ := 1
						Result := c
					invariant
						list.inv_only ("cells_domain", "cells_exist", "cells_linked", "cells_first", "cells_last", "first_cell_empty", "sequence_implementation")
						1 <= j_ and j_ <= list.sequence.count
						Result = list.cells [j_]
						list.sequence.domain [j_ + 1] implies Result.right = list.cells [j_ + 1]
						∀ l: 1 |..| j_ ¦ not k.is_model_equal (list.sequence [l].left)
					until
						attached Result.right as r implies k.is_equal_ (r.item.left)
					loop
						Result := r
						j_ := j_ + 1
					variant
						list.sequence.count - j_
					end
				end
			else
				check from_precondition: False then end
			end
		ensure
			definition_not_found: Result /= Void and then Result.right = Void implies
				∀ i: 1 |..| list.sequence.count ¦ not k.is_model_equal (list.sequence [i].left)
			definition_found_first: Result = Void implies k.is_model_equal (list.sequence.first.left)
			definition_found_later: Result /= Void and then attached Result.right as r implies
				list.cells.has (Result) and list.cells.has (r) and k.is_model_equal (r.item.left)
		end

	make_empty_buckets (n: INTEGER)
			-- Create an empty set with `buckets' of size `n'.
		require
			open: is_open
			n_positive: n > 0
			no_iterators: observers.is_empty
			inv_only ("lock_exists", "subjects_definition", "A2")
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
				∀ j: 1 |..| (i - 1) ¦
						buckets.sequence [j].is_wrapped and
						buckets.sequence [j].is_fresh and
						buckets.sequence [j].sequence.is_empty and
						buckets.sequence [j].observers.is_empty
				∀ k: 1 |..| (i - 1) ¦ ∀ l: 1 |..| (i - 1) ¦
							k /= l implies buckets.sequence [k] /= buckets.sequence [l]
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
			modify_field (["buckets", "count_", "map", "lists", "buckets_", "locked", "bag", "owns", "closed"], Current)
		end

	remove_at (it: V_HASH_TABLE_ITERATOR [K, V])
			-- Remove element to which `it' points.
		require
			wrapped: is_wrapped
			it_open: it.is_open
			valid_target: it.target = Current
			lock_wrapped: lock.is_wrapped
			only_iterator: observers ~ create {MML_SET [ANY]}.singleton (it)
			1 <= it.bucket_index and it.bucket_index <= lists.count
			list_iterator_wrapped: it.list_iterator.is_wrapped
			it.inv_only ("target_which_bucket", "list_iterator_not_off")
		local
			idx_, i_: INTEGER
		do
			unwrap
			idx_ := it.bucket_index
			i_ := it.list_iterator.index_
			check it.list_iterator.inv_only ("subjects_definition", "A2", "sequence_definition") end

			check lists [idx_].observers ~ create {MML_SET [ANY]}.singleton (it.list_iterator) end
			it.list_iterator.remove

			count_ := count_ - 1
			map := map.removed (buckets_ [idx_] [i_])
			buckets_ := buckets_.replaced_at (idx_, buckets_ [idx_].removed_at (i_))
			wrap
		ensure
			wrapped: is_wrapped
			list_iterator_wrapped: it.list_iterator.is_wrapped
			map_effect: map = old (map.removed (buckets_ [it.bucket_index] [it.list_iterator.index_]))
			same_index: it.list_iterator.index_ = old it.list_iterator.index_
			same_lists: lists = old lists
			buckets_effect: buckets_ = old (buckets_.replaced_at (it.bucket_index, buckets_ [it.bucket_index].removed_at (it.list_iterator.index_)))
			modify_model ("map", Current)
			modify_model (["index_", "sequence"], it.list_iterator)
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
			list_keys_owned: ∀ i: 1 |..| list.sequence.count ¦ lock.locked [list.sequence [i].left]
			has_equal: ∃ i: 1 |..| list.sequence.count ¦ k.is_model_equal (list.sequence [i].left)
			no_observers: list.observers.is_empty
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
			modify_model ("sequence", list)
		end

	replace_at (it: V_HASH_TABLE_ITERATOR [K, V]; v: V)
			-- Replace the value at the element to which `it' points.
		require
			wrapped: is_wrapped
			it_open: it.is_open
			valid_target: it.target = Current
			lock_wrapped: lock.is_wrapped
			only_iterator: observers ~ create {MML_SET [ANY]}.singleton (it)
			1 <= it.bucket_index and it.bucket_index <= lists.count
			list_iterator_wrapped: it.list_iterator.is_wrapped
			it.inv_only ("target_which_bucket", "list_iterator_not_off")
		local
			idx_, i_: INTEGER
			x: K
		do
			unwrap
			idx_ := it.bucket_index
			i_ := it.list_iterator.index_
			check it.list_iterator.inv_only ("subjects_definition", "A2", "sequence_definition") end
			x := it.list_iterator.item.left
			check x = buckets_ [idx_] [i_] end

			check lists [idx_].observers ~ create {MML_SET [ANY]}.singleton (it.list_iterator) end
			it.list_iterator.put (create {MML_PAIR [K, V]}.make (x, v))

			map := map.updated (x, v)
			check map.domain = map.domain.old_ end
			wrap
		ensure
			wrapped: is_wrapped
			list_iterator_wrapped: it.list_iterator.is_wrapped
			map_effect: map = old (map.updated (buckets_ [it.bucket_index] [it.list_iterator.index_], v))
			same_index: it.list_iterator.index_ = old it.list_iterator.index_
			modify_field (["map", "bag", "closed"], Current)
			modify_model (["sequence", "box"], it.list_iterator)
		end

	simple_extend (v: V; k: K)
			-- Extend table with key-value pair <`k', `v'> without resizing the buckets.
		require
			wrapped: is_wrapped
			k_locked: lock.locked [k]
			fresh_key: not domain_has (k)
			lock_wrapped: lock.is_wrapped
			no_iterators: observers.is_empty
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
			modify_model ("map", Current)
		end

	auto_resize (new_count: INTEGER)
			-- Resize `buckets' to an optimal size for `new_count'.
		require
			wrapped: is_wrapped
			no_iterators: observers.is_empty
			lock_wrapped: lock.is_wrapped
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
			modify_model ("map", Current)
		end

	resize (c: INTEGER)
			-- Resize `buckets' to `c'.
		require
			wrapped: is_wrapped
			c_positive: c > 0
			no_iterators: observers.is_empty
			lock_wrapped: lock.is_wrapped
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
				∀ j: 1 |..| b.sequence.count ¦ b.sequence [j].is_wrapped
				lists.count = c
				inv_only ("locked_definition")
				locked <= locked.old_
				∀ x: locked ¦ map [x] = map.old_ [x]
				∀ k: 1 |..| buckets_.old_.count ¦ ∀ l: 1 |..| buckets_.old_ [k].count ¦
							map.domain [buckets_.old_ [k] [l]] = (k < i)
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
					∀ k: 1 |..| buckets_.old_.count ¦ ∀ l: 1 |..| buckets_.old_ [k].count ¦
								map.domain [buckets_.old_ [k] [l]] = (k < i or (k = i and l < it.index_))
					locked <= locked.old_
					∀ x: locked ¦ map [x] = map.old_ [x]
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
			modify_model ("map", Current)
		end

	has_list (list: V_LINKED_LIST [MML_PAIR [K, V]]; other: like Current): BOOLEAN
			-- Does `other' contain all elements stored in the bucket `list'?
		require
			list_closed: list.closed
			other_closed: other.closed
			lock_closed: lock.closed
			other_lock_closed: other.lock.closed
			list_items_locked: ∀ j: 1 |..| list.sequence.count ¦ lock.locked [list.sequence [j].left]
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
				Result implies ∀ j: 1 |..| (i_ - 1) ¦
						other.map.domain [list.sequence [j].left] and then other.map [list.sequence [j].left] = list.sequence [j].right
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
			definition: Result = ∀ j: 1 |..| list.sequence.count ¦
						other.map.domain [list.sequence [j].left] and then other.map [list.sequence [j].left] = list.sequence [j].right
		end

feature -- Specification

	map: MML_MAP [K, V]
			-- Map of keys to values.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	buckets_: MML_SEQUENCE [MML_SEQUENCE [K]]
			-- Abstract element storage.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	lock: V_HASH_LOCK [K]
			-- Helper object for keeping items consistent.
		note
			status: ghost
		attribute
			check is_executable: False then end
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
					∀ k: 1 |..| lists.count ¦ lists [k].is_wrapped and then
							lists [k].observers = if k >= j and k /= i
								then lists [k].observers.old_
								else lists [k].observers.old_ / htit.list_iterator end
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
			check is_executable: False then end
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
			check ∀ j: 1 |..| lists [i].cells.count ¦ lists [i].cells [j].inv_only ("default_owns") end
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

			check ∀ i: 1 |..| lists.count ¦ lists [i].inv_only ("owns_definition") end
			check ∀ i: 1 |..| lists.count ¦ ∀ j: 1 |..| lists [i].cells.count ¦ lists [i].cells [j].inv_only ("default_owns") end
			check ∀ i: 1 |..| lists.count ¦ not lists [i].transitive_owns [lock] end
			check not transitive_owns [lock] end
		ensure
			not ownership_domain [lock]
		end

invariant
		-- Abstract state:
	buckets_non_empty: not buckets_.is_empty
	valid_buckets: ∀ x: map.domain ¦ lock.hash.domain [x] and then lock.hash [x] >= 0 and then
			buckets_ [bucket_index (lock.hash [x], buckets_.count)].has (x)
	domain_not_too_small: ∀ i: 1 |..| buckets_.count ¦
			∀ j: 1 |..| buckets_ [i].count ¦ map.domain [buckets_ [i] [j]]
	no_precise_duplicates: ∀ i: 1 |..| buckets_.count ¦ -- ToDo: within is enough?
			∀ j: 1 |..| buckets_.count ¦
				∀ k: 1 |..| buckets_ [i].count ¦
					∀ l: 1 |..| buckets_ [j].count ¦
						i /= j or k /= l implies buckets_ [i] [k] /= buckets_ [j] [l]
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
	lists_counts: ∀ i: 1 |..| buckets_.count ¦ lists [i].sequence.count = buckets_ [i].count
	buckets_content: ∀ i: 1 |..| buckets_.count ¦ ∀ j: 1 |..| buckets_ [i].count ¦ buckets_ [i] [j] = lists [i].sequence [j].left
	map_implementation: ∀ i: 1 |..| buckets_.count ¦ ∀ j: 1 |..| buckets_ [i].count ¦
				map [buckets_ [i] [j]] = lists [i].sequence [j].right
		-- Iterators:
	array_observers: buckets.observers.is_empty
	iterators_type: ∀ o: observers ¦ attached {V_HASH_TABLE_ITERATOR [K, V]} o
	list_observers_same: ∀ i: 1 |..| lists.count ¦ ∀ j: 1 |..| lists.count ¦ lists [i].observers = lists [j].observers
	list_observers_count: ∀ i: 1 |..| lists.count ¦ lists [i].observers.count <= observers.count

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
