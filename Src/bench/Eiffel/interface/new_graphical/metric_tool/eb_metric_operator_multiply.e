indexing
	description: "Representation of operator %"*%" when used in a composite%N%
				%metric definition to ease metric calculation."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_OPERATOR_MULTIPLY

inherit
	EB_METRIC_OPERATOR

create
	make

feature -- Initialization

	make (v1, v2: EB_METRIC_VALUE) is
			--	Set values for multiplication.
		require
			effective_values: v1 /= Void and v2 /= Void
		do
			value1 := v1
			value2 := v2
		end

feature -- Access

	value1, value2: EB_METRIC_VALUE
		-- values current operator applies to

feature -- Value

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate multiplication of `value2' by `value1' over scope `s'.
		do
			Result := value1.value (s) * value2.value (s)
		end


end -- class EB_METRIC_OPERATOR_MULTIPLY
