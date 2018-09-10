note
	description: "Finite relations."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	theory: "relation.bpl", "set.bpl", "pair.bpl"
	maps_to: "Rel"
	type_properties: "Rel#DomainType", "Rel#RangeType"

class
	MML_RELATION [G, H]

inherit
	ITERABLE [MML_PAIR [G, H]]
		redefine
			default_create,
			is_equal
		end

create
	default_create,
	singleton

feature {NONE} -- Initialization

	default_create
			-- Create an empty relation.
		note
			maps_to: "Rel#Empty"
		do
		end

	singleton (x: G; y: H)
			-- Create a relation with just one pair <`x', `y'>.
		do
		end

feature -- Properties

	has alias "[]" (x: G; y: H): BOOLEAN
			-- Is `x' related `y'?
		note
			maps_to: "[]"
		do
		end

	is_empty: BOOLEAN
			-- Is map empty?
		do
		end

feature -- Sets

	domain: MML_SET [G]
			-- The set of left components.
		do
			check is_executable: False then end
		end

	range: MML_SET [H]
			-- The set of right components.
		do
			check is_executable: False then end
		end

	to_set: MML_SET [MML_PAIR [G, H]]
			-- Relation as a set of pairs.
		do
			check is_executable: False then end
		end

	image_of (x: G): MML_SET [H]
			-- Set of values related to `x'.
		do
			check is_executable: False then end
		end

	image (subdomain: MML_SET [G]): MML_SET [H]
			-- Set of values related to any value in `subdomain'.
		do
			check is_executable: False then end
		end

feature -- Measurement

	count: INTEGER
			-- Cardinality.
		note
			maps_to: "Rel#Card"
		do
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' the same relation as `Current'?
		note
			maps_to: "Rel#Equal"
		do
		end

feature -- Modification

	extended (x: G; y: H): MML_RELATION [G, H]
			-- Current relation extended with pair (`x', `y') if absent.
		do
			check is_executable: False then end
		end

	removed (x: G; y: H): MML_RELATION [G, H]
			-- Current relation with pair (`x', `y') removed if present.
		do
			check is_executable: False then end
		end

	restricted alias "|" (subdomain: MML_SET [G]): MML_RELATION [G, H]
			-- Relation that consists of all pairs in `Current' whose left component is in `subdomain'.
		do
			check is_executable: False then end
		end

	inverse: MML_RELATION [H, G]
			-- Relation that consists of inverted pairs from `Current'.
		do
			check is_executable: False then end
		end

	union alias "+" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in either `Current' or `other'.
		do
			check is_executable: False then end
		end

	intersection alias "*" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in both `Current' and `other'.
		do
			check is_executable: False then end
		end

	difference alias "-" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in `Current' but not in `other'.
		do
			check is_executable: False then end
		end

	sym_difference alias "^" (other: MML_RELATION [G, H]): MML_RELATION [G, H]
			-- Relation that consists of pairs contained in either `Current' or `other', but not in both.
		do
			check is_executable: False then end
		end

feature -- Iterable implementation

	new_cursor: ITERATION_CURSOR [MML_PAIR [G, H]]
			-- <Precursor>
		note
			maps_to: "Rel#ToSet"
		do
			check is_executable: False then end
		end

feature -- Convenience

	empty_relation: MML_RELATION [G, H]
			-- Empty relation.
			-- Can be used as `{MML_RELATION [G]}.empty_relation'.
		note
			maps_to: "Rel#Empty"
		external "C inline"
		alias
			"[
				return NULL;
			]"
		end

end
