class INT_INTER_B 

inherit

	INTERVAL_B
		redefine
			lower, upper,
			generate
		end

creation

	make

feature -- Access

	lower: INT_VAL_B;
			-- Lower bound

	upper: INT_VAL_B;
			-- Upper bound

feature -- C generation

	generate is
			-- Generate then interval
		require else
			is_good_range: is_good_range
		local
			low, up: INTEGER;
			buf: GENERATION_BUFFER
		do
			from
				buf := buffer
				low := lower.generation_value;
				up := upper.generation_value;
			until
				low > up
			loop
				buf.putstring ("case ");
				buf.putint (low);
				buf.putchar ('L');
				buf.putchar (':');
				buf.new_line;
				low := low + 1;
			end;
		end;

feature -- IL generation

	generate_il_interval (next_case_label: IL_LABEL) is
			--  Generate IL code for interval
		local
			low, up: INTEGER;
		do
			low := lower.generation_value
			up := upper.generation_value
			if low < up then
					-- Generate test `val >= low'.
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (low)
				il_generator.generate_binary_operator (Il_ge)
				il_generator.branch_on_false (next_case_label)

					-- If `val >= low' then generate test `val <= up'.
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (up)
				il_generator.generate_binary_operator (Il_le)
			else
				il_generator.duplicate_top
				il_generator.put_integer_32_constant (low)
				il_generator.generate_binary_operator (Il_eq)
			end
			il_generator.branch_on_false (next_case_label)
		end

feature -- Checking

	intersection (other: INT_INTER_B): INT_INTER_B is
			-- Intersection of Current and `other'.
		local
			new_lower, new_upper: INT_VAL_B;
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
