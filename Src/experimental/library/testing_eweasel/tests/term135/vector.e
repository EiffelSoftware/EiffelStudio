deferred class
	VECTOR [G -> NUMERIC]

inherit
	NUMERIC
	
feature -- Basic operations

	scalar_product alias "|*" (other: G): like Current is
			-- Scalar product between `Current' and other.
		deferred
		end
end
