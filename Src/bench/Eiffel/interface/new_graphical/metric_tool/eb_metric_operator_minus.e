indexing
	description: "Representation of operator %"-%" when used in a composite%N%
				%metric definition to ease metric calculation."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_OPERATOR_MINUS

inherit
	EB_METRIC_OPERATOR

create
	make

feature -- Initialization

	make (v1, v2: EB_METRIC_VALUE) is
			--	Set values for substraction.
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
			-- Evaluate substraction of `value1' from `value2' over scope `s'.
		do
			Result := value2.value (s) - value1.value (s)
				-- Caution !! Value1 and value2 are inverted when
				-- storing in a stack. That is why we calculate
				-- value2 - value1 and not value1 - value2
		end

end -- class EB_METRIC_OPERATOR_MINUS
