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

end
