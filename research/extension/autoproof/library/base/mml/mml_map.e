note
	description: "Finite maps."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	theory: "map.bpl", "sequence.bpl", "bag.bpl", "relation.bpl", "set.bpl", "pair.bpl"
	maps_to: "Map"
	type_properties: "Map#DomainType", "Map#RangeType"

class
	MML_MAP [K, V]

inherit
	ITERABLE [K]
		redefine
			default_create,
			is_equal
		end

create
	default_create,
	singleton

feature {NONE} -- Initialization

	default_create
			-- Create an empty map.
		note
			maps_to: "Map#Empty"
		do
		end

	singleton (k: K; x: V)
			-- Create a map with just one key-value pair <`k', `x'>.
		do
		end

feature -- Properties

	has (x: V): BOOLEAN
			-- Is value `x' contained?
		do
		end

	is_empty: BOOLEAN
			-- Is map empty?
		do
		end

	is_constant (c: V): BOOLEAN
			-- Are all values equal to `c'?
		do
		end

feature -- Elements

	item alias "[]" (k: K): V
			-- Value associated with `k'.
		require
			in_domain: domain [k]
		do
			check is_executable: False then end
		end

feature -- Conversion

	domain: MML_SET [K]
			-- Set of keys.
		do
			check is_executable: False then end
		end

	range: MML_SET [V]
			-- Set of values.
		do
			check is_executable: False then end
		end

	image (subdomain: MML_SET [K]): MML_SET [V]
			-- Set of values corresponding to keys in `subdomain'.
		require
			in_domain: subdomain <= domain
		do
			check is_executable: False then end
		end

	sequence_image (s: MML_SEQUENCE [K]): MML_SEQUENCE [V]
			-- Sequence of images of `s' elements under `Current'.
		require
			range_in_domain: s.range <= domain
		do
			check is_executable: False then end
		end

	to_bag: MML_BAG [V]
			-- Bag of map values.
		do
			check is_executable: False then end
		end

feature -- Measurement

	count: INTEGER
			-- Map cardinality.
		note
			maps_to: "Map#Card"
		do
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' the same sequence as `Current'?
		note
			maps_to: "Map#Equal"
		do
		end

	is_disjoint (a_other: like Current): BOOLEAN
			-- Do `a_other' and `Current' have disjoint domains?
		note
			maps_to: "Map#Disjoint"
		do
		end

feature -- Modification

	updated (k: K; x: V): MML_MAP [K, V]
			-- Current map with `x' associated with `k'.
			-- If `k' already exists, the value is replaced, otherwise added.
		note
			maps_to: "Map#Update"
		do
			check is_executable: False then end
		end

	removed (k: K): MML_MAP [K, V]
			-- Current map without the key `k' and the corresponding value.
			-- If `k' doesn't exist, current map.
		do
			check is_executable: False then end
		end

	restricted alias "|" (subdomain: MML_SET [K]): MML_MAP [K, V]
			-- Map that consists of all key-value pairs in `Current' whose key is in `subdomain'.
		do
			check is_executable: False then end
		end

	override alias "+" (other: MML_MAP [K, V]): MML_MAP [K, V]
			-- Map that is equal to `other' on its domain and to `Current' on its domain minus the domain of `other'.
		do
			check is_executable: False then end
		end

	inverse: MML_RELATION [V, K]
			-- Relation consisting of inverted pairs from `Current'.
		do
			check is_executable: False then end
		end

feature -- Iterable implementation

	new_cursor: ITERATION_CURSOR [K]
			-- <Precursor>
		note
			maps_to: "Map#Domain"
		do
			check is_executable: False then end
		end

feature -- Convenience

	empty_map: MML_MAP [K, V]
			-- Empty map.
			-- Can be used as `{MML_MAP [K, V]}.empty_map'.
		note
			maps_to: "Map#Empty"
		external "C inline"
		alias
			"[
				return NULL;
			]"
		end

feature -- Lemmas

	lemma_sequence_image_bag (seq: MML_SEQUENCE [K])
			-- If `seq' has no duplicates, its image under this map has the same elements
			-- as the restriction of this map onto `seq's range.
		note
			status: lemma
		require
			seq.range <= domain
			seq.no_duplicates
			decreases (seq)
		do
			if not seq.is_empty then
				lemma_sequence_image_bag (seq.but_last)
				check sequence_image (seq) = sequence_image (seq.but_last) & item (seq.last) end
				check (Current | seq.range) = (Current | seq.but_last.range).updated (seq.last, item (seq.last)) end
			end
		ensure
			sequence_image (seq).to_bag ~ (Current | seq.range).to_bag
		end

end
