indexing
	description: "[
					Strategies for computing several features of subsets. The computing
					strategy is optimized depending on the type of elements contained in
					the set.
			  ]"
	class_type: Interface
	external_name: "ISE.Base.SubsetStrategy"

deferred class 
	SUBSET_STRATEGY [G]

feature -- Comparison

	disjoint (set1, set2: TRAVERSABLE_SUBSET [G]): BOOLEAN is
		indexing
			description: "Are `set1' and `set2' disjoint?"
		require
			sets_exist: set1 /= Void and set2 /= Void
			same_types: set1.get_type.is_equal (set2.get_type)
			same_rule: set1.object_comparison = set2.object_comparison
		deferred
		end
	
feature -- Basic operations

	symdif (set1, set2: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "[
						Remove all items of `set1' that are also in `set2', and add all
						items of `set2' not already present in `set1'.
					  ]"
		require
			sets_exist: set1 /= Void and set2 /= Void
			same_types: set1.get_type.is_equal (set2.get_type)
			same_rule: set1.object_comparison = set2.object_comparison
		deferred
		end

end -- class SUBSET_STRATEGY
