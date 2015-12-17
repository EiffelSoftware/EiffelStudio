note
	description: "Finite maps."
	author: "Nadia Polikarpova"

class
	MML_MAP [K, V]

inherit
	MML_MODEL
		redefine
			default_create
		end

create
	default_create,
	singleton

create {MML_MODEL}
	make_from_arrays

feature {NONE} -- Initialization

	default_create
			-- Create an empty map.
		do
			create keys.make (1, 0)
			create values.make (1, 0)
		end

	singleton (k: K; x: V)
			-- Create a map with just one key-value pair <`k', `x'>.
		do
			create keys.make_filled (1, 1, k)
			create values.make_filled (1, 1, x)
		end

feature -- Properties

	has (x: V): BOOLEAN
			-- Is value `x' contained?
		do
			Result := values.exists (agent meq_value (x, ?))
		end

	is_empty: BOOLEAN
			-- Is map empty?
		do
			Result := keys.is_empty
		end

	is_constant (c: V): BOOLEAN
			-- Are all values equal to `c'?
		do
			Result := values.for_all (agent meq_value (c, ?))
		end

	for_all (test: PREDICATE [K, V]): BOOLEAN
			-- Does `test' hold for all indexe-value pairs?
		require
			test_has_one_arg: test.open_count = 2
		local
			i: INTEGER
		do
			from
				i := 1
				Result := True
			until
				i > keys.count or not Result
			loop
				Result := Result and test.item ([keys [i], values [i]])
				i := i + 1
			end
		end

	exists (test: PREDICATE [K, V]): BOOLEAN
			-- Does `test' hold for any indexe-value pair?
		require
			test_has_one_arg: test.open_count = 2
		local
			i: INTEGER
		do
			from
				i := 1
				Result := False
			until
				i > keys.count or Result
			loop
				Result := Result or test.item ([keys [i], values [i]])
				i := i + 1
			end
		end

feature -- Elements

	item alias "[]" (k: K): V
			-- Value associated with `k'.
		require
			in_domain: domain [k]
		local
			i: INTEGER
		do
			i := keys.index_satisfying (agent meq_key (k, ?))
			if keys.has_index (i) then
				Result := values [i]
			else
				Result := values.default_value
			end
		end

feature -- Conversion

	domain: MML_SET [K]
			-- Set of keys.
		do
			create Result.make_from_array (keys)
		end

	range: MML_SET [V]
			-- Set of values.
		local
			i: INTEGER
		do
			create Result
			from
				i := 1
			until
				i > values.count
			loop
				Result := Result & values [i]
				i := i + 1
			end
		end

	image (subdomain: MML_SET [K]): MML_SET [V]
			-- Set of values corresponding to keys in `subdomain'.
		do
			Result := restricted (subdomain).range
		end

	sequence_image (s: MML_SEQUENCE [K]): MML_SEQUENCE [V]
			-- Sequence of images of `s' elements under `Current'.
			-- (Skip elements of `s' that are not in domain of `Current').
		local
			i: INTEGER
			a: V_ARRAY [V]
		do
			create a.make (1, s.count)
			from
				i := 1
			until
				i > s.count
			loop
				if domain [s [i]] then
					a [i] := item (s [i])
					i := i + 1
				end
			end
			create Result.make_from_array (a)
		end

	to_bag: MML_BAG [V]
			-- Bag of map values.
		local
			i: INTEGER
		do
			from
				create Result
				i := 1
			until
				i > values.count
			loop
				Result := Result & values [i]
				i := i + 1
			end
		end

feature -- Measurement

	count: INTEGER
			-- Map cardinality.
		do
			Result := keys.count
		end

feature -- Comparison

	is_model_equal alias "|=|" (other: MML_MODEL): BOOLEAN
			-- Does this map contain the same key-value pairs as `other'?		
		local
			i: INTEGER
		do
			if attached {MML_MAP [K, V]} other as map and then domain |=| map.domain then
				from
					Result := True
					i := 1
				until
					i > keys.count or not Result
				loop
					Result := model_equals (values [i], map [keys [i]])
					i := i + 1
				end
			end
		end

feature -- Modification

	updated (k: K; x: V): MML_MAP [K, V]
			-- Current map with `x' associated with `k'.
			-- If `k' already exists, the value is replaced, otherwise added.
		local
			i: INTEGER
			ks: V_ARRAY [K]
			vs: V_ARRAY [V]
		do
			i := keys.index_satisfying (agent meq_key (k, ?))
			if keys.has_index (i) then
				vs := values.twin
				vs [i] := x
				create Result.make_from_arrays (keys, vs)
			else
				create ks.make (1, keys.count + 1)
				ks.array_copy_range (keys, 1, keys.count, 1)
				ks [ks.count] := k
				create vs.make (1, values.count + 1)
				vs.array_copy_range (values, 1, values.count, 1)
				vs [vs.count] := x
				create Result.make_from_arrays (ks, vs)
			end
		end

	removed (k: K): MML_MAP [K, V]
			-- Current map without the key `k' and the corresponding value.
			-- If `k' doesn't exist, current map.
		local
			ks: V_ARRAY [K]
			vs: V_ARRAY [V]
			i: INTEGER
		do
			i := keys.index_satisfying (agent meq_key (k, ?))
			if keys.has_index (i) then
				create ks.make (1, keys.count - 1)
				create vs.make (1, values.count - 1)
				ks.array_copy_range (keys, 1, i - 1, 1)
				ks.array_copy_range (keys, i + 1, keys.count, i)
				vs.array_copy_range (values, 1, i - 1, 1)
				vs.array_copy_range (values, i + 1, values.count, i)
				create Result.make_from_arrays (ks, vs)
			else
				Result := Current
			end
		end

	restricted alias "|" (subdomain: MML_SET [K]): MML_MAP [K, V]
			-- Map that consists of all key-value pairs in `Current' whose key is in `subdomain'.
		local
			i, j: INTEGER
			ks: V_ARRAY [K]
			vs: V_ARRAY [V]
		do
			create ks.make (1, keys.count)
			create vs.make (1, values.count)
			from
				i := 1
				j := 1
			until
				i > keys.count
			loop
				if subdomain [keys [i]] then
					ks [j] := keys [i]
					vs [j] := values [i]
					j := j + 1
				end
				i := i + 1
			end
			ks.resize (1, j - 1)
			vs.resize (1, j - 1)
			create Result.make_from_arrays (ks, vs)
		end

	override alias "+" (other: MML_MAP [K, V]): MML_MAP [K, V]
			-- Map that is equal to `other' on its domain and to `Current' on its domain minus the domain of `other'.
		local
			i, j: INTEGER
			ks: V_ARRAY [K]
			vs: V_ARRAY [V]
		do
			create ks.make (1, keys.count + other.keys.count)
			create vs.make (1, values.count + other.values.count)
			ks.array_copy_range (other.keys, 1, other.keys.count, 1)
			vs.array_copy_range (other.values, 1, other.values.count, 1)
			from
				i := 1
				j := other.keys.count + 1
			until
				i > keys.count
			loop
				if not other.domain [keys [i]] then
					ks [j] := keys [i]
					vs [j] := values [i]
					j := j + 1
				end
				i := i + 1
			end
			ks.resize (1, j - 1)
			vs.resize (1, j - 1)
			create Result.make_from_arrays (ks, vs)
		end

	inverse: MML_RELATION [V, K]
			-- Relation consisting of inverted pairs from `Current'.
		do
			create Result.make_from_arrays (values, keys)
		end

feature {MML_MODEL} -- Implementation

	keys: V_ARRAY [K]
			-- Storage for keys.

	values: V_ARRAY [V]
			-- Storage for values.

	make_from_arrays (ks: V_ARRAY [K]; vs: V_ARRAY [V])
			-- Create with predefined arrays.
		require
			same_lower: ks.lower = vs.lower
			same_upper: ks.upper = vs.upper
			start_from_one: ks.lower = 1
			ks_has_no_duplicates: ks.bag.is_constant (1)
		do
			keys := ks
			values := vs
		end

	meq_key (k1, k2: K): BOOLEAN
			-- Are `k1' and `k2' mathematically equal?
			-- The same as `model_equals' but with generic arguments.
			-- Workaround for agent typing problem.
		do
			Result := model_equals (k1, k2)
		end

	meq_value (v1, v2: V): BOOLEAN
			-- Are `v1' and `v2' mathematically equal?
			-- The same as `model_equals' but with generic arguments.
			-- Workaround for agent typing problem.
		do
			Result := model_equals (v1, v2)
		end

invariant
	same_lower: keys.lower = values.lower
	same_upper: keys.upper = values.upper
	start_from_one: keys.lower = 1
end
