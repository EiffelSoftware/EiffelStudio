-- Error for unvalid assignment attempt

class VJAR 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature 

	target_name: STRING;

	target_type: TYPE_A;
			-- Target type of the reverse assignment (left part)

	source_type: TYPE_A;
			-- Source type of the reverse assignment (right part)

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

	set_target_name (s: STRING) is
		do
			target_name := s;
		end;

	code: STRING is "VJAR";

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("Target name: ");
			put_string (target_name);
			put_string ("%NTarget type: ");
			target_type.append_clickable_signature (error_window);
			put_string ("%NSource_type: ");
			source_type.append_clickable_signature (error_window);
			new_line
		end

end
