indexing
	description: "[
					Data structures whose items may be compared
					according to a total order relation
			  ]"
	class_type: Interface
	external_name: "ISE.Base.ComparableStruct"

deferred class 
	COMPARABLE_STRUCT [G -> ICOMPARABLE] 

inherit
	BILINEAR [G]

feature -- Measurement

	min: G is
		indexing
			description: "Minimum item"
		require
			min_max_available
		deferred
		ensure
		--	smallest: For every item `it' in structure, `Result' <= `it'
		end

	max: G is
		indexing
			description: "Maximum item"
		require
			min_max_available

		deferred
		ensure
		--	largest: For every item `it' in structure, `it' <= `Result'
		end

	min_max_available: BOOLEAN is
		indexing
			description: "Can min and max be computed?"
		deferred
		ensure
			Result implies not is_empty
		end

feature {NONE} -- Inapplicable

	index: INTEGER is
		deferred
		end

--invariant

--	empty_constraint: min_max_available implies not is_empty

end -- class COMPARABLE_STRUCT



