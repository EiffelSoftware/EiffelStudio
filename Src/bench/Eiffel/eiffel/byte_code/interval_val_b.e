indexing
	description: "Abstract representation of an interval value for `inspect' clauses."
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
			same_type: same_type (other)
		deferred
		end
		
	is_allowed_unique_value: BOOLEAN is
			-- Does `Current' represent an allowed unique value?
			-- (This is now true for positive integers.)
		do
			-- False by default.
		end

feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		require
			other_not_void: other /= Void
			same_type: same_type (other)
			other_not_less: other >= Current
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
			same_type: same_type (other)
			other_not_less: other >= Current
			action_not_void: action /= Void
		deferred
		end

feature -- Evaluation

	inspect_interval (upper: like Current): TYPED_INTERVAL_B [like Current] is
			-- Interval with lower set to `Current' and upper set to `upper'
		require
			upper_not_void: upper /= Void
			same_type: same_type (upper)
			upper_not_less: upper >= Current
		do
			create Result.make (Current, upper)
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
			-- Generate code to subtract this value if `is_included' is true or
			-- next value if `is_included' is false from top of IL stack.
			-- Ensure that resulting value on the stack is UInt32.
		deferred
		end

feature {INTERVAL_B} -- C code generation

	generate_interval (other: like Current) is
			-- Generate interval Current..`other'.
		require
			other_not_void: other /= Void
			same_type: same_type (other)
			good_range: Current <= other
		deferred
		end

feature {INTERVAL_B} -- IL code generation

	il_load_value is
			-- Load value to IL stack.
		deferred
		end

	il_load_difference (other: like Current) is
			-- Load a difference between current and `other' to IL stack.
		require
			other_not_void: other /= Void
			same_type: same_type (other)
			other_not_greater: other <= Current
		deferred
		end

end
