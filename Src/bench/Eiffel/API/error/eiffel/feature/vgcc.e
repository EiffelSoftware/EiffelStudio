-- Error in creation instruction

class VGCC 

inherit

	FEATURE_ERROR
	
feature

	type: TYPE_A;
			-- Creation type involved

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	code: STRING is "VGCC";
			-- Error code

	target_name: STRING;

	set_target_name (s: STRING) is
		do
			target_name := s
		end;

	print_name is
		do
			put_string ("Creation of: ");
			put_string (target_name);
			put_string ("%NTarget type: ");
			type.append_clickable_signature (error_window);
			new_line;
		end;

end
