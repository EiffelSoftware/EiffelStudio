indexing
	description: "Representation of coefficients of a composite metric%N%
				%to ease metric calculation."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CONSTANT

inherit
	EB_METRIC_VALUE

create
	make

feature -- Initialization

	make (v: DOUBLE) is
		do
			val := v
		end

feature -- Access

	val: DOUBLE
		-- value of the multiplying coefficient.

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Return `val'.
		do
			Result := val
		end

end -- class EB_METRIC_CONSTANT
