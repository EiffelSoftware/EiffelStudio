note
	description: "[
		Maps where key-value pairs can be updated, added and removed.
		Keys are unique with respect to object equality.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: map, lock
	manual_inv: true
	false_guards: true

deferred class
	V_TABLE [K -> separate ANY, V]

inherit
	V_MAP [K, V]

feature -- Search

	item alias "[]" (k: K): V assign force
			-- Value associated with `k'.
		deferred
		end

feature -- Iteration

	new_cursor: V_TABLE_ITERATOR [K, V]
			-- New iterator pointing to a position in the map, from which it can traverse all elements by going `forth'.
		note
			status: impure
		deferred
		end

feature -- Replacement

	put (v: V; k: K)
			-- Associate `v' with key `k'.
		note
			status: nonvariant
		require
			lock_wrapped: lock.is_wrapped
			k_locked: lock.locked [k]
			has_key: domain_has (k)
			no_iterators: observers.is_empty
		local
			it: V_TABLE_ITERATOR [K, V]
		do
			check inv_only ("locked_non_void", "locked_definition", "lock_non_current", "items_locked", "no_duplicates") end
			check lock.inv_only ("owns_definition", "equivalence_definition") end
			it := at_key (k)
			it.put (v)
			forget_iterator (it)
		ensure
			map_effect: map ~ old map.updated (domain_item (k), v)
			observers_restored: observers ~ old observers
			same_domain: map.domain ~ old map.domain
			modify_model (["map", "observers"], Current)
		end

feature -- Extension

	extend (v: V; k: K)
			-- Extend table with key-value pair <`k', `v'>.
		require
			k_locked: lock.locked [k]
			fresh_key: not domain_has (k)
			lock_wrapped: lock.is_wrapped
			no_iterators: observers.is_empty
		deferred
		ensure
			abstract_effect: domain_has (k)
			map_effect: map ~ old map.updated (k, v)
			modify_model ("map", Current)
		end

	force (v: V; k: K)
			-- Make sure that `k' is associated with `v'.
			-- Add `k' if not already present.
		note
			status: nonvariant
		require
			k_locked: lock.locked [k]
			lock_wrapped: lock.is_wrapped
			no_iterators: observers.is_empty
		local
			it: V_TABLE_ITERATOR [K, V]
		do
			check inv_only ("locked_non_void", "locked_definition", "lock_non_current", "items_locked", "no_duplicates") end
			check lock.inv_only ("owns_definition", "equivalence_definition") end
			it := at_key (k)
			if it.after then
				forget_iterator (it)
				extend (v, k)
			else
				it.put (v)
				forget_iterator (it)
			end
		ensure
			map_effect_has: old domain_has (k) implies map ~ old map.updated (domain_item (k), v)
			map_effect_not_has: not old domain_has (k) implies map ~ old map.updated (k, v)
			observers_restored: observers ~ old observers
			modify_model (["map", "observers"], Current)
		end

feature -- Removal

	remove (k: K)
			-- Remove key `k' and its associated value.
		require
			v_locked: lock.locked [k]
			has_key: domain_has (k)
			lock_wrapped: lock.is_wrapped
			no_iterators: observers.is_empty
		deferred
		ensure
			map_effect: map ~ old map.removed (domain_item (k))
			modify_model ("map", Current)
		end

	wipe_out
			-- Remove all elements.
		require
			no_iterators: observers.is_empty
		deferred
		ensure
			map_effect: map.is_empty
			modify_model ("map", Current)
		end

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
