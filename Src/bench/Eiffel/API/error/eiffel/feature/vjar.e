-- Error for unvalid assignment attempt

class VJAR 

inherit

	FEATURE_ERROR
		rename
			build_explain as old_build_explain
		end;

	FEATURE_ERROR
		redefine
			build_explain
		select
			build_explain
		end
	
feature 

	attempt: ASSIGN_AS;
			-- Reverse assignment

	target_type: TYPE_A;
			-- Target type of the reverse assignment (left part)

	source_type: TYPE_A;
			-- Source type of the reverse assignment (right part)

	set_attempt (r: ASSIGN_AS) is
			-- Assign `r' to `attempt'.
		do
			attempt := r;
		end;

	set_source_type (s: TYPE_A) is
			-- Assign `s' to `source_type'.
		do
			source_type := s;
		end;

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_type'.
		do
			target_type := t;
		end;

	code: STRING is 
			-- Error code
		do
			Result := Assign_code;
		end;

	Assign_code: STRING is "VJAR";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
        do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%Ttarget = ");
			a_clickable.put_string (target_type.dump);
			a_clickable.put_string ("%N%Tsource_type = ");
			a_clickable.put_string (source_type.dump);
			a_clickable.put_string ("%N")
		end

end
