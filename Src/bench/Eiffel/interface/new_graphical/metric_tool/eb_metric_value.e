indexing
	description: "Representation of terms composing a composite metric%N%
				%to ease metric calculation."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_VALUE

feature -- Access

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate of metric over `s'.
		require
			scope_not_void: s /= Void
		deferred
		end

end -- class EB_METRIC_VALUE
