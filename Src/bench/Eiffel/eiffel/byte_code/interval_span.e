indexing
	description: "A span that is either a single interval or a group of intervals in inspect instruction."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTERVAL_SPAN

feature -- Access

	lower: INTERVAL_VAL_B is
			-- Lower bound of a span
		deferred
		end

	upper: like lower is
			-- Upper bound of a span
		deferred
		end
			
	is_lower_included: BOOLEAN is
			-- Is `lower' included in a span?
		deferred
		end

	is_upper_included: BOOLEAN is
			-- Is `upper' included in a span?
		deferred
		end

feature -- Measurement

	count: DOUBLE is
			-- Number of intervals and gaps in current span
		deferred
		end

feature -- IL code generation

	generate_il (min_value, max_value: like lower; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]) is
			-- Generate code for span assuming that inspect value is in range `min_value'..`max_value'
			-- where bounds are included in interval according to values of `is_min_included' and `is_max_included'.
			-- Use `labels' to branch to the corresponding code.
		require
			min_value_not_void: min_value /= Void
			max_value_not_void: max_value /= Void
			labels_not_void: labels /= Void
			labels_not_empty: not labels.is_empty
			labels_has_else_label: labels.lower = 0
			else_label_not_void: labels.item (0) /= Void
		deferred
		end

invariant
	lower_not_void: lower /= Void
	upper_not_void: upper /= Void
	lower_before_upper: lower <= upper

end
