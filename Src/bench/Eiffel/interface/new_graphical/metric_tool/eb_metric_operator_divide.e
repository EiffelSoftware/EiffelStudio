indexing
	description: "Representation of operator %"/%" when used in a composite%N%
				%metric definition to ease metric calculation."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_OPERATOR_DIVIDE

inherit
	EB_METRIC_OPERATOR

create
	make

feature -- Initialization

	make (v1, v2: EB_METRIC_VALUE) is
			--	Set values for division.
		require
			effective_values: v1 /= Void and v2 /= Void
		do
			value1 := v1
			value2 := v2
		end

feature -- Access

	value1, value2: EB_METRIC_VALUE
		-- values current operator applies to.

feature -- Value

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate division of `value2' over `value1' over scope `s'.
		do
			if value1.value (s) /= 0 then
				Result := value2.value (s) / value1.value (s)
					-- Caution !! Value1 and value2 are inverted when
					-- storing in a stack. That is why we calculate
					-- value2 / value1 and not value1 / value2
			else
				Result := -123456
			end
		end

end -- class EB_METRIC_OPERATOR_DIVIDE
