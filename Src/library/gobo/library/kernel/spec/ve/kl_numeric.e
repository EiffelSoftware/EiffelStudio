indexing

	description:

		"Properties of numeric types"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "MIT License"
	date: "$Date$"

deferred class KL_NUMERIC

inherit

	NUMERIC






		rename 
			exponentiable as ve_exponentiable,
			infix "^" as ve_exponentiation
		end














feature -- Basic operations

	ve_exponentiation (other: DOUBLE): DOUBLE is
			-- Not implemented
		do
		end

	ve_exponentiable (other: DOUBLE): BOOLEAN is
			-- Not implemented
		do
		end


end
