-- Error for unvalid reverse assignment attempt

class VJRV 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature 

	target_type: TYPE_A;
			-- Target type

	target_name: STRING;

	set_target_name (s: STRING) is
		do
			target_name := s;
		end;

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_type'.
		do
			target_type := t;
		end; -- set_target_type

	code: STRING is "VJRV";
			-- Error code

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Target name: ");
			ow.put_string (target_name);
			ow.put_string ("%NTarget type: ");
			target_type.append_to (ow);
		end;

end 
