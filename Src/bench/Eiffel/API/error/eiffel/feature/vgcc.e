-- Error in creation instruction

class VGCC 

inherit

	FEATURE_ERROR
		redefine
			build_Explain
		end;

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

	print_name (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Creation of: ");
			ow.put_string (target_name);
			ow.put_string ("%NTarget type: ");
			type.append_to (ow);
			ow.new_line;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			print_name (ow)
		end;

end
