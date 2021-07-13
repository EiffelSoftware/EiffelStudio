note
	description: "[
			Hash sets with hash function provided by HASHABLE and object equality.
			Implementation uses hash tables.
			Search, extension and removal are amortized constant time.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: set, lock
	manual_inv: true
	false_guards: true

frozen class
	V_HASH_SET [G -> V_HASHABLE]

inherit
	V_SET [G]
		redefine
			is_equal_,
			lock,
			forget_iterator
		end

create
	make

feature {NONE} -- Initialization

	make (l: V_HASH_LOCK [G])
			-- Create an empty set with lock `l'.
		note
			status: creator
		require
			l_wrapped: l.is_wrapped
		do
			create table.make (l)
			l.add_client (Current)
		ensure then
			set_empty: set.is_empty
			lock_set: lock = l
			lock_observers_effect: l.observers = old l.observers & table & Current
			table.is_empty
			is_empty
			observers_empty: observers.is_empty
			modify (Current)
			modify_model ("observers", l)
		end

feature -- Initialization

	copy_ (other: V_HASH_SET [G])
			-- Initialize by copying all the items of `other'.
		note
			explicit: wrapping
		require
			lock_wrapped: lock.is_wrapped
			same_lock: lock = other.lock
			no_iterators: observers.is_empty
		do
			if other /= Current then
				unwrap
				other.unwrap
				table.copy_ (other.table)
				other.wrap
				wrap
			end
		ensure
			set_effect: set ~ old other.set
			observers_restored: observers ~ old observers
			other_observers_restored: other.observers ~ old other.observers
			modify_model ("set", Current)
			modify_model ("observers", [Current, other])
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.
		do
			check inv end
			Result := table.count
		end

feature -- Search

	has (v: G): BOOLEAN
			-- Is `v' contained?
			-- (Uses object equality.)
		do
			check inv end
			Result := table.has_key (v)
		end

	item (v: G): G
			-- Element of `set' equivalent to `v' according to object equality.
		do
			check inv end
			Result := table.key (v)
		end

feature -- Iteration

	new_cursor: V_HASH_SET_ITERATOR [G]
			-- New iterator pointing to a position in the set, from which it can traverse all elements by going `forth'.
		note
			status: impure
		do
			create Result.make (Current)
			Result.start
		end

	at (v: G): V_HASH_SET_ITERATOR [G]
			-- New iterator over `Current' pointing at element `v' if it exists and `after' otherwise.
		note
			status: impure
		do
			create Result.make (Current)
			Result.search (v)
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is the abstract state of Current equal to that of `other'?
		do
			check inv; other.inv end
			check table.inv_only ("subjects_definition"); other.table.inv_only ("subjects_definition") end
			Result := table.is_equal_ (other.table)
		end

feature -- Extension

	extend (v: G)
			-- Add `v' to the set.
		do
			check table.inv_only ("items_locked", "locked_definition") end
			check lock.inv_only ("owns_definition") end
			table.force (Void, v)
			check table.inv_only ("locked_definition", "no_duplicates") end
			if not table.domain_has (v).old_ then
				check table.map.domain [v] end
			else
				check table.map.domain = table.map.domain.old_ end
			end
		end

feature -- Removal

	wipe_out
			-- Remove all elements.
		do
			table.lemma_domain
			table.wipe_out
		end

feature -- Implementation

	table: V_HASH_TABLE [G, detachable ANY]
			-- Hash table that stores set elements as keys.

feature -- Specification

	lock: V_HASH_LOCK [G]
			-- Helper object for keeping items consistent.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	forget_iterator (it: V_ITERATOR [G])
			-- Remove `it' from `observers'.
		note
			status: ghost
			explicit: contracts
		do
			check it.inv_only ("subjects_definition", "A2") end
			check attached {V_HASH_SET_ITERATOR [G]} it as hsit then
				hsit.unwrap
				set_observers (observers / hsit)
				check hsit.iterator.inv_only ("subjects_definition", "A2") end
				table.lemma_domain
				check hsit.iterator.inv_only ("owns_definition"); hsit.iterator.list_iterator.inv_only ("default_owns") end
				table.forget_iterator (hsit.iterator)
			end
		end

invariant
	table_exists: table /= Void
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (table)
	set_implementation: set = table.map.domain
	table_values_definition: across set as x all table.map [x] = Void end
	same_lock: lock = table.lock
	observers_type: across observers as o all attached {V_HASH_SET_ITERATOR [G]} o end
	observers_correspond: table.observers.count <= observers.count

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
