indexing
	description: "[
					Subsets with the associated operations,
					without commitment to a particular representation
			  ]"
	class_type: Interface
	external_name: "ISE.Base.Subset"

deferred class 
	SUBSET [G] 

inherit
	SET [G]

feature -- Comparison

	is_subset (other: SUBSET [G]): BOOLEAN is
		indexing
			description: "Is current set a subset of `other'?"
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		end

	is_superset (other: SUBSET [G]): BOOLEAN is
		indexing
			description: "Is current set a superset of `other'?"
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		end

	disjoint (other: SUBSET [G]): BOOLEAN is
		indexing
			description: "Do current set and `other' have no items in common?"
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		end

feature -- Duplication

	duplicate (n: INTEGER): SUBSET [G] is
		indexing
			description: "[
						New structure containing min (`n', `count')
						items from current structure
					  ]"
		require
			non_negative: n >= 0
		deferred
		ensure
			correct_count_1: n <= count implies Result.count = n
			correct_count_2: n >= count implies Result.count = count
		end

feature -- Basic operations

	intersect (other: SUBSET [G]) is
		indexing
			description: "Remove all items not in `other'."
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			is_subset_other: is_subset (other)
		end

	merge (other: CONTAINER [G]) is
		indexing
			description: "Add all items of `other'."
		require
			set_exists: other /= Void
 			same_rule: object_comparison = other.object_comparison
		deferred
		end

	subtract (other: SUBSET [G]) is
		indexing
			description: "Remove all items also in `other'."
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			is_disjoint: disjoint (other)
		end

	symdif (other: SUBSET [G]) is
		indexing
			description: "[
						Remove all items also in `other', and add all
						items of `other' not already present.
					  ]"
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		end

end -- class SUBSET



