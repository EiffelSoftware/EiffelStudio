note
	description: "[
		Container where all elements are unique with respect to some equivalence relation. 
		Elements can be added and removed.
		]"
	author: "Nadia Polikarpova"
	updated_by: "Alexander Kogtenkov"
	model: set, equivalence

deferred class
	V_SET [G]

inherit
	V_CONTAINER [G]
		rename
			has as has_exactly
		redefine
			has_exactly,
			occurrences,
			is_equal
		end

feature -- Search

	has (v: G): BOOLEAN
			-- Is `v' contained?
			-- (Uses `equivalence'.)
		deferred
		ensure
			definition: Result = set.exists (agent equivalent (v, ?))
		end

	item (v: G): G
			-- Element of `set' equivalent to `v' according to `relation'.
		require
			has: has (v)
		deferred
		ensure
			Result = (set | agent equivalent (v, ?)).any_item
		end

	equivalence: PREDICATE [G, G]
			-- Equivalence relation on values.
		deferred
		end

	equivalent (x, y: G): BOOLEAN
			-- Are `x' and `y' equivalent according to `equivalence'?
		do
			Result := equivalence.item ([x, y])
		ensure
			definition: Result = equivalence.item ([x, y])
		end

	has_exactly (v: G): BOOLEAN
			-- Is value `v' contained?
			-- (Uses reference equality.)
		local
			i: V_SET_ITERATOR [G]
		do
			i := new_cursor
			i.search (v)
			Result := not i.after and then i.item = v
		end

	occurrences (v: G): INTEGER
			-- How many times is `v' contained?
			-- (Uses reference equality.)
		do
			if has_exactly (v) then
				Result := 1
			end
		end

feature -- Iteration

	new_cursor: V_SET_ITERATOR [G]
			-- New iterator pointing to a position in the set, from which it can traverse all elements by going `forth'.
		deferred
		end

	at (v: G): V_SET_ITERATOR [G]
			-- New iterator over `Current' pointing at element `v' if it exists and `after' otherwise.
		deferred
		ensure
			target_definition: Result.target = Current
			index_definition_found: has (v) implies equivalent (Result.sequence [Result.index], v)
			index_definition_not_found: not has (v) implies Result.index = Result.sequence.count + 1
		end

feature -- Comparison

	is_subset_of (other: V_SET [G]): BOOLEAN
			-- Does `other' have all elements of `Current'?
			-- (Uses `other.equivalence'.)
		do
			Result := for_all (agent other.has)
		ensure
			definition: Result = set.for_all (agent other.has)
		end

	is_superset_of (other: V_SET [G]): BOOLEAN
			-- Does `Current' have all elements of `other'?
			-- (Uses `equivalence'.)
		do
			Result := other.is_subset_of (Current)
		ensure
			definition: Result = other.set.for_all (agent has)
		end

	disjoint (other: V_SET [G]): BOOLEAN
			-- Do no elements of `other' occur in `Current'?
			-- (Uses `equivalence'.)
		do
			Result := not other.exists (agent has)
		ensure
			definition: Result = not other.set.exists (agent has)
		end

	is_equal (other: like Current): BOOLEAN
			-- Does `other' has equivalent elements (with respect to both `equivalence' and `other.equivalence')?
		local
			i, j: V_SET_ITERATOR [G]
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
					j.search (i.item)
					Result := not j.after and then equivalent (i.item, j.item)
					i.forth
				end
			end
		ensure then
			definition: Result = (set.count = other.set.count and
				set.for_all (agent (x: G; o: like Current): BOOLEAN
					do
						Result := o.has (x) and then equivalent (x, o.item (x))
					end (?, other)))
		end

feature -- Extension

	extend (v: G)
			-- Add `v' to the set.
		note
			modify: set
		deferred
		ensure
			set_effect_not_has: not old has (v) implies set |=| (old set & v)
			set_effect_has: old has (v) implies set |=| old set
		end

	join (other: V_SET [G])
			-- Add all elements from `other'.
		note
			modify: set
		local
			other_iterator: V_SET_ITERATOR [G]
		do
			if other /= Current then
				from
					other_iterator := other.new_cursor
				until
					other_iterator.after
				loop
					extend (other_iterator.item)
					other_iterator.forth
				end
			end
		ensure
			set_effect_old: (old set).for_all (agent has)
			set_effect_other: other.set.for_all (agent has)
			set_effect_new: set.for_all (agent (x: G; c, o: V_SET [G]): BOOLEAN
				do
					Result := c.has (x) or o.has (x)
				end (?, old Current.twin, other))
		end

feature -- Removal

	remove (v: G)
			-- Remove `v' from the set, if contained.
			-- Otherwise do nothing.		
		note
			modify: set
		local
			iterator: V_SET_ITERATOR [G]
		do
			iterator := at (v)
			if not iterator.after then
				iterator.remove
			end
		ensure
			set_effect_has: old has (v) implies set |=| old (set / item (v))
			set_effect_not_has: not old has (v) implies set |=| old set
		end

	meet (other: V_SET [G])
			-- Keep only elements that are also in `other'.
		note
			modify: set
		local
			iterator: V_SET_ITERATOR [G]
		do
			if other /= Current then
				from
					iterator := new_cursor
				until
					iterator.after
				loop
					if not other.has (iterator.item) then
						iterator.remove
					else
						iterator.forth
					end
				end
			end
		ensure
			set_effect_old: (old set).for_all (agent (x: G; o: V_SET [G]): BOOLEAN
				do
					Result := has (x) = o.has (x)
				end (?, other))
			set_effect_new: set.for_all (agent (old Current.twin).has)
		end

	subtract (other: V_SET [G])
			-- Remove elements that are in `other'.
		note
			modify: set
		local
			other_iterator: V_SET_ITERATOR [G]
		do
			if other = Current then
				wipe_out
			else
				from
					other_iterator := other.new_cursor
				until
					other_iterator.after
				loop
					remove (other_iterator.item)
					other_iterator.forth
				end
			end
		ensure
			set_effect_old: (old set).for_all (agent (x: G; o: V_SET [G]): BOOLEAN
				do
					Result := has (x) or o.has (x)
				end (?, old other.twin))
			set_effect_new: set.for_all (agent (old Current.twin).has)
		end

	symmetric_subtract (other: V_SET [G])
			-- Keep elements that are only in `Current' or only in `other'.
		note
			modify: set
		local
			other_iterator: V_SET_ITERATOR [G]
		do
			if other = Current then
				wipe_out
			else
				from
					other_iterator := other.new_cursor
				until
					other_iterator.after
				loop
					if has (other_iterator.item) then
						remove (other_iterator.item)
					else
						extend (other_iterator.item)
					end
					other_iterator.forth
				end
			end
		ensure
			set_effect_old: (old set).for_all (agent (x: G; o: V_SET [G]): BOOLEAN
				do
					Result := not o.has (x) implies has (x)
				end (?, old other.twin))
			set_effect_other: (old other.set).for_all (agent (x: G; c: V_SET [G]): BOOLEAN
				do
					Result := not c.has (x) implies has (x)
				end (?, old Current.twin))
			set_effect_new: set.for_all (agent (x: G; c, o: V_SET [G]): BOOLEAN
				do
					Result := c.has (x) or o.has (x)
				end (?, old Current.twin, old other.twin))
		end

	wipe_out
			-- Remove all elements.
		note
			modify: set
		deferred
		ensure
			set_effect: set.is_empty
		end

feature -- Specification

	set: MML_SET [G]
			-- Set of elements.
		note
			status: specification
		do
			create Result
			across
				Current as i
			loop
				Result := Result & i.item
			end
		end

---	is_equivalence (r: PREDICATE [ANY, TUPLE [G, G]])
			-- Is `r' an equivalence relation?
---		note
---			status: specification
---		deferred
---		ensure
			--- definition: Result = (
			---	(forall x: G :: r (x, x)) and
			--- (forall x, y: G :: r (x, y) = r (y, x)) and
			--- (forall x, y, z: G :: r (x, y) and r (y, z) implies r (x, z))
---		end		

invariant
	bag_domain_definition: bag.domain |=| set
	bag_definition: bag.is_constant (1)
	--- equivalence_is_total: equivalence.precondition |=| True
	--- equivalence_is_equivalence: is_equivalence (equivalence)
end
