indexing
	description: "Objects that may be compared according to a total order relation"
	class_type: Interface
	external_name: "ISE.Base.Comparable"

deferred class
	COMPARABLE

inherit
	PART_COMPARABLE

feature -- Comparison

	three_way_comparison (other: like Current): INTEGER is
		indexing
			description: "[
						If current object equal to `other', 0;
						if smaller, -1; if greater, 1
					  ]"
		require
			other_exists: other /= Void
		deferred
		ensure
			equal_zero: (Result = 0) = is_equal (other)
			smaller_negative: (Result = -1) = (Current < other)
			greater_positive: (Result = 1) = (Current > other)
		end

	max (other: like Current): COMPARABLE is
		indexing
			description: "The greater of current object and `other'"
		require
			other_exists: other /= Void
		deferred
		ensure
			current_if_not_smaller: Current >= other implies Result = Current
			other_if_smaller: Current < other implies Result = other
		end

	min (other: like Current): COMPARABLE is
		indexing
			description: "The smaller of current object and `other'"
		require
			other_exists: other /= Void
		deferred
		ensure
			current_if_not_greater: Current <= other implies Result = Current
			other_if_greater: Current > other implies Result = other
		end

--invariant
--	irreflexive_comparison: not (Current < Current)

end -- class COMPARABLE



