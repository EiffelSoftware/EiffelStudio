note
	description: "Finite sets."
	author: "Nadia Polikarpova"

class
	MML_SET [G]

inherit
	MML_MODEL
		redefine
			default_create
		end

create
	default_create,
	singleton

create {MML_MODEL}
	make_from_array

--convert
--	singleton ({G})

feature {NONE} -- Initialization

	default_create
			-- Create an empty set.
		do
			create array.make (1, 0)
		ensure then
			empty: is_empty
		end

	singleton (x: G)
			-- Create a set that contains only `x'.
		do
			create array.make_filled (1, 1, x)
		ensure
			one_element: count = 1
			has_x: has (x)
		end

feature -- Properties

	has alias "[]" (x: G): BOOLEAN
			-- Is `x' contained?
		do
			Result := array.exists (agent meq (x, ?))
		end

	is_empty: BOOLEAN
			-- Is the set empty?
		do
			Result := array.is_empty
		ensure
			count_zero: Result = (count = 0)
		end

	for_all (test: PREDICATE [G]): BOOLEAN
			-- Does `test' hold for all elements?
		require
			test_has_one_arg: test.open_count = 1
		do
			Result := array.for_all (test)
		end

	exists (test: PREDICATE [G]): BOOLEAN
			-- Does `test' hold for at least one element?
		require
			test_has_one_arg: test.open_count = 1
		do
			Result := array.exists (test)
		end

feature -- Elements

	any_item: G
			-- Arbitrary element.
		require
			not_empty: not is_empty
		do
			if not is_empty then
				Result := array [1]
			else
				Result := array.default_value
			end
		ensure
			element: has (Result)
		end

	extremum (order: PREDICATE [G, G]): G
			-- Least element with respect to `order'.
		require
			not_empty: not is_empty
			order_has_one_arg: order.open_count = 2
			--- transitive: forall x, y, z: G :: order (x, y) and order (y, z) implies order (x, z)
			--- total: forall x, y: G :: order (x, y) or order (y, x)
		local
			i: INTEGER
		do
			if not is_empty then
				from
					Result := array.first
					i := 2
				until
					i > array.count
				loop
					if order.item ([array [i], Result]) then
						Result := array [i]
					end
					i := i + 1
				end
			else
				Result := array.default_value
			end
		ensure
			element: has (Result)
			extremum: for_all (agent (x, y: G; o: PREDICATE [G, G]): BOOLEAN
				do
					Result := o.item ([x, y])
				end (Result, ?, order))
		end

feature -- Subsets

	filtered alias "|" (test: PREDICATE [G]): MML_SET [G]
			-- Set of all elements that satisfy `test'.
		require
			test_has_one_arg: test.open_count = 1
		local
			a: V_ARRAY [G]
			i, j: INTEGER
		do
			create a.make (1, array.count)
			from
				i := 1
				j := 1
			until
				i > array.count
			loop
				if test.item ([array [i]]) then
					a [j] := array [i]
					j := j + 1
				end
				i := i + 1
			end
			a.resize (1, j - 1)
			create Result.make_from_array (a)
		ensure
			subset: Result <= Current
			satisfies_test: Result.for_all (test)
			maximum: not (Current - Result).exists (test)
		end

feature -- Measurement

	count alias "#": INTEGER
			-- Cardinality.
		do
			Result := array.count
		end

feature -- Comparison

	is_model_equal alias "|=|" (other: MML_MODEL): BOOLEAN
			-- Does this set contain same elements as `other'?
		do
			Result := attached {MML_SET[G]} other as set and then
				(count = set.count and Current <= set)
		end

	is_subset_of alias "<=" (other: MML_SET [G]): BOOLEAN
			-- Does `other' have all elements of `Current'?
		do
			Result := for_all (agent other.has)
		ensure
			other_has_all: Result = for_all (agent other.has)
		end

	is_superset_of alias ">=" (other: MML_SET [G]): BOOLEAN
			-- Does `Current' have all elements of `other'?
		do
			Result := other <= Current
		ensure
			other_is_subset: Result = (other <= Current)
		end

	disjoint (other: MML_SET [G]): BOOLEAN
			-- Do no elements of `other' occur in `Current'?
		do
			Result := not other.exists (agent has)
		ensure
			no_common_elements: Result = not other.exists (agent has)
		end

feature -- Modification

	extended alias "&" (x: G): MML_SET [G]
			-- Current set extended with `x' if absent.
		local
			a: V_ARRAY [G]
		do
			if not Current [x] then
				create a.make (1, array.count + 1)
				a.array_copy_range (array, 1, array.count, 1)
				a [a.count] := x
				create Result.make_from_array (a)
			else
				Result := Current
			end
		ensure
			singleton_union: Result |=| (Current + create {MML_SET [G]}.singleton (x))
		end

	removed alias "/" (x: G): MML_SET [G]
			-- Current set with `x' removed if present.
		local
			a: V_ARRAY [G]
			i: INTEGER
		do
			i := array.index_satisfying (agent meq (x, ?))
			if array.has_index (i) then
				create a.make (1, array.count - 1)
				a.array_copy_range (array, 1, i - 1, a.lower)
				a.array_copy_range (array, i + 1, array.count, i)
				create Result.make_from_array (a)
			else
				Result := Current
			end
		ensure
			singleton_difference: Result |=| (Current - create {MML_SET [G]}.singleton (x))
		end

	union alias "+" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in either `Current' or `other'.
		do
			Result := Current - other
			Result.array.resize (1, Result.array.count + other.array.count)
			Result.array.array_copy_range (other.array, 1, other.array.count, Result.array.count - other.count + 1)
		ensure
			contains_current: Current <= Result
			contains_other: other <= Result
			minimal: Result.for_all (agent (y: G; other_: MML_SET [G]): BOOLEAN
				do
					Result := Current [y] or other_ [y]
				end (? , other))
		end

	intersection alias "*" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in both `Current' and `other'.
		local
			a: V_ARRAY [G]
			i, j: INTEGER
		do
			create a.make (1, array.count)
			from
				i := 1
				j := 1
			until
				i > array.count
			loop
				if other [array [i]] then
					a [j] := array [i]
					j := j + 1
				end
				i := i + 1
			end
			a.resize (1, j - 1)
			create Result.make_from_array (a)
		ensure
			contained_in_current: Result <= Current
			contained_in_other: Result <= other
			maximal: for_all (agent (y: G; other_, result_: MML_SET [G]): BOOLEAN
				do
					Result := other_ [y] implies result_ [y]
				end (?, other, Result))
		end

	difference alias "-" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in `Current' but not in `other'.
		local
			a: V_ARRAY [G]
			i, j: INTEGER
		do
			create a.make (1, array.count)
			from
				i := 1
				j := 1
			until
				i > array.count
			loop
				if not other [array [i]] then
					a [j] := array [i]
					j := j + 1
				end
				i := i + 1
			end
			a.resize (1, j - 1)
			create Result.make_from_array (a)
		ensure
			contained_in_current: Result <= Current
			disjoint_from_other: Result.disjoint (other)
			maximal: for_all (agent (y: G; other_, result_: MML_SET [G]): BOOLEAN
				do
					Result := not other_ [y] implies result_ [y]
				end (?, other, Result))
		end

	sym_difference alias "^" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in either `Current' or `other', but not in both.
		do
			Result := (Current + other) - (Current * other)
		ensure
			definition: Result |=| ((Current + other) - (Current * other))
		end

	mapped (f: FUNCTION [G, G]): MML_SET [G]
			-- Set of elements of `Current' with `f' applied to each of them.
		require
			f_has_one_arg: f.open_count = 1
		local
			a: V_ARRAY [G]
			i: INTEGER
		do
			create a.make (1, count)
			from
				i := 1
			until
				i > count
			loop
				a [i] := f.item ([array [i]])
				i := i + 1
			end
			create Result.make_from_array (a)
		end

feature {MML_MODEL} -- Implementation

	array: V_ARRAY [G]
			-- Element storage.

	make_from_array (a: V_ARRAY [G])
			-- Create with a predefined array.
		require
			starts_from_one: a.lower = 1
			no_duplicates: a.bag.is_constant (1)
		do
			array := a
		end

	meq (v1, v2: G): BOOLEAN
			-- Are `v1' and `v2' mathematically equal?
			-- The same as `model_equals' but with generic arguments.
			-- Workaround for agent typing problem.
		do
			Result := model_equals (v1, v2)
		end

invariant
	starts_from_one: array.lower = 1
end
