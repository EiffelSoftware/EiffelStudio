note
	description: "[
		Indexable containers with arbitrary bounds, whose elements are stored in a continuous memory area.
		Random access is constant time, but resizing requires memory reallocation and copying elements, and takes linear time.
		The logical size of array is the same as the physical size of the underlying memory area.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: map

class
	V_ARRAY [G]

inherit
	V_MUTABLE_SEQUENCE [G]
		redefine
			copy,
			is_equal,
			put,
			fill,
			clear
		end

	V_DEFAULT [G]
		undefine
			out
		redefine
			copy,
			is_equal
		end

create
	make,
	make_filled

feature {NONE} -- Initialization

	make (l, u: INTEGER)
			-- Create array with indexes in [`l', `u']; set all values to default.
		require
			valid_indexes: l <= u + 1
		do
			if l <= u then
				lower := l
				upper := u
			else
				lower := 1
				upper := 0
			end
			create area.make_filled (default_value, upper - lower + 1)
		ensure
			map_domain_effect: map.domain |=| create {MML_INTERVAL}.from_range (l, u)
			map_effect: map.is_constant (default_value)
		end

	make_filled (l, u: INTEGER; v: G)
			-- Create array with indexes in [`l', `u']; set all values to `v'.
		require
			valid_indexes: l <= u + 1
		do
			if l <= u then
				lower := l
				upper := u
			else
				lower := 1
				upper := 0
			end
			create area.make_filled (v, u - l + 1)
		ensure
			map_domain_effect: map.domain |=| create {MML_INTERVAL}.from_range (l, u)
			map_effect: map.is_constant (v)
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize by copying all the items of `other'.
			-- Reallocate memory unless count stays the same.
		note
			modify: map
		do
			if other /= Current then
				if area /= Void and other.count = count then
					lower := other.lower
					upper := other.upper
				else
					make (other.lower, other.upper)
				end
				area.copy_data (other.area, 0, 0, count)
			end
		ensure then
			map_effect: map |=| other.map
		end

feature -- Access

	item alias "[]" (i: INTEGER): G assign put
			-- Value associated with `i'.
		do
			if attached area [i - lower] as res then
				Result := res
			else
				Result := default_value
			end
		end

	subarray (l, u: INTEGER): V_ARRAY [G]
			-- Array consisting of elements of Current in index range [`l', `u'].
		require
			l_not_too_small: l >= lower
			u_not_too_large: u <= upper
			l_not_too_large: l <= u + 1
		do
			create Result.make (l, u)
			Result.array_copy_range (Current, l, u, Result.lower)
		ensure
			map_domain_definition: Result.map.domain |=| create {MML_INTERVAL}.from_range (l, u)
			map_definition: Result.map.for_all (agent (i: INTEGER; x: G): BOOLEAN
				do
					Result := x = map [i]
				end)
		end

feature -- Measurement

	lower: INTEGER
			-- Lower bound of index interval.

	upper: INTEGER
			-- Upper bound of index interval.		

feature -- Iteration

	at (i: INTEGER): V_ARRAY_ITERATOR [G]
			-- New iterator pointing at position `i'.
		do
			create Result.make (Current, i - lower + 1)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is array made of the same items as `other'?
			-- (Use reference comparison.)
		do
			if other = Current then
				Result := True
			else
				Result := (lower = other.lower and upper = other.upper) and then
					area.same_items (other.area, 0, 0, count)
			end
		ensure then
			definition: Result = (map |=| other.map)
		end

feature -- Replacement

	put (v: G; i: INTEGER)
			-- Put `v' at position `i'.
		do
			area.put (v, i - lower)
		end

	fill (v: G; l, u: INTEGER)
			-- Put `v' at positions [`l', `u'].
		do
			area.fill_with (v, l - lower, u - lower)
		end

	clear (l, u: INTEGER)
			-- Put default value at positions [`l', `u'].		
		do
			area.fill_with (default_value, l - lower, u - lower)
		end

	array_copy_range (other: V_ARRAY [G]; other_first, other_last, index: INTEGER)
			-- Copy items of `other' within bounds [`other_first', `other_last'] to current array starting at index `i'.
		require
			other_first_not_too_small: other_first >= other.lower
			other_last_not_too_large: other_last <= other.upper
			other_first_not_too_large: other_first <= other_last + 1
			index_not_too_small: index >= lower
			enough_space: upper - index >= other_last - other_first
		do
			if other_last >= other_first then
				area.copy_data (other.area, other_first - other.lower, index - lower, other_last - other_first + 1)
			end
		ensure
			map_domain_effect: map.domain |=| old map.domain
			map_changed_effect: (create {MML_INTERVAL}.from_range (index, index + other_last - other_first)).for_all (
				agent (i: INTEGER; other_map: MML_MAP [INTEGER, G]; f, of: INTEGER): BOOLEAN
					do
						Result := map [i] = other_map [i - f + of]
					end (?, old other.map, index, other_first))
			map_unchanged_effect: (map | (map.domain - create {MML_INTERVAL}.from_range (index, index + other_last - other_first))) |=|
				old (map | (map.domain - create {MML_INTERVAL}.from_range (index, index + other_last - other_first)))
		end

feature -- Resizing

	resize (l, u: INTEGER)
			-- Set index interval to [`l', `u']; keep values at old indexes; set to default at new indexes.
			-- Reallocate memory unless count stays the same.
		note
			modify: map
		require
			valid_indexes: l <= u + 1
		local
			new_count, x, y: INTEGER
		do
			new_count := u - l + 1
			if new_count = 0 then
				create area.make_empty (0)
				lower := 1
				upper := 0
			else
				if new_count > area.count then
					area := area.aliased_resized_area_with_default (default_value, new_count)
				end
				x := lower.max (l)
				y := upper.min (u)
				if x > y then
					-- No intersection
					area.fill_with (default_value, 0, area.count - 1)
				else
					-- Intersection
					area.move_data (x - lower, x - l, y - x + 1)
					area.fill_with (default_value, 0, x - l - 1)
					area.fill_with (default_value, y - l + 1, area.count - 1)
				end
				if new_count < area.count then
					area := area.resized_area (new_count)
				end
				lower := l
				upper := u
			end
		ensure
			map_domain_effect: map.domain |=| create {MML_INTERVAL}.from_range (l, u)
			map_old_effect: (map | (map.domain * old map.domain)) |=| (old map | (map.domain * old map.domain))
			map_new_effect: (map | (map.domain - old map.domain)).is_constant (default_value)
		end

	include (i: INTEGER)
			-- Resize in a minimal way to include index `i'; keep values at old indexes; set to default at new indexes.
			-- Reallocate memory unless count stays the same.
		note
			modify: map
		do
			if is_empty then
				resize (i, i)
			elseif i < lower then
				resize (i, upper)
			elseif i > upper then
				resize (lower, i)
			end
		ensure
			map_domain_effect_empty: old map.is_empty implies map.domain |=| create {MML_SET [INTEGER]}.singleton (i)
			map_domain_effect_non_empty: not old map.is_empty implies map.domain |=| create {MML_INTERVAL}.from_range (i.min (old lower), i.max (old upper))
			map_old_effect: (map | (map.domain * old map.domain)) |=| (old map | (map.domain * old map.domain))
			map_new_effect: (map | (map.domain - old map.domain)).is_constant (default_value)
		end

	force (v: G; i: INTEGER)
			-- Put `v' at position `i'; if position is not defined, include it.
			-- Reallocate memory unless count stays the same.
		note
			modify: map
		do
			include (i)
			put (v, i)
		ensure
			map_domain_effect_empty: old map.is_empty implies map.domain |=| create {MML_SET [INTEGER]}.singleton (i)
			map_domain_effect_non_empty: not old map.is_empty implies map.domain |=| create {MML_INTERVAL}.from_range (i.min (old lower), i.max (old upper))
			map_i_effect: map [i] = v
			map_old_effect: (map | (map.domain * old map.domain - create {MML_INTERVAL}.singleton (i))) |=| (old map | (map.domain * old map.domain - create {MML_INTERVAL}.singleton (i)))
			map_new_effect: (map | (map.domain - old map.domain - create {MML_INTERVAL}.singleton (i))).is_constant (default_value)
		end

	wipe_out
			-- Remove all elements.
		note
			modify: map
		do
			resize (1, 0)
		ensure
			map_effect: map.is_empty
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	area: SPECIAL [detachable G]
			-- Memory area where elements are stored.

invariant
	lower_definition_empty: map.is_empty implies lower = 1
	upper_definition_empty: map.is_empty implies upper = 0

end
