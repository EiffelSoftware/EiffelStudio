indexing
	description: "[
				Collections of items, where each item may occur zero
				or more times, and the number of occurrences is meaningful.
			 ]"
	class_type: Interface
	external_name: "ISE.Base.Bag"

deferred class
	BAG [G]

inherit

	COLLECTION [G]

feature -- Measurement

	occurrences (v: G): INTEGER is
		indexing	
			description: "[
						Number of times `v' appears in structure
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		deferred
		ensure
			non_negative_occurrences: Result >= 0
		end

end -- class BAG



