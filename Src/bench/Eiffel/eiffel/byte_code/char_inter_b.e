indexing
	description: "Interval byte node for an interval of character values in inspect statement."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_INTER_B 

inherit
	INTERVAL_B	
		redefine
			lower, upper, generate
		end

create
	make
	
feature -- Access

	lower: CHAR_VAL_B
			-- Lower bound

	upper: CHAR_VAL_B
			-- Upper bound

feature -- C generation

	generate is
			-- Generate then interval
		local
			low, up: CHARACTER
			buf: GENERATION_BUFFER
		do
				-- Do not use "lower > up" as exit test since `low'
				-- will be out of bounds when `up' is the greatest
				-- allowed character.
			from
				buf := buffer
				low := lower.generation_value
				up := upper.generation_value
				buf.put_string ("case (EIF_CHARACTER) '")
				buf.escape_char (low)
				buf.put_string ("':")
				buf.put_new_line
			until
				low = up
			loop
				low := low + 1
				buf.put_string ("case (EIF_CHARACTER) '")
				buf.escape_char (low)
				buf.put_string ("':")
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
			lo: CHARACTER
			up: CHARACTER
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
					il_generator.put_character_constant (up)
					if label = Void then
						il_generator.branch_on_condition (feature {MD_OPCODES}.bgt, else_label)
					else
						il_generator.branch_on_condition (feature {MD_OPCODES}.ble, label)
					end
				end
			elseif is_max_equal_upper then
					-- No need to test upper bound
					-- Test lower bound
				instruction.generate_il_load_value
				il_generator.put_character_constant (lo)
				if label = Void then
					il_generator.branch_on_condition (feature {MD_OPCODES}.blt, else_label)
				else
					il_generator.branch_on_condition (feature {MD_OPCODES}.bge, label)
				end
			elseif lo = up then
					-- This is a single value
					-- Test for equality
				instruction.generate_il_load_value
				il_generator.put_character_constant (lo)
				if label = Void then
					il_generator.branch_on_condition (feature {MD_OPCODES}.bne_un, else_label)
				else
					il_generator.branch_on_condition (feature {MD_OPCODES}.beq, label)
				end
			else
					-- General case
					-- Generate unsigned test `val - lo <= up - lo' which is equivalent to
					-- signed test `lo <= val and val <= up'.
				instruction.generate_il_load_value
				il_generator.put_character_constant (lo)
				il_generator.generate_binary_operator (il_minus)
				il_generator.put_integer_32_constant (up |-| lo)
				il_generator.branch_on_condition (feature {MD_OPCODES}.ble_un, label)
				if label = Void then
					il_generator.branch_on_condition (feature {MD_OPCODES}.bgt_un, else_label)
				else
					il_generator.branch_on_condition (feature {MD_OPCODES}.ble_un, label)
				end
			end
			if label = Void then
				instruction.generate_il_when_part (case_index, labels)
			else
				il_generator.branch_to (else_label)
			end
		end

feature -- Checking

	intersection (other: CHAR_INTER_B): CHAR_INTER_B is
			-- Intersection of Current and `other'.
		local
			new_lower, new_upper: CHAR_VAL_B
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
