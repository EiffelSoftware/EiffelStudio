indexing
	description: "[
					Data structures of the most general kind,
					used to hold zero or more items.
			  ]"
	class_type: Interface
	external_name: "ISE.Base.Container"

deferred class
	CONTAINER [G]

feature -- Access

	has (v: G): BOOLEAN is
		indexing
			description: "[
						Does structure include `v'?
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		deferred
		ensure
			not_found_in_empty: Result implies not is_empty
		end

feature -- Status report

	is_empty: BOOLEAN is
		indexing
			description: "Is there no element?"
		deferred
		end

	object_comparison: BOOLEAN is 
		indexing
			description: "[
						Must search operations use `equal' rather than `='
						for comparing references? (Default: no, use `='.)
					  ]"
		deferred
		end

	changeable_comparison_criterion: BOOLEAN is
		indexing
			description: "May `object_comparison' be changed? (Answer: yes by default.)"
		deferred
		end

feature -- Status setting

	compare_objects is
		indexing
			description: "[
						Ensure that future search operations will use `equal'
						rather than `=' for comparing references.
					  ]"
		require
			changeable_comparison_criterion
		deferred
		ensure
			object_comparison
		end

	compare_references is
		indexing
			description: "[
						Ensure that future search operations will use `='
						rather than `equal' for comparing references.
					  ]"
		require
			changeable_comparison_criterion
		deferred
		ensure
			reference_comparison: not object_comparison
		end

feature -- Conversion

	linear_representation: LINEAR [G] is
		indexing
			description: "Representation as a linear structure"
		deferred
		end

feature -- Implementation

	implementation: SYSTEM_COLLECTIONS_ICOLLECTION is
		indexing
			description: "Object for .NET access and implementation"
		deferred
		end
		
--invariant
--	reflexive_equality: is_equal (Current)
--	reflexive_conformance: get_type.is_equal (Current.get_type)

end -- class CONTAINER
