indexing
	description: "Abstract representation of an interval for `inspect' clauses."
	date: "$Date$"
	revision: "$Revision$"

deferred class INTERVAL_VAL_B

inherit
	BYTE_NODE
		undefine
			is_equal
		end
	
	COMPARABLE

feature -- Error reporting

	display (st: STRUCTURED_TEXT) is
		require
			st_not_void: st /= Void
		deferred
		end

feature -- Comparison

	is_next (other: like Current): BOOLEAN is
			-- Is `other' next to Current?
		require
			other_not_void: other /= Void
		deferred
		end
		
feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		require
			other_not_void: other /= Void
		deferred
		ensure
			non_negative_result: Result >= 0
		end

feature -- Iteration

	do_all (is_included: BOOLEAN; other: like Current; is_other_included: BOOLEAN; action: PROCEDURE [ANY, TUPLE]) is
			-- Apply `action' to all values in range `Current'..`other' where
			-- inclusion of bounds in the range is specified by `is_included' and `is_other_included'.
		require
			other_not_void: other /= Void
			action_not_void: action /= Void
		deferred
		end

feature -- Evaluation

	make_interval (upper: like Current): INTERVAL_B is
			-- Create a new interval with lower set to `Current' and upper set to `upper'.
		require
			upper_not_void: upper /= Void
		deferred
		ensure
			result_not_void: Result /= Void
			lower_set: Result.lower = Current
			upper_set: Result.upper = upper
		end

feature -- IL code generation

	generate_il_branch_on_greater (is_included: BOOLEAN; label: IL_LABEL; instruction: INSPECT_B) is
			-- Generate branch to `label' if value on IL stack it greater than this value.
			-- Assume that current value is included in lower interval if `is_included' is true.
		require
			label_not_void: label /= Void
			instruction_not_void: instruction /= Void
		deferred
		end

	generate_il_subtract (is_included: BOOLEAN) is
			-- Generate code to subtract this value if `is_included' is true or next value if `is_included' is false from top of IL stack.
		deferred
		end

end
