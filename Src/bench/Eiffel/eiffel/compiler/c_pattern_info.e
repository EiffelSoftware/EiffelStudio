-- Information about C patterns

class C_PATTERN_INFO 

inherit

	HASHABLE
		redefine
			is_equal
		end;
	SHARED_CODE_FILES
		redefine
			is_equal
		end;
	
feature 

	pattern: C_PATTERN;
			-- Pattern

	c_pattern_id: INTEGER;
			-- Pattern id

	set_c_pattern_id (i: INTEGER) is
			-- Assign `i' to `c_pattern_id'.
		do
			c_pattern_id := i;
		end;

	set_pattern (p: C_PATTERN) is
		require
			good_argument: p /= Void
		do
			pattern := p;
		end;

	is_equal (other: C_PATTERN_INFO): BOOLEAN is
            -- Is `other' equal to Current ?
        do
            Result := pattern.is_equal (other.pattern);
        end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := pattern.hash_code;
		end;

	generate_pattern is
			-- Generate pattern for interface between C generated code
			-- and the interpreter
		do
			pattern.generate_pattern (c_pattern_id, Pattern_file);
		end;

invariant

	pattern_exists: pattern /= Void

end
