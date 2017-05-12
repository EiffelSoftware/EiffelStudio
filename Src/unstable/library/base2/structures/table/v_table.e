note
	description: "Maps where key-value pairs can be updated, added and removed."
	author: "Nadia Polikarpova"
	updated_by: "Alexander Kogtenkov"
	model: map, key_equivalence

deferred class
	V_TABLE [K, V]

inherit
	V_MAP [K, V]
		redefine
			item,
			is_equal
		end

feature -- Access

	item alias "[]" (k: K): V assign force
			-- Value associated with `k'.
		deferred
		end

feature -- Iteration

	at_key (k: K): V_TABLE_ITERATOR [K, V]
			-- New iterator pointing to a position with key `k'
		deferred
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' have equivalent set of keys (with respect to both `key_equivalence' and `other.key_equivalence'),
			-- and associate them with then same values?
		local
			i, j: V_MAP_ITERATOR [K, V]
		do
			if other = Current then
				Result := True
			elseif count = other.count then
				from
					Result := True
					i := new_cursor
					j := other.new_cursor
				until
					i.after or not Result
				loop
					j.search_key (i.key)
					Result := not j.after and then (equivalent (i.key, j.key) and i.item = j.item)
					i.forth
				end
			end
		ensure then
			definition: Result = (map.count = other.map.count and
				map.domain.for_all (agent (k: K; o: like Current): BOOLEAN
					do
						Result := o.has_key (k) and then (equivalent (k, o.key (k)) and map [k] = o.map [o.key (k)])
					end (?, other)))
		end

feature -- Replacement

	put (v: V; k: K)
			-- Associate `v' with key `k'.
		note
			modify: map
		require
			has_key: has_key (k)
		do
			at_key (k).put (v)
		ensure
			map_effect: map |=| old map.updated (key (k), v)
		end

feature -- Extension

	extend (v: V; k: K)
			-- Extend table with key-value pair <`k', `v'>.
		note
			modify: map
		require
			fresh_key: not has_key (k)
		deferred
		ensure
			map_effect: map |=| old map.updated (k, v)
		end

	force (v: V; k: K)
			-- Make sure that `k' is associated with `v'.
			-- Add `k' if not already present.
		note
			modify: map
		local
			i: V_TABLE_ITERATOR [K, V]
		do
			i := at_key (k)
			if i.after then
				extend (v, k)
			else
				i.put (v)
			end
		ensure
			map_effect_has: old has_key (k) implies map |=| old map.updated (key (k), v)
			map_effect_not_has: not old has_key (k) implies map |=| old map.updated (k, v)
		end

feature -- Removal

	remove (k: K)
			-- Remove key `k' and its associated value.
		note
			modify: map
		require
			has_key: has_key (k)
		deferred
		ensure
			map_effect: map |=| old map.removed (key (k))
		end

	wipe_out
			-- Remove all elements.
		note
			modify: map
		deferred
		ensure
			map_effect: map.is_empty
		end

end
