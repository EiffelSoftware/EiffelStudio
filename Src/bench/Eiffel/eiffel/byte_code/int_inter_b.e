indexing
	description: "Interval byte node for an interval of integer values in inspect statement."
	date: "$Date$"
	revision: "$Revision$"

class INT_INTER_B 

inherit
	INTERVAL_B
		redefine
			lower, upper,
			generate
		end

create
	make

feature -- Access

	lower: INT_VAL_B
			-- Lower bound

	upper: INT_VAL_B
			-- Upper bound

feature -- C generation

	generate is
			-- Generate then interval
		require else
			is_good_range: is_good_range
		local
			low, up: INTEGER
			buf: GENERATION_BUFFER
		do
			from
				buf := buffer
				low := lower.generation_value
				up := upper.generation_value
			until
				low > up
			loop
				buf.put_string ("case ")
				buf.put_integer (low)
				buf.put_character ('L')
				buf.put_character (':')
				buf.put_new_line
				low := low + 1
			end
		end

feature -- IL code generation

	generate_il (min_value, max_value: like lower; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]) is
			-- Generate code for group assuming that inspect value is in range `min_value'..`max_value'
			-- where bounds are included in interval according to values of `is_min_included' and `is_max_included'.
			-- Use `labels' to branch to the corresponding code.
		local
			is_min_equal_lower: BOOLEAN
			is_max_equal_upper: BOOLEAN
			lo: INTEGER
			up: INTEGER
			label: IL_LABEL
			else_label: IL_LABEL
		do
			is_min_equal_lower := min_value = lower or else not is_min_included and then min_value.is_next (lower)
			is_max_equal_upper := upper = max_value or else not is_max_included and then upper.is_next (max_value)
			lo := lower.generation_value
			up := upper.generation_value
			label := labels.item (case_index)
			if label = Void then
				label := il_label_factory.new_label
				labels.put (label, case_index)
			end
			else_label := labels.item (0)
			if is_min_equal_lower then
					-- No need to test lower bound
				if is_max_equal_upper then
						-- No need to test either bound: just branch to the code
					else_label := label
				else
						-- Test upper bound
					il_generator.duplicate_top
					il_generator.put_integer_32_constant (up)
					il_generator.branch_on_condition (feature {MD_OPCODES}.ble, label)
				end
			elseif is_max_equal_upper then
					-- No need to test upper bound
					-- Test lower bound
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (lo)
				il_generator.branch_on_condition (feature {MD_OPCODES}.bge, label)
			elseif lo = up then
					-- This is a single value
					-- Test for equality
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (lo)
				il_generator.branch_on_condition (feature {MD_OPCODES}.beq, label)
			else
					-- General case
					-- Generate unsigned test `val - lo <= up - lo' which is equivalent to
					-- signed test `lo <= val and val <= up'.
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (lo)
				il_generator.generate_binary_operator (il_minus)
				il_generator.put_integer_32_constant (up - lo)
				il_generator.branch_on_condition (feature {MD_OPCODES}.ble_un, label)
			end
			il_generator.branch_to (else_label)
		end

feature -- Checking

	intersection (other: INT_INTER_B): INT_INTER_B is
			-- Intersection of Current and `other'.
		local
			new_lower, new_upper: INT_VAL_B
		do
			if lower < other.lower then
                new_lower := other.lower
            else
                new_lower := lower
            end
            if upper < other.upper then
                new_upper := upper
            else
                new_upper := other.upper
            end
            create Result.make (new_lower, new_upper)
		end

end
