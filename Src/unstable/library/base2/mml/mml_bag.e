note
	description: "Finite bags."
	author: "Nadia Polikarpova"

class
	MML_BAG [G]

inherit
	MML_MODEL
		redefine
			default_create
		end

inherit {NONE}
	V_EQUALITY [INTEGER]
		export {NONE}
			all
		redefine
			default_create
		end

create
	default_create,
	singleton,
	multiple

create {MML_MODEL}
	make_from_arrays

feature {NONE} -- Initialization

	default_create
			-- Create an empty bag.
		do
			create keys.make (1, 0)
			create values.make (1, 0)
		end

	singleton (x: G)
			-- Create a bag that contains a single occurrence of `x'.
		do
			multiple (x, 1)
		end

	multiple (x: G; n: INTEGER)
			-- Create a bag that contains `n' occurrences of `x'.
		require
			n_positive: n >= 0
		do
			if n = 0 then
				default_create
			else
				create keys.make_filled (1, 1, x)
				create values.make_filled (1, 1, n)
				count := n
			end
		end

feature -- Properties

	has (x: G): BOOLEAN
			-- Is `x' contained?
		do
			Result := occurrences (x) > 0
		end

	is_empty: BOOLEAN
			-- Is bag empty?
		do
			Result := keys.is_empty
		end

	is_constant (c: INTEGER): BOOLEAN
			-- Are all values equal to `c'?
		do
			Result := values.for_all (agent reference_equal (c, ?))
		end

feature -- Sets

	domain: MML_SET [G]
			-- Set of values that occur at least once.
		do
			create Result.make_from_array (keys)
		end

feature -- Measurement

	occurrences alias "[]" (x: G): INTEGER
			-- How many times `v' appears.
		local
			i: INTEGER
		do
			i := keys.index_satisfying (agent meq (x, ?))
			if keys.has_index (i) then
				Result := values [i]
			end
		end

	count alias "#": INTEGER
			-- Total number of elements.

feature -- Comparison

	is_model_equal alias "|=|" (other: MML_MODEL): BOOLEAN
			-- Does this bag contain the same elements the same number of times as `other'?		
		local
			i: INTEGER
		do
			if attached {MML_BAG [G]} other as bag and then count = bag.count then
				from
					Result := True
					i := 1
				until
					i > keys.count or not Result
				loop
					Result := bag [keys [i]] = values [i]
					i := i + 1
				end
			end
		end

feature -- Modification

	extended alias "&" (x: G): MML_BAG [G]
			-- Current bag extended with one occurrence of `x'.
		do
			Result := extended_multiple (x, 1)
		end

	extended_multiple (x: G; n: INTEGER): MML_BAG [G]
			-- Current bag extended with `n' occurrences of `x'.
		require
			n_non_negative: n >= 0
		local
			ks: V_ARRAY [G]
			vs: V_ARRAY [INTEGER]
			i: INTEGER
		do
			if n > 0 then
				i := keys.index_satisfying (agent meq (x, ?))
				if keys.has_index (i) then
					ks := keys
					vs := values.twin
					vs [i] := vs [i] + n
				else
					create ks.make (1, keys.count + 1)
					ks.array_copy_range (keys, 1, keys.count, 1)
					ks [ks.count] := x
					create vs.make (1, values.count + 1)
					vs [vs.count] := n
					vs.array_copy_range (values, 1, values.count, 1)
				end
				create Result.make_from_arrays (ks, vs, count + n)
			else
				Result := Current
			end
		end

	removed alias "/" (x: G): MML_BAG [G]
			-- Current bag with one occurrence of `x' removed if present.
		do
			Result := removed_multiple (x, 1)
		end

	removed_multiple (x: G; n: INTEGER): MML_BAG [G]
			-- Current bag with at most `n' occurrences of `x' removed if present.
		require
			n_non_negative: n >= 0
		local
			ks: V_ARRAY [G]
			vs: V_ARRAY [INTEGER]
			i: INTEGER
		do
			i := keys.index_satisfying (agent meq (x, ?))
			if n = 0 or not keys.has_index (i) then
				Result := Current
			elseif values [i] <= n then
				create ks.make (1, keys.count - 1)
				ks.array_copy_range (keys, 1, i - 1, 1)
				ks.array_copy_range (keys, i + 1, keys.count, i)
				create vs.make (1, values.count - 1)
				vs.array_copy_range (values, 1, i - 1, 1)
				vs.array_copy_range (values, i + 1, values.count, i)
				create Result.make_from_arrays (ks, vs, count - n)
			else
				vs := values.twin
				vs [i] := vs [i] - n
				create Result.make_from_arrays (keys, vs, count - n)
			end
		end

	removed_all (x: G): MML_BAG [G]
			-- Current bag with all occurrences of `x' removed.
		do
			Result := removed_multiple (x, occurrences (x))
		end

	restricted alias "|" (subdomain: MML_SET [G]): MML_BAG [G]
			-- Bag that consists of all elements of `Current' that are in `subdomain'.
		local
			i, j: INTEGER
			ks: V_ARRAY [G]
			vs: V_ARRAY [INTEGER]
			n: INTEGER
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
					n := n + values [i]
					j := j + 1
				end
				i := i + 1
			end
			ks.resize (1, j - 1)
			vs.resize (1, j - 1)
			create Result.make_from_arrays (ks, vs, n)
		end

	union alias "+" (other: MML_BAG [G]): MML_BAG [G]
			-- Bag that contains all elements from `other' and `Current'.
		local
			i, j, k: INTEGER
			ks: V_ARRAY [G]
			vs: V_ARRAY [INTEGER]
		do
			create ks.make (1, keys.count + other.keys.count)
			create vs.make (1, values.count + other.values.count)
			ks.array_copy_range (keys, 1, keys.count, 1)
			vs.array_copy_range (values, 1, values.count, 1)
			from
				i := 1
				j := keys.count + 1
			until
				i > other.keys.count
			loop
				k := keys.index_satisfying (agent meq (other.keys [i], ?))
				if keys.has_index (k) then
					vs [k] := vs [k] + other.values [i]
				else
					ks [j] := other.keys [i]
					vs [j] := other.values [i]
					j := j + 1
				end
				i := i + 1
			end
			ks.resize (1, j - 1)
			vs.resize (1, j - 1)
			create Result.make_from_arrays (ks, vs, count + other.count)
		end

	difference alias "-" (other: MML_BAG [G]): MML_BAG[G]
			-- Current bag with all occurrences of values from `other' removed.
		local
			i, j, k, c: INTEGER
			ks: V_ARRAY [G]
			vs: V_ARRAY [INTEGER]
		do
			create ks.make (1, keys.count)
			create vs.make (1, values.count)
			from
				i := 1
				j := 1
			until
				i > keys.count
			loop
				k := other [keys [i]]
				if k < values [i] then
					ks [j] := keys [i]
					vs [j] := values [i] - k
					c := c + vs [j]
					j := j + 1
				end
				i := i + 1
			end
			ks.resize (1, j - 1)
			vs.resize (1, j - 1)
			create Result.make_from_arrays (ks, vs, c)
		end

feature {MML_MODEL} -- Implementation

	keys: V_ARRAY [G]
			-- Element storage.

	values: V_ARRAY [INTEGER]
			-- Occurrences storage.

	make_from_arrays (ks: V_ARRAY [G]; vs: V_ARRAY [INTEGER]; n: INTEGER)
			-- Create with predefined arrays and count.
		require
			same_lower: ks.lower = vs.lower
			same_upper: ks.upper = vs.upper
			start_at_one: ks.lower = 1
			ks_has_no_duplicates: ks.bag.is_constant (1)
--			vs_positive: vs.for_all (agent (x: INTEGER): BOOLEAN do Result := x > 0 end)
			--- n_valid: n = sum i: INTEGER :: vs.lower <= i and i <= vs.upper ==> vs [i]
		do
			keys := ks
			values := vs
			count := n
		end

	meq (v1, v2: G): BOOLEAN
			-- Are `v1' and `v2' mathematically equal?
			-- The same as `model_equals' but with generic arguments.
			-- Workaround for agent typing problem.
		do
			Result := model_equals (v1, v2)
		end

invariant
	same_lower: keys.lower = values.lower
	same_upper: keys.upper = values.upper
	start_at_one: keys.lower = 1
end
