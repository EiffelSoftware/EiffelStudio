-- Error for a feature call: type mismatch one one argument

class VUAR2 

inherit

	VUAR
	
feature 

	argument_name: STRING;
			-- Name of the involved argument

	formal_type: TYPE_A;
			-- Formal type of the argument

	actual_type: TYPE_A;
			-- Actual type of the call

	set_argument_name (n: STRING) is
			-- Assign `n' to `argument_name'.
		do
			argument_name := n;
		end;

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		do
			formal_type := t;
		end;

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
		end;

end
		
