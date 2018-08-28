note
	description: "Finite sets."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	theory: "set.bpl"
	maps_to: "Set"
	type_properties: "Set#ItemsType"

class MML_SET [G]

inherit

	ITERABLE [G]
		redefine
			default_create,
			is_equal
		end

create
	default_create,
	singleton

feature {NONE} -- Initialization

	default_create
			-- Create an empty set.
		note
			maps_to: "Set#Empty"
		do
		end

	singleton (x: G)
			-- Create a set that contains only `x'.
		do
		end

feature -- Properties

	has alias "[]" (x: G): BOOLEAN
			-- Is `x' contained?
		note
			maps_to: "[]"
		do
		end

	is_empty: BOOLEAN
			-- Is the set empty?
		do
		end


feature -- Elements

	any_item: G
			-- Arbitrary element.
		require
			not_empty: not is_empty
		do
			check is_executable: False then end
		end

	min: G
			-- Least element.
		require
			not_empty: not is_empty
		do
			check is_executable: False then end
		end

	max: G
			-- Greatest element.
		require
			not_empty: not is_empty
		do
			check is_executable: False then end
		end

feature -- Measurement

	count alias "#": INTEGER
			-- Cardinality.
		note
			maps_to: "Set#Card"
		do
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' the same set as `Current'?
		note
			maps_to: "Set#Equal"
		do
		end

	is_subset_of alias "<=" (a_other: MML_SET [G]): BOOLEAN
			-- Does `a_other' have all elements of `Current'?
		note
			maps_to: "Set#Subset"
		do
		end

	is_superset_of alias ">=" (a_other: MML_SET [G]): BOOLEAN
			-- Does `Current' have all elements of `a_other'?
		note
			maps_to: "Set#Superset"
		do
		end

	is_disjoint (a_other: MML_SET [G]): BOOLEAN
			-- Do no elements of `a_other' occur in `Current'?
		note
			maps_to: "Set#Disjoint"
		do
		end

feature -- Modification

	extended alias "&" (x: G): MML_SET [G]
			-- Current set extended with `x' if absent.
		do
			check is_executable: False then end
		end

	removed alias "/" (x: G): MML_SET [G]
			-- Current set with `x' removed if present.
		do
			check is_executable: False then end
		end

	union alias "+" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in either `Current' or `other'.
		do
			check is_executable: False then end
		end

	intersection alias "*" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in both `Current' and `other'.
		do
			check is_executable: False then end
		end

	difference alias "-" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in `Current' but not in `other'.
		do
			check is_executable: False then end
		end

	sym_difference alias "^" (other: MML_SET [G]): MML_SET [G]
			-- Set of values contained in either `Current' or `other', but not in both.
		do
			check is_executable: False then end
		end

feature -- Iterable implementation

	new_cursor: ITERATION_CURSOR [G]
			-- <Precursor>
		note
			maps_to: ""
		do
			check is_executable: False then end
		end

feature -- Convenience

	empty_set: MML_SET [G]
			-- Empty set.
			-- Can be used as `{MML_SET [G]}.empty_set'.
		note
			maps_to: "Set#Empty"
		external "C inline"
		alias
			"[
				return NULL;
			]"
		end

	non_void: BOOLEAN
			-- Are all elements non-Void?
		note
			maps_to: "Set#NonNull"
		do
		end

feature -- Lemmas

	lemma_subset (other: like Current)
			-- A subset with no less elements is the same set.
		note
			status: lemma
		require
			subset: other <= Current
			count: count <= other.count
		local
			x: G
		do
			if not other.is_empty then
				x := other.any_item
				removed (x).lemma_subset (other / x)
				check Current = removed (x) & x end
			end
		ensure
			Current = other
		end

end
