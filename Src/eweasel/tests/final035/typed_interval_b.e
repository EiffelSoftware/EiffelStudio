class TYPED_INTERVAL_B [reference G -> INTERVAL_VAL_B]

inherit
	INTERVAL_B
		redefine
			lower
		end

feature -- Access

	lower: G
			-- Lower bound

end
