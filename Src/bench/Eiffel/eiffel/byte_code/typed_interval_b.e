indexing
	description: "Inspect interval of particular type."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPED_INTERVAL_B [H]

inherit
	INTERVAL_B
		redefine
			generate,
			lower,
			upper
		end

feature -- Access

	lower: TYPED_INTERVAL_VAL_B [H]
			-- Lower bound

	upper: like lower
			-- Upper bound

feature -- C code generation

	generate is
			-- Generate the interval.
		local
			low, up: H
			buf: GENERATION_BUFFER
		do
			check
				is_good_range: is_good_range
			end
				-- Do not use "lower > up" as exit test since `low'
				-- will be out of bounds when `up' is the greatest
				-- allowed value.
			from
				buf := buffer
				low := lower.generation_value
				up := upper.generation_value
				buf.put_string ("case ")
				generate_value (low)
				buf.put_character (':')
				buf.put_new_line
			until
				low = up
			loop
				low := next_value (low)
				buf.put_string ("case ")
				generate_value (low)
				buf.put_character (':')
				buf.put_new_line
			end
		end

feature -- IL code generation

	generate_il (min_value, max_value: like lower; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]; instruction: INSPECT_B) is
			-- Generate code for single interval of `instruction' assuming that inspect value is in range `min_value'..`max_value'
			-- where bounds are included in interval according to values of `is_min_included' and `is_max_included'.
			-- Use `labels' to branch to the corresponding code.
		local
			is_min_equal_lower: BOOLEAN
			is_max_equal_upper: BOOLEAN
			lo: H
			up: H
			label: IL_LABEL
			else_label: IL_LABEL
		do
			is_min_equal_lower := min_value = lower or else not is_min_included and then min_value.is_next (lower)
			is_max_equal_upper := upper = max_value or else not is_max_included and then upper.is_next (max_value)
			lo := lower.generation_value
			up := upper.generation_value
			label := labels.item (case_index)
			else_label := labels.item (0)
			if is_min_equal_lower then
					-- No need to test lower bound
				if is_max_equal_upper then
						-- No need to test either bound: just branch to the code
					else_label := label
				else
						-- Test upper bound
					instruction.generate_il_load_value
					il_load_value (up)
					if label = Void then
						il_generator.branch_on_condition ({MD_OPCODES}.bgt, else_label)
					else
						il_generator.branch_on_condition ({MD_OPCODES}.ble, label)
					end
				end
			elseif is_max_equal_upper then
					-- No need to test upper bound
					-- Test lower bound
				instruction.generate_il_load_value
				il_load_value (lo)
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.blt, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.bge, label)
				end
			elseif lo = up then
					-- This is a single value
					-- Test for equality
				instruction.generate_il_load_value
				il_load_value (lo)
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.bne_un, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.beq, label)
				end
			else
					-- General case
					-- Generate unsigned test `val - lo <= up - lo' which is equivalent to
					-- signed test `lo <= val and val <= up'.
				instruction.generate_il_load_value
				il_load_value (lo)
				il_generator.generate_binary_operator (il_minus)
				il_load_difference (up, lo)
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.bgt_un, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.ble_un, label)
				end
			end
			if label = Void then
				instruction.generate_il_when_part (case_index, labels)
			else
				il_generator.branch_to (else_label)
			end
		end

feature {NONE} -- Implementation: C code generation

	generate_value (value: H) is
			-- Generate single `value'.
		require
			value_not_void: value /= Void
		deferred
		end

	next_value (value: H): H is
			-- Value after given `value'
		deferred
		end
		
feature {NONE}-- Implementation: IL code generation

	il_load_value (value: H) is
			-- Load `value' to stack.
		require
			value_not_void: value /= Void
		deferred
		end

	il_load_difference (upper_value, lower_value: H) is
			-- Load a difference between `upper_value' and `lower_value' to stack.
		require
			upper_value_not_void: upper_value /= Void
			lower_value_not_void: lower_value /= Void
		deferred
		end

end
