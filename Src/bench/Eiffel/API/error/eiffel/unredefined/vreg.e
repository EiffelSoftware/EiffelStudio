-- Error when there are two arguments with the same name

class VREG 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;
	
feature 

	argument_name: ID_AS;
			-- Argument name violating the VREG rule

	code: STRING is "VREG";
			-- Error code

	set_argument_name (s: ID_AS) is
			-- Assign `s' to `argument_name'.
		do
			argument_name := s;
		end;

	build_explain is
		do
			put_string ("%T`");
			put_string (argument_name);
			put_string ("' can only appear once in the formal argument clause%N");
		end;

end
