class INT_INTER_B 

inherit

	INTERVAL_B
		redefine
			lower, upper,
			generate
		end

creation

	make

feature 

	make (i, j: INT_VAL_B) is
		do
			if i < j then
				lower := i;
				upper := j;
			else
				lower := j;
				upper := i;
			end;
		end;

	lower: INT_VAL_B;
			-- Lower bound

	upper: INT_VAL_B;
			-- Upper bound

	generate is
			-- Generate then interval
		local
			low, up: INTEGER;
		do
			from
				low := lower.generation_value;
				up := upper.generation_value;
			until
				low > up
			loop
				generated_file.putstring ("case ");
				generated_file.putint (low);
				generated_file.putchar ('L');
				generated_file.putchar (':');
				generated_file.new_line;
				low := low + 1;
			end;
		end;

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
