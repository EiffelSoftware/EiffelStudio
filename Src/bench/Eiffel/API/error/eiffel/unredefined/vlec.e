-- Error for class violating the expanded client rule

class VLEC 

inherit

	EIFFEL_ERROR

feature 

	class_type: CLASS_TYPE;
			-- Unvalid class type

	code: STRING is "VLEC";
			-- Error code

	set_class_type (t: like class_type) is
			-- Assign `t' to `class_type'.
		do
			class_type := t;
		end;

end
