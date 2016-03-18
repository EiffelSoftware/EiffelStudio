note
	description: "[
			Objects comparing scored values.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SCORED_VALUE_COMPARATOR [G]

inherit
	PART_COMPARATOR [SCORED_VALUE [G]]
	
feature -- Status report

	less_than (u, v: SCORED_VALUE [G]): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := u < v
		end

end
