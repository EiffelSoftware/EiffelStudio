-- Error when a generic type has not the exact number of generic parameters

class VTUG 

inherit

	EIFFEL_ERROR
	
feature 

	type: TYPE_A;
			-- Type violating the rule

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	code: STRING is
			-- Error code
		do
			Result := "VTUG";
		end;

end
