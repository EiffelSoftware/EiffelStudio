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

	generate is
			-- Generate then interval
		require else
			is_good_range: is_good_range
		local
			low, up: CHARACTER;
		do
			from
				low := lower.generation_value;
				up := upper.generation_value;
			until
				low > up
			loop
				generated_file.putstring ("case '");
				generated_file.escape_char (low);
				generated_file.putstring ("':");
				generated_file.new_line;
				low := low + 1;
			end;
		end;

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
