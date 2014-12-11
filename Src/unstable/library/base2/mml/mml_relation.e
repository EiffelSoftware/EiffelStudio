note
	description: "Finite relations."
	author: "Nadia Polikarpova"

class
	MML_RELATION [G, H]

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
			-- Create an empty relation.
		do
			create lefts.make (1, 0)
			create rights.make (1, 0)
		end

	singleton (x: G; y: H)
			-- Create a relation with just one pair <`x', `y'>.
		do
			create lefts.make_filled (1, 1, x)
			create rights.make_filled (1, 1, y)
		end

feature -- Properties

	has alias "[]" (x: G; y: H): BOOLEAN
			-- Is `x' related `y'?
		local
			i: INTEGER
		do
			from
				i := lefts.index_satisfying (agent meq_left (x, ?))
			until
				Result or not lefts.has_index (i)
			loop
				Result := model_equals (rights [i], y)
				i := lefts.index_satisfying_from (agent meq_left (x, ?), i + 1)
			end
		end

	is_empty: BOOLEAN
			-- Is map empty?
		do
			Result := lefts.is_empty
		end

feature -- Sets

	domain: MML_SET [G]
			-- The set of left components.
		local
			i: INTEGER
		do
			create Result
			from
				i := 1
			until
				i > lefts.count
			loop
				Result := Result & lefts [i]
				i := i + 1
			end
		end

	range: MML_SET [H]
			-- The set of right components.
		local
			i: INTEGER
		do
			create Result
			from
				i := 1
			until
				i > rights.count
			loop
				Result := Result & rights [i]
				i := i + 1
			end
		end

	image_of (x: G): MML_SET [H]
			-- Set of values related to `x'.
		do
			Result := image (create {MML_SET [G]}.singleton (x))
		end

	image (subdomain: MML_SET [G]): MML_SET [H]
			-- Set of values related to any value in `subdomain'.
		do
			Result := restricted (subdomain).range
		end

feature -- Measurement

	count: INTEGER
			-- Cardinality.
		do
			Result := lefts.count
		end

feature -- Comparison

	is_model_equal alias "|=|" (other: MML_MODEL): BOOLEAN
			-- Does this relation contain the same pairs as `other'?		
		local
			i: INTEGER
		do
			if attached {MML_RELATION [G, H]} other as rel and then count = rel.count then
				from
					Result := True
					i := 1
				until
					i > lefts.count or not Result
				loop
					Result := rel [lefts [i], rights [i]]
					i := i + 1
				end
			end
		end

feature -- Modification

	extended (x: G; y: H): MML_RELATION [G, H]
			-- Current relation extended with pair (`x', `y') if absent.
		local
			ls: V_ARRAY [G]
			rs: V_ARRAY [H]
		do
			if not Current [x, y] then
				create ls.make (1, lefts.count + 1)
				ls.array_copy_range (lefts, 1, lefts.count, 1)
				ls [ls.count] := x
				create rs.make (1, rights.count + 1)
				rs.array_copy_range (rights, 1, rights.count, 1)
				rs [rs.count] := y
				create Result.make_from_arrays (ls, rs)
			else
				Result := Current
			end
		end

	removed (x: G; y: H): MML_RELATION [G, H]
			-- Current relation with pair (`x', `y') removed if present.
		local
			ls: V_ARRAY [G]
			rs: V_ARRAY [H]
			i: INTEGER
		do
			i := lefts.index_satisfying (agent meq_left (x, ?))
			if lefts.has_index (i) and then model_equals (y, rights [i]) then
				create ls.make (1, lefts.count - 1)
				ls.array_copy_range (lefts, 1, i - 1, 1)
				ls.array_copy_range (lefts, i + 1, lefts.count, i)
				create rs.make (1, rights.count - 1)
				rs.array_copy_range (rights, 1, i - 1, 1)
				rs.array_copy_range (rights, i + 1, rights.count, i)
				create Result.make_from_arrays (ls, rs)
			else
				Result := Current
			end
		end

	restricted alias "|" (subdomain: MML_SET [G]): MML_RELATION [G, H]
			-- Relation that consists of all pairs in `Current' whose left component is in `subdomain'.
		local
			ls: V_ARRAY [G]
			rs: V_ARRAY [H]
			i, j: INTEGER
		do
			create ls.make (1, lefts.count)
			create rs.make (1, rights.count)
			from
				i := 1
				j := 1
			until
				i > lefts.count
			loop
				if subdomain [lefts [i]] then
					ls [j] := lefts [i]
					rs [j] := rights [i]
					j := j + 1
				end
				i := i + 1
			end
			ls.resize (1, j - 1)
			rs.resize (1, j - 1)
			create Result.make_from_arrays (ls, rs)
		end

	inverse: MML_RELATION [H, G]
			-- Relation that consists of inverted pairs from `Current'.
		do
			create Result.make_from_arrays (rights, lefts)
		end

	union alias "+" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in either `Current' or `other'.
		do
			Result := Current - other
			Result.lefts.resize (1, Result.lefts.count + other.lefts.count)
			Result.rights.resize (1, Result.rights.count + other.rights.count)
			Result.lefts.array_copy_range (other.lefts, 1, other.lefts.count, Result.lefts.count - other.count + 1)
			Result.rights.array_copy_range (other.rights, 1, other.rights.count, Result.rights.count - other.count + 1)
		end

	intersection alias "*" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in both `Current' and `other'.
		local
			ls: V_ARRAY [G]
			rs: V_ARRAY [H]
			i, j: INTEGER
		do
			create ls.make (1, lefts.count)
			create rs.make (1, rights.count)
			from
				i := 1
				j := 1
			until
				i > lefts.count
			loop
				if other [lefts [i], rights [i]] then
					ls [j] := lefts [i]
					rs [j] := rights [i]
					j := j + 1
				end
				i := i + 1
			end
			ls.resize (1, j - 1)
			rs.resize (1, j - 1)
			create Result.make_from_arrays (ls, rs)
		end

	difference alias "-" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in `Current' but not in `other'.
		local
			ls: V_ARRAY [G]
			rs: V_ARRAY [H]
			i, j: INTEGER
		do
			create ls.make (1, lefts.count)
			create rs.make (1, rights.count)
			from
				i := 1
				j := 1
			until
				i > lefts.count
			loop
				if not other [lefts [i], rights [i]] then
					ls [j] := lefts [i]
					rs [j] := rights [i]
					j := j + 1
				end
				i := i + 1
			end
			ls.resize (1, j - 1)
			rs.resize (1, j - 1)
			create Result.make_from_arrays (ls, rs)
		end

	sym_difference alias "^" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in either `Current' or `other', but not in both.
		do
			Result := (Current + other) - (Current * other)
		end

feature {MML_MODEL} -- Implementation

	lefts: V_ARRAY [G]
			-- Storage for the left components of pairs.

	rights: V_ARRAY [H]
			-- Storage for the right components of pairs.


	make_from_arrays (ls: V_ARRAY [G]; rs: V_ARRAY [H])
			-- Create with predefined arrays.
		require
			same_lower: ls.lower = rs.lower
			same_upper: ls.upper = rs.upper
			start_from_one: ls.lower = 1
		do
			lefts := ls
			rights := rs
		end

	meq_left (v1, v2: G): BOOLEAN
			-- Are `v1' and `v2' mathematically equal?
			-- The same as `model_equals' but with generic arguments.
			-- Workaround for agent typing problem.
		do
			Result := model_equals (v1, v2)
		end

	meq_right (v1, v2: H): BOOLEAN
			-- Are `v1' and `v2' mathematically equal?
			-- The same as `model_equals' but with generic arguments.
			-- Workaround for agent typing problem.
		do
			Result := model_equals (v1, v2)
		end

invariant
	same_lower: lefts.lower = rights.lower
	same_upper: lefts.upper = rights.upper
	start_from_one: lefts.lower = 1
end
