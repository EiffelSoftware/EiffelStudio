class CHAR_INTER_B 

inherit

	INTERVAL_B	
		redefine
			lower, upper, generate
		end

creation

	make
	
feature 

	lower: CHAR_VAL_B;
			-- Lower bound

	upper: CHAR_VAL_B;
			-- Upper bound

feature -- C generation

	generate is
			-- Generate then interval
		local
			low, up: CHARACTER;
			buf: GENERATION_BUFFER
		do
				-- Do not use "lower > up" as exit test since `low'
				-- will be out of bounds when `up' is the greatest
				-- allowed character.
			from
				buf := buffer
				low := lower.generation_value;
				up := upper.generation_value;
				buf.putstring ("case '");
				buf.escape_char (buf,low);
				buf.putstring ("':");
				buf.new_line;
			until
				low = up
			loop
				low := low + 1;
				buf.putstring ("case '");
				buf.escape_char (buf,low);
				buf.putstring ("':");
				buf.new_line;
			end;
		end;

feature -- IL generation

	generate_il_interval (next_case_label: IL_LABEL) is
			--  Generate IL code for interval
		local
			low, up: CHARACTER
		do
			low := lower.generation_value
			up := upper.generation_value
			if low < up then
					-- Generate test `val >= low'.
				il_generator.duplicate_top
				il_generator.put_character_constant (low)
				il_generator.generate_binary_operator (Il_ge)
				il_generator.branch_on_false (next_case_label)

					-- If `val >= low' then generate test `val <= up'.
				il_generator.duplicate_top
				il_generator.put_character_constant (up)
				il_generator.generate_binary_operator (Il_le)
			else
				il_generator.duplicate_top
				il_generator.put_character_constant (low)
				il_generator.generate_binary_operator (Il_eq)
			end
			il_generator.branch_on_false (next_case_label)
		end

feature -- Checking

	intersection (other: CHAR_INTER_B): CHAR_INTER_B is
			-- Intersection of Current and `other'.
		local
			new_lower, new_upper: CHAR_VAL_B;
		do
			if lower < other.lower then
				new_lower := other.lower;
			else
				new_lower := lower;
			end;
			if upper < other.upper then
				new_upper := upper;
			else
				new_upper := other.upper;
			end;
			!!Result.make (new_lower, new_upper);
		end;

invariant

	lower <= upper

end
